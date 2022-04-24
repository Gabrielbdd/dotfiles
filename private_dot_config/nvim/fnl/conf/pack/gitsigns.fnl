(import-macros {: buf-map!} :conf.macros)

(local {: setup} (require :gitsigns))

(fn next_hunk [gs]
  (if vim.wo.diff "]c" (do
                         (vim.schedule (fn []
                                         (gs.next_hunk)))
                         :<Ignore>)))

(fn prev_hunk [gs]
  (if vim.wo.diff "[c" (do
                         (vim.schedule (fn []
                                         (gs.prev_hunk)))
                         :<Ignore>)))

(fn on_attach []
  (local gs package.loaded.gitsigns)
  (buf-map! [n expr] "]c" (fn []
                            (next_hunk gs)))
  (buf-map! [n expr] "[c" (fn []
                            (prev_hunk gs)))
  ;; actions
  (buf-map! [n silent] :<leader>hs ":Gitsigns stage_hunk<CR>")
  (buf-map! [v silent] :<leader>hs ":Gitsigns stage_hunk<CR>")
  (buf-map! [n silent] :<leader>hr ":Gitsigns reset_hunk<CR>")
  (buf-map! [v silent] :<leader>hr ":Gitsigns reset_hunk<CR>")

  ;; text object
  (buf-map! [o] :ih ":<C-U>Gitsigns select_hunk<CR>")
  (buf-map! [x] :ih ":<C-U>Gitsigns select_hunk<CR>"))

(setup {: on_attach})
