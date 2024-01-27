;;; fain-editor.el -*- lexical-binding: t; -*-

(use-package tree-sitter)
(use-package tree-sitter-langs)
(use-package yasnippet)
(use-package yaml-mode)
(use-package magit)

(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
(add-to-list 'tree-sitter-major-mode-language-alist '(org-mode . org))

(setq scroll-conservatively 10000)
(setq scroll-margin 3)

(setq x-underline-at-descent-line t)

(delete-selection-mode 1)               ; Allow us to replace text on selected region

(setq-default indent-tabs-mode nil)     ; Disable tabs, use spaces
(setq-default tab-width 2)
(setq-default c-basic-offset 2)
(setq-default standard-indent 2)

(setq make-backup-files nil)            ; Disable backup files
(setq auto-save-default nil)            ; Disable auto save files
(setq completion-ignored-extensions '("#" "~" ".o" ".elc" ".pyc" ".class"))

(define-key prog-mode-map (kbd "C-M-;") 'comment-region)
(global-set-key (kbd "C-c C-g") 'magit)

(defun kill-other-buffers ()
  "Kill other buffers."
  (interactive)
  (mapc 'kill-buffer (delete (current-buffer) (buffer-list))))

(global-set-key (kbd "C-x C-k C-o") 'kill-other-buffers)

;;; fain-editor.el ends here
