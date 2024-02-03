;;; fain-wiki.el -*- lexical-binding: t; -*-

(use-package org-roam
  :bind (("C-c n n" . org-roam-capture)
         ("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f f" . org-roam-node-find)
         ("C-c n j" . org-roam-dailies-capture-today)
         ("C-c n J" . org-roam-dailies-goto-today)
         ("C-c n f j" . org-roam-dailies-find-date))
  :custom
  (org-roam-directory (file-truename "~/Documents/wiki/"))
  :config
  (defun org-capture-turn-off-header-line ()
    (setq-local header-line-format nil))
  (add-hook 'org-capture-mode-hook #'org-capture-turn-off-header-line))

;;; fain-wiki.el ends here
