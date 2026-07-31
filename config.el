;;; package --- Summary: Emacs config -*- lexical-binding: t; -*-

;;; Commentary:
;;; Basic editor configuration.

;;; Code:

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
		vterm-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(setq inhibit-startup-message t)                             ; Disable splash screen
(setq visible-bell t)                                        ; Disable bell and show visible highlight when executing blocked command

;; Window Tabs
(require 'tab-line)
(global-tab-line-mode 1)
(setq tab-line-tabs-function #'tab-line-tabs-window-buffers)

;; (define-advice tab-line-close-tab (:override (&optional e))
;;   "Close the selected tab.
;; If the tab is presented in another window,
;; close the tab by using the `bury-buffer` function.
;; If the tab is unique to all existing windows,
;; kill the buffer with the `kill-buffer` function.
;; Lastly, if no tabs are left in the window,
;; it is deleted with the `delete-window` function."
;;   (interactive "e")
;;   (let* ((posnp (event-start e))
;;          (window (posn-window posnp))
;;          (buffer (get-pos-property 1 'tab (car (posn-string posnp)))))
;;     (with-selected-window window
;;       (let ((tab-list (tab-line-tabs-window-buffers))
;;             (buffer-list (flatten-list
;;                           (seq-reduce (lambda (list window)
;;                                         (select-window window t)
;;                                         (cons (tab-line-tabs-window-buffers) list))
;;                                       (window-list) nil))))
;;         (select-window window)
;;         (if (> (seq-count (lambda (b) (eq b buffer)) buffer-list) 1)
;;             (progn
;;               (if (eq buffer (current-buffer))
;;                   (bury-buffer)
;;                 (set-window-prev-buffers window (assq-delete-all buffer (window-prev-buffers)))
;;                 (set-window-next-buffers window (delq buffer (window-next-buffers))))
;;               (unless (cdr tab-list)
;;                 (ignore-errors (delete-window window))))
;;           (and (kill-buffer buffer)
;;                (unless (cdr tab-list)
;;                  (ignore-errors (delete-window window)))))))
;;     (force-mode-line-update)))


(define-advice tab-line-close-tab (:override (&optional e))
  "Close the selected tab by burying its buffer.
If no tabs are left in the window, delete the window."
  (interactive "e")
  (let* ((posnp (event-start e))
         (window (posn-window posnp))
         (buffer (get-pos-property 1 'tab (car (posn-string posnp)))))
    (with-selected-window window
      (let ((tab-list (tab-line-tabs-window-buffers)))
        (if (eq buffer (current-buffer))
            (bury-buffer)
          (set-window-prev-buffers window (assq-delete-all buffer (window-prev-buffers)))
          (set-window-next-buffers window (delq buffer (window-next-buffers))))
        (unless (cdr tab-list)
          (ignore-errors (delete-window window)))))
    (force-mode-line-update)))


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
  "Navigate to Emacs configuration folder in eshell."
  (cd "~/.emacs.d"))

;; Functions
(require 'projectile)
(defun load-code-files()
  "Load all .el files in the .vscode folder."
  (let ((code-dir (expand-file-name ".vscode" (projectile-project-root))))
    (if (file-directory-p code-dir)
        (dolist (file (directory-files code-dir t "\\.el$"))
          (message "Load file: %s" file)
          (load-file file)))))
					
; Make dired use a single buffer
(require 'dired)
(setq dired-kill-when-opening-new-dired-buffer t
      dired-auto-revert-buffer t)

(c-add-style "my-c-style"
	     '("bsd"
	       (c-basic-offset . 4)
	       (c-hanging-semi&comma-criteria . nil)))




(require 'lsp)
(require 'cc-mode)
;(add-hook 'c-mode-hook 'lsp)
(add-hook 'c-mode-common-hook
	  (lambda ()
	    (c-set-style "my-c-style")
	    (electric-pair-mode 1)
	    (c-toggle-auto-newline 1)
	    (setq lsp-enable-indentation nil)
	    (lsp)))

(provide 'config)
;;; config.el ends here
