;;; package --- Summary - CTZNFIVE EMACS INIT -

;;; Commentary:

;;; --------------------------
;;; ----- CTZNFIVE EMACS -----
;;; --------------------------

;;; Code:
(require 'server)
(if (not (server-running-p)) (server-start))



;;; ----- C U S T O M -----
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
    '(custom-safe-themes
         '("e29a6c66d4c383dbda21f48effe83a1c2a1058a17ac506d60889aba36685ed94" default))
 '(helm-minibuffer-history-key "M-p")
    '(package-selected-packages
         '(pass which-key use-package undo-fu smartparens smart-mode-line-atom-one-dark-theme org-download org-bullets magit helm-projectile git-gutter flycheck evil-collection doom-themes diminish crux avy auto-complete)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line-inactive ((t (:background nil)))))



;;; ----- P A C K A G E S -----
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))

(eval-when-compile
    (require 'use-package))

(use-package undo-fu
    :ensure t)

(use-package evil
    :ensure t
    :init
    (setq evil-want-keybinding nil)
    :config
    (define-key evil-normal-state-map "u" 'undo-fu-only-undo)
    (define-key evil-normal-state-map "\C-r" 'undo-fu-only-redo)
    (evil-mode 1))

(use-package evil-collection
    :ensure t
    :after (evil)
    :config
    (evil-collection-init))

(use-package doom-themes
    :ensure t
    :config
    (load-theme 'doom-one t))

(use-package smart-mode-line-atom-one-dark-theme
    :ensure t)

(use-package smart-mode-line
    :ensure t
    :config
    (custom-set-faces
        '(mode-line-inactive ((t (:background nil)))))
    (setq sml/theme 'atom-one-dark)
    (sml/setup))

(use-package diminish
    :ensure t)

(use-package smartparens
    :ensure t
    :diminish smartparens-mode
    :config
    (progn
        (require 'smartparens-config)
        (smartparens-global-mode 1)
        (show-paren-mode t)))

(use-package which-key
    :ensure t
    :diminish which-key-mode
    :config
    (which-key-mode 1))

(use-package avy
    :ensure t
    :bind
    ("C-'" . avy-goto-char)
    :config
    (setq avy-background t))

(use-package crux
    :ensure t
    :bind
    ("C-c I" . crux-find-user-init-file)
    ("C-c t" . crux-visit-term-buffer)
    ("C-c u" . crux-view-url)
    ("C-c l" . crux-open-with))

(use-package magit
    :ensure t
    :bind (("C-M-g" . magit-status)))

(use-package git-gutter
    :ensure t
    :config
    (global-git-gutter-mode t))

(use-package helm-projectile
    :ensure t
    :config
    (helm-projectile-on))

(use-package projectile
    :ensure t
    :diminish projectile-mode
    :bind
    ("C-c p f" . helm-projectile-find-file)
    ("C-c p p" . helm-projectile-switch-project)
    ("C-c p s" . projectile-save-project-buffers)
    :config
    (projectile-mode 1))

(use-package helm
    :ensure t
    :defer 2
    :diminish helm-mode
    :bind
    ("M-x" . helm-M-x)
    ("C-x C-f" . helm-find-files)
    ("M-y" . helm-show-kill-ring)
    ("C-x b" . helm-mini)
    :config
    (require 'helm-config)
    (helm-mode 1)
    (setq helm-split-window-inside-p t
        helm-move-to-line-cycle-in-source t)
    (setq helm-autoresize-max-height 0)
    (setq helm-autoresize-min-height 50)
    (helm-autoresize-mode 1)
    (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action))

(use-package flycheck
    :ensure t
    :diminish flycheck-mode
    :config
    (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package auto-complete
    :ensure t
    :init
    (require 'auto-complete-config)
    :config
    (ac-config-default))

(use-package org-bullets
    :ensure t
    :hook (org-mode . org-bullets-mode))

(use-package org-download
    :ensure t
    :config
    (add-hook 'dired-mode-hook 'org-download-enable))

(use-package pass
    :ensure t)



;;; ----- C O N F I G -----
(setq gc-cons-threshold 50000000)
(setq large-file-warning-threshold 100000000)
(global-auto-revert-mode t)
(setq frame-title-format
      '((:eval (if (buffer-file-name)
       (abbreviate-file-name (buffer-file-name))
       "%b"))))
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(setq inhibit-splash-screen t)
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq ring-bell-function 'ignore)
(setq use-dialog-box nil)
(setq scroll-step 1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(global-hl-line-mode 1)
(when (version<= "26.0.50" emacs-version)
    (global-display-line-numbers-mode))
(blink-cursor-mode -1)
(column-number-mode t)
(fset 'yes-or-no-p 'y-or-n-p)
(global-set-key (kbd "C-x k") 'kill-this-buffer)
(setq-default truncate-lines t)
(add-hook 'before-save-hook 'whitespace-cleanup)
(setq-default indent-tabs-mode nil)
(define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)
;; indentiation stuff (maybe some variable is missing for other language
(setq-default indent-line-function 4)
(setq-default tab-width 4)
(setq-default c-basic-offset 4)
(setq-default lisp-indent-offset 4)
(setq-default sgml-basic-offset 4)
(setq-default nxml-child-indent 4)
(setq tab-stop-list (number-sequence 4 200 4))

(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(display-time)

(add-to-list 'initial-frame-alist '(background-color . "#1a1a1b"))
(add-to-list 'initial-frame-alist '(foreground-color . "#ffffff"))
(add-to-list 'default-frame-alist '(background-color . "#1a1a1b"))
(add-to-list 'default-frame-alist '(foreground-color . "#ffffff"))
(set-face-foreground 'font-lock-comment-face "gray50")
(set-face-background 'hl-line "gray20")
(set-frame-font "Iosevka Semibold 16" nil t)

(show-paren-mode t)
(setq show-paren-delay 0)
(setq backup-directory-alist
    `(("." . ,(expand-file-name
        (concat user-emacs-directory "backups")))))
(setq auto-save-file-name-transforms
    `((".*" ,(expand-file-name
        (concat user-emacs-directory "auto-save")))))

(setq org-startup-with-inline-images t)
(setq org-image-actual-width (/ (display-pixel-width) 3))
(add-hook 'org-mode-hook #'visual-line-mode)
(setq org-priority-faces '((?A . (:foreground "#f65b5b"))
                           (?B . (:foreground "#e7e78a"))
                           (?C . (:foreground "#84f684"))))
(setq org-todo-keywords
    '((sequence "TODO" "NEXT" "WAITING" "|" "DONE")))
(setq org-todo-keyword-faces
    '(("NEXT" . "#f65b5b")))

;;; COMMON LISP
(load (expand-file-name "~/.quicklisp/slime-helper.el"))
(setq inferior-lisp-program "sbcl")



;;; init.el ends here
