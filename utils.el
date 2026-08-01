;;; package --- Summary: Emacs config -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(require 'projectile)
(defun search/project-root()
  "Search the project root."
  (or (when (bound-and-true-p projectile-mode)
	(projectile-project-root))
      (locate-dominating-file default-directory ".git")
      default-directory))

(provide 'utils)
;;; utils.el ends here
