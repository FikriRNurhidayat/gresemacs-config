;;; fain-wiki.el -*- lexical-binding: t; -*-

(ensure-packages-installed '(org-roam))

(setq org-roam-directory (file-truename "~/Documents/wiki/"))

(global-set-key (kbd "C-c n n") 'org-roam-capture)
(global-set-key (kbd "C-c n l") 'org-roam-buffer-toggle)
(global-set-key (kbd "C-c n f f") 'org-roam-node-find)
(global-set-key (kbd "C-c n j") 'org-roam-dailies-capture-today)
(global-set-key (kbd "C-c n J") 'org-roam-dailies-goto-today)
(global-set-key (kbd "C-c n f j") 'org-roam-dailies-find-date)

;; Stolen from: https://emacs.stackexchange.com/questions/53648/eliminate-org-capture-message
(defun org-capture-turn-off-header-line ()
  (setq-local header-line-format nil))

(add-hook 'org-capture-mode-hook #'org-capture-turn-off-header-line)
