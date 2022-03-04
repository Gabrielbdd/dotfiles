(local {: setup} (require :telescope))
(local ffi (require :ffi))

(setup {:defaults {:prompt_prefix "   "
                   :selection_caret "  "
                   :entry_prefix "  "
                   :sorting_strategy :ascending
                   :layout_strategy :horizontal
                   :layout_config {:horizontal {:prompt_position :top
                                                :preview_width 0.55
                                                :results_width 0.8}
                                   :vertical {:mirror false}
                                   :width 0.87
                                   :height 0.8
                                   :preview_cutoff 120}
                   :use_less false
                   :set_env {:COLORTERM :truecolor}
                   :dynamic_preview_title true}})

;; load our extensions
((. (require :telescope) :load_extension) :fzf)
