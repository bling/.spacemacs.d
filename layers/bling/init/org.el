
(defun bling/post-init-org ()
  (after 'org
    (defcustom bling/org-inbox-file (concat org-directory "/inbox.org")
      "The path to the file where to capture notes."
      :type 'file
      :group 'bling)

    (defcustom bling/org-journal-file (concat org-directory "/journal.org")
      "The path to the file where to capture journal entries."
      :type 'file
      :group 'bling)

    (setq org-refile-use-outline-path 'file)
    (setq org-outline-path-complete-in-steps nil)
    (setq org-startup-indented t)
    (setq org-log-into-drawer t)
    (setq org-treat-S-cursor-todo-selection-as-state-change nil)
    (setq org-confirm-babel-evaluate nil)

    (when (boundp 'org-plantuml-jar-path)
      (org-babel-do-load-languages
       'org-babel-load-languages
       '((plantuml . t))))

    (setq org-todo-keywords
          '((sequence "☛ TODO(t)" "NEXT(n@)" "|" "✔ DONE(d@)")
            (sequence "⚑ WAITING(w@/!)" "|" "✘ CANCELLED(c@/!)")))

    (setq org-capture-templates
          '(("t" "Todo" entry (file+headline (expand-file-name bling/org-inbox-file) "INBOX")
             "* TODO %?\n%U\n%a\n")
            ("n" "Note" entry (file+headline (expand-file-name bling/org-inbox-file) "NOTES")
             "* %? :NOTE:\n%U\n%a\n")
            ("m" "Meeting" entry (file (expand-file-name bling/org-inbox-file))
             "* MEETING %? :MEETING:\n%U")
            ("j" "Journal" entry (file+datetree (expand-file-name bling/org-journal-file))
             "* %U\n** %?")))

    (setq org-todo-state-tags-triggers
          ' (("✘ CANCELLED" ("✘ CANCELLED" . t))
             ("⚑ WAITING" ("⚑ WAITING" . t))
             ("☛ TODO" ("⚑ WAITING") ("✘ CANCELLED"))
             ("NEXT" ("⚑ WAITING") ("✘ CANCELLED"))
             ("✔ DONE" ("⚑ WAITING") ("✘ CANCELLED"))))

    (setq org-refile-targets '((nil :maxlevel . 9)
                               (org-agenda-files :maxlevel . 9)))

    (add-hook 'org-mode-hook #'toggle-word-wrap)
    (add-hook 'org-mode-hook #'toggle-truncate-lines)
    (add-hook 'org-mode-hook #'spacemacs/toggle-spelling-checking-on)))
