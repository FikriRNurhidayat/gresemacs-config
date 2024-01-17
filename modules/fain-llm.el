;; fain-llm.el  -*- lexical-binding: t -*-

(ensure-packages-installed '(gptel))

(global-set-key (kbd "C-c C-<return>") 'gptel-menu)
(global-set-key (kbd "C-c <return>") 'gptel-send)

(setq gptel-response-prefix-alist '("ChatGPT:"))
(setq gptel-default-mode 'org-mode)

;;; fain-llm.el ends here
