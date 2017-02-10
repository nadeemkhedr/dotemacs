(use-package evil
  :ensure t
  :config
  (evil-mode 1)
  (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
  (define-key evil-normal-state-map (kbd "RET") 'newline-without-break-of-line)
  (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
  (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
  (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
  (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
  (define-key evil-normal-state-map (kbd "C--") 'text-scale-decrease)
  (define-key evil-normal-state-map (kbd "C-+") 'text-scale-increase)
  (define-key evil-normal-state-map (kbd "C-=") 'text-scale-set)
  (setq evil-shift-width 2)
  ;;(define-key evil-normal-state-map (kbd "C-k") (lambda () (interactive) (evil-scroll-up nil)))
  ;;(define-key evil-normal-state-map (kbd "C-j") (lambda () (interactive) (evil-scroll-down nil)))
  (setq evil-move-cursor-back nil))

(defun newline-without-break-of-line ()
"1. move to end of the line.
2. insert newline with index"
  (interactive)
  (let ((oldpos (point)))
    (end-of-line)

    (newline-and-indent)))

(use-package evil-leader
  :ensure t
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader ",")
  (setq evil-leader/in-all-states 1)
  (evil-leader/set-key
    ","  (lambda () (interactive) (ansi-term (getenv "SHELL")))
    "m"  'neotree-toggle
    "n"  'neotree-project-dir
    "."  'switch-to-previous-buffer
    "/"  'evil-search-highlight-persist-remove-all
    "h"  'help-map
    "ps" 'helm-projectile-ag
    "pa" 'helm-projectile-find-file-in-known-projects
    "z" 'zoom-window-zoom
    "be" (lambda () (interactive) (bookmark-jump "emacs"))
    "w"  'ace-window))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package evil-search-highlight-persist
  :ensure t
  :config
  (global-evil-search-highlight-persist t))

(use-package evil-matchit
  :ensure t
  :config
  (global-evil-matchit-mode t))

(provide 'init-evil)
;;; init-evil.el ends here
