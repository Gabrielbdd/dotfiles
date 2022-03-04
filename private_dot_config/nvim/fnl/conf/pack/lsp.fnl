(import-macros {: buf-map!} :conf.macros)

(local config (require :lspconfig))

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
(local lsp_installer (require :nvim-lsp-installer))

(fn on-attach [client bufnr]
  (buf-map! [n noremap silent] :gd ":lua vim.lsp.buf.definition()<CR>")
  (buf-map! [n noremap silent] :gi ":lua vim.lsp.buf.implementation()<CR>")
  (buf-map! [n noremap silent] :gr ":lua vim.lsp.buf.references()<CR>")
  (buf-map! [n noremap silent] :K ":lua vim.lsp.buf.hover()<CR>")
  (buf-map! [n noremap silent] :rn ":lua vim.lsp.buf.rename()<CR>")
  (buf-map! [n noremap silent] :<space>ca ":lua vim.lsp.buf.code_action()<CR>")
  (buf-map! [n noremap silent] :<space>e ":lua vim.diagnostic.open_float()<CR>")
  (buf-map! [n noremap silent] "[d" ":lua vim.diagnostic.goto_prev()<CR>")
  (buf-map! [n noremap silent] "]d" ":lua vim.diagnostic.goto_next()<CR>")
  ;; disable formatting for languages that is formatted using "null-ls"
  (when (or (= client.name :tsserver) (= client.name :jsonls)
            (= client.name :rnix))
    (set client.resolved_capabilities.document_formatting false)
    (set client.resolved_capabilities.document_range_formatting false)))

(local client_capabilities
       ((. (require :coq) :lsp_ensure_capabilities) (vim.lsp.protocol.make_client_capabilities)))

(local sumneko_lua_config
       {:on_attach on-attach
        :capabilities client_capabilities
        :settings {:Lua {:runtime {:version :LuaJIT
                                   :path (vim.split package.path ";")}
                         :diagnostics {:globals [:vim]}
                         :workspace {:library {(vim.fn.expand :$VIMRUNTIME/lua) true
                                               (vim.fn.expand :$VIMRUNTIME/lua/vim/lsp) true}}}}})

(local jsonls_config
       {:on_attach on-attach
        :capabilities client_capabilities
        :settings {:json {:schemas (let [schemastore (require :schemastore)]
                                     (schemastore.json.schemas))}}})

(local default_config {:on_attach on-attach :capabilities client_capabilities})

(lsp_installer.on_server_ready (fn [server]
                                 (let [config (if (= server.name :sumneko_lua)
                                                  sumneko_lua_config
                                                  (= server.name :jsonls)
                                                  jsonls_config
                                                  default_config)]
                                   (server:setup config))))
