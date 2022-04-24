(import-macros {: let! : map! : buf-map!} :conf.macros)

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
(map! [n] "[b" ":bprev<CR>")
(map! [n] "]b" ":bnext<CR>")

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

;; hotpot
;; (map! [v] :<leader>e
;;       "<cmd>lua print(require('hotpot.api.eval')['eval-selection']())<CR>")
;;
;; (map! [v] :<leader>c
;;       "<cmd>lua print(require('hotpot.api.compile')['compile-selection']())<CR>")
;;
;; (map! [n] :<leader>c
;;       "<cmd>lua print(require('hotpot.api.compile')['compile-buffer'](0))<CR>")

;; trevj
(map! [n] :gj "<cmd>lua require('trevj').format_at_cursor()<CR>")

;; trouble
(map! [n] :<leader>tt "<cmd>TroubleToggle workspace_diagnostics<CR>")

;; coq & autopairs
;; manually map coq completion's keymaps to integrate with "nvim-autopairs"
;; back space (BS) carriage return (CR) and are mappend in the "nvim-autopairs" config
(map! [i expr noremap] :<Esc> "pumvisible() ? \"<C-e><Esc>\" : \"<Esc>\"")
(map! [i expr noremap] :<C-c> "pumvisible() ? \"<C-e><C-c>\" : \"<C-c>\"")
(map! [i expr noremap] :<Tab> "pumvisible() ? \"<C-n>\" : \"<Tab>\"")
(map! [i expr noremap] :<S-Tab> "pumvisible() ? \"<C-p>\" : \"<BS>\"")

(map! [n noremap] :<M-n>
      ":lua require(\"illuminate\").next_reference{wrap=true}<CR>")

(map! [n noremap] :<M-p>
      ":lua require(\"illuminate\").next_reference{reverse=true,wrap=true}<CR>")
