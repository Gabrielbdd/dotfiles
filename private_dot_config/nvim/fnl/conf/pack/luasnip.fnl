(local ls (require :luasnip))
(local {: load} (require :luasnip.loaders.from_lua))
(local keymaps (require :conf.modules.core.maps))

(load {:paths "~/.config/nvim/fnl/conf/snippets"})

(keymaps.luasnip luasnip)
