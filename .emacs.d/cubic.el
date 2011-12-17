(require 'cl)
(global-set-key "\C-w" 'backward-kill-word)
(setq make-backup-files nil)
(setq truncate-partial-width-windows nil)
(setq split-height-threshold 30)
(define-key global-map "\C-j" 'join-line)

(global-set-key (kbd "C-<tab>") 'hippie-expand)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq require-final-newline t)
(setq mumamo-chunk-coloring 20)
(setq ispell-dictionary "english")
(setq-default fill-column 80)

;; Mode Specific things
(eval-after-load "tex-mode"
  '(progn
	 (load "auctex.el" nil nil t)
     (setq TeX-auto-save t)
     (setq TeX-parse-self t)
     (setq TeX-PDF-mode t)
	 (require 'reftex)
	 (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
     (add-hook 'LaTeX-mode-hook
               (lambda ()
                 (TeX-fold-mode 1)
                 (add-hook 'find-file-hook 'TeX-fold-buffer t)
                 (add-hook 'after-save-hook 'TeX-fold-buffer t)))))


; Allow flymake to use PyFlakes
(eval-after-load "flymake"
  '(progn
     (defun flymake-pyflakes-init ()
       (let* ((temp-file (flymake-init-create-temp-buffer-copy
                          'flymake-create-temp-inplace))
              (local-file (file-relative-name
                           temp-file
                           (file-name-directory buffer-file-name))))
         (list "pyflakes" (list local-file))))
     (add-to-list 'flymake-allowed-file-name-masks
                  '("\\.py\\'" flymake-pyflakes-init))))

(defun auto-indent-hook ()
  (local-set-key (kbd "RET") 'newline-and-indent))

(eval-after-load "python"
  '(progn
	 (message "Python lawls")
     (add-hook 'python-mode-hook 'auto-indent-hook)
     (add-hook 'python-mode-hook 'auto-fill-mode)
     (add-hook 'python-mode-hook 'flymake-mode)))

(defun go-to-char (arg char)
  (interactive "p\ncGo to char: ")
  (with-no-warnings
    (if (char-table-p translation-table-for-input)
        (setq char (or (aref translation-table-for-input char) char))))
  (search-forward (char-to-string char) nil nil arg)
  (backward-char))

(setq org-agenda-files (list "~/org/work.org"
                             "~/org/home.org"
                             "~/org/notes.org"))
(add-to-list 'auto-mode-alist '("\\.po$" . po-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))

;;(require 'js2-mode)
(eval-after-load "js2-mode"
  '(progn
     (setq js2-auto-indent-p t
           js2-use-font-lock-faces t
           js2-bounce-indent-p t
           js2-enter-indents-newline t
           js2-indent-on-enter-key t)
     (add-hook 'js2-mode-hook
               (lambda ()
                 (setq c-basic-offset 2)))))

(eval-after-load "org-latex"
  '(progn
     (unless (boundp 'org-export-latex-classes)
       (setq org-export-latex-classes nil))
     (add-to-list 'org-export-latex-classes
                  '("oreport"
                    "\\documentclass{report}"
                    ("\\chapter{%s}" . "\\chapter*{%s}")
                    ("\\section{%s}" . "\\section*{%s}")
                    ("\\subsection{%s}" . "\\subsection*{%s}")
                    ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))))

;(add-to-list 'auto-mode-alist '("\\.html$" . html-mode))

(add-to-list 'load-path "~/.emacs.d/django-mode/")
;(require 'django-mode)
;(require 'django-html-mode)
(autoload 'django-html-mode "django-html-mode" "Edit Django templates")
(autoload 'django-mode "django-mode" "Edit Django templates")
(yas/load-directory (concat user-emacs-directory "django-mode/snippets/"))
(defun django-unflymake ()
  (setq rng-nxml-auto-validate-flag nil)
  (django-html-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml$" . django-unflymake))
(add-hook 'django-html-mode-hook
          (lambda ()
            (flymake-mode nil)))


(unless (null window-system)
  (server-start)
  ;(set-face-font 'default "-xos4-terminus-medium-r-normal--14-140-*-*-*-*-*-*")
  )
