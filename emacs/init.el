(require 'package)
(push '("melpa" . "http://melpa.milkbox.net/packages/")
      package-archives)
(package-initialize)

(require 'cl)

(defvar my-packages
  '(
    autopair
    evil
    evil-leader
    evil-surround
    goto-chg
    haskell-mode
    js2-mode
    markdown-mode
    php-mode
    scala-mode
    typescript-mode
    undo-tree
    web-mode
    yaml-mode
    )
  "A list of packages to ensure are installed at launch.")

(defun my-packages-installed-p ()
  (loop for p in my-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

(unless (my-packages-installed-p)
  ;; check for new packages (package versions)
  (package-refresh-contents)
  ;; install the missing packages
  (dolist (p my-packages)
    (when (not (package-installed-p p))
            (package-install p))))

(require 'evil-leader)
(global-evil-leader-mode)

(evil-leader/set-leader ";")
(evil-leader/set-key
  "<SPC>" 'evil-ex

  "e" 'find-file
  "f" 'find-file
  "b" 'switch-to-buffer
  "w" 'save-buffer
  "q" 'kill-this-buffer
  "x" 'kill-buffer-and-window

  "\"" 'split-window-below
  "%" 'split-window-right
  "0" 'delete-window

  "h" 'evil-window-left
  "j" 'evil-window-down
  "k" 'evil-window-up
  "l" 'evil-window-right
 )

(require 'evil)
(evil-mode 1)

(require 'evil-surround)
(global-evil-surround-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("ce08249e5bb367822a811e84a7a9cc44c4228605ab7cbbb6896039529720809a" "2b280ad6cde9097a8677663009decae239a35d70a180d2321baf9e467696f6c8" default)))
 '(global-subword-mode t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-buffer-menu t)
 '(inhibit-startup-screen t)
 '(initial-scratch-message "")
 '(menu-bar-mode nil)
 '(mouse-wheel-mode nil)
 '(package-selected-packages
   (quote
    (yaml-mode web-mode typescript-mode scala-mode php-mode markdown-mode js2-mode haskell-mode evil-surround evil-leader evil autopair)))
 '(require-final-newline t)
 '(scheme-program-name "racket")
 '(show-paren-delay 0)
 '(show-paren-mode 1)
 '(tab-width 4)
 '(tool-bar-mode t)
 '(vc-follow-symlinks nil)
 '(visible-cursor nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'autopair)
(autopair-global-mode)

(require 'ido)
(ido-mode t)

;; remove line wrap character
(set-display-table-slot standard-display-table 'wrap ?\ )

;; longlines mode everywhere
(global-visual-line-mode t)

;; show line/column numbers
(setq line-number-mode t)
(setq column-number-mode t)

;; prettify symbols
(global-prettify-symbols-mode 1)

(put 'narrow-to-region 'disabled nil)
(global-hl-line-mode 1)

;; comment current line
;; Original idea from
;; http://www.opensubscriber.com/message/emacs-devel@gnu.org/10971693.html
(defun comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
        If no region is selected and current line is not blank and we are not at the end of the line,
        then comment current line.
        Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
(global-set-key "\M-;" 'comment-dwim-line)

;; python3
(add-to-list 'auto-mode-alist '("\\.py3\\'" . python-mode))

;; Missing things from scheme IDE
(defun scheme-send-buffer ()
  (interactive)
  (let ((oldbuf (current-buffer)))
    (run-scheme scheme-program-name)
    (switch-to-buffer oldbuf)
    (scheme-send-region (point-min) (point-max))))

(defun scheme-send-buffer-and-go ()
  (interactive)
  (let ((oldbuf (current-buffer)))
    (if (= (length (window-list)) 1)
        (split-window-right))
    (other-window 1)
    (run-scheme scheme-program-name)
    (other-window -1))
  (scheme-send-region (point-min) (point-max)))

(eval-after-load 'scheme
  '(define-key scheme-mode-map (kbd "C-c C-s") 'scheme-send-buffer))

(require 'php-mode)

(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; linum-mode
(add-hook 'prog-mode-hook (lambda () (linum-mode 1)))
(unless window-system
  (add-hook 'linum-before-numbering-hook
            (lambda ()
              (setq-local linum-format-fmt
                          (let ((w (length (number-to-string
                                            (count-lines (point-min) (point-max))))))
                            (concat "%" (number-to-string w) "d"))))))

(defun linum-format-func (line)
  (concat
   (propertize (format linum-format-fmt line) 'face 'linum)
   (propertize " " 'face 'linum)))

(unless window-system
  (setq linum-format 'linum-format-func))

;; delete trailing whitespace on save
(add-hook 'prog-mode-hook (lambda () (add-to-list 'write-file-functions 'delete-trailing-whitespace)))

;; found at https://gist.github.com/NFicano/1356280
;; modified for 24.3

(defadvice python-indent-calculate-indentation (around fix-list-indentation)
  "Fix indentation in continuation lines within lists"
  (unless (save-excursion
            (beginning-of-line)
            (when (python-info-continuation-line-p)
              (let* ((syntax (syntax-ppss))
                     (open-start (cadr syntax))
                     (point (point)))
                (when open-start
                  ;; Inside bracketed expression.
                  (goto-char (1+ open-start))
                  ;; Indent relative to statement start, one
                  ;; level per bracketing level.
                  (goto-char (1+ open-start))
                  (python-nav-beginning-of-statement)
                  (setq ad-return-value (+ (current-indentation) (* (car syntax) python-indent)))))))
    ad-do-it))

(defadvice python-indent-calculate-indentation (around outdent-closing-brackets)
 "Handle lines beginning with a closing bracket and indent them so that
they line up with the line containing the corresponding opening bracket."
  (save-excursion
    (beginning-of-line)
    (let ((syntax (syntax-ppss)))
      (if (and (not (eq 'string (syntax-ppss-context syntax)))
               (python-info-continuation-line-p)
               (cadr syntax)
               (skip-syntax-forward "-")
               (looking-at "\\s)"))
          (progn
            (forward-char 1)
            (ignore-errors (backward-sexp))
            (setq ad-return-value (current-indentation)))
        ad-do-it))))


;; Activate Python ident advice
(ad-activate 'python-indent-calculate-indentation)

(require 'scala-mode)

(require 'haskell-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))

(setq web-mode-content-types-alist
      '(("jsx" . "\\.jsx?\\'")))

(add-hook 'web-mode-hook
          (lambda ()
            (setq web-mode-markup-indent-offset 2)
            (setq web-mode-css-indent-offset 2)
            (setq web-mode-code-indent-offset 4)
            (setq web-mode-enable-auto-pairing t)
            (setq web-mode-enable-auto-expanding t)

            (setq web-mode-enable-html-colorization t)
            (setq web-mode-enable-css-colorization t)

            (define-key web-mode-map (kbd "C-c /") 'web-mode-element-close)))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'jdkaplan t)
;; (load-theme 'jdkaplan-light t)

(require 'js2-mode)

(add-to-list 'auto-mode-alist '("/tmp/mutt.*" . mail-mode))
