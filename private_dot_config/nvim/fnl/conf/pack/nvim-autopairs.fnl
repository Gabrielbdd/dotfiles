(import-macros {: map!} :conf.macros)

(local npairs (require :nvim-autopairs))

(npairs.setup {:check_ts true :map_bs false :map_cr false})

;; setup back space (BS) and carriage return (CR) mappings to integrate with "coq" completion

(fn autopairs_cr []
  (npairs.autopairs_cr (vim.api.nvim_get_current_buf)))

(fn autopairs_bs []
  (npairs.autopairs_bs (vim.api.nvim_get_current_buf)))

(global PairsUtils {})
(tset PairsUtils :CR (fn []
                       (if (not= (vim.fn.pumvisible) 0)
                           (let [complete_info (vim.fn.complete_info [:selected])]
                             (if (not= complete_info.selected -1)
                                 (npairs.esc :<c-y>)
                                 (.. (npairs.esc :<c-e>) (autopairs_cr))))
                           (autopairs_cr))))

(tset PairsUtils :BS (fn []
                       (if (and (not= (vim.fn.pumvisible) 0)
                                (let [complete_info (vim.fn.complete_info [:mode])]
                                  (= complete_info.mode :eval)))
                           (.. (npairs.esc :<c-e>) (autopairs_bs))
                           (autopairs_bs))))

(map! [i expr noremap] :<CR> "v:lua.PairsUtils.CR()")
(map! [i expr noremap] :<BS> "v:lua.PairsUtils.BS()")
