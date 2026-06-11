;(load-theme 'modus-vivendi-tinted t)                         ; Set theme
(load-theme 'wombat t)
(set-face-attribute 'default nil
		    :background "#0d0e1c")

(tool-bar-mode -1)                                           ; Disable visual toolbar
(menu-bar-mode -1)                                           ; Disable visual menu bar
(scroll-bar-mode -1)                                         ; Disable scroll bars
(tooltip-mode -1)                                            ; Disable tooltips

(column-number-mode)
(global-display-line-numbers-mode 1)                         ; Enable line numbers
(set-fringe-mode 10)                                         ; Add some margins
(setq display-line-numbers-type 'relative)                   ; Set relative line numbers

;; Diasble line numbers in certain modes
(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(setq inhibit-startup-message t)                             ; Disable splash screen
(setq visible-bell t)                                        ; Disable bell and show visible highlight when executing blocked command
(toggle-frame-fullscreen)                                    ; Open full screen
;(set-face-attribute 'default nil :font "Fira Code Retina")

;; Redirect backups and auto save
(defvar my-emacs-tmp-dir
  (expand-file-name ".emacs-tmp/" (getenv "HOME")))

(defvar my-auto-save-dir
  (expand-file-name "emacs-autosaves/" my-emacs-tmp-dir))

(defvar my-backup-dir
  (expand-file-name "emacs-backups/" my-emacs-tmp-dir))

(make-directory my-auto-save-dir t)
(make-directory my-backup-dir t)

;; autosaves (#file#)
(setq auto-save-file-name-transforms
      `((".*" ,my-auto-save-dir t)))

;; backups (file~)
(setq backup-directory-alist
      `((".*" . ,my-backup-dir)))

;; NAV functions
(defun eshell/emacs-conf ()
  (cd "~/.emacs.d"))

(defun eshell/dev ()
  (cd "~/Dev"))

;; Keybindings
;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-M-b") 'counsel-switch-buffer)
(global-set-key (kbd "C-M-j") 'dired-jump)
