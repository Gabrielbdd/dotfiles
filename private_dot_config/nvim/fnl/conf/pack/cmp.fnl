(local cmp (require :cmp))
(local luasnip (require :luasnip))

;; vs code like icons
(local cmp_kinds {:Text " "
                  :Method " "
                  :Function " "
                  :Constructor " "
                  :Field " "
                  :Variable " "
                  :Class " "
                  :Interface " "
                  :Module " "
                  :Property " "
                  :Unit " "
                  :Value " "
                  :Enum " "
                  :Keyword " "
                  :Snippet " "
                  :Color " "
                  :File " "
                  :Reference " "
                  :Folder " "
                  :EnumMember " "
                  :Constant " "
                  :Struct " "
                  :Event " "
                  :Operator " "
                  :TypeParameter " "})

(fn has-words-before []
  (local (line col) (unpack (vim.api.nvim_win_get_cursor 0)))
  (and (not= col 0) (-?> (vim.api.nvim_buf_get_lines 0 (- line 1) line true)
                         (. 0)
                         (: :sub col col)
                         (: :match "%s")
                         (= nil))))

(cmp.setup {:snippet {:expand (fn [args]
                                (luasnip.lsp_expand args.body))}
            ;; vs code like icons
            :formatting {:format (fn [_ item]
                                   (set item.kind
                                        (-> (. cmp_kinds item.kind)
                                            (or "")))
                                   item)
                         :fields [:kind :abbr]}
            :mapping {:<tab> (cmp.mapping (fn [fallback]
                                            (if (cmp.visible)
                                                (cmp.select_next_item)
                                                ;; (luasnip.expand_or_jumpable)
                                                ;; (luasnip.expand_or_jump)
                                                (has-words-before)
                                                (cmp.complete)
                                                (fallback)))
                                          [:i :s])
                      :<s-tab> (cmp.mapping (fn [fallback]
                                              (if (cmp.visible)
                                                  (cmp.select_prev_item)
                                                  ;; (luasnip.jumpable -1)
                                                  ;; (luasnip.jump -1)
                                                  (fallback)))
                                            [:i :s])
                      :<c-space> (cmp.mapping (cmp.mapping.complete) [:i :c])
                      :<cr> (cmp.mapping {:i (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Replace
                                                                   :select false})})}
            ;; :c (fn [fallback]
            ;;      (if (cmp.visible)
            ;;          (cmp.confirm {:behavior cmp.ConfirmBehavior.Replace
            ;;                        :select false})
            ;;          (fallback)))})}
            :sources (cmp.config.sources [{:name :nvim_lsp}
                                          {:name :luasnip}
                                          {:name :path}]
                                         [{:name :buffer}])})

;; (cmp.setup.cmdline ":"
;;                    {:mapping (cmp.mapping.preset.cmdline)
;;                     :sources (cmp.config.sources [{:name :path}]
;;                                                  [{:name :cmdline}])})
