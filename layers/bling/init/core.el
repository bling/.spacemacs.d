(setq mac-command-modifier 'meta)


;; better scrolling
(setq scroll-conservatively 9999
      scroll-preserve-screen-position t
      scroll-margin 3)


;; clean up old buffers periodically
(require 'midnight)
(midnight-delay-set 'midnight-delay 0)


;; gc
(defun my-minibuffer-setup-hook () (setq gc-cons-threshold most-positive-fixnum))
(defun my-minibuffer-exit-hook () (setq gc-cons-threshold (* 32 1024 1024)))
(add-hook 'minibuffer-setup-hook #'my-minibuffer-setup-hook)
(add-hook 'minibuffer-exit-hook #'my-minibuffer-exit-hook)


(defun my-do-not-kill-scratch-buffer ()
  (if (member (buffer-name (current-buffer))
              '("*scratch*" "*Messages*"))
      (progn
        (bury-buffer)
        nil)
    t))
(add-hook 'kill-buffer-query-functions #'my-do-not-kill-scratch-buffer)
