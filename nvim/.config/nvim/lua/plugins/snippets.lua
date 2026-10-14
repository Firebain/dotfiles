local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node

ls.setup {}

ls.add_snippets('go', {
  s('ife', {
    t { 'if err != nil' },
    t { ' {', '\t' },
    t { 'return nil' },
    t { '', '}' },
  }),
  s('ifp', {
    t { 'if err != nil' },
    t { ' {', '\t' },
    t { 'panic(err)' },
    t { '', '}' },
  }),
})
