;;; fain-ui.el -*- lexical-binding: t; -*-

(ensure-packages-installed '(vertico
							               rainbow-mode
							               rainbow-delimiters
                             doom-themes
							               helpful
							               company
							               visual-fill-column
                             org-modern
                             org-appear
                             beacon
                             ewal
                             ewal-doom-themes
							               hide-mode-line
							               mixed-pitch
                             all-the-icons))

(setq completion-styles '(substring basic))

(load-theme 'ewal-doom-one t)

(global-visual-line-mode 1)
(vertico-mode 1)
(rainbow-mode 1)
(beacon-mode 1)

(global-org-modern-mode)

(setq org-modern-list '((43 . "◦") (45 . "•") (42 . "•"))
      org-modern-block-fringe nil
      org-modern-keyword '(("title"       . "title:      ")
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

(setq org-hide-emphasis-markers t)

(add-hook 'org-mode-hook 'org-appear-mode)

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'after-init-hook #'global-company-mode)

(defun fain/make-frame (frame)
  "Setup Emacs frame."
  (select-frame frame)
  (when (display-graphic-p)
    (modify-all-frames-parameters
     '((right-divider-width . 16)
       (internal-border-width . 16)))
    (fain/style-theme))
  (set-face-attribute 'default nil :family "Iosevka" :height 120)
  (set-face-attribute 'variable-pitch nil :family "Iosevka Etoile")
  (set-face-attribute 'fixed-pitch nil :family "Iosevka")
  (set-fontset-font t nil (font-spec :name "Symbols Nerd Font")))

(defun fain/style-theme ()
  "TODO"
  (dolist (face '(window-divider
                  window-divider-first-pixel
                  window-divider-last-pixel
                  internal-border
                  fringe
                  border))
    (face-spec-reset-face face)
    (set-face-foreground face (face-attribute 'default :background))
    (set-face-background face (face-attribute 'default :background)))
  (set-face-background 'fringe (face-attribute 'default :background))
  (set-face-attribute 'mode-line nil :box nil)
  (set-face-attribute 'mode-line-inactive nil :box nil))

(setq-default inhibit-message nil
      echo-keystrokes nil
      message-log-max nil)

(add-hook 'after-make-frame-functions #'fain/make-frame)
(add-hook 'modus-themes-after-load-theme-hook #'fain/style-theme)

(global-hide-mode-line-mode 1)

;; Helpful
(define-key helpful-mode-map [remap revert-buffer] #'helpful-update)
(global-set-key [remap describe-command] #'helpful-command)
(global-set-key [remap describe-function] #'helpful-callable)
(global-set-key [remap describe-key] #'helpful-key)
(global-set-key [remap describe-symbol] #'helpful-symbol)
(global-set-key [remap describe-variable] #'helpful-variable)
(global-set-key (kbd "C-h F") #'helpful-function)
(global-set-key (kbd "C-h K") #'describe-keymap)

(provide 'fain-ui)

;;; fain-ui.el ends here
