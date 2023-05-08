;;; fain-ui.el -*- lexical-binding: t; -*-

(ensure-packages-installed '(doom-themes
							 vertico
							 rainbow-mode
							 rainbow-delimiters
							 helpful
							 all-the-icons
							 popper
							 company
							 visual-fill-column
							 hide-mode-line
							 mixed-pitch))

(setq completion-styles '(substring basic))

(load-theme 'doom-nord-aurora t)

(global-visual-line-mode 1)
(vertico-mode 1)
(rainbow-mode 1)

(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(global-set-key (kbd "C-`") 'popper-toggle-latest) 

(defun setup-popper ()
  "Setup popper."
  (popper-mode +1)
  (setq popper-mode-line nil)
  (setq popper-reference-buffers
		(append popper-reference-buffers
				'("^\\*eshell.*\\*$" eshell-mode ; eshell as a popup
                  "^\\*shell.*\\*$"  shell-mode  ; shell as a popup
                  "^\\*term.*\\*$"   term-mode   ; term as a popup
                  "^\\*vterm.*\\*$"  vterm-mode  ; vterm as a popup
                  ))))

;; TODO: Tidy up
;; run this hook after we have initialized the first time
(add-hook 'after-init-hook 'setup-popper)
;; re-run this hook if we create a new frame from daemonized Emacs
(add-hook 'server-after-make-frame-hook 'setup-popper)

(add-hook 'after-init-hook 'global-company-mode)

;; Helpful
(define-key helpful-mode-map [remap revert-buffer] #'helpful-update)
(global-set-key [remap describe-command] #'helpful-command)
(global-set-key [remap describe-function] #'helpful-callable)
(global-set-key [remap describe-key] #'helpful-key)
(global-set-key [remap describe-symbol] #'helpful-symbol)
(global-set-key [remap describe-variable] #'helpful-variable)
(global-set-key (kbd "C-h F") #'helpful-function)
(global-set-key (kbd "C-h K") #'describe-keymap)
