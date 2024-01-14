;;; fain-project.el -*- lexical-binding: t; -*-

(ensure-packages-installed '(project))

(global-set-key (kbd "C-x p a") #'project-remember-projects-under)

(defun project-find-go-module (dir)
  (when-let ((root (locate-dominating-file dir "go.mod")))
    (cons 'go-module root)))

(cl-defmethod project-root ((project (head go-module)))
  (cdr project))

(add-hook 'project-find-functions #'project-find-go-module)


(provide 'fain-project)

;;; fain-ui.el ends here
