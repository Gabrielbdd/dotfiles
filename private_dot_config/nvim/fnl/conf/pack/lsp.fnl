(local keymaps (require :conf.modules.core.maps))

;; must run before lsp_config[server].setup()
(let [{: setup} (require :nvim-lsp-installer)]
  (setup))

(local lsp_config (require :lspconfig))
(local cmp_lsp (require :cmp_nvim_lsp))

;; customize diagnostics
(let [{: config : severity} vim.diagnostic
      {: sign_define} vim.fn]
  (config {:underline {:severity {:min severity.INFO}}
           :signs {:severity {:min severity.INFO}}
           :virtual_text {:severity {:min severity.INFO}}
           :update_in_insert false
           :severity_sort true
           :float {:show_header false :border :single}}))

(let [{: with : handlers : diagnostic} vim.lsp]
  (set vim.lsp.handlers.textDocument/signatureHelp
       (with handlers.signature_help {:border :single}))
  (set vim.lsp.handlers.textDocument/publishDiagnostics
       (with diagnostic.on_publish_diagnostics
             {:virtual_text false :signs false}))
  (set vim.lsp.handlers.textDocument/hover
       (with handlers.hover {:border :single})))

(fn lsp_formatting [bufnr]
  (vim.lsp.buf.format {: bufnr
                       :filter (fn [client]
                                   (or (not= client.name
                                             :tsserver)
                                       (not= client.name
                                             :jsonls)
                                       (not= client.name :rnix)
                                       (not= client.name
                                             :rust_analyzer)
                                       (not= client.name
                                             :sumneko_lua)))}))

(local format-au-group (vim.api.nvim_create_augroup :LspFormatting {}))
(local highlight-au-group (vim.api.nvim_create_augroup :LspHighlighting {}))

;; language servers setup
(fn on_attach [client bufnr]
  ;; setup keymaps
  (keymaps.lsp)
  ;; format on save
  (when client.supports_method
    :textDocument/formatting
    (do
      (vim.api.nvim_clear_autocmds {:group format-au-group :buffer bufnr})
      (vim.api.nvim_create_autocmd :BufWritePre
                                   {:group format-au-group
                                    :buffer bufnr
                                    :callback (fn []
                                                (lsp_formatting bufnr))}))))

(var client_capabilities
     (-> (vim.lsp.protocol.make_client_capabilities)
         (cmp_lsp.update_capabilities)))

(local default_config {: on_attach
                       :capabilities client_capabilities})

(local sumneko_lua_config
       {: on_attach
        :capabilities client_capabilities
        :settings {:Lua {:runtime {:version :LuaJIT
                                   :path (vim.split package.path ";")}
                         :diagnostics {:globals [:vim]}
                         :workspace {:library {(vim.fn.expand :$VIMRUNTIME/lua) true
                                               (vim.fn.expand :$VIMRUNTIME/lua/vim/lsp) true}}}}})

(local jsonls_config
       {: on_attach
        :capabilities client_capabilities
        :settings {:json {:schemas (let [schemastore (require :schemastore)]
                                     (schemastore.json.schemas))}}})

(vim.lsp.set_log_level :DEBUG)

(lsp_config.jsonls.setup jsonls_config)
(lsp_config.tsserver.setup default_config)
(lsp_config.html.setup default_config)
(lsp_config.cssls.setup default_config)
;; (lsp_config.tailwindcss.setup default_config)
(lsp_config.omnisharp.setup default_config)
(lsp_config.rnix.setup default_config)
(lsp_config.sumneko_lua.setup sumneko_lua_config)
(lsp_config.rust_analyzer.setup sumneko_lua_config)
