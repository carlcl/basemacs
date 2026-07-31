;;; package --- Summary: Keybindings config -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

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
;; Keybindings
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-M-b") 'counsel-switch-buffer)
(global-set-key (kbd "C-M-j") 'dired-jump)
(global-set-key (kbd "C-M-s") 'counsel-projectile-rg)
(global-set-key (kbd "C-M-f") 'counsel-find-file)
(global-set-key (kbd "M-<up>") 'move-text-up)
(global-set-key (kbd "M-k") 'move-text-up)
(global-set-key (kbd "M-<down>") 'move-text-down)
(global-set-key (kbd "M-j") 'move-text-down)
(global-set-key (kbd "C-/") 'comment-line-stay)
(global-set-key (kbd "<mouse-8>") 'xref-go-back)
(global-set-key (kbd "<mouse-9>") 'xref-go-forward)
;(global-set-key (kbd "<mouse-8>") 'evil-jump-backward)
;(global-set-key (kbd "<mouse-9>") 'evil-jump-forward)

(provide 'keybindings.el)
;;; keybindings.el ends here
