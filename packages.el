;;; package --- Summary: Emacs config -*- lexical-binding: t; -*-
;;; Commentary:
;;; Package configuration
;;; Code:

;; Quicklisp - the lisp package manager
;(load (expand-file-name "~/.quicklisp/slime-helper.el"))
(let ((f (expand-file-name "~/.quicklisp/slime-helper.el")))
  (when (file-exists-p f) (load f)))

;;; Setup Package Management
(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
	("org" . "https://orgmode.org/elpa/")
        ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;;; packages
;;; --------
(when (eq system-type 'gnu/linux)
  (use-package vterm
    :ensure t))

;; Doom Modeline - A more modern status line
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 45)))

(use-package doom-themes
  :ensure t
  :custom
  ;; Global settings (defaults)
  (doom-themes-enable-bold t)   ; if nil, bold is universally disabled
  (doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;; for treemacs users
  (doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  :config
  (load-theme 'doom-ayu-dark t)
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; or for treemacs users
  ;(doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; Vim keybindings with evil
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-C-u-scroll t)
  (setq evil-undo-system 'undo-redo)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  :config
  (evil-mode 1))

;; Shortcut keybding helper
(use-package which-key
  :ensure t
  :init (which-key-mode)
  :diminish (which-key-mode)
  :config
  (setq which-key-idle-delay 0.0))

;; Git
(use-package magit
  :ensure t
  :commands (magit-status magit-get-current-branch)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  :bind (("C-x g" . magit-status)))

;; The ivy-counsel-swiper stack:
;; Ivy is a better completion framework
;; Swiper provide in-buffer fuzzy searcho
;; Counsel is a collection of Ivy-enhanced versions of common Emacs command.
(use-package ivy
  :ensure t
  :diminish
  :bind (("C-s" . swiper)
	 ("C-S-s" . swiper-all)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package ivy-posframe
  :after ivy
  :commands (ivy-posframe-mode
	     ivy-posframe-display-at-frame-center)
  :init
  (ivy-posframe-mode 1)
  :config
  (setq ivy-height 40
	ivy-posframe-width 160
        ivy-posframe-height 40
        ivy-posframe-min-width 80
        ivy-posframe-border-width 16)
  (setq ivy-posframe-display-functions-alist
	'((t . ivy-posframe-display-at-frame-center))))

;; ivy-rich adds more configuration options, and shows descriptions next to common functions
(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

;; counsel provides ivy-optimised replacement functions of common emacs commands
(use-package counsel
  :ensure t
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 ("C-p" . counsel-projectile-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil))

;; (use-package move-text
;;   :ensure t)

;; Add more icons to emacs
(use-package all-the-icons)

;; Helpful - a package that provides an improved help system
(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; Projectile - Add project management to emacs
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/Dev/code")
    (setq projectile-project-search-path '("~/Dev/code")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

;; Orgmode
(use-package org
  :config
  (setq org-ellipsis " ▾"))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(require 'org)
(require 'org-agenda)
(setq org-agenda-start-with-log-mode t)
(setq org-log-done 'time)
(setq org-log-into-drawer t)
(setq org-agenda-files '("~/Org/tasks.org"))

;; Install via straight/use-package
(use-package centaur-tabs
  :ensure t
  :hook (after-init . centaur-tabs-mode)
  :config
  (setq centaur-tabs-style "bar")
  (setq centaur-tabs-cycle-scope 'tabs)
  (setq centaur-tabs-height 32)
  (setq centaur-tabs-set-icons t)
  (setq centaur-tabs-set-modified-marker t)
  :bind
  ("C-<tab>" . centaur-tabs-forward)
  ("C-<iso-lefttab>" . centaur-tabs-backward))
      
;; Treemacs
(use-package treemacs
  :ensure t
  :bind
  (("C-c t" . treemacs-select-window)
   ("C-c b" . treemacs))
  :defer t
  :functions (treemacs-follow-mode
	      treemacs-filewatch-mode)
  :config
  (progn
    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-project-follow-mode t)))

 (use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

;; Flycheck provides syntax checking and static analysis
(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode))

;; Set up LSP
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :functions
  (lsp-enable-which-key-integration)
  :custom
  (lsp-keymap-prefix "C-c l")
  (lsp-diagnostics-provider :flycheck)
  (lsp-completion-provider :capf)
  (lsp-cmake-server-command "cmake-language-server")
  (lsp-clients-clangd-args '("--clang-tidy" "--enable-config"))
  :config
  (lsp-enable-which-key-integration t))

;; Corfu - an in-buffer completion package. Displays completions in a popup overlay
(use-package corfu
  :init
  (global-corfu-mode)
  ;; :bind (:map corfu-map
	      ;; ("C-n" . corfu-next)
	      ;; ("C-p" . corfu-previous))
  :custom
  (corfu-auto t)
  (corfu-auto-prefix 1))

;; LSP Language Servers
(use-package lsp-pyright
  :ensure t
  :custom (lsp-pyright-langserver-command "pyright") ;; or basedpyright
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp-deferred))))  ; or lsp
;; Cmake
(use-package cmake-mode
  :ensure t
  :mode ("CMakeLists\\.txt\\'" "\\.cmake\\'")
  :hook (cmake-mode . lsp-deferred))

(use-package lsp-ui
  :ensure t
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-delay 0.3)
  (lsp-ui-doc-position 'at-point)
  (lsp-ui-doc-show-with-mouse t)
  (lsp-ui-doc-border "gray")
  ;; Sideline (in-buffer hints)
  (lsp-ui-sideline-enable t)
  (lsp-ui-sideline-show-diagnostics t)
  (lsp-ui-sideline-show-hover nil)
  ;; Peek (definitions/references popup)
  (lsp-ui-peek-enable t)
  ;; Flycheck integration display
  (lsp-ui-flycheck-enable t))

  ;; Optional: better LSP completion integration
(use-package cape
    :ensure t
    :init
    (add-to-list 'completion-at-point-functions #'cape-file)
    (add-to-list 'completion-at-point-functions #'cape-dabbrev))

(add-hook 'c-mode-hook 'lsp)
(add-hook 'c-mode-hook
          (lambda ()
            (setq-local comment-start "// ")
            (setq-local comment-end "")))
(add-hook 'c++-mode-hook 'lsp)

;; Yasnippet adds coding snippets
(use-package yasnippet
  :ensure t
  :config
  (require 'yasnippet)
  (yas-global-mode 1))

;; DAP MODE
(use-package dap-mode
  :ensure t
  :after lsp-mode
  :custom
  (dap-python-debugger 'debugpy)
  (dap-default-terminal-kind "internal")
  :config
  (require 'dap-cpptools)
  (require 'dap-python)
  (dap-mode 1)
  (dap-ui-mode 1))

(provide 'packages)
;;; packages.el ends here
