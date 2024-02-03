;; fain-tools.el  -*- lexical-binding: t -*-

(use-package restclient
  :defer t
  :ensure t
  :config
  (defun restclient-buffer ()
    "Create new buffer and run restclient-mode."
    (interactive)
    (let ((new-buffer (generate-new-buffer "*Restclient*")))
      (switch-to-buffer new-buffer)
      (restclient-mode))))

;;; fain-ide.el ends here
