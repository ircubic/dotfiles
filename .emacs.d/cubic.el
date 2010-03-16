(global-set-key "\C-w" 'backward-kill-word)
(setq make-backup-files nil)
(setq truncate-partial-width-windows nil)
(setq split-height-threshold 30)
(define-key global-map "\C-j" 'join-line)

(global-set-key (kbd "C-<tab>") 'hippie-expand)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq require-final-newline t)



; Allow flymake to use PyFlakes
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "pyflakes" (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init)))
(add-hook 'python-mode-hook 'flymake-mode)

(defun auto-indent-hook ()
  (local-set-key (kbd "RET") 'newline-and-indent))
(add-hook 'python-mode-hook 'auto-indent-hook)
(add-hook 'python-mode-hook 'auto-fill-mode)


(setq mumamo-chunk-coloring 20)
(setq ispell-dictionary "english")
(setq-default fill-column 80)
(setq org-agenda-files (list "~/org/work.org"
                             "~/org/home.org"
                             "~/org/notes.org"))
(add-to-list 'auto-mode-alist '("\\.po$" . po-mode))

;;(require 'js2-mode)
(setq js2-auto-indent-p t
      js2-use-font-lock-faces t
      js2-bounce-indent-p t
      js2-enter-indents-newline t
      js2-indent-on-enter-key t)
(add-hook 'js2-mode-hook
          (lambda ()
            (setq c-basic-offset 2)))

(unless (null window-system)
  (server-start)
  (set-face-font 'default "-xos4-terminus-medium-r-normal--14-140-*-*-*-*-*-*"))
