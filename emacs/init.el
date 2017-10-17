(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

(require 'evil-leader)
(global-evil-leader-mode)

(evil-leader/set-leader ";")
(evil-leader/set-key
  "<SPC>" 'evil-ex

  "e" 'find-file
  "f" 'helm-for-files
  "p" 'helm-projectile-find-file
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
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("ce08249e5bb367822a811e84a7a9cc44c4228605ab7cbbb6896039529720809a" "2b280ad6cde9097a8677663009decae239a35d70a180d2321baf9e467696f6c8" default)))
 '(fill-column 80)
 '(global-hl-line-mode t)
 '(global-prettify-symbols-mode t)
 '(global-subword-mode t)
 '(global-visual-line-mode t)
 '(helm-split-window-in-side-p t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-buffer-menu t)
 '(inhibit-startup-screen t)
 '(initial-scratch-message "")
 '(js2-highlight-level 1)
 '(menu-bar-mode nil)
 '(mouse-wheel-mode nil)
 '(nlinum-format "%d ")
 '(package-selected-packages
   (quote
    (go-mode helm-projectile helm nlinum coffee-mode yaml-mode web-mode typescript-mode scala-mode php-mode markdown-mode js2-mode haskell-mode evil-surround evil-leader evil autopair)))
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

(require 'autopair)
(autopair-global-mode)

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

;; tako
(add-to-list 'auto-mode-alist '("\\.tako\\'" . python-mode))

(require 'php-mode)

(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(add-hook 'prog-mode-hook 'nlinum-mode)

;; delete trailing whitespace on save
(add-hook 'prog-mode-hook (lambda () (add-to-list 'write-file-functions 'delete-trailing-whitespace)))

(require 'scala-mode)

(require 'haskell-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

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
;; (load-theme 'jdkaplan-light t)

(require 'js2-mode)
;; (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(add-to-list 'auto-mode-alist '("/tmp/mutt.*" . mail-mode))

(add-hook 'markdown-mode-hook 'turn-on-auto-fill)
(add-hook 'tex-mode-hook 'turn-on-auto-fill)

(require 'go-mode)

(projectile-global-mode)
(setq projectile-completion-system 'helm)
(setq projectile-enable-caching t)

(require 'helm-config)
(helm-mode 1)
(helm-projectile-on)

(add-hook 'python-mode-hook
          (lambda ()
            (setq prettify-symbols-alist '(("lambda" . ?λ)))))

(add-hook 'prog-mode-hook
          (lambda ()
            (font-lock-add-keywords nil
                                    '(("\\(FIXME\\|TODO\\|BUG\\|QQ\\):" 0 font-lock-warning-face t)))))
