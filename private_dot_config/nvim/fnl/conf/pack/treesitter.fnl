(import-macros {: set!} :conf.macros)
(local {: setup} (require :nvim-treesitter.configs))
(local parsers (require :nvim-treesitter.parsers))

(tset (parsers.get_parser_configs) :just
      {:install_info {:url "https://github.com/IndianBoy42/tree-sitter-just"
                      :files [:src/parser.c :src/scanner.cc]
                      :branch :main}
       :mantainers ["@IndianBoy42"]})

;; the usual
(setup {:ensure_installed {1 :lua 2 :fennel}
        :incremental_selection {:enable true
                                :keymaps {:init_selection :gnn
                                          :node_incremental :grn
                                          :scope_incremental :grc
                                          :node_decremental :grm}}
        :highlight {:enable true :use_languagetree true}
        :indent {:enable true}
        :rainbow {:enable true
                  :extended_mode true
                  :max_file_lines 1000
                  :colors ["#878d96"
                           "#a8a8a8"
                           "#8d8d8d"
                           "#a2a9b0"
                           "#8f8b8b"
                           "#ada8a8"]}
        :matchup {:enable true}
        :textsubjects {:enable true
                       :prev_selection ","
                       :keymaps {:. :textsubjects-smart
                                 ";" :textsubjects-container-outer
                                 "i;" :textsubjects-container-inner}}
        :textobjects {:select {:enable true
                               :lookahead true
                               :keymaps {:af "@function.outer"
                                         :if "@function.inner"}}}})
