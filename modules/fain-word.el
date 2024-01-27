;;; fain-word.el -*- lexical-binding: t; -*-

(use-package visual-fill-column)
(use-package mixed-pitch)
(use-package adaptive-wrap)

(define-minor-mode fain/org-essay-mode ()
  "Toggle essay view for org mode."
  :init-value nil
  :lighter "fain/org-essay-mode"
  (when fain/org-essay-mode
    (setq-local visual-fill-column-width 96
                visual-fill-column-center-text t
                org-list-indent-offset 2)
    (visual-fill-column-mode 1)
    (mixed-pitch-mode 1))
  (unless fain/org-essay-mode
    (setq-local visual-fill-column-width nil)
    (mixed-pitch-mode 0)
    (visual-fill-column-mode 0)))

(define-key org-mode-map (kbd "C-c t n") 'fain/org-essay-mode)

;;; fain-word.el ends here
