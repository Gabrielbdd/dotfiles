;; highli yanked text
(import-macros {: set! : let!} :conf.macros)

;; ================ General ================
;; add leader keys
(let! mapleader " ")
(let! maplocalleader ",")

;; disable the ruler
(set! noru)

;; show whitespaces as characters 
(set! list)

;; emable mouse
(set! mouse :a)

;; enable undo (and disable the swap/backup)
(set! undofile)
(set! noswapfile)
(set! nowritebackup)

;; smart searching
(set! smartcase)

;; add some padding while scrolling
(set! scrolloff 3)

;; the default updatetime in vim is around 4 seconds. This messes with gitsigns and the like, lets reduce it
(set! updatetime 300)

;; faster response
(set! timeoutlen 250)

;; universal clipboard support
(set! clipboard :unnamedplus)

;; ================ Editing ================
;; tab = 2 spaces
(set! expandtab)
(set! tabstop 2)
(set! shiftwidth 0)

;; ================ Folds ================
;; (set! foldenable)
;; (set! foldmethod :indent)
;; (set! foldlevel 1)
;; (set! foldnestmax 10)
;; (set! foldcolumn :0)

;; ================ UI ================
;; faster macros 
(set! lazyredraw)

;; filename + lineno
(set! statusline "%F%m%r%h%w: %2l")
(set! laststatus 3)

;; disable line numbers
(set! nonumber)

;; as many signs in the signcolumn as you like, width is auto-adjusted. 
;; (set! signcolumn "auto:1-9")
(set! signcolumn :yes)

;; do not show mode
(set! noshowmode)

;; remove the informative but slightly ugly eob tilde fringe
(set! fillchars "eob: ")

;; ================ Auto commands ================
;; highlight yanked text
(vim.api.nvim_create_autocmd [:TextYankPost]
                             {:pattern ["*"]
                              :callback (fn []
                                          (vim.highlight.on_yank))})

;; ================ Misc ================
;; disable unessecary plugins & providers
(let [built-ins [:2html_plugin
                 :getscript
                 :getscriptPlugin
                 :gzip
                 :logipat
                 :matchit
                 :netrw
                 :netrwFileHandlers
                 :netrwPlugin
                 :netrwSettings
                 :rrhelper
                 :spellfile_plugin
                 :tar
                 :tarPlugin
                 :vimball
                 :vimballPlugin
                 :zip
                 :zipPlugin]
      providers [:perl :python :python3 :node :ruby]]
  (each [_ v (ipairs built-ins)]
    (let [b (.. :loaded_ v)]
      (tset vim.g b 1)))
  (each [_ v (ipairs providers)]
    (let [p (.. :loaded_ v :_provider)]
      (tset vim.g p 0))))
