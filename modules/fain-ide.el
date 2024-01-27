;; fain-ide.el  -*- lexical-binding: t -*-

(use-package eglot)
(use-package go-mode)
(use-package rust-mode)
(use-package simple-httpd)
(use-package geiser)
(use-package geiser-guile)
(use-package elm-mode)
(use-package typescript-mode)

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '((rust-ts-mode rust-mode) . ("rustup" "run" "stable" "rust-analyzer"))))

(defun fain/programming-view ()
  "Setup programming view."
  (visual-line-mode 0)
  (setq-default)
  (setq truncate-lines t)
  (setq indent-tabs-mode nil)
  (setq tab-width 2)
  (setq js-indent-level 2)
  (setq c-basic-offset 2)
  (setq standard-indent 2))

(defun fain/ensure-lsp ()
  "Run lsp."
  (interactive)
  (fain/programming-view)
  (add-hook 'before-save-hook 'eglot-format-buffer)
  (eglot-ensure))

(add-hook 'prog-mode-hook #'fain/programming-view)
(dolist (mode-hook '(c-mode-hook
                     c++-mode-hook
                     go-mode-hook
                     rust-mode-hook
                     js-mode-hook))
  (add-hook mode-hook 'fain/ensure-lsp))

(define-key eglot-mode-map (kbd "C-c a") 'eglot-code-actions)
(define-key eglot-mode-map (kbd "M-c f f") 'eglot-format)
(define-key eglot-mode-map (kbd "C-c f b") 'eglot-format-buffer)
(define-key eglot-mode-map (kbd "C-c C-r") 'eglot-rename)
(define-key eglot-mode-map (kbd "C-c o") 'eglot-code-action-organize-imports)
(define-key eglot-mode-map (kbd "C-c h") 'eldoc)
(define-key eglot-mode-map (kbd "C-c r") 'eglot-reconnect)
(define-key eglot-mode-map (kbd "C-c c f") 'xref-find-definitions)

(setq flymake-fringe-indicator-position nil)

;;; fain-ide.el ends here
