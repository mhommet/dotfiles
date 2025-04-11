;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Theme and font
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 14))
(setq doom-theme 'catppuccin)

;; Disable line numbers for performance
(setq display-line-numbers-type nil)

;; Prevents some cases of Emacs flickering.
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

;; Minimalistic startup
(setq fancy-splash-image (file-name-concat doom-user-dir "splash.png"))
(setq +doom-dashboard-functions '(doom-dashboard-widget-banner))

;; Disable long line warnings in magit
(setq magit-show-long-lines-warning nil)

;; An evil mode indicator is redundant with cursor shape
(setq doom-modeline-modal nil
      doom-modeline-check-simple-format t)
