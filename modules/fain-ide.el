;; fain-ide.el  -*- lexical-binding: t -*-

(ensure-packages-installed '(eglot go-mode rust-mode simple-httpd geiser geiser-guile))

(add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)
(add-hook 'go-mode-hook 'eglot-ensure)

(define-key eglot-mode-map (kbd "C-c a") 'eglot-code-actions)
(define-key eglot-mode-map (kbd "M-c f f") 'eglot-format)
(define-key eglot-mode-map (kbd "C-c f b") 'eglot-format-buffer)
(define-key eglot-mode-map (kbd "C-c C-r") 'eglot-rename)
(define-key eglot-mode-map (kbd "C-c o") 'eglot-code-action-organize-imports)
(define-key eglot-mode-map (kbd "C-c h") 'eldoc)
(define-key eglot-mode-map (kbd "C-c r") 'eglot-reconnect)
(define-key eglot-mode-map (kbd "C-c c f") 'xref-find-definitions)

;;; fain-ide.el ends here
