# firebain in ~/dotfiles >
function fish_prompt
    set -l last_status $status

    set -l stat
    if test $last_status -ne 0
        set stat (set_color red)"[$last_status]"(set_color normal)
    end

    echo -n (set_color green)(whoami)(set_color normal) in (set_color green)(prompt_pwd)(set_color normal) $stat '> '
end