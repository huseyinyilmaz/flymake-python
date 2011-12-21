;; add this to your .emacs file:

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; enable flymake-python ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (load "flymake" t)
  (defun flymake-pylint-init (&optional trigger-type)
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-with-folder-structure))
	   (local-file (file-relative-name
			temp-file
			(file-name-directory buffer-file-name)))
	   (options (when trigger-type (list "--trigger-type" trigger-type))))
      (list "~/.emacs.d/plugins/flymake-python/pyflymake.py" (append options (list local-file)))))
  
  (add-to-list 'flymake-allowed-file-name-masks
	       '("\\.py\\'" flymake-pylint-init)))


(add-hook 'find-file-hook 'flymake-find-file-hook)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; add flymake errors to minibuffer ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-flymake-show-help ()
  (when (get-char-property (point) 'flymake-overlay)
   (let ((help (get-char-property (point) 'help-echo)))
    (if help (message "%s" help)))))

(add-hook 'post-command-hook 'my-flymake-show-help)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; disable flymake for html ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(delete '("\\.html?\\'" flymake-xml-init) flymake-allowed-file-name-masks)


