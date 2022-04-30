(import-macros {: buf-map!} :conf.macros)

;; must run before lsp_config[server].setup()
(let [{: setup} (require :nvim-lsp-installer)]
  (setup))

(local lsp_config (require :lspconfig))

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

;; language servers setup
(fn on_attach [client bufnr]
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
  (buf-map! [n noremap silent] "]d" ":lua vim.diagnostic.goto_next()<CR>")
  ;; disable formatting for languages that is formatted using "null-ls"
  (when (or (= client.name :tsserver) (= client.name :jsonls)
            (= client.name :rnix) (= client.name :rust_analyzer)
            (= client.name :sumneko_lua))
    (set client.resolved_capabilities.document_formatting false)
    (set client.resolved_capabilities.document_range_formatting false)))

(local client_capabilities
       ((. (require :coq) :lsp_ensure_capabilities) (vim.lsp.protocol.make_client_capabilities)))

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

(local default_config {: on_attach :capabilities client_capabilities})

(lsp_config.jsonls.setup jsonls_config)
(lsp_config.tsserver.setup default_config)
(lsp_config.html.setup default_config)
(lsp_config.cssls.setup default_config)
(lsp_config.tailwindcss.setup default_config)
(lsp_config.omnisharp.setup default_config)
(lsp_config.rnix.setup default_config)
(lsp_config.sumneko_lua.setup sumneko_lua_config)
