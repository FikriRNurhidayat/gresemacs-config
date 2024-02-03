;;; fain-essential.el --- Base configuration file -*- lexical-binding: t -*-
(setq custom-file (from-emacs-config-directory "custom.el")
      environment-file (from-emacs-config-directory "environment.el"))

(load-file environment-file)

(setq inhibit-startup-message t
      warning-minimum-level :emergency
      ring-bell-function 'ignore
      use-short-answers t
      make-backup-files nil
      completion-styles '(substring basic)
      echo-keystrokes nil
      message-log-max nil)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;;; fain-essential.el ends here
