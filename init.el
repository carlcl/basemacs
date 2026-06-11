;;;; Emacs main configuration file
;;;; -----------------------------


;; Load configuration files
(load (expand-file-name "~/.emacs.d/packages.el"))
(load (expand-file-name "~/.emacs.d/config.el"))

(add-hook 'emacs-startup-hook
	  (lambda () (eshell)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(all-the-icons counsel doom-modeline evil helpful ivy-rich magit
		   slime)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
