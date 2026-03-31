local M = {}

local function git_ref_exists(ref)
  if not ref or ref == '' then
    return false
  end

  local result = vim.system({ 'git', 'rev-parse', '--verify', '--quiet', ref }, { text = true }):wait()
  return result.code == 0
end

local function resolve_git_ref(branch)
  if not branch or branch == '' then
    return nil
  end

  if git_ref_exists(branch) then
    return branch
  end

  local remote_branch = 'origin/' .. branch
  if git_ref_exists(remote_branch) then
    return remote_branch
  end

  return branch
end

local function format_glab_error(result, fallback)
  local message = vim.trim(result.stderr or '')
  if message == '' then
    message = vim.trim(result.stdout or '')
  end
  if message == '' then
    message = fallback
  end
  return vim.split(message, '\n')[1]
end

local function run_glab_json(args, callback)
  vim.system(args, { text = true }, function(result)
    if result.code ~= 0 then
      callback(nil, format_glab_error(result, 'glab command failed'))
      return
    end

    local ok, decoded = pcall(vim.json.decode, result.stdout or '')
    if not ok then
      callback(nil, 'Failed to parse JSON from glab')
      return
    end

    callback(decoded, nil)
  end)
end

local function format_labels(labels)
  if type(labels) ~= 'table' or vim.tbl_isempty(labels) then
    return 'none'
  end

  local names = {}
  for _, label in ipairs(labels) do
    if type(label) == 'table' then
      names[#names + 1] = label.name or 'unknown'
    else
      names[#names + 1] = tostring(label)
    end
  end

  if vim.tbl_isempty(names) then
    return 'none'
  end

  return table.concat(names, ', ')
end

local function bool_text(value)
  return value and 'yes' or 'no'
end

local function render_merge_request_preview(item, details)
  local description = vim.trim(item.description or '')
  if description == '' then
    description = '_No description_'
  end

  local lines = {
    string.format('# %s %s', item.reference or '?', item.title or ''),
    '',
    string.format('- State: %s', item.state or 'unknown'),
    string.format('- Draft: %s', bool_text(item.draft)),
    string.format('- Author: %s (@%s)', item.author_name or 'unknown', item.author_username or 'unknown'),
    string.format('- Branches: %s -> %s', item.source_branch or '?', item.target_branch or '?'),
    string.format('- Merge status: %s', item.detailed_merge_status or 'unknown'),
    string.format('- Has conflicts: %s', bool_text(item.has_conflicts)),
    string.format('- Updated: %s', item.updated_at or 'unknown'),
    string.format('- Labels: %s', format_labels(item.labels)),
    string.format('- URL: %s', item.url or 'n/a'),
    '',
    '## Description',
    description,
  }

  if details and details.loading then
    lines[#lines + 1] = ''
    lines[#lines + 1] = 'Loading commit details...'
    return table.concat(lines, '\n')
  end

  lines[#lines + 1] = ''
  lines[#lines + 1] = '## Last 10 Commits'

  if details and details.commits_error then
    lines[#lines + 1] = '- Failed to load commits: ' .. details.commits_error
  elseif details and type(details.commits) == 'table' and #details.commits > 0 then
    for _, commit in ipairs(details.commits) do
      local sha = tostring(commit.short_id or commit.id or '?'):sub(1, 8)
      local message = commit.title or commit.message or 'No commit message'
      message = vim.split(message, '\n')[1]
      local author = commit.author_name or commit.author_email or 'unknown'
      lines[#lines + 1] = string.format('- `%s` %s (%s)', sha, message, author)
    end
  else
    lines[#lines + 1] = '- No commits found'
  end

  return table.concat(lines, '\n')
end

local function fetch_merge_request_details(item, callback)
  if not item.project_id or not item.iid then
    callback {
      commits_error = 'Missing project_id/iid',
    }
    return
  end

  local details = {}
  local endpoint = string.format('projects/%s/merge_requests/%s/commits?per_page=10', item.project_id, item.iid)

  run_glab_json({ 'glab', 'api', endpoint }, function(commits, commits_error)
    if commits_error then
      details.commits_error = commits_error
    elseif type(commits) == 'table' then
      details.commits = commits
    end

    callback(details)
  end)
end

local function open_merge_request_url(item)
  if not item or not item.url then
    vim.notify('Merge request URL is missing', vim.log.levels.WARN)
    return
  end

  if vim.ui.open then
    vim.ui.open(item.url)
  end
end

function M.open_merge_requests()
  local result = vim.system({ 'glab', 'mr', 'list', '--output', 'json' }, { text = true }):wait()

  if result.code ~= 0 then
    local error_message = vim.trim(result.stderr or '')
    if error_message == '' then
      error_message = 'Failed to fetch merge requests with glab'
    end
    vim.notify(error_message, vim.log.levels.ERROR)
    return
  end

  local ok, merge_requests = pcall(vim.json.decode, result.stdout or '')
  if not ok or type(merge_requests) ~= 'table' then
    vim.notify('Failed to parse merge requests from glab', vim.log.levels.ERROR)
    return
  end

  local items = {}
  for _, merge_request in ipairs(merge_requests) do
    local reference = merge_request.references and merge_request.references.short or ('!' .. tostring(merge_request.iid))
    local author_username = merge_request.author and merge_request.author.username or 'unknown'

    local item = {
      text = string.format(
        '%s %s (%s -> %s) @%s [%s]',
        reference,
        merge_request.title or '',
        merge_request.source_branch or '?',
        merge_request.target_branch or '?',
        author_username,
        merge_request.state or 'unknown'
      ),
      reference = reference,
      title = merge_request.title,
      state = merge_request.state,
      draft = merge_request.draft,
      description = merge_request.description,
      detailed_merge_status = merge_request.detailed_merge_status,
      has_conflicts = merge_request.has_conflicts,
      project_id = merge_request.project_id,
      iid = merge_request.iid,
      labels = merge_request.labels,
      author_name = merge_request.author and merge_request.author.name,
      author_username = author_username,
      updated_at = merge_request.updated_at,
      source_branch = merge_request.source_branch,
      target_branch = merge_request.target_branch,
      url = merge_request.web_url,
    }

    item.preview = {
      text = render_merge_request_preview(item),
      ft = 'markdown',
      loc = false,
    }

    table.insert(items, item)
  end

  if vim.tbl_isempty(items) then
    vim.notify('No merge requests found', vim.log.levels.INFO)
    return
  end

  local preview_cache = {}
  local preview_loading = {}

  require('snacks').picker {
    title = 'GitLab Merge Requests',
    items = items,
    format = 'text',
    preview = 'preview',
    on_change = function(picker, item)
      if not item then
        return
      end

      local key = string.format('%s:%s', tostring(item.project_id or ''), tostring(item.iid or ''))

      if preview_cache[key] then
        if type(item.preview) == 'table' and item.preview.text ~= preview_cache[key] then
          item.preview.text = preview_cache[key]
        end
        return
      end

      if preview_loading[key] then
        return
      end

      preview_loading[key] = true
      item.preview = {
        text = render_merge_request_preview(item, { loading = true }),
        ft = 'markdown',
        loc = false,
      }

      fetch_merge_request_details(item, function(details)
        local preview_text = render_merge_request_preview(item, details)
        preview_cache[key] = preview_text
        preview_loading[key] = nil
        item.preview = {
          text = preview_text,
          ft = 'markdown',
          loc = false,
        }

        vim.schedule(function()
          if picker.closed then
            return
          end

          local ok_current, current = pcall(function()
            return picker:current { resolve = false }
          end)

          if not ok_current or not current then
            return
          end

          if current.project_id == item.project_id and current.iid == item.iid then
            if picker.preview and picker.preview.refresh then
              picker.preview:refresh(picker)
            else
              picker:show_preview()
            end
          end
        end)
      end)
    end,
    actions = {
      open_url = function(picker, item)
        picker:close()
        open_merge_request_url(item)
      end,
    },
    win = {
      input = {
        footer_keys = { '<C-o>' },
        keys = {
          ['<C-o>'] = { 'open_url', mode = { 'n', 'i' }, desc = 'Open in Browser' },
        },
      },
      list = {
        keys = {
          ['<C-o>'] = 'open_url',
        },
      },
      preview = {
        wo = {
          wrap = true,
          linebreak = true,
        },
      },
    },
    confirm = function(picker, item)
      picker:close()

      if not item then
        return
      end

      local source_ref = resolve_git_ref(item.source_branch)
      local target_ref = resolve_git_ref(item.target_branch)

      if not source_ref or not target_ref then
        vim.notify('Failed to resolve merge request branches for CodeDiff', vim.log.levels.ERROR)
        open_merge_request_url(item)
        return
      end

      local comparison = string.format('%s...%s', target_ref, source_ref)

      vim.schedule(function()
        local ok_cmd, err = pcall(vim.api.nvim_cmd, {
          cmd = 'CodeDiff',
          args = { comparison },
        }, {})

        if not ok_cmd then
          local message = 'Failed to open CodeDiff for ' .. (item.reference or comparison)
          vim.notify(message .. ': ' .. tostring(err), vim.log.levels.ERROR)
          open_merge_request_url(item)
        end
      end)
    end,
  }
end

return M
