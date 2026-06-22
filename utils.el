;; Workspace Helpers
(defun my/project-root()
  (or (when (bound-and-true-p projectile-mode)
	(projectile-project-root))
      (locate-dominating-file default-directory ".git")
      default-directory))
      
