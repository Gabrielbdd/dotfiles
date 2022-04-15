(import-macros {: let!} :conf.macros)
(local {: setup} (require :nvim-tree))

(let! nvim_tree_git_hl 1)
(let! nvim_tree_group_empty 1)
(let! nvim_tree_highlight_opened_files 1)
(let! nvim_tree_special_files {})
(let! nvim_tree_root_folder_modifier ":p:~")
(let! nvim_tree_show_icons {:git 0 :folder 0 :files 0 :folder_arrows 0})

(setup {:diagnostic {:enable true}
        :tab_open true
        :auto_close false
        :view {:width 40}
        :actions {:open_file {:quit_on_open true}}})
