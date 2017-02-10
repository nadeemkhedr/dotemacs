(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(add-to-list 'exec-path "/usr/local/bin")


(require 'bookmark)
(bookmark-maybe-load-default-file)


(setq package-enable-at-startup nil)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; Essential settings.
(setq inhibit-splash-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(when (boundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(show-paren-mode 1)
(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
(setq-default left-fringe-width nil)
(setq-default indent-tabs-mode nil)
(eval-after-load "vc" '(setq vc-handled-backends nil))
(setq vc-follow-symlinks t)
(setq large-file-warning-threshold nil)
(setq split-height-threshold nil)
(setq split-width-threshold 0)
(setq custom-safe-themes t)
(put 'narrow-to-region 'disabled nil)

;; auto refresh buffers
(global-auto-revert-mode t)

(setq-default show-trailing-whitespace t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq whitespace-style '(tabs tab-mark))
(global-whitespace-mode)

(setq make-backup-files nil)
(setq backup-directory-alist
      `((".*" . "~/.saves")))
(setq auto-save-file-name-transforms
      `((".*" "~/.saves" t)))
(setq create-lockfiles nil)

(winner-mode 1)

(use-package dictionary :ensure t)

(use-package emmet-mode
  :defer t
  :init
  (add-hook 'css-mode-hook 'emmet-mode)
  (add-hook 'sgml-mode-hook 'emmet-mode)
  :config
  (setq-default emmet-move-cursor-between-quote t)
  (unbind-key "<C-return>" emmet-mode-keymap)
  (unbind-key "C-M-<left>" emmet-mode-keymap)
  (unbind-key "C-M-<right>" emmet-mode-keymap)
  (define-key evil-normal-state-map (kbd "C-f") 'emmet-expand-line)
  (global-set-key (kbd "C-f") 'emmet-expand-line))

(use-package sublime-themes :ensure t)
(use-package gruvbox-theme :ensure t)
(use-package monokai-theme :ensure t)
(use-package color-theme-sanityinc-tomorrow :ensure t)

(use-package paradox :ensure t)

(use-package nlinum-relative
  :ensure t
  :config
  (nlinum-relative-setup-evil)
  (setq nlinum-relative-redisplay-delay 0)
  (add-hook 'prog-mode-hook #'nlinum-relative-mode))

(use-package company
  :ensure t
  :config
  (global-company-mode)
  (setq company-idle-delay 0.2)
  (setq company-selection-wrap-around t)
  (define-key company-active-map [tab] 'company-complete)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (with-eval-after-load 'company
  (add-to-list 'company-backends 'company-elm))
  (add-hook 'elm-mode-hook #'elm-oracle-setup-completion))

(use-package find-file-in-project :ensure t)

(use-package neotree
  :ensure t
  :config
  (setq projectile-switch-project-action 'neotree-projectile-action)
  (add-hook 'neotree-mode-hook
    (lambda ()
      (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
      (define-key evil-normal-state-local-map (kbd "I") 'neotree-hidden-file-toggle)
      (define-key evil-normal-state-local-map (kbd "z") 'neotree-stretch-toggle)
      (define-key evil-normal-state-local-map (kbd "R") 'neotree-refresh)
      (define-key evil-normal-state-local-map (kbd "m") 'neotree-rename-node)
      (define-key evil-normal-state-local-map (kbd "c") 'neotree-create-node)
      (define-key evil-normal-state-local-map (kbd "d") 'neotree-delete-node)

      (define-key evil-normal-state-local-map (kbd "s") 'neotree-enter-vertical-split)
      (define-key evil-normal-state-local-map (kbd "S") 'neotree-enter-horizontal-split)

      (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter))))

(defun neotree-project-dir ()
  "Open NeoTree using the git root."
  (interactive)
  (let ((project-dir (ffip-project-root))
        (file-name (buffer-file-name)))
    (if project-dir
        (progn
        (neotree-dir project-dir)
        (neotree-find file-name))
    (message "Could not find git project root."))))

(use-package ace-window :ensure t)

(use-package ag
  :ensure t
  :config
  (setq ag-reuse-buffers 't)
  (setq ag-reuse-window 't)
  (setq ag-highlight-search t))

(use-package zoom-window :ensure t)

(use-package projectile
  :ensure t
  :defer t
  :config
  (projectile-global-mode))

(use-package helm
  :ensure t
  :diminish helm-mode
  :config
  (helm-mode 1)
  (setq helm-buffers-fuzzy-matching t)
  (setq helm-autoresize-mode t)
  (setq helm-buffer-max-length 40)
  (global-set-key (kbd "M-x") #'helm-M-x)
  (define-key helm-map (kbd "S-SPC") 'helm-toggle-visible-mark)
  (define-key helm-find-files-map (kbd "C-k") 'helm-find-files-up-one-level))

(use-package magit
  :ensure t
  :defer t
  :config
  (setq magit-branch-arguments nil)
  (setq magit-push-always-verify nil)
  (setq magit-last-seen-setup-instructions "1.4.0"))

(use-package helm-ag
  :ensure t)

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

(use-package elm-mode
  :ensure t
  :config
  (setq elm-format-on-save t))

(require 'init-spaces)
(require 'init-evil)
(require 'init-flycheck)
(require 'init-webmode)
(require 'init-powerline)
(require 'evil-little-word)

(use-package helm-projectile
  :bind (("C-S-P" . helm-projectile-switch-project)
         :map evil-normal-state-map
         ("C-p" . helm-projectile))
  :after (helm projectile evil)
  :commands (helm-projectile helm-projectile-switch-project)
  :ensure t)


;;set frame full height and 86 columns wide
;;and position at screen left
(defun bjm-frame-resize-l ()
  "set frame full height and 86 columns wide and position at screen left"
  (interactive)
  (set-frame-width (selected-frame) 86)
  (maximize-frame-vertically)
  (set-frame-position (selected-frame) 0 0)
  )

;;set frame full height and 86 columns wide
;;and position at screen right
(defun bjm-frame-resize-r ()
  "set frame full height and 86 columns wide and position at screen right"
  (interactive)
  (set-frame-width (selected-frame) 86)
  (maximize-frame-vertically)
  (set-frame-position (selected-frame) (- (display-pixel-width) (frame-pixel-width)) 0)
  )

;;set frame full height and 86 columns wide
;;and position at screen right of left hand screen in 2 monitor display
;;assumes monitors are same resolution
(defun bjm-frame-resize-r2 ()
  "set frame full height and 86 columns wide and position at screen right of left hand screen in 2 monitor display assumes monitors are same resolution"
  (interactive)
  (set-frame-width (selected-frame) 86)
  (maximize-frame-vertically)
  (set-frame-position (selected-frame) (- (/ (display-pixel-width) 2) (frame-pixel-width)) 0)
  )

;;set keybindings
(global-set-key (kbd "C-c b <left>") 'bjm-frame-resize-l)
(global-set-key (kbd "C-c b <right>") 'bjm-frame-resize-r)
(global-set-key (kbd "C-c b <S-right>") 'bjm-frame-resize-r2)




;; escape quits
(bind-key "<escape>" 'isearch-cancel isearch-mode-map)
(define-key minibuffer-local-map (kbd "ESC") 'abort-recursive-edit)
(define-key minibuffer-local-ns-map (kbd "ESC") 'abort-recursive-edit)
(define-key minibuffer-local-completion-map (kbd "ESC") 'abort-recursive-edit)
(define-key minibuffer-local-must-match-map (kbd "ESC") 'abort-recursive-edit)
(define-key minibuffer-local-isearch-map (kbd "ESC") 'abort-recursive-edit)
(bind-key "<escape>" 'helm-keyboard-quit helm-map)
(bind-key "<escape>" 'helm-keyboard-quit helm-comp-read-map)

;;(load-theme 'gruvbox)
(load-theme 'monokai)

;; start maximized
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(package-selected-packages (quote (evil-surround evil-leader evil use-package)))
 '(paradox-github-token t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((((class color) (min-colors 257)) (:foreground "#F8F8F2" :background "#272822")) (((class color) (min-colors 89)) (:foreground "#F5F5F5" :background "#1B1E1C")))))
