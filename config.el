;;; Editor Configuration
;;; --------------------


(tool-bar-mode -1)                                           ; Disable visual toolbar
(menu-bar-mode -1)                                           ; Disable visual menu bar
(scroll-bar-mode -1)                                         ; Disable scroll bars
(tooltip-mode -1)                                            ; Disable tooltips

(column-number-mode)
(set-fringe-mode 10)                                         ; Add some margins
(global-display-line-numbers-mode 1)                         ; Enable line numbers
;(setq display-line-numbers-type 'relative)                   ; Set relative line numbers

;; Disable line numbers in certain modes
(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(setq inhibit-startup-message t)                             ; Disable splash screen
(setq visible-bell t)                                        ; Disable bell and show visible highlight when executing blocked command

;; Window Tabs
(global-tab-line-mode 1)
(setq tab-line-tabs-function #'tab-line-tabs-window-buffers)

;; Redirect backups and auto save
(defvar my-emacs-tmp-dir
  (expand-file-name ".emacs-tmp/" (getenv "HOME")))

(defvar my-auto-save-dir
  (expand-file-name "emacs-autosaves/" my-emacs-tmp-dir))

(defvar my-backup-dir
  (expand-file-name "emacs-backups/" my-emacs-tmp-dir))

(make-directory my-auto-save-dir t)
(make-directory my-backup-dir t)

(setq auto-save-file-name-transforms
      `((".*" ,my-auto-save-dir t)))

(setq backup-directory-alist
      `((".*" . ,my-backup-dir)))

;; NAV functions
(defun eshell/emacs-conf ()
  (cd "~/.emacs.d"))

;; Keybindings
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-M-b") 'counsel-switch-buffer)
(global-set-key (kbd "C-M-j") 'dired-jump)
(global-set-key (kbd "C-M-s") 'counsel-projectile-rg)
(global-set-key (kbd "C-M-f") 'counsel-find-file)

;; Hooks
(add-hook 'projectile-after-switch-project-hook
	  (lambda ()
            (let ((code-dir (expand-file-name ".vscode" (projectile-project-root))))
              (if (file-directory-p code-dir)
             	  (dolist (file (directory-files code-dir t "\\.el$"))
             	    (message "Load file: %s" file)
             	    (load-file file))))))
	     
;; Functions
(defun load-code-files()
  (let ((code-dir (expand-file-name ".vscode" (projectile-project-root))))
    (if (file-directory-p code-dir)
        (dolist (file (directory-files code-dir t "\\.el$"))
          (message "Load file: %s" file)
          (load-file file)))))
  
	    
