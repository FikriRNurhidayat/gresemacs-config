;;; fain-editor.el -*- lexical-binding: t; -*-
(ensure-packages-installed '(evil evil-collection tree-sitter tree-sitter-langs yasnippet))

;; Evil
(setq evil-want-keybinding nil)
(evil-collection-init)
(evil-mode 1)

(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
(add-to-list 'tree-sitter-major-mode-language-alist '(org-mode . org))
