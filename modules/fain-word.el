;;; fain-word.el -*- lexical-binding: t; -*-

(use-package visual-fill-column
  :ensure t
  :defer t)
(use-package adaptive-wrap
  :ensure t
  :defer t)

(define-minor-mode fain/org-essay-mode ()
  "Toggle essay view for org mode."
  :init-value nil
  :lighter "fain/org-essay-mode"
  (when fain/org-essay-mode
    (setq-local visual-fill-column-width 74
                visual-fill-column-center-text nil
                org-list-indent-offset 2)
    (visual-fill-column-mode 1))
  (unless fain/org-essay-mode
    (setq-local visual-fill-column-width nil)
    (visual-fill-column-mode 0)))

(use-package org
  :bind (:map org-mode-map ("C-c t n" . fain/org-essay-mode)))

;;; fain-word.el ends here
