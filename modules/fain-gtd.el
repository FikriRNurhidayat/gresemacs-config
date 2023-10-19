;;; fain-gtd.el -*- lexical-binding: t; -*-

(setq fain/org-gtd-directory "~/Documents/gtd/")

(defun fain/org-gtd-file (file)
  "Expand 'file' with 'fain/org/gtd-directory'."
  (expand-file-name file fain/org-gtd-directory))

(setq fain/org-gtd-inbox-file (fain/org-gtd-file "INBOX.org")
      fain/org-gtd-project-file (fain/org-gtd-file "PROJECT.org")
      fain/org-gtd-maybe-file (fain/org-gtd-file "MAYBE.org")
      fain/org-gtd-tickler-file (fain/org-gtd-file "TICKLER.org"))

(setq org-agenda-files (list fain/org-gtd-inbox-file
                             fain/org-gtd-project-file
                             fain/org-gtd-tickler-file))

(setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline fain/org-gtd-inbox-file "Tasks")
                               "* TODO %i%?")
                              ("T" "Tickler" entry
                               (file+headline fain/org-gtd-tickler-file "Tickler")
                               "* %i%? \n %U")))

(setq org-refile-targets '((fain/org-gtd-project-file :maxlevel . 3)
                           (fain/org-gtd-maybe-file :level . 1)
                           (fain/org-gtd-tickler-file :maxlevel . 2)))

(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))

(setq org-agenda-custom-commands 
      '(("o" "At the office" tags-todo "@office"
         ((org-agenda-overriding-header "Office")
          (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))
        ("h" "At the home" tags-todo "@home"
         ((org-agenda-overriding-header "Home")
          (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))))

(defun my-org-agenda-skip-all-siblings-but-first ()
  "Skip all but the first non-done entry."
  (let (should-skip-entry)
    (unless (org-current-is-todo)
      (setq should-skip-entry t))
    (save-excursion
      (while (and (not should-skip-entry) (org-goto-sibling t))
        (when (org-current-is-todo)
          (setq should-skip-entry t))))
    (when should-skip-entry
      (or (outline-next-heading)
          (goto-char (point-max))))))
		  
(defun org-current-is-todo ()
  (string= "TODO" (org-get-todo-state)))

(global-set-key (kbd "C-c c") 'org-capture)

;;; fain-gtd.el ends here

