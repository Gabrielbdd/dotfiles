(local {: setup} (require :gitsigns))
(local keymaps (require :conf.modules.core.maps))

(fn on_attach []
  (keymaps.gitsigns))

(setup {: on_attach})
