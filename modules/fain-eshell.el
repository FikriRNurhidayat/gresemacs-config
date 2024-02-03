;;; fain-eshell.el -*- lexical-binding: t; -*-

(use-package eat
  :ensure t
  :defer t)

(defun read-file (file-path)
  "Read file with temporary buffer."
  (with-temp-buffer
    (insert-file-contents file-path)
    (buffer-string)))

(defun fain/eshell-configure ()
  (push 'eshell-tramp eshell-modules-list)
  (delq 'eshell-handle-ansi-color eshell-output-filter-functions)

  ;; Save command history when commands are entered
  (add-hook 'eshell-pre-command-hook 'eshell-save-some-history)

  ;; Truncate buffer for performance
  (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)

  ;; We want to use xterm when running interactive commands
  ;; in eshell but not during other times when we might be launching
  ;; a shell command to gather its output.
  (add-hook 'eshell-pre-command-hook
            (lambda () (setenv "TERM" "dumb")))

  ;; Use completion-at-point to provide completions in eshell
  (define-key eshell-mode-map (kbd "<tab>") 'completion-at-point)

  ;; Initialize the shell history
  (eshell-hist-initialize)
  (setenv "PAGER" "cat")
  (setq eshell-prompt-function      'fain/eshell-prompt
        eshell-prompt-regexp        "^λ "
        eshell-history-size         10000
        eshell-buffer-maximum-lines 10000
        eshell-hist-ignoredups t
        eshell-highlight-prompt t
        eshell-scroll-to-bottom-on-input t
        eshell-prefer-lisp-functions nil))

(add-hook 'eshell-first-time-mode-hook #'fain/eshell-configure)
(setq eshell-directory-name "~/.cache/eshell/"
      eshell-aliases-file (expand-file-name "~/.cache/eshell/alias"))

(defun fain/eshell-prompt ()
  (concat
   "\n"
   (propertize (system-name) 'face `(:foreground ,(face-attribute 'font-lock-keyword-face :foreground)))
   (propertize " • " 'face `(:foreground ,(face-attribute 'font-lock-comment-face :foreground)))
   (propertize (fain/get-prompt-path) 'face `(:foreground ,(face-attribute 'font-lock-variable-name-face :foreground)))
   (propertize " • " 'face `(:foreground ,(face-attribute 'font-lock-comment-face :foreground)))
   (propertize (format-time-string "%I:%M:%S %p") 'face `(:foreground ,(face-attribute 'font-lock-comment-face :foreground)))
   (if (= (user-uid) 0)
       (propertize "\n#" 'face `(:foreground ,(face-attribute 'font-lock-type-face :foreground)))
     (propertize "\nλ" 'face `(:foreground ,(face-attribute 'font-lock-type-face :foreground))))
   (propertize " " 'face `(:foreground ,(face-attribute 'default :foreground)))))

(defun fain/get-prompt-path ()
  (let* ((current-path (eshell/pwd))
         (git-output (shell-command-to-string "git rev-parse --show-toplevel"))
         (has-path (not (string-match "^fatal" git-output))))
    (if (not has-path)
        (abbreviate-file-name current-path)
      (string-remove-prefix (file-name-directory git-output) current-path))))

(defun fain/map-line-to-status-char (line)
  (cond ((string-match "^?\\? " line) "?")))

(defun fain/get-git-status-prompt ()
  (let ((status-lines (cdr (process-lines "git" "status" "--porcelain" "-b"))))
    (seq-uniq (seq-filter 'identity (mapcar 'fain/map-line-to-status-char status-lines)))))

;; TODO: Use path framework or something
(setq eshell-rc-script "~/.config/gresemacs/modules/fain-eshell-profile.el")

(defun run-this-in-eshell (cmd)
    "Runs the command 'cmd' in eshell."
    (end-of-buffer)
    (eshell-kill-input)
    (insert cmd)
    (eshell-send-input)
    (end-of-buffer)
    (eshell-bol)
    (yank))

(defun fain/eshell-clear ()
  "Clear eshell buffer."
  (interactive)
  (run-this-in-eshell "clear 1"))

(defun fain/eshell-mode-hook ()
  "Setup keybinding on eshell."
  (define-key eshell-mode-map (kbd "C-l") 'fain/eshell-clear))

;; Clear Command
(add-hook 'eshell-mode-hook 'fain/eshell-mode-hook)
(add-hook 'eshell-load-hook #'eat-eshell-mode)


;;; fain-eshell.el ends here
