;; fain-agenda.el --- ORG Agenda configuration file -*- lexical-binding: t -*-

(setq fain/org-agenda-directory "~/Documents/agenda/")

(defun fain/org-agenda-file (file)
  "Expand 'file' with 'fain/org/agenda-directory'."
  (expand-file-name file fain/org-agenda-directory))

(setq org-agenda-files (list (fain/org-agenda-file "agenda.org")))
