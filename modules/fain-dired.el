;;; fain-dired.el --- Dired configuration file -*- lexical-binding: t -*-

(use-package nerd-icons-dired
  :ensure t
  :hook
  (dired-mode . dired-hide-details-mode))

;;; fain-dired.el ends here
