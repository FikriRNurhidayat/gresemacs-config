;;; fain-dired.el --- Dired configuration file -*- lexical-binding: t -*-

(use-package all-the-icons-dired
  :ensure t
  :defer t
  :hook
  (dired-mode . dired-hide-details-mode)
  (dired-mode . all-the-icons-dired-mode))

;;; fain-dired.el ends here
