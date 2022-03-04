(import-macros {: pack
                : use-package!
                : unpack!
                : map!
                : buf-map!
                : let!
                : set!} :conf.macros)

;; Emacs' use-package is not a package manager! Although use-package does have the useful capability to interface with package managers, its mainly for configuring and loading packages. 
;; Still, as packer.nvim is use-package inspired, lets just think of it as a vim-y version of straight-use-package for now :)

;; The syntax is simple:
;; (use-package! <repo-name> {:keyword :arg ...} ...)
;; Please refer to :h packer.nvim for more information.

;;; Emacs' use-package is not a package manager! Although use-package does have the useful capability to interface with package managers, its mainly for configuring and loading packages.
;;; Still, as packer.nvim is use-package inspired, lets just think of it as a vim-y version of straight-use-package for now :)

;;; The syntax is simple:
;;; (use-package! <repo-name> {:keyword :arg ...} ...)
;;; Please refer to :h packer.nvim for more information. I trust the examples below are enough to get you started.

;;; One catch to the use-package! macro: It doesn't obey whats around it, whatever package declaration you create gets directly added to the global conf/pack list. To work around this, we can add aniseed/hotpot as requirements for the conjure package, then use the pack macro to load them instead.
;;; You can use the pack macro to create package declarations within a use-package! block.
;;; e.g. (use-package! :nvim-telescope/telescope.nvim {:requires [(pack :nvim-telescope/telescope-frecency.nvim {:requires [:tami5/sqlite.lua]})]}) will create a package declaration for telescope-frecency.nvim, which requires sqlite.

;;; This config also introduces the init! keyword
;;; :init! is used to initialize any package which as the form require("<name>").setup
;;; e.g. (use-package! :folke/which-key.nvim {:init :which-key}) expands to use({config = "require('which-key').setup()", "folke/which-key.nvim"})

;;; Some other notes about the package macros
;;; Packages can be added with use-package! anywhere you please, as they are added to a global list. However, make sure to call packitup! after you have declared all the packages you need to install, as the configuration will ignore everything *after* packitup! is called.
;;; Similar to use-package and pack, there are also the rock and rock! macros for declaring, you guessed it, luarock dependencies. As I don't like external dependencies (and because luarocks is *extremely* finicky on macOS), you don't see it used in this config by default. Feel free to use it yourself though.
;;; rock vs rock!: rock is to rock! as pack is to use-package!

;;; for lazy loading, here is a quick reference of the events you should use.
;;; 1. BufRead (read the contexts of demo.txt into the new buffer)
;;; 2. InsertEnter (swap into Insert mode)
;;; 3. InsertCharPre (swap into Insert mode, right when you press the first input)
;;; you can also lazy load packages on commands (:cmd), filetypes (:ft), and after other plugins (:after).

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
(use-package! :luukvbaal/nnn.nvim {:init :nnn :cmd [:NnnPicker]})

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
              {:after :telescope-fzf-native.nvim
               :config! :telescope
               :requires [(pack :nvim-lua/popup.nvim {:cmd :Telescope})
                          (pack :nvim-telescope/telescope-fzf-native.nvim
                                {:run :make :after :plenary.nvim})]})

;; tree-sitter
(use-package! :nvim-treesitter/nvim-treesitter
              {:config! :treesitter
               :run :TSUpdate
               :requires [(pack :IndianBoy42/tree-sitter-just)
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
              {:cmd :Trouble
               :config (fn []
                         (local {: setup} (require :trouble))
                         (setup {:icons false}))})

;; aesthetics
(use-package! :/home/gabriel/projects/personal/github-nvim-theme
              {:branch :feature/match-vscode-theme
               :config (fn []
                         (local {: setup} (require :github-theme))
                         (setup {:theme_style :dark
                                 :transparent false
                                 :comment_style :NONE
                                 :keyword_style :NONE
                                 :function_style :NONE
                                 :variable_style :NONE
                                 :dark_sidebar true
                                 :dark_float true}))})

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


;; utils
(use-package! :tpope/vim-repeat)
(use-package! :norcalli/nvim-colorizer.lua
              {:init :colorizer :cmd [:ColorizerToggle]})

;; At the end of the file, the unpack! macro is called to initialize packer and pass each package to the packer.nvim plugin.
(unpack!)
