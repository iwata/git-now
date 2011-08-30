;;; git-now.el - Call "git now" command

(provide 'git-now)

(defun now ()
  (interactive)
  (call-process "git" nil "*git now*" nil "now")
  (pop-to-buffer "*git now*" t nil)
  (other-window -1)
  (message "git now!"))
