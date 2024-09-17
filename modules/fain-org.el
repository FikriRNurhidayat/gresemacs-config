;;; fain-org.el -*- lexical-binding: t; -*-

(use-package org
  :ensure nil
  :bind (("C-c t" . (lambda () (interactive) (org-capture nil "t"))))
  :custom
  (org-hide-emphasis-markers t)
  (org-ellipsis "…")
  (org-default-notes-file "~/Documents/org/inbox.org")
  (org-capture-templates
   '(("t" "TODO" entry (file "")
      "* TODO %?")))
  :config
  (custom-set-faces
   '(org-level-1 ((t (:inherit default :height 1.0))))
   '(org-level-2 ((t (:inherit default :height 1.0))))
   '(org-level-3 ((t (:inherit default :height 1.0))))
   '(org-level-4 ((t (:inherit default :height 1.0))))
   '(org-level-5 ((t (:inherit default :height 1.0))))
   '(org-level-6 ((t (:inherit default :height 1.0))))
   '(org-level-7 ((t (:inherit default :height 1.0))))
   '(org-level-8 ((t (:inherit default :height 1.0))))))

(use-package org-appear
  :defer t
  :ensure t
  :hook (org-mode . org-appear-mode))

;;; fain-org.el ends here
