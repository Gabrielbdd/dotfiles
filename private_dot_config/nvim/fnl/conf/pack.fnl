(import-macros {: pack
                : use-package!
                : unpack!
                : map!
                : buf-map!
                : let!
                : set!} :conf.macros)

;; Bootstrap essential plugins
(use-package! :wbthomason/packer.nvim)
(use-package! :lewis6991/impatient.nvim)
(use-package! :nvim-lua/plenary.nvim)

;; There are some plugins we only want to load for lisps. Heres a list of lispy filetypes I use
(local lisp-ft [:fennel :clojure :lisp :racket :scheme])

;; lispy configs
(use-package! :rktjmp/hotpot.nvim)
(use-package! :eraserhd/parinfer-rust
              {:ft lisp-ft :run "cargo build --release"})

;; file explorer
(use-package! :kyazdani42/nvim-tree.lua
              {:requires :kyazdani42/nvim-web-devicons
               :config! :nvim-tree
               :cmd [:NvimTreeFindFileToggle]})

;; completion
(use-package! :ms-jpq/coq_nvim
              {:branch :coq
               :module :coq
               :setup (fn []
                        (let! coq_settings
                              {:auto_start :shut-up
                               :keymap {:recommended false}
                               :display {:pum {:kind_context [" " ""]
                                               :source_context [" " ""]}
                                         :ghost_text {:context [" " ""]}
                                         :icons {:mode :short
                                                 :mappings {:Text ""
                                                            :Method ""
                                                            :Function ""
                                                            :Constructor ""
                                                            :Field ""
                                                            :Variable ""
                                                            :Class ""
                                                            :Interface ""
                                                            :Module ""
                                                            :Property ""
                                                            :Unit ""
                                                            :Value ""
                                                            :Enum ""
                                                            :Keyword ""
                                                            :Snippet ""
                                                            :Color ""
                                                            :File ""
                                                            :Reference ""
                                                            :Folder ""
                                                            :EnumMember ""
                                                            :Constant ""
                                                            :Struct ""
                                                            :Event ""
                                                            :Operator ""
                                                            :TypeParameter ""}}}}))})

;; commenting
(use-package! :numToStr/Comment.nvim {:init :Comment :event :BufRead})

;; auto pairs
(use-package! :windwp/nvim-autopairs {:event :BufRead :config! :nvim-autopairs})

;; Fuzzy navigation
;; the loading order for this one is a bit weird, but it works. Extensions are loaded on their command, fzf native is loaded first, then telescope.nvim after fzf.
(use-package! :nvim-telescope/telescope.nvim
              {;;:after :telescope-fzf-native.nvim
               :config! :telescope
               :requires [(pack :nvim-telescope/telescope-fzf-native.nvim
                                {:run :make :after :plenary.nvim})
                          (pack :nvim-lua/popup.nvim {:cmd :Telescope})]})

;; tree-sitter
(use-package! :nvim-treesitter/nvim-treesitter
              {:config! :treesitter
               :run :TSUpdate
               :requires [(pack :IndianBoy42/tree-sitter-just)
                          (pack :RRethy/nvim-treesitter-textsubjects)
                          (pack :nvim-treesitter/nvim-treesitter-textobjects)
                          (pack :nvim-treesitter/playground
                                {:cmd [:TSPlayground
                                       :TSHighlightCapturesUnderCursor]})]})

;; lsp
(use-package! :neovim/nvim-lspconfig
              {:config! :lsp
               :requires [(pack :williamboman/nvim-lsp-installer
                                {:module :nvim-lsp-installer})
                          (pack :b0o/schemastore.nvim {:module :schemastore})]
               :event :BufRead})

(use-package! :jose-elias-alvarez/null-ls.nvim
              {:config! :null-ls :event :BufRead})

(use-package! :folke/trouble.nvim
              {:cmd [:Trouble :TroubleToggle]
               :config (fn []
                         (local {: setup} (require :trouble))
                         (setup {:icons false}))})

(use-package! :j-hui/fidget.nvim
              {:config (fn []
                         (local {: setup} (require :fidget))
                         (setup {}))})

;; git
(use-package! :lewis6991/gitsigns.nvim {:config! :gitsigns :event :BufRead})

;; aesthetics
;; (use-package! :projekt0n/github-nvim-theme {})
;; :branch :feature/match-vscode-theme
;; :config (fn []
;;           (local {: setup} (require :github-theme))
;;           (setup {:theme_style :dark
;;                   :transparent false
;;                   :comment_style :NONE
;;                   :keyword_style :NONE
;;                   :function_style :NONE
;;                   :variable_style :NONE
;;                   :dark_sidebar true
;;                   :dark_float true}))})

(use-package! :rktjmp/lush.nvim)
(use-package! :/home/gabriel/projects/personal/rider-dark
              {:setup (fn []
                        (set! termguicolors)
                        (vim.cmd "colorscheme rider-dark"))})

(use-package! :rcarriga/nvim-notify
              {:config (fn []
                         (local notify (require :notify))
                         (set vim.notify notify)
                         (notify.setup {:stages :slide
                                        :timeout 2500
                                        :minimum_width 50
                                        :icons {:ERROR ""
                                                :WARN ""
                                                :INFO ""
                                                :DEBUG ""
                                                :TRACE "✎"}}))})

;; terminal
(use-package! :akinsho/toggleterm.nvim
              {:config (fn []
                         (local {: setup} (require :toggleterm))
                         (setup {:insert_mappings false}))
               :cmd [:ToggleTerm]})

;; editing
;; apply .editorconfig settings
(use-package! :gpanders/editorconfig.nvim {:event :BufRead})

;; surrounding utilities
(use-package! :ur4ltz/surround.nvim
              {:event :BufRead
               :config (fn []
                         (local {: setup} (require :surround))
                         (setup {:mappings_style :surround}))})

(use-package! :AckslD/nvim-trevJ.lua
              {:module :trevj
               :config (fn []
                         (local {: setup} (require :trevj))
                         (setup {:containers {:cs {:parameter_list {:final_separator ","
                                                                    :final_end_line true
                                                                    :skip {}}
                                                   :argument_list {:final_separator false
                                                                   :final_end_line true
                                                                   :skip {}}
                                                   :initializer_expression {:final_separator ","
                                                                            :final_end_line true
                                                                            :skip {}}}}}))})

;; utils
(use-package! :tpope/vim-repeat)
(use-package! :norcalli/nvim-colorizer.lua
              {:init :colorizer :cmd [:ColorizerToggle]})

;; At the end of the file, the unpack! macro is called to initialize packer and pass each package to the packer.nvim plugin.
(unpack!)

;; parinfer
