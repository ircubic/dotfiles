;; Choose custom file to be the same as previous ESK setting
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)

;; Set up package manager to use marmalade
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Requirements for my emacs setup, for automatic setup on new machines
(defvar my-packages
  '(starter-kit starter-kit-lisp starter-kit-bindings
    starter-kit-js python-mode flymake-cursor yasnippet-bundle
    zenburn-theme );
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))
