(import-macros {: let! : map!} :conf.macros)

;; no highlight on escape
(map! [n] :<esc> :<esc><cmd>noh<cr>)

;; wrap/unwrap
(map! [n] :<leader>w "<cmd>set wrap!<CR>")

;; nnn
(map! [n] :<C-b> ":NnnPicker %:p:h<CR>")

;; treesitter 
(map! [n] :<Leader>th ":TSHighlightCapturesUnderCursor<CR>")
(map! [n] :<Leader>tp ":TSPlayground<CR>")

;; telescope
(map! [n] :<leader>fw "<cmd>Telescope live_grep<CR>")
(map! [n] :<leader>fb "<cmd>Telescope buffers<CR>")
(map! [n] :<leader>ff "<cmd>Telescope current_buffer_fuzzy_find<CR>")
(map! [n] :<leader><space> "<cmd>Telescope find_files<CR>")

;; toggleterm
(map! [n] "<localleader>," ":execute v:count . \"ToggleTerm\"<CR>")

;; hotpot
(map! [v] :<leader>e
      "<cmd>lua print(require('hotpot.api.eval')['eval-selection']())<CR>")

(map! [v] :<leader>c
      "<cmd>lua print(require('hotpot.api.compile')['compile-selection']())<CR>")

(map! [n] :<leader>c
      "<cmd>lua print(require('hotpot.api.compile')['compile-buffer'](0))<CR>")

;; coq & autopairs
;; manually map coq completion's keymaps to integrate with "nvim-autopairs"
;; back space (BS) carriage return (CR) and are mappend in the "nvim-autopairs" config
(map! [i expr noremap] :<Esc> "pumvisible() ? \"<C-e><Esc>\" : \"<Esc>\"")
(map! [i expr noremap] :<C-c> "pumvisible() ? \"<C-e><C-c>\" : \"<C-c>\"")
(map! [i expr noremap] :<Tab> "pumvisible() ? \"<C-n>\" : \"<Tab>\"")
(map! [i expr noremap] :<S-Tab> "pumvisible() ? \"<C-p>\" : \"<BS>\"")

(map! [n noremap] :<M-n> ":lua require(\"illuminate\").next_reference{wrap=true}<CR>")
(map! [n noremap] :<M-p> ":lua require(\"illuminate\").next_reference{reverse=true,wrap=true}<CR>")
