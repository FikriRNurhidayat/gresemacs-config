;;; fain-editor.el -*- lexical-binding: t; -*-

(use-package tree-sitter
  :ensure t
  :hook ((js-mode go-mode org-mode) . tree-sitter-mode)
  :config
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package tree-sitter-langs
  :ensure t
  :defer t)

(use-package magit
  :ensure t
  :defer t)

(use-package visual-fill-column
  :ensure t
  :hook (visual-line-mode . visual-fill-column-mode)
  :custom
  (visual-fill-column-center-text t)
  (visual-fill-column-width 74))

(use-package csv-mode
  :ensure t
  :hook (csv-mode . csv-align-mode)
  :init
  (add-hook 'csv-mode-hook '(lambda () (interactive) (toggle-truncate-lines nil))))

(setq-default indent-tabs-mode nil
              tab-width 2
              c-basic-offset 2
              standard-indent 2)

(setq make-backup-files nil
      auto-save-default nil
      completion-ignored-extensions '("#" "~" ".o" ".elc" ".pyc" ".class")
      scroll-conservatively 10000
      scroll-margin 3
      x-underline-at-descent-line t
      xref-search-program 'ripgrep)

(delete-selection-mode 1)

(defun kill-other-buffers ()
  "Kill other buffers."
  (interactive)
  (mapc 'kill-buffer (delete (current-buffer) (buffer-list))))

(define-key prog-mode-map (kbd "C-M-;") 'comment-region)
(global-set-key (kbd "C-c C-g") 'magit)
(global-set-key (kbd "C-x C-k C-o") 'kill-other-buffers)

;;; fain-editor.el ends here
