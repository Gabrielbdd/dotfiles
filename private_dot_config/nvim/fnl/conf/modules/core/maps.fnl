(import-macros {: let! : map! : buf-map!} :conf.macros)

(local M {})

;; =================== General ===================

;; no highlight on escape
(map! [n] :<esc> :<esc><cmd>noh<cr>)

;; wrap/unwrap
(map! [n] :<leader>w "<cmd>set wrap!<CR>")

;; better navigation between splits
(map! [n] :<c-h> :<c-w>h)
(map! [n] :<c-j> :<c-w>j)
(map! [n] :<c-k> :<c-w>k)
(map! [n] :<c-l> :<c-w>l)

;; better navigation between buffers
;; (map! [n] "[b" ":bprev<CR>")
;; (map! [n] "]b" ":bnext<CR>")

;; esier way to het into command mode
(map! [n] ";" ":")

;; =================== Plugins ===================

;; nvim-tree
(map! [n silent] :<C-b> ":NvimTreeFindFileToggle<CR>")

;; treesitter 
(map! [n] :<Leader>th ":TSHighlightCapturesUnderCursor<CR>")
(map! [n] :<Leader>tp ":TSPlayground<CR>")

;; telescope
(map! [n] :<leader>fw "<cmd>Telescope live_grep<CR>")
(map! [n] :<leader>fb "<cmd>Telescope buffers<CR>")
(map! [n] :<leader>ff "<cmd>Telescope current_buffer_fuzzy_find<CR>")
(map! [n] :<leader><space> "<cmd>Telescope find_files<CR>")
(map! [n] "<leader>:" "<cmd>Telescope keymaps<CR>")

;; toggleterm
(vim.api.nvim_create_autocmd [:TermOpen]
                             {:pattern ["term://*toggleterm#*"]
                              :callback (fn []
                                          (buf-map! [t noremap] :<esc>
                                                    "<c-\\><c-n>")
                                          (buf-map! [t noremap] :<c-h>
                                                    "<c-\\><c-n><c-W>h")
                                          (buf-map! [t noremap] :<c-j>
                                                    "<c-\\><c-n><c-W>j")
                                          (buf-map! [t noremap] :<c-k>
                                                    "<c-\\><c-n><c-W>k")
                                          (buf-map! [t noremap] :<c-l>
                                                    "<c-\\><c-n><c-W>l"))})

;; iswap
(map! [n noremap] :<m-h> :<cmd>ISwapCursorNodeLeft<CR>)
(map! [n noremap] :<m-l> :<cmd>ISwapCursorNodeRight<CR>)

;; hotpot
;; (map! [v] :<leader>e
;;       "<cmd>lua print(require('hotpot.api.eval')['eval-selection']())<CR>")
;;
;; (map! [v] :<leader>c
;;       "<cmd>lua print(require('hotpot.api.compile')['compile-selection']())<CR>")

(map! [n] :<localleader>c
      "<cmd>lua print(require('hotpot.api.compile')['compile-buffer'](0))<CR>")

;; trevj
(map! [n] :gj "<cmd>lua require('trevj').format_at_cursor()<CR>")

;; trouble
(map! [n] :<leader>tt "<cmd>TroubleToggle workspace_diagnostics<CR>")
;; (map! [n noremap] :<M-n>
;;       ":lua require(\"illuminate\").next_reference{wrap=true}<CR>")
;;
;; (map! [n noremap] :<M-p>
;;       ":lua require(\"illuminate\").next_reference{reverse=true,wrap=true}<CR>")

(fn M.lsp []
  ;; lsp keymaps
  ;; (buf-map! [n noremap silent] :gd ":lua vim.lsp.buf.definition()<CR>")
  ;; (buf-map! [n noremap silent] :gi ":lua vim.lsp.buf.implementation()<CR>")
  ;; (buf-map! [n noremap silent] :gr ":lua vim.lsp.buf.references()<CR>")
  (buf-map! [n noremap silent] :gd ":Telescope lsp_definitions<CR>")
  (buf-map! [n noremap silent] :gi ":Telescope lsp_implementations<CR>")
  (buf-map! [n noremap silent] :gr ":Telescope lsp_references<CR>")
  (buf-map! [n noremap silent] :<space>ca ":lua vim.lsp.buf.code_action()<CR>")
  (buf-map! [v noremap silent] :<space>ca
            ":lua vim.lsp.buf.range_code_action()<CR>")
  (buf-map! [n noremap silent] :K ":lua vim.lsp.buf.hover()<CR>")
  (buf-map! [n noremap silent] :rn ":lua vim.lsp.buf.rename()<CR>")
  (buf-map! [n noremap silent] :<space>e ":lua vim.diagnostic.open_float()<CR>")
  (buf-map! [n noremap silent] "[d" ":lua vim.diagnostic.goto_prev()<CR>")
  (buf-map! [n noremap silent] "]d" ":lua vim.diagnostic.goto_next()<CR>"))

;; git signs
(fn M.gitsigns []
  ;; movements
  (buf-map! [n silent] "]c" ":Gitsigns next_hunk<CR>")
  (buf-map! [n silent] "[c" ":Gitsigns prev_hunk<CR>")
  ;; actions
  (buf-map! [n silent] :<leader>hs ":Gitsigns stage_hunk<CR>")
  (buf-map! [v silent] :<leader>hs ":Gitsigns stage_hunk<CR>")
  (buf-map! [n silent] :<leader>hr ":Gitsigns reset_hunk<CR>")
  (buf-map! [v silent] :<leader>hr ":Gitsigns reset_hunk<CR>")
  ;; text object
  (buf-map! [o] :ih ":<C-U>Gitsigns select_hunk<CR>")
  (buf-map! [x] :ih ":<C-U>Gitsigns select_hunk<CR>"))

;; lua snip
(fn M.luasnip []
  (fn next-jump []
    (local ls (require :luasnip))
    (if (ls.expand_or_jumpable)
        (ls.expand_or_jump)))

  (fn prev-jump []
    (local ls (require :luasnip))
    (if (ls.jumpable -1)
        (ls.jump -1)))

  (fn next-choice []
    (local ls (require :luasnip))
    (if (ls.choice_active)
        (ls.change_choice 1)))

  (fn prev-choice []
    (local ls (require :luasnip))
    (if (ls.choice_active)
        (ls.change_choice -1)))

  (map! [i] :<m-k> next-jump)
  (map! [s] :<m-k> next-jump)
  (map! [i] :<m-j> prev-jump)
  (map! [s] :<m-j> prev-jump)
  (map! [i] :<m-l> next-choice)
  (map! [s] :<m-l> next-choice)
  (map! [i] :<m-h> prev-choice)
  (map! [s] :<m-h> prev-choice))

M
