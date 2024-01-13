;; fain-ide.el  -*- lexical-binding: t -*-

(ensure-packages-installed '(eglot go-mode rust-mode simple-httpd geiser geiser-guile elm-mode typescript-mode))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '((rust-ts-mode rust-mode) . ("rustup" "run" "stable" "rust-analyzer"))))

(defun fain/js-mode-hook ()
  "Hook when javascript is started."
  (setq indent-tabs-mode nil)
  (setq tab-width 2)
  (setq js-indent-level 2)
  (eglot-ensure))

(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)
(add-hook 'go-mode-hook 'eglot-ensure)
(add-hook 'rust-mode-hook 'eglot-ensure)
(add-hook 'js-mode-hook 'fain/js-mode-hook)

(setq major-mode-remap-alist
  '((css-mode  . css-ts-mode)
    (js-mode . js-ts-mode)
    (typescript-mode . typescript-ts-mode)))

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
