(deftheme jdkaplan "jdkaplan's theme")

(let (
      (black "#1e1e1e")
      (lightblack "#262626")
      (darkgray "#3a3a3a")
      (gray "#444444")
      (lightgray "#aaaaaa")
      (lightergray "#c7c7c7")
      (darkwhite "#e4e4e4")
      (white "#eeeeee")

      (red "#ab4642")
      (lightorange "#dc9656")
      (orange "#f67f4e")
      (goldenrod "#ccac62")
      (paleyellow "#f7ca88")
      (yellow "#e0d000")
      (lime "#38ce35")
      (palegreen "#a1d06c")
      (green "#0cc91c")
      (seagreen "#04d4a0")
      (teal "#3ecae0")
      (brightblue "#00c7ff")
      (paleblue "#66C4FF")
      (bluegray "#8bcef0")
      (purple "#b98fff")
      (tan "#d49804")
      (brown "#a87f00")
      (neutralbrown "#c78f6b")
      )

  (send-string-to-terminal "\033]11;black\007")
  (send-string-to-terminal "\033]12;white\007")

  (custom-theme-set-faces
   'jdkaplan
   `(default ((t (:foreground ,darkwhite :background ,lightblack ))))
   `(cursor ((t (:background ,white ))))
   `(fringe ((t (:background ,lightblack ))))
   `(mode-line ((t (:foreground ,white :background ,gray ))))
   `(mode-line-inactive ((t (:foreground ,gray :background ,black ))))
   `(vertical-border ((t (:foreground ,gray :background ,lightblack ))))
   `(region ((t (:background ,darkgray ))))
   `(secondary-selection ((t (:background ,black ))))
   `(font-lock-builtin-face ((t (:foreground ,lightorange ))))
   `(font-lock-comment-face ((t (:foreground ,lightgray ))))
   `(font-lock-function-name-face ((t (:foreground ,paleblue ))))
   `(font-lock-keyword-face ((t (:foreground ,lime ))))
   `(font-lock-string-face ((t (:foreground ,goldenrod ))))
   `(font-lock-type-face ((t (:foreground ,yellow ))))
   `(font-lock-constant-face ((t (:foreground ,purple ))))
   `(font-lock-variable-name-face ((t (:foreground ,paleblue ))))
   `(minibuffer-prompt ((t (:foreground ,lightergray :bold t ))))
   `(font-lock-warning-face ((t (:foreground ,red :bold t ))))
   `(hl-line ((t (:background "black"))))

   `(web-mode-html-attr-name-face ((t (:foreground ,palegreen ))))
   `(web-mode-html-attr-equal-face ((t (:foreground "gray60" ))))
   `(web-mode-html-tag-bracket-face ((t (:foreground "gray60" ))))
   `(web-mode-html-tag-face ((t (:foreground ,bluegray ))))
   `(web-mode-block-delimiter-face ((t (:foreground ,orange ))))

   `(show-paren-match-face ((t (:foreground ,teal :bold t ))))
   )
  )
(provide-theme 'jdkaplan)
