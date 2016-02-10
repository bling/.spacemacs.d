(defgroup bling nil
  "Custom configuration for bling's spacemacs layer."
  :group 'local)

(defconst bling-packages
  '(
    org
    erc
    evil
    helm
    eshell
    projectile
    ))

(defalias 'after 'with-eval-after-load)

(let ((debug-on-error t))
  (cl-loop for file in (directory-files (concat (file-name-directory load-file-name) "init/") t)
           when (string-match "\\.el$" file)
           do (load file)))

(spacemacs|use-package-add-hook markdown-mode
  :post-config
  (add-hook 'markdown-mode-hook #'toggle-word-wrap))

(global-prettify-symbols-mode)
