;;; Set up Package Management

(load (expand-file-name "~/.quicklisp/slime-helper.el"))

(require 'package)

(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
	("org" . "https://orgmode.org/elpa/")
        ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)

;; Refresh the package contents
(unless package-archive-contents
  (package-refresh-contents))

;; Install use-package if not installed
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Install packages

;; Vim keybindings with evil
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
 ; (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  ;(setq evil-want-C-i-jump nil)
  (setq evil-undo-system 'undo-redo)
  :config
  (evil-mode 1))

;; Shortcut keybding helper
(use-package which-key
  :ensure t
  :init (which-key-mode)
  :diminish (which-key-mode)
  :config
  (setq which-key-idle-delay 0.0))

;; The best git interface
(use-package magit
  :ensure t
  :commands (magit-status magit-get-current-branch)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  :bind (("C-x g" . magit-status)))

;(use-package evil-collection
  ;:after (evil magit)
  ;:config
  ;(evil-collection-init))

;; The ivy-counsel-swiper stack
;; Ivy provides a better completion framework
;; Swiper is bundled with Ivy and provides in-buffer fuzzy search
(use-package ivy
  :ensure t
  :diminish
  :bind (("C-s" . swiper)
	 ;("C-S" . swiper-all)
	 :map ivy-minibuffer-map
	 ;("TAB" . ivy-alt-done)
	 ("TAB" . ivy-next-line)
	 ("<backtab>" . ivy-previous-line)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
 (ivy-mode 1))

;; counsel provides ivy-optimised replacement functions of common emacs commands
(use-package counsel
  :ensure t
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil))

;; ivy-rich adds more configuration options, and shows descriptions next to common functions  
(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

;; SBCL + Quicklisp
(use-package slime
  :config
  (setq inferior-lisp-program "sbcl")
  (slime-setup '(slime-fancy)))

(use-package all-the-icons)

;; A more modern status line
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height)))

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
  
;; Todo (optional): General, Evil-Collection, Hydra
;; Todo (mandatory): Projectile, Treemacs, LSP, DAP

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

(use-package org
  :config
  (setq org-ellipsis " ▾"))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(setq org-agenda-start-with-log-mode t)
(setq org-log-done 'time)
(setq org-log-into-drawer t)
(setq org-agenda-files '("~/Org/tasks.org"))
      
;; Set up LSP

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))

(use-package corfu
  :init
  (global-corfu-mode)
  :custom
  (corfu-auto t)
  (corfu-auto-prefix 1))

(setq lsp-completion-provider :capf)

;; LSP Language Servers
(use-package lsp-pyright
  :ensure t
  :custom (lsp-pyright-langserver-command "pyright") ;; or basedpyright
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp-deferred))))  ; or lsp


;; DAP MODE
(use-package dap-mode
  :ensure t
  :after lsp-mode
  :config
  (dap-auto-configure-mode))

;; DAP Extensions
(use-package dap-python
  :ensure nil 
  :after dap-mode
  :config
  (setq dap-python-debugger 'debugpy))

(add-hook 'python-mode-hook 'dap-mode)
(add-hook 'python-mode-hook 'dap-ui-mode)

(with-eval-after-load 'dap-mode
  (define-key dap-mode-map (kbd "<f9>") 'dap-breakpoint-toggle)
  (define-key dap-mode-map (kbd "<f5>") 'dap-debug)
  (define-key dap-mode-map (kbd "<f10>") 'dap-next)
  (define-key dap-mode-map (kbd "<f11>") 'dap-step-in)
  (define-key dap-mode-map (kbd "<f12>") 'dap-step-out))
