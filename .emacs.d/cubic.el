(require 'cl)

;; No backup files, they clutter so much
(setq make-backup-files nil)

;; Delete all trailing whitespace, and no newline at EOF
(setq require-final-newline t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Wrap to 80 chars
(setq-default fill-column 80)

;; soft wrap in windows
(setq truncate-partial-width-windows nil)

;; Slit sanely
(setq split-height-threshold 30)

;; Sane mumamo
(setq mumamo-chunk-coloring 20)

;; We like english
(setq ispell-dictionary "english")

;; Some keymap settings I like
(global-set-key "\C-w" 'backward-kill-word)
(define-key global-map "\C-j" 'join-line)
(global-set-key (kbd "C-<tab>") 'hippie-expand)

;; Utility function, like 'f' in vim
(defun go-to-char (arg char)
  (interactive "p\ncGo to char: ")
  (with-no-warnings
    (if (char-table-p translation-table-for-input)
        (setq char (or (aref translation-table-for-input char) char))))
  (search-forward (char-to-string char) nil nil arg)
  (backward-char))

;; Mode mappings
(add-to-list 'auto-mode-alist '("\\.po$" . po-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))

;;; Mode Specific things

;; LaTeX mode.

;; Load and start auctex, default to PDF mode, and hook in reftex. In addition,
;; set up folding mode for auctex and have it fold the file on save, to get a
;; semi-preview style to it, and hide a lot of the "ugly" latex syntax.
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

;; Python Mode

;; Allow flymake to use PyFlakes, gives syntax checking and finds "bad code
;; smell"  such as unused variables and imports.
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

;; We want auto indentation and filling, and enabling flymake
(eval-after-load "python"
  '(progn
     (add-hook 'python-mode-hook 'auto-indent-hook)
     (add-hook 'python-mode-hook 'auto-fill-mode)
     (add-hook 'python-mode-hook 'flymake-mode)))


;; Org-mode

;; Agenda files
(setq org-agenda-files (list "~/org/work.org"
                             "~/org/home.org"
                             "~/org/notes.org"))
;; Latex export options
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


;; Javascript (js2-mode)

;; Indentation options
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


;; Django mode

(add-to-list 'load-path "~/.emacs.d/django-mode/")
(autoload 'django-html-mode "django-html-mode" "Edit Django templates")
(autoload 'django-mode "django-mode" "Edit Django templates")
(yas/load-directory (concat user-emacs-directory "django-mode/snippets/"))

;; Some hairy stuff to turn off nxml validation on Django files.
(defun django-novalidate ()
  (setq rng-nxml-auto-validate-flag nil)
  (django-html-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml$" . django-novalidate))
(add-hook 'django-html-mode-hook
          (lambda ()
            (flymake-mode nil)))


;;; Server autostart, and font setting (if wanted)
(unless (null window-system)
  (server-start)
  ;(set-face-font 'default "-xos4-terminus-medium-r-normal--14-140-*-*-*-*-*-*")
  )
