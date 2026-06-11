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
  ;(setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  ;(setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1))

;; Shortcut keybding helper
(use-package which-key
  :ensure t
  :init (which-key-mode)
  :diminish (which-key-mode)
  :config
  (setq which-key-idle-delay 0.3))

;; The best git interface
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

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
	 ("S-TAB" . ivy-previous-line)
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
