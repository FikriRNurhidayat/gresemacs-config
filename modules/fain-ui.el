;;; fain-ui.el -*- lexical-binding: t; -*-

(use-package visual-fill-column
  :ensure t)

(use-package vertico
  :ensure t
  :defer t
  :init (vertico-mode))

(use-package rainbow-mode
  :defer t
  :ensure t
  :hook (fundamental-mode))

(use-package helpful
  :defer t
  :ensure t
  :bind (([remap describe-command] . helpful-command)
	 ([remap describe-function] . helpful-callable)
	 ([remap describe-key] . helpful-key)
	 ([remap describe-symbol] . helpful-symbol)
	 ([remap describe-variable] . helpful-variable)
	 :map helpful-mode-map
	      ([remap revert-buffer] . helpful-update)))

(use-package company
  :defer t
  :ensure t
  :hook (prog-mode text-mode))

(use-package visual-fill-column
  :defer t
  :ensure t)

(use-package catppuccin-theme
  :ensure t
  :custom
  (catppuccin-flavor 'mocha)
  :config
  (load-theme 'catppuccin :no-confirm))

(use-package ligature
  :ensure t
  :init
  (global-ligature-mode 1))

(defun fain/make-frame (frame)
  "Setup Emacs frame."
  (select-frame frame)
  (when (display-graphic-p)
    (set-frame-font default-font)
    (set-frame-parameter nil 'alpha-background 0.9)))

(add-hook 'after-make-frame-functions #'fain/make-frame)

(with-system gnu/linux
  (setq default-font "IBM Plex Mono"
        variable-font "IBM Plex Mono"
        monospace-font "IBM Plex Mono"))

(with-system darwin
  (setq default-font "Cousine Nerd Font"
        variable-font "Cousine Nerd Font"
        monospace-font "Cousine Nerd Font"))

;; Setting up fonts
(custom-set-faces
 `(default ((t (:font ,default-font :weight normal))))
 `(variable-pitch ((t (:font ,variable-font normal))))
 `(fixed-pitch((t (:font ,monospace-font normal)))))
(setq-default line-spacing 1)

(setq frame-title-format '("GNU Emacs"))
(setq display-line-numbers-type 'relative)

(provide 'fain-ui)

;;; fain-ui.el ends here
