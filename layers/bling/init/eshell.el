
(defun bling/post-init-eshell ()
  (setq eshell-scroll-to-bottom-on-input 'this)
  (setq eshell-glob-case-insensitive t)
  (setq eshell-error-if-no-glob t)
  (setq eshell-history-size 1024)
  (setq eshell-cmpl-ignore-case t)
  (setq eshell-last-dir-ring-size 512)

  (lexical-let ((count 0))
    (defun my-new-eshell-split ()
      (interactive)
      (split-window)
      (eshell (incf count))))

  (defun eshell/ff (&rest args)
    "Opens a file in emacs."
    (when (not (null args))
      (mapc #'find-file (mapcar #'expand-file-name (eshell-flatten-list (reverse args))))))

  (defun my-eshell-prompt ()
    (concat (propertize (abbreviate-file-name (eshell/pwd)) 'face 'eshell-prompt)
            (when (fboundp #'vc-git-branches)
              (let ((branch (car (vc-git-branches))))
                (when branch
                  (concat
                   (propertize " [" 'face 'font-lock-keyword-face)
                   (propertize branch 'face 'font-lock-function-name-face)
                   (let* ((status (shell-command-to-string "git status --porcelain"))
                          (parts (split-string status "\n" t " "))
                          (states (mapcar #'string-to-char parts))
                          (added (count-if (lambda (char) (= char ?A)) states))
                          (modified (count-if (lambda (char) (= char ?M)) states))
                          (deleted (count-if (lambda (char) (= char ?D)) states)))
                     (when (> (+ added modified deleted) 0)
                       (propertize (format " +%d ~%d -%d" added modified deleted) 'face 'font-lock-comment-face)))
                   (propertize "]" 'face 'font-lock-keyword-face)))))
            (propertize " $ " 'face 'font-lock-constant-face)))

  (after 'esh-mode
    (defun my-eshell-color-filter (string)
      (let ((case-fold-search nil)
            (lines (split-string string "\n")))
        (cl-loop for line in lines
                 do (progn
                      (cond ((string-match "\\[DEBUG\\]" line)
                             (put-text-property 0 (length line) 'font-lock-face font-lock-comment-face line))
                            ((string-match "\\[INFO\\]" line)
                             (put-text-property 0 (length line) 'font-lock-face compilation-info-face line))
                            ((string-match "\\[WARN\\]" line)
                             (put-text-property 0 (length line) 'font-lock-face compilation-warning-face line))
                            ((string-match "\\[ERROR\\]" line)
                             (put-text-property 0 (length line) 'font-lock-face compilation-error-face line)))))
        (mapconcat 'identity lines "\n")))

    (require 'compile)
    (add-to-list 'eshell-preoutput-filter-functions #'my-eshell-color-filter))

  (setq eshell-prompt-function #'my-eshell-prompt))
