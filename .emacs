;; Load path
(setq load-path (cons "~/.elisp" load-path))

;; User settings
(partial-completion-mode 1)
(icomplete-mode 1)
(setq make-backup-files nil)
(setq truncate-partial-width-windows nil)

; I want to be able to join lines, I already bloody have a newline key
(define-key global-map "\C-j" 'join-line)
(define-key global-map (kbd"C-TAB") 'complete-symbol)

; Force more unique buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

; I don't want no bloody trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; PSVN settings
(global-set-key [f2] 'svn-status)

;; python-mode settings
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode)
				   interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)
(add-hook 'python-mode-hook 'turn-on-auto-fill)

;; ffap settings
(require 'ffap)
(ffap-bindings)
(setq ffap-require-prefix t)

;; Dired settings
(define-key global-map "\C-x\C-j" 'dired-jump)
(require 'dired-x)
(setq dired-omit-files
      (rx (or (seq bol (? ".") "#")         ;; emacs autosave files
              (seq "~" eol)                 ;; backup-files
              (seq bol "svn" eol)           ;; svn dirs
              (seq ".pyc" eol)
              )))
(add-hook 'dired-mode-hook (lambda () (dired-omit-mode 1)))
(put 'dired-find-alternate-file 'disabled nil)

;; ido settings
(require 'ido)
(ido-mode 'buffer)
(setq ido-enable-flex-matching t)

;; nXML mode settings
(autoload 'nxml-mode "nxml-mode" "" t)
(add-to-list 'auto-mode-alist
	     (cons (concat "\\." (regexp-opt '("xml" "xsd" "sch" "rng" "xslt" "svg" "rss") t) "\\'")
		   'nxml-mode))

(unify-8859-on-decoding-mode)

(setq magic-mode-alist
      (cons '("<＼＼?xml " . nxml-mode)
	    magic-mode-alist))
(fset 'xml-mode 'nxml-mode)
(fset 'html-mode 'nxml-mode)

;; Apache settings
(autoload 'apache-mode "apache-mode" "" t)
(add-to-list 'auto-mode-alist
	     (cons "\\.conf$" 'apache-mode))

(require 'flymake)
(load-library "flymake-cursor")
(add-hook 'find-file-hook 'flymake-find-file-hook)
(global-set-key "\C-c\C-j"  'flymake-goto-next-error)
(global-set-key "\C-c\C-k"  'flymake-goto-prev-error)
(global-set-key "\C-cs" 'flymake-display-err-menu-for-current-line)


(defun flymake-pyflakes-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
		     'flymake-create-temp-inplace))
	 (local-file (file-relative-name
		      temp-file
		      (file-name-directory buffer-file-name))))
    (list "pyflakes" (list local-file))))
(add-to-list 'flymake-allowed-file-name-masks
	     '("\\.py\\'" flymake-pyflakes-init))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-layout-name "left14")
 '(ecb-layout-window-sizes (quote (("left9" (0.21774193548387097 . 0.9821428571428571)) ("left2" (0.21774193548387097 . 0.21428571428571427) (0.21774193548387097 . 0.7678571428571429)))))
 '(ecb-options-version "2.32")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--mouse-2))
 '(ecb-source-file-regexps (quote ((".*" ("\\(^\\(\\.\\|#\\)\\|\\(~$\\|\\.\\(elc\\|pyc\\|obj\\|o\\|class\\|lib\\|dll\\|a\\|so\\|cache\\)$\\)\\)") ("^\\.\\(emacs\\|gnus\\)$")))))
 '(ecb-toggle-layout-sequence (quote ("left2" "left9")))
 '(ecb-tree-indent 2)
 '(ecb-windows-width 0.22)
 '(flymake-no-changes-timeout 1))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
