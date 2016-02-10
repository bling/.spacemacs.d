
(defun bling/post-init-projectile ()
  (setq projectile-indexing-method 'alien)
  (setq projectile-enable-caching t)
  (after 'projectile
    (add-to-list 'projectile-globally-ignored-directories "elpa")
    (add-to-list 'projectile-globally-ignored-directories ".cache")
    (add-to-list 'projectile-globally-ignored-directories "node_modules")))
