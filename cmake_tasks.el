;;; package --- Summary: Build Tasks -*- lexical-binding: t; -*-
;;; Cmake build commands
;;; Commentary:
;;; Code:

;; DEBUG configuration
(require 'projectile)

(defun save-project-buffers()
  "Save all the project files, without needing confirmation."
  (interactive)
  (when-let ((root (projectile-project-root)))
    (save-some-buffers
     t
     (lambda ()
       (and buffer-file-name
	    (file-in-directory-p buffer-file-name root))))))

(defun cmake-generate-debug ()
  "Generate cmake debug target."
  (interactive)
  (let ((default-directory (projectile-project-root)))
    (compile "cmake -DCMAKE_BUILD_TYPE=Debug -B BUILD/debug")))

(defun cmake-build-debug ()
  "Cmake build debug target."
  (interactive)
  (save-project-buffers)
  (let ((default-directory (projectile-project-root)))
    (save-some-buffers t)
    (compile "cmake --build BUILD/debug")))

(defun cmake-rebuild-debug ()
  "Cmake rebuild debug target."
  (interactive)
  (save-project-buffers)
  (let ((default-directory (projectile-project-root)))
    (compile "cmake --build BUILD/debug --clean-first")))

(defun cmake-clean-debug ()
  "Cmake clean debug target."
  (interactive)
  (let ((default-directory (projectile-project-root)))
    (compile "cmake --build BUILD/debug --target clean")))

;; RELEASE configuration
(defun cmake-generate-release ()
  "Generate cmake release target."
  (interactive)
  (let ((default-directory (projectile-project-root)))
    (compile "cmake -DCMAKE_BUILD_TYPE=Release -B BUILD/release")))

(defun cmake-build-release ()
  "Cmake build release target."
  (interactive)
  (save-project-buffers)
  (let ((default-directory (projectile-project-root)))
    (save-some-buffers t)
    (compile "cmake --build BUILD/release")))

(defun cmake-rebuild-release ()
  "Cmake rebuild release target."
  (interactive)
  (save-project-buffers)
  (let ((default-directory (projectile-project-root)))
    (compile "cmake --build BUILD/release --clean-first")))

(defun cmake-clean-release ()
  "Cmake clean release target."
  (interactive)
  (let ((default-directory (projectile-project-root)))
    (compile "cmake --build BUILD/release --target clean")))

;;; Set up keybindings
(define-key projectile-command-map (kbd "b") #'cmake-build-debug)


(provide 'cmake_tasks)
;;; cmake_tasks.el ends here
