(eval-when-compile (require 'cl))

(defmacro bind (&rest commands)
  "Convenience macro which creates a lambda interactive command."
  `(lambda (arg)
     (interactive "P")
     ,@commands))

(add-hook
 'after-init-hook
 (lambda ()
   (spacemacs/set-leader-keys "SPC" #'helm-M-x)
   (spacemacs/set-leader-keys "'" #'my-new-eshell-split)

   (define-key evil-normal-state-map (kbd "g b") #'helm-mini)

   (define-key evil-normal-state-map (kbd "C-h") #'evil-window-left)
   (define-key evil-normal-state-map (kbd "C-j") #'evil-window-down)
   (define-key evil-normal-state-map (kbd "C-k") #'evil-window-up)
   (define-key evil-normal-state-map (kbd "C-l") #'evil-window-right)
   (define-key evil-normal-state-map (kbd "C-w C-h") #'evil-window-left)
   (define-key evil-normal-state-map (kbd "C-w C-j") #'evil-window-down)
   (define-key evil-normal-state-map (kbd "C-w C-k") #'evil-window-up)
   (define-key evil-normal-state-map (kbd "C-w C-l") #'evil-window-right)
   (define-key evil-normal-state-map (kbd "C-w o") #'delete-other-windows)
   (define-key evil-normal-state-map (kbd "C-w C-o") #'delete-other-windows)

   (define-key evil-normal-state-map (kbd ", c") #'my-new-eshell-split)
   (define-key evil-normal-state-map (kbd ", w") #'save-buffer)
   (define-key evil-normal-state-map (kbd ", s") (kbd "C-w s C-w j"))
   (define-key evil-normal-state-map (kbd ", v") (kbd "C-w v C-w l"))

   (define-key evil-normal-state-map (kbd ", e") #'eval-last-sexp)
   (define-key evil-visual-state-map (kbd ", e") #'eval-region)
   (define-key evil-normal-state-map (kbd ", , e") #'eval-defun)
   (define-key evil-normal-state-map (kbd ", E") #'eval-defun)
   (define-key evil-normal-state-map (kbd ", C") #'customize-group)
   (define-key evil-normal-state-map (kbd ", P") #'package-list-packages)

   (define-key evil-normal-state-map (kbd "C-b") #'evil-scroll-up)
   (define-key evil-normal-state-map (kbd "C-f") #'evil-scroll-down)

   (define-key evil-normal-state-map (kbd "C-p") #'helm-projectile)

   (define-key evil-normal-state-map (kbd "Q") #'my-window-killer)

   (global-set-key (kbd "C-w") #'evil-window-map)
   (global-set-key (kbd "C-x C-k") #'kill-this-buffer)

   (global-set-key (kbd "C-s") #'isearch-forward-regexp)
   (global-set-key (kbd "C-M-s") #'isearch-forward)
   (global-set-key (kbd "C-r") #'isearch-backward-regexp)
   (global-set-key (kbd "C-M-r") #'isearch-backward)

   (global-set-key (kbd "C-x C-c") (bind (message "Thou shall not quit!")))

   (global-set-key (kbd "C-c t") 'my-new-eshell-split)

   (global-set-key (kbd "C-x c") 'calculator)
   (global-set-key (kbd "C-x C") 'calendar)

   ;; have no use for these default bindings
   (global-unset-key (kbd "C-x m"))))
