;;; fain-editor.el -*- lexical-binding: t; -*-

(ensure-packages-installed '(tree-sitter tree-sitter-langs yasnippet yaml-mode magit))

(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
(add-to-list 'tree-sitter-major-mode-language-alist '(org-mode . org))

(setq scroll-conservatively 10000)
(setq scroll-margin 3)

(setq x-underline-at-descent-line t)

(delete-selection-mode 1)               ; Allow us to replace text on selected region

(setq-default indent-tabs-mode nil)     ; Disable tabs, use spaces
(setq-default tab-width 2)

(setq make-backup-files nil)            ; Disable backup files
(setq auto-save-default nil)            ; Disable auto save files

(define-key prog-mode-map (kbd "C-M-;") 'comment-region)
(global-set-key (kbd "C-c C-g") 'magit)

;; TODO: Move me
(defun programming-view ()
  "Setup programming view."
  (visual-line-mode 0)
  (setq-local truncate-lines t))

(add-hook 'prog-mode-hook #'programming-view)

(defun kill-other-buffers ()
  "Kill other buffers."
  (interactive)
  (mapc 'kill-buffer (delete (current-buffer) (buffer-list))))

(global-set-key (kbd "C-x C-k C-o") 'kill-other-buffers)

;;; fain-editor.el ends here
