;;; package --- Summary: Emacs config -*- lexical-binding: t; -*-
;;; Commentary:
;;; Package configuration
;;; Code:

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

(with-eval-after-load 'dap-mode
  ;(define-key dap-mode-map (kbd "<f5>") 'dap-debug)
  (define-key dap-mode-map (kbd "<f5>") 'my/dap-debug-fresh)
  (define-key dap-mode-map (kbd "<f6>") 'dap-continue)
  (define-key dap-mode-map (kbd "<f9>") 'dap-breakpoint-toggle)
  (define-key dap-mode-map (kbd "<f10>") 'dap-next)
  (define-key dap-mode-map (kbd "<f11>") 'dap-step-in)
  (define-key dap-mode-map (kbd "<f12>") 'dap-step-out))

(provide 'dev-config)
;;; dev-config.el ends here
