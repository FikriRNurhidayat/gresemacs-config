;;; fain-window.el --- Window configuration file -*- lexical-binding: t -*-

(setq display-buffer-alist
      '(("\\*compilation\\*"
         (display-buffer-reuse-window display-buffer-below-selected))
        ("\\*Flymake diagnostics*"
         (display-buffer-reuse-window display-buffer-below-selected))
        ("\\*helpful*"
         (display-buffer-reuse-window display-buffer-below-selected))))

;;; fain-window.el ends here
