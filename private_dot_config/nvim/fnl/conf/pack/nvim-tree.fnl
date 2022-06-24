(import-macros {: let!} :conf.macros)
(local {: setup} (require :nvim-tree))

(setup {:diagnostics {:enable true}
        :renderer {:highlight_git true
                   :group_empty true
                   :highlight_opened_files :none
                   :root_folder_modifier ":p:~"
                   :special_files {}
                   :icons {:show {:folder true
                                  :file true
                                  :folder_arrow true}}}
        :view {:width 40}
        :actions {:open_file {:quit_on_open true}}})
