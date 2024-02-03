;; fain-ide.el  -*- lexical-binding: t -*-

(use-package eglot
  :commands (eglot eglot-ensure)
  :bind (:map eglot-mode-map
              ("C-c a" . eglot-code-actions)
              ("M-c f f" . eglot-format)
              ("C-c f b" . eglot-format-buffer)
              ("C-c C-r" . eglot-rename)
              ("C-c o" . eglot-code-action-organize-imports)
              ("C-c h" . eldoc)
              ("C-c r" . eglot-reconnect)
              ("C-c c f" . xref-find-definitions))
  :hook ((go-mode c++-mode c-mode rust-mode js-mode) . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
               '((rust-ts-mode rust-mode) . ("rustup" "run" "stable" "rust-analyzer"))))

(use-package go-mode
  :ensure t
  :defer t)
(use-package rust-mode
  :ensure t
  :defer t)
(use-package simple-httpd
  :ensure t
  :defer t)
(use-package geiser
  :ensure t
  :defer t)
(use-package geiser-guile
  :ensure t
  :defer t)

(setq flymake-fringe-indicator-position nil)

;;; fain-ide.el ends here
