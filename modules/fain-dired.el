;;; fain-dired.el --- Dired configuration file -*- lexical-binding: t -*-

(add-hook 'dired-mode-hook 'dired-hide-details-mode)
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

(use-package all-the-icons-dired)

;;; fain-dired.el ends here
