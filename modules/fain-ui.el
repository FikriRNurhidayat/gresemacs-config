;;; fain-ui.el -*- lexical-binding: t; -*-

(use-package vertico
  :ensure t
  :defer t
  :init (vertico-mode))

(use-package rainbow-mode
  :defer t
  :ensure t
  :hook (fundamental-mode))

(use-package spacious-padding
  :defer t
  :ensure t
  :custom (spacious-padding-widths
           '(:internal-border-width 16
                                    :header-line-width 16
                                    :mode-line-width 16
                                    :tab-width 2
                                    :right-divider-width 16
                                    :scroll-bar-width 16))
  :init (spacious-padding-mode))

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

(use-package org-modern
  :defer t
  :ensure t
  :custom
  (org-modern-hide-stars t)
  (org-modern-block-fringe nil)
  (org-modern-keyword '(("title"       . "title:      ")
                       ("description" . "description:")
                       ("summary"     . "summary:    ")
                       ("subtitle"    . "subtitle:   ")
                       ("date"        . "date:       ")
                       ("email"       . "email:      ")
                       ("author"      . "author:     ")
                       ("language"    . "language:   ")
                       ("filetags"    . "filetags:   ")
                       ("options"     . "options:    ")
                       (t . t)))
  :config
  (global-org-modern-mode))

(use-package org-appear
  :defer t
  :ensure t
  :hook (org-mode . org-appear-mode))

;; TODO: Remove this package
(use-package mixed-pitch
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
  :config
  (global-ligature-mode 1))

(use-package hide-mode-line
  :ensure t
  :config
  (global-hide-mode-line-mode 1))

(global-visual-line-mode 1)

(setq org-hide-emphasis-markers t)

(with-system gnu/linux
  (setq default-font "Gitlab Mono"
        variable-font "Gitlab Mono"
        monospace-font "Gitlab Mono"))

(with-system darwin
  (setq default-font "Courier"
        variable-font "Courier"
        monospace-font "Courier"))

;; Setting up fonts
(custom-set-faces
 `(default ((t (:font ,default-font :height 120 :weight normal))))
 `(variable-pitch ((t (:font ,variable-font :weight normal))))
 `(fixed-pitch((t (:font ,monospace-font :weight normal)))))
(setq-default line-spacing 0.2)

(defun fain/adjust-face-colors ()
  "TODO"
  (setq background-color (face-attribute 'default :background))
  (dolist (face '(window-divider
                  window-divider-first-pixel
                  window-divider-last-pixel
                  internal-border
                  fringe
                  mode-line-active
                  mode-line-inactive
                  border))
    (set-face-attribute face nil :background background-color :foreground background-color)))

(defun fain/make-frame (frame)
  "Setup Emacs frame."
  (select-frame frame)
  (when (display-graphic-p)
    (fain/adjust-face-colors)))

(add-hook 'after-make-frame-functions #'fain/make-frame)

(unless (daemonp)
  (fain/adjust-face-colors))

(setq frame-title-format '("GNU Emacs"))
(setq display-line-numbers-type 'relative)
(setq org-ellipsis "…")

(provide 'fain-ui)

;;; fain-ui.el ends here
