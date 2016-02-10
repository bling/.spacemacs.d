(defcustom bling/emacs-state-minor-modes '(git-commit-mode)
  "List of minor modes that when active should switch to Emacs state."
  :type '(repeat (symbol))
  :group 'bling)

(defcustom bling/emacs-state-major-modes
  '(eshell-mode
    term-mode
    calculator-mode
    makey-key-mode)
  "List of major modes that should default to Emacs state."
  :type '(repeat (symbol))
  :group 'bling)

(defun bling/post-init-evil ()
  (cl-loop for mode in bling/emacs-state-minor-modes
           do (let ((hook (concat (symbol-name mode) "-hook")))
                (add-hook (intern hook) `(lambda ()
                                           (if ,mode
                                               (evil-emacs-state)
                                             (evil-normal-state))))))

  (cl-loop for mode in bling/emacs-state-major-modes
           do (evil-set-initial-state mode 'emacs))

  (defadvice evil-search-next (after advice-for-evil-ex-search-next activate)
    (recenter))
  (defadvice evil-search-previous (after advice-for-evil-ex-search-previous activate)
    (recenter))
  (defadvice evil-quit (around advice-for-evil-quit activate)
    (message "Thou shall not quit!"))
  (defadvice evil-quit-all (around advice-for-evil-quit-all activate)
    (message "Thou shall not quit!")))

(defun bling/post-init-evil-mc ()
  (evil-define-key 'normal evil-mc-key-map (kbd "C-p") nil))
