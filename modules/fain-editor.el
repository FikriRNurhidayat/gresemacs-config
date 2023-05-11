;;; fain-editor.el -*- lexical-binding: t; -*-

(ensure-packages-installed '(tree-sitter tree-sitter-langs yasnippet yaml-mode magit))

(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
(add-to-list 'tree-sitter-major-mode-language-alist '(org-mode . org))

(setq scroll-conservatively 10000)
(setq scroll-margin 3)

(delete-selection-mode 1)               ; Allow us to replace text on selected region

(setq-default indent-tabs-mode nil)     ; Disable tabs, use spaces

(setq make-backup-files nil)            ; Disable backup files
(setq auto-save-default nil)            ; Disable auto save files

(define-key prog-mode-map (kbd "C-M-;") 'comment-region)
(global-set-key (kbd "C-c C-g") 'magit)

;;; fain-editor.el ends here
