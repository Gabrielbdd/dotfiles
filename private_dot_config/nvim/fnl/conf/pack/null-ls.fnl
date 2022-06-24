(local {: setup : builtins : methods : generator : register} (require :null-ls))
(local {: diagnostics : formatter_factory} (require :null-ls.helpers))

;; register formatter for Justfile
(local justfmt {:name :justfmt
                :method methods.FORMATTING
                :filetypes [:just]
                :generator (generator {:command :just
                                       :args [:--unstable :--fmt]
                                       :from_stderr true
                                       :on_output (fn []
                                                    ;; call "edit" command to force the buffer to update
                                                    ;; as the format command writes directly to the file
                                                    (vim.cmd :e))})
                :factory formatter_factory})

(register justfmt)

(setup {:sources [builtins.formatting.fnlfmt
                  builtins.formatting.stylua
                  builtins.formatting.prettierd
                  builtins.formatting.nixfmt
                  builtins.formatting.rustfmt
                  builtins.code_actions.refactoring
                  justfmt]})
