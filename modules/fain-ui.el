;;; fain-ui.el -*- lexical-binding: t; -*-

(ensure-packages-installed '(doom-themes
							               vertico
							               rainbow-mode
							               rainbow-delimiters
							               helpful
							               company
							               visual-fill-column
                             org-modern
							               hide-mode-line
							               mixed-pitch))

(setq completion-styles '(substring basic))

(load-theme 'modus-operandi t)

(global-visual-line-mode 1)
(vertico-mode 1)
(rainbow-mode 1)

(global-org-modern-mode)

(setq org-modern-list '((43 . "◦") (45 . "•") (42 . "•")))

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
;; (add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'after-init-hook #'global-company-mode)

;; Reseting Borders
(defun fain/adjust-frame ()
  "Adjust Emacs frame."
  (modify-all-frames-parameters
   '((right-divider-width . 16)
     (internal-border-width . 16)))
  (set-face-attribute 'mode-line nil :box nil)          ; Remove border on mode-line
  (set-face-attribute 'mode-line-inactive nil :box nil) ; Remove border on mode-line-inactive
  (dolist (face '(window-divider
                  window-divider-first-pixel
                  vertical-border
                  window-divider-last-pixel))
    (face-spec-reset-face face)
    (set-face-foreground face (face-attribute 'default :background)))
  (set-face-background 'fringe (face-attribute 'default :background)))

(add-hook 'window-setup-hook #'fain/adjust-frame)

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
