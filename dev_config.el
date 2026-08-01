;;; package --- Summary: Emacs config -*- lexical-binding: t; -*-
;;; Commentary:
;;; Package configuration
;;; Code:

(require 'projectile)
(defun load-code-files()
  "Load all .el files in the .vscode folder."
  (let ((code-dir (expand-file-name ".vscode" (projectile-project-root))))
    (if (file-directory-p code-dir)
	(dolist (file (directory-files code-dir t "\\.el$"))
	  (message "Load file: %s" file)
	  (load-file file)))))

(c-add-style "my-c-style"
	     '("bsd"
	       (c-basic-offset . 4)
	       (c-hanging-semi&comma-criteria . nil)))

;;; Tab and indentation mode
(require 'lsp)
(require 'cc-mode)
(add-hook 'c-mode-common-hook
	  (lambda ()
	    (c-set-style "my-c-style")
	    (electric-pair-mode 1)
	    (c-toggle-auto-newline 1)
	    (setq lsp-enable-indentation nil)
	    (lsp)))

;;; Kill old debug buffers when starting debug
(require 'dap-mode)
(defun my/dap-kill-stale-debug-buffers ()
  "Kill any leftover dap-mode/adapter buffers from previous debug sessions."
  (dolist (buf (buffer-list))
    (let ((name (buffer-name buf)))
      (when (and name
                 (or (string-match-p "\\`debug buffer" name)
                     (string-match-p "cppdbg" name)))
        (let ((proc (get-buffer-process buf)))
          (when proc (delete-process proc)))
        (kill-buffer buf)))))
(defun my/dap-debug-fresh ()
  "Clear old debug buffers."
  (interactive)
  (dap-delete-all-sessions)
  (my/dap-kill-stale-debug-buffers)
  (call-interactively #'dap-debug))

;; Dap mode keybindings
(with-eval-after-load 'dap-mode
  ;(define-key dap-mode-map (kbd "<f5>") 'dap-debug)
  (define-key dap-mode-map (kbd "<f5>") 'my/dap-debug-fresh)
  (define-key dap-mode-map (kbd "<f6>") 'dap-continue)
  (define-key dap-mode-map (kbd "<f9>") 'dap-breakpoint-toggle)
  (define-key dap-mode-map (kbd "<f10>") 'dap-next)
  (define-key dap-mode-map (kbd "<f11>") 'dap-step-in)
  (define-key dap-mode-map (kbd "<f12>") 'dap-step-out))

;;; Toggle comment
(defun comment-line-stay ()
  "A custom comment function."
  (interactive)
  (if (use-region-p)
      (comment-or-uncomment-region
       (region-beginning)
       (region-end))
    (comment-or-uncomment-region
     (line-beginning-position)
     (line-end-position))))

(custom-set-faces
 '(font-lock-comment-face ((t (:foreground "#57A64A"
                               :slant italic)))))

(provide 'dev_config)
;;; dev_config.el ends here
