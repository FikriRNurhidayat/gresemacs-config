(ensure-packages-installed '(org-present org-modern mixed-pitch visual-fill-column))

(require 'org-indent)

(setq org-present-add-overlays-regex "^[[:space:]]*\\(#\\\+\\)\\(\\(\\(title\\|subtitle\\|date\\|author\\|email\\)\\\:[[:space:]]\\)\\|\\(\\([a-zA-Z]+\\(?:_[a-zA-Z]+\\)*\\).*\\)\\)")

(defun org-present-add-overlays ()
  "Add overlays for this mode."
  (add-to-invisibility-spec '(org-present))
  (save-excursion
    ;; hide org-mode options starting with #+
    (goto-char (point-min))
    (while (re-search-forward org-present-add-overlays-regex nil t)
      (let ((end (if (org-present-show-option (match-string 2)) 2 0)))
        (org-present-add-overlay (match-beginning 1) (match-end end))))
    ;; hide stars in headings
    (if org-present-hide-stars-in-headings
        (progn (goto-char (point-min))
               (while (re-search-forward "^\\(*+\\)" nil t)
                 (org-present-add-overlay (match-beginning 1) (match-end 1)))))
    ;; hide emphasis/verbatim markers if not already hidden by org
    (if org-hide-emphasis-markers nil
      ;; TODO https://github.com/rlister/org-present/issues/12
      ;; It would be better to reuse org's own facility for this, if possible.
      ;; However it is not obvious how to do this.
      (progn
        ;; hide emphasis markers
        (goto-char (point-min))
        (while (re-search-forward org-emph-re nil t)
          (org-present-add-overlay (match-beginning 2) (1+ (match-beginning 2)))
          (org-present-add-overlay (1- (match-end 2)) (match-end 2)))
        ;; hide verbatim markers
        (goto-char (point-min))
        (while (re-search-forward org-verbatim-re nil t)
          (org-present-add-overlay (match-beginning 2) (1+ (match-beginning 2)))
          (org-present-add-overlay (1- (match-end 2)) (match-end 2)))))))

(defvar fain/org-present-org-modern-keyword '(("title"       . "")
											  ("description" . "")
											  ("subtitle"    . "")
											  ("date"        . "")
											  ("author"      . "")
											  ("email"       . "")
											  ("language"    . "")
											  ("options"     . "")
											  (t . t)))

(define-minor-mode fain/org-present-mode
  "Toggle Presentation Mode."
  :lighter "fain/org-present-mode"
  (if fain/org-present-mode
	  (org-present)
	(org-present-quit)))

(defvar fain/org-present-org-level-scale '((org-level-1 . 2.5)
										   (org-level-2 . 2.5)
										   (org-level-3 . 1.5)
										   (org-level-4 . 1.5)
										   (org-level-5 . 1.5)
										   (org-level-6 . 1.5)
										   (org-level-7 . 1.5)
										   (org-level-8 . 1.5))
  "Org level size remap for presentation.")

(defun fain/org-present-enable-hook ()
  (setq-local fain/org-present--inhibit-message inhibit-message
			  fain/org-present--echo-keystrokes echo-keystrokes
			  fain/org-present--visual-line-mode visual-line-mode
			  fain/org-present--org-ellipsis org-ellipsis
			  fain/org-present--org-indent-mode org-indent-mode)
  (org-indent-mode 0)

  ;; Disable 'org-modern-mode' to setup adjustment if it's installed
  (if (package-installed-p 'org-modern)
	  (org-modern-mode 0))

  (setq-local inhibit-message t
              echo-keystrokes nil
              header-line-format " "
			  org-ellipsis "⤵")

  (if (package-installed-p 'visual-fill-column)
	  (progn
		(setq-local fain/org-present--visual-fill-column-mode visual-fill-column-mode
					fain/org-present--visual-fill-column-width visual-fill-column-width
					fain/org-present--visual-fill-column-center-text visual-fill-column-center-text)
		(setq-local visual-fill-column-width 128
					visual-fill-column-center-text t)))

  (if (package-installed-p 'org-modern)
	  (setq-local fain/org-present--org-modern-hide-stars org-modern-hide-stars
				  fain/org-present--org-modern-keyword org-modern-keyword
				  fain/org-present--org-modern-block-fringe org-modern-block-fringe

				  org-modern-hide-stars t
				  org-modern-block-fringe nil
				  org-modern-keyword fain/org-present-org-modern-keyword))

  (if (package-installed-p 'mixed-pitch)
	  (setq-local fain/org-present--mixed-pitch-mode mixed-pitch-mode))

  (setq-local face-remapping-alist (append (mapcar (lambda (face) `(,(car face) (:height ,(cdr face))  ,(car face))) fain/org-present-org-level-scale)
                                           `((default (:height 1.5) default)
                                             (header-line (:height 8.0 :background ,(face-attribute 'default :background)) header-line)
                                             (org-block (:background ,(face-attribute 'org-block-begin-line :background)) org-block)
                                             (org-document-title (:height 4.0) org-document-title)
                                             (org-document-info (:height 1.25) org-document-info))))
  (display-line-numbers-mode 0)

  (if (package-installed-p 'visual-fill-column)
	(visual-fill-column-mode 1))

  (if (package-installed-p 'org-modern)
	  (org-modern-mode 1))

  (if (package-installed-p 'hide-mode-line)
	  (hide-mode-line-mode 1))

  (if (package-installed-p 'mixed-pitch)
	  (mixed-pitch-mode 1))

  (visual-line-mode 1)
  (evil-normal-state)
  (org-display-inline-images))

(defun fain/org-present-prepare-slide (buffer-name heading)
  (org-overview)
  (org-show-entry)
  (org-show-children))

(defun fain/org-present-disable-hook ()
  (setq-local header-line-format nil
              face-remapping-alist nil
              org-adapt-indentation nil
			  visual-line-mode fain/org-present--visual-line-mode
			  org-ellipsis fain/org-present--org-ellipsis
              inhibit-message fain/org-present--inhibit-message
              echo-keystrokes fain/org-present--echo-keystrokes)
  (org-present-small)

  ;; TODO: Fix this, buggy
  (if (package-installed-p 'visual-fill-column)
	  (progn
		(setq-local visual-fill-column-width fain/org-present--visual-fill-column-width
					visual-fill-column-center-text fain/org-present--visual-fill-column-center-text)
		(visual-fill-column-mode 0)))

  (if (package-installed-p 'mixed-pitch)
	  (mixed-pitch-mode fain/org-present--mixed-pitch-mode))

  (org-indent-mode fain/org-present--org-indent-mode)

  (if (package-installed-p 'hide-mode-line)
	  (hide-mode-line-mode 0))

  (visual-line-mode fain/org-present--visual-line-mode)

  (org-mode-restart)
  (org-remove-inline-images))

(defun fain/org-present-up ()
  "Go to higher heading from current heading."
  (interactive)
  (widen)
  (org-up-heading-safe)
  (org-present-narrow)
  (org-present-run-after-navigate-functions))

(defun fain/org-present-next-sibling ()
  "Go to next sibling."
  (interactive)
  (widen)
  (unless (org-goto-first-child)
    (org-get-next-sibling))
  (org-present-narrow)
  (org-present-run-after-navigate-functions))

(defun fain/org-present--last-child ()
  "Find last child of current heading."
  (when (org-goto-sibling) (fain/org-present--last-child))
  (when (org-goto-first-child) (fain/org-present--last-child)))

(defun fain/org-present-previous-sibling ()
  "Go to next sibling."
  (interactive)
  (widen)
  (when (org-current-level)
    (org-back-to-heading)
    (if (and (org-get-previous-sibling) (org-current-level))
        (when (org-goto-first-child)
          (fain/org-present--last-child))))
  (org-present-narrow)
  (org-present-run-after-navigate-functions))

(add-hook 'org-present-after-navigate-functions 'fain/org-present-prepare-slide)
(add-hook 'org-present-mode-hook 'fain/org-present-enable-hook)
(add-hook 'org-present-mode-quit-hook 'fain/org-present-disable-hook)

(evil-define-key 'normal org-present-mode-keymap (kbd "C-h") 'fain/org-present-previous-sibling)
(evil-define-key 'normal org-present-mode-keymap (kbd "C-l") 'fain/org-present-next-sibling)
(evil-define-key 'normal org-present-mode-keymap (kbd "q") 'fain/org-present-mode)
(evil-define-key 'normal org-mode-map (kbd "C-t p") 'fain/org-present-mode)
