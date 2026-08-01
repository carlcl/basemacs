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
(toggle-frame-maximized)
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

;;; Tab-line - Add and configure window tabs
(require 'tab-line)
(global-tab-line-mode 1)
(setq tab-line-tabs-function #'tab-line-tabs-window-buffers)
(custom-set-faces
 '(tab-line ((t (:inherit mode-line
                          :height 110))))
 '(tab-line-tab-current ((t (:inherit tab-line
                                      :weight bold
                                      :foreground "orange")))))
(with-eval-after-load 'faces
  (set-face-attribute 'tab-line-tab-current nil
                      :weight 'bold
                      :foreground "orange"
                      :box `(:line-width 6 :color ,(face-background 'tab-line))))
(add-hook 'enable-theme-functions
          (lambda (_)
            (set-face-attribute 'tab-line-tab-current nil
                                :weight 'bold
                                :foreground "orange"
                                :box `(:line-width 6 :color ,(face-background 'tab-line)))))

;; This buries buffers when tabs are closed.
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
					
; Make dired use a single buffer
(require 'dired)
(setq dired-kill-when-opening-new-dired-buffer t
      dired-auto-revert-buffer t)

;; There is a weird padding bug here.
;; If I remove this then dap-mode debugging breaks with an obscure error:
;; Error in process filter: args out of range: 3767, 1, 3619
;; padding padding
;; padding padding
;; padding padding
;; padding padding
;; padding padding
;; padding padding
;; padding padding
;; padding padding
;; padding padding
;; padding padding

(provide 'config)
;;; config.el ends here
