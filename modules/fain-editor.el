;;; fain-editor.el -*- lexical-binding: t; -*-
(ensure-packages-installed '(tree-sitter tree-sitter-langs yasnippet yaml-mode))

(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
(add-to-list 'tree-sitter-major-mode-language-alist '(org-mode . org))

(setq scroll-conservatively 10000)
(setq scroll-margin 3)

(delete-selection-mode 1)

(define-key prog-mode-map (kbd "C-M-;") 'comment-region)
