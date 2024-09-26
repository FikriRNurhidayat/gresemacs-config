;;; fain-org.el -*- lexical-binding: t; -*-

(use-package org
  :ensure nil
  :bind
  ("C-c a" . org-agenda)
  ("C-c c" . org-capture)
  ("C-c i" . org-capture-inbox)
  :hook
  (org-after-todo-state-change-hook . log-todo-next-creation-date)
  :custom
  (org-log-done 'time)
  (org-agenda-hide-tags-regexp ".")
  (org-hide-emphasis-markers t)
  (org-ellipsis "…")
  (org-directory "~/Documents/org")
  (org-agenda-files (list "inbox.org" "agenda.org" "projects.org" "notes.org"))
  (org-capture-templates
   `(("i" "Inbox" entry  (file "inbox.org")
      ,(concat "* TODO %?\n"
               "/Entered on/ %U"))
     ("m" "Meeting" entry  (file+headline "agenda.org" "Future")
      ,(concat "* %? :meeting:\n"
               "<%<%Y-%m-%d %a %H:00>>"))
     ("n" "Note" entry  (file "notes.org")
      ,(concat "* Note (%a)\n"
               "/Entered on/ %U\n" "\n" "%?"))))
  (org-agenda-prefix-format
   '((agenda . " %i %-12:c%?-12t% s")
     (todo   . " %i %-12:c")
     (tags   . " %i %-12:c")
     (search . " %i %-12:c")))
  (org-refile-targets
   '(("projects.org" :maxlevel . 3)))
  (org-refile-use-outline-path 'file)
  (org-outline-path-complete-in-steps nil)
  (org-todo-keywords
   '((sequence "TODO(t)" "NEXT(n)" "HOLD(h)" "|" "DONE(d)")))
  (org-agenda-custom-commands
        '(("g" "Get Things Done (GTD)"
           ((agenda ""
                    ((org-agenda-skip-function
                      '(org-agenda-skip-entry-if 'deadline))
                     (org-deadline-warning-days 0)))
            (todo "NEXT"
                  ((org-agenda-skip-function
                    '(org-agenda-skip-entry-if 'deadline))
                   (org-agenda-prefix-format "  %i %-12:c [%e] ")
                   (org-agenda-overriding-header "\nTasks\n")))
            (agenda nil
                    ((org-agenda-entry-types '(:deadline))
                     (org-agenda-format-date "")
                     (org-deadline-warning-days 7)
                     (org-agenda-skip-function
                      '(org-agenda-skip-entry-if 'notregexp "\\* NEXT"))
                     (org-agenda-overriding-header "\nDeadlines")))
            (tags-todo "inbox"
                       ((org-agenda-prefix-format "  %?-12t% s")
                        (org-agenda-overriding-header "\nInbox\n")))
            (tags "CLOSED>=\"<today>\""
                  ((org-agenda-overriding-header "\nCompleted today\n")))))))

  :config
  (custom-set-faces
   '(org-level-1 ((t (:inherit default :height 1.0))))
   '(org-level-2 ((t (:inherit default :height 1.0))))
   '(org-level-3 ((t (:inherit default :height 1.0))))
   '(org-level-4 ((t (:inherit default :height 1.0))))
   '(org-level-5 ((t (:inherit default :height 1.0))))
   '(org-level-6 ((t (:inherit default :height 1.0))))
   '(org-level-7 ((t (:inherit default :height 1.0))))
   '(org-level-8 ((t (:inherit default :height 1.0)))))

  ;; SEE: https://www.labri.fr/perso/nrougier/GTD/index.html#org620db8f
  (defun log-todo-next-creation-date (&rest ignore)
    "Log NEXT creation time in the property drawer under the key 'ACTIVATED'"
    (when (and (string= (org-get-todo-state) "NEXT")
               (not (org-entry-get nil "ACTIVATED")))
      (org-entry-put nil "ACTIVATED" (format-time-string "[%Y-%m-%d]"))))
  
  (defun org-capture-inbox ()
    (interactive)
    (call-interactively 'org-store-link)
    (org-capture nil "i")))

(use-package org-appear
  :defer t
  :ensure t
  :hook (org-mode . org-appear-mode))

;;; fain-org.el ends here
