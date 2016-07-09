(use-package evil
  :ensure t
  :config
  (evil-mode 1)
  (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
  ;;(define-key evil-normal-state-map (kbd "C-k") (lambda () (interactive) (evil-scroll-up nil)))
  ;;(define-key evil-normal-state-map (kbd "C-j") (lambda () (interactive) (evil-scroll-down nil)))
  (setq evil-move-cursor-back nil))

(use-package evil-leader
  :ensure t
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader ",")
  (setq evil-leader/in-all-states 1)
  (evil-leader/set-key
    ","  (lambda () (interactive) (ansi-term (getenv "SHELL")))
    "m"  'neotree-toggle
    "n"  'neotree-find
    "."  'switch-to-previous-buffer
    "/"  'evil-search-highlight-persist-remove-all
    "w"  'ace-window))

(use-package evil-surround
  :ensure t)

(use-package evil-search-highlight-persist
  :ensure t
  :config
  (global-evil-search-highlight-persist t))

(provide 'init-evil)
