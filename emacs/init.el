(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(electric-pair-mode t)
 '(evil-respect-visual-line-mode t)
 '(fill-column 80)
 '(global-hl-line-mode t)
 '(global-prettify-symbols-mode t)
 '(global-subword-mode nil)
 '(global-visual-line-mode t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-buffer-menu t)
 '(inhibit-startup-screen t)
 '(initial-scratch-message "")
 '(js2-highlight-level 1)
 '(menu-bar-mode nil)
 '(mouse-wheel-mode nil)
 '(nlinum-format "%d ")
 '(org-adapt-indentation nil)
 '(org-cycle-level-faces nil)
 '(org-n-level-faces 3)
 '(package-selected-packages
   (quote
    (evil evil-leader evil-org evil-surround go-mode lua-mode markdown-mode nlinum org scala-mode web-mode)))
 '(require-final-newline t)
 '(scheme-program-name "racket")
 '(show-paren-delay 0)
 '(show-paren-mode 1)
 '(tab-width 4)
 '(tool-bar-mode t)
 '(vc-follow-symlinks nil)
 '(visible-cursor nil)
 '(web-mode-code-indent-offset 4)
 '(web-mode-css-indent-offset 4)
 '(web-mode-enable-auto-expanding nil)
 '(web-mode-enable-auto-pairing t)
 '(web-mode-enable-css-colorization nil)
 '(web-mode-markup-indent-offset 4)
 '(web-mode-script-padding 0)
 '(web-mode-style-padding 0))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'evil)
(evil-mode 1)

(require 'evil-surround)
(global-evil-surround-mode 1)

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

(require 'ido)
(ido-mode t)

;; remove line wrap character
(set-display-table-slot standard-display-table 'wrap ?\ )

(put 'narrow-to-region 'disabled nil)

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

(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(add-hook 'prog-mode-hook 'nlinum-mode)

;; delete trailing whitespace on save
(add-hook 'prog-mode-hook (lambda () (add-to-list 'write-file-functions 'delete-trailing-whitespace)))

(require 'scala-mode)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))

(setq web-mode-content-types-alist '())
(add-to-list 'web-mode-content-types-alist '("jsx" . "\\.jsx?\\'"))

(add-hook 'web-mode-hook
          (lambda ()
            (define-key web-mode-map (kbd "C-c /") 'web-mode-element-close)))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'jdkaplan t)

(add-to-list 'auto-mode-alist '("/tmp/mutt.*" . mail-mode))

(add-hook 'markdown-mode-hook 'turn-on-auto-fill)
(add-hook 'tex-mode-hook 'turn-on-auto-fill)

(require 'go-mode)
(add-hook 'go-mode-hook
          (lambda ()
            (define-key go-mode-map (kbd "C-c C-f j") 'godef-jump)
            (define-key go-mode-map (kbd "C-c C-f k") 'godef-jump-other-window)
            (add-hook 'before-save-hook #'gofmt-before-save)))

(add-hook 'python-mode-hook
          (lambda ()
            (setq prettify-symbols-alist '(("lambda" . ?λ)))))

(add-hook 'prog-mode-hook
          (lambda ()
            (font-lock-add-keywords nil
                                    '(("\\(FIXME\\|TODO\\|BUG\\|\\?\\?\\):" 0 font-lock-warning-face t)))))

(require 'org-install)
(require 'evil-org)
(add-hook 'org-mode-hook 'evil-org-mode)
(evil-org-set-key-theme '(navigation insert textobjects additional))
(setq org-startup-folded "showeverything")

(setq org-todo-keywords
      '((sequence "NEW(n)" "QUALIFIED(q)" "STARTED(s)" "BLOCKED(b)" "|" "DONE(d)")
        (sequence "TODO(t)" "|" "DONE(d)")))

(setq org-todo-keyword-faces
      '(("NEW" . "white")
        ("TODO" . "gray")
        ("QUALIFIED" . "lightblue")
        ("STARTED" . "orange" )
        ("BLOCKED" . "red")
        ("DONE" . "green")))

(evil-define-key '(normal visual) evil-org-mode-map (kbd "TAB") 'org-cycle)
