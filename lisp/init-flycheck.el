(defun my/use-eslint-from-node-modules ()
  (let ((root (locate-dominating-file
               (or (buffer-file-name) default-directory)
               (lambda (dir)
                 (let ((eslint (expand-file-name "node_modules/eslint/bin/eslint.js" dir)))
                  (and eslint (file-executable-p eslint)))))))
    (when root
      (let ((eslint (expand-file-name "node_modules/eslint/bin/eslint.js" root)))
        (setq-local flycheck-javascript-eslint-executable eslint)))))

(use-package let-alist
  :ensure t)

 (use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-flycheck-mode)
  (add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)

  ;; Flycheck mode:
  (add-hook 'flycheck-mode-hook
            (lambda ()
                (evil-define-key 'normal flycheck-mode-map (kbd "]e") 'flycheck-next-error)
                (evil-define-key 'normal flycheck-mode-map (kbd "[e") 'flycheck-previous-error)
                (evil-leader/set-key (kbd "e") 'flycheck-list-errors)))

  ;; Override default flycheck triggers
  (setq flycheck-emacs-lisp-load-path 'inherit
        flycheck-check-syntax-automatically '(save idle-change mode-enabled)
        flycheck-idle-change-delay 0.8
        flycheck-disabled-checkers '(php-phpmd)
        flycheck-phpcs-standard "CSNStores")

  (setq flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list)

  (setq-default flycheck-temp-prefix ".flycheck")
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(javascript-jshint)))
  (setq flycheck-checkers '(javascript-eslint))
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(json-jsonlist)))

  (flycheck-add-mode 'javascript-eslint 'js-mode)
  (flycheck-add-mode 'javascript-eslint 'web-mode))

(use-package flycheck-pos-tip
   :ensure t
   :after (flycheck))

(use-package flycheck-elm
  :ensure t
  :config
  (add-hook 'flycheck-mode-hook 'flycheck-elm-setup)
  (add-hook 'elm-mode-hook (lambda ()
    (setq default-directory (elm--find-dependency-file-path)))))

(provide 'init-flycheck)
;;; init-flycheck.el ends here
