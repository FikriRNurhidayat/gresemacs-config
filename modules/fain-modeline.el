;;; fain-modeline.el -*- lexical-binding: t; -*-

(setq-default mode-line-format '(
                                 "%e"
                                 " "
                                 fain/modeline-buffer-name
                                 " "
                                 fain/modeline-major-mode-name))

(set-face-attribute 'mode-line nil :background (face-attribute 'default :background) :box (face-attribute 'region :background))
(set-face-attribute 'mode-line-inactive nil :background (face-attribute 'default :background))

(defun fain/modeline--major-mode-name ()
  "Retrieve major mode as string."
  (capitalize (symbol-name major-mode)))

(defvar fain/modeline-major-mode-name
  '(:eval (propertize (fain/modeline--major-mode-name) 'face 'bold))
  "Modeline construct that display major mode.")

(defun fain/modeline--buffer-name ()
  "Retrieve major mode as string."
  (buffer-name))

(defvar fain/modeline-buffer-name
  '(:eval (propertize (fain/modeline--buffer-name) 'face 'bold))
  "Modeline construct that display buffer name.")

(put 'fain/modeline-major-mode-name 'risky-local-variable t)
(put 'fain/modeline-buffer-name 'risky-local-variable t)

(global-hide-mode-line-mode 1)

;;; fain-modeline.el ends here
