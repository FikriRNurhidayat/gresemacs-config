;; init.el --- Personal configuration file -*- lexical-binding: t -*-

;; Copyright (c) 2023  Fikri Rahmat Nurhidayat

;; Author: Fikri Rahmat Nurhidayat <fikrirnurhidayat@gmail.com>
;; URL: https://github.com/fikrirnurhidayat/gresemacs
;; Version: 0.1.0
;; Package-Requires: ((emacs "28.2"))

;; This file is NOT part of GNU Emacs.

;; This file is free software: you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation, either version 3 of the License, or (at
;; your option) any later version.
;;
;; This file is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this file.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(setq custom-file (from-emacs-config-directory "custom.el")
      environment-file (from-emacs-config-directory "environment.el"))

(load-file environment-file)
(load-file custom-file)

(setq inhibit-startup-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq warning-minimum-level :emergency)
(setq-default tab-width 4)
(setq display-line-numbers-type 'relative)

(setq frame-title-format '("%b"))
(setq ring-bell-function 'ignore)
(setq use-short-answers t)
(setq make-backup-files nil)
(setq indent-tabs-mode nil)

(setq org-ellipsis " ⤵ ")

(ensure-packages-installed '(project eglot go-mode org-modern))

;; ORG Modern
(require 'org-modern)
(global-org-modern-mode)
;; TODO: Move me
(setq org-modern-list '((43 . "◦") (45 . "•") (42 . "•")))
;; TODO: Move me
(ensure-packages-installed '(ox-rss))

(with-eval-after-load 'org-modern
 (add-hook 'org-mode #'visual-line-mode))

(use-module 'fain-editor)
(use-module 'fain-ide)
(use-module 'fain-ui)
(use-module 'fain-dired)
(use-module 'fain-present)
(use-module 'fain-eshell)
(use-module 'fain-word)
(use-module 'fain-agenda)

;; (defun fain/setup-font ()
;;   "."
;;   (set-face-attribute 'fixed-pitch nil :font "Iosevka Term" :inherit 'fixed-pitch))

;; (if (daemonp)
;;     (add-hook 'after-make-frame-functions
;;               (lambda (frame)
;;                 (select-frame frame)
;;                 (if (display-graphic-p frame)
;;                     (fain/setup-font)))))
