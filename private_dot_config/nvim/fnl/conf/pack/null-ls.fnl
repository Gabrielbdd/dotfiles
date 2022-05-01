(import-macros {: buf-map!} :conf.macros)
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

;; format on save
(fn lsp-formatting [bufnr]
  (vim.lsp.buf.format {: bufnr
                       :filter (fn [clients]
                                 (vim.tbl_filter (fn [client]
                                                   (or (not= client.name
                                                             :tsserver)
                                                       (not= client.name
                                                             :jsonls)
                                                       (not= client.name :rnix)
                                                       (not= client.name
                                                             :rust_analyzer)
                                                       (not= client.name
                                                             :sumneko_lua)))
                                                 clients))}))

(local auto-group (vim.api.nvim_create_augroup :LspFormatting {}))

(fn on-attach [client bufnr]
  (when client.supports_method
    :textDocument/formatting
    (do
      (vim.api.nvim_clear_autocmds {:group auto-group :buffer bufnr})
      (vim.api.nvim_create_autocmd :BufWritePre
                                   {:group auto-group
                                    :buffer bufnr
                                    :callback (fn []
                                                (lsp-formatting bufnr))}))))

(setup {:sources [builtins.formatting.fnlfmt
                  builtins.formatting.stylua
                  builtins.formatting.prettierd
                  builtins.formatting.nixfmt
                  builtins.formatting.rustfmt
                  justfmt]
        :on_attach on-attach})
