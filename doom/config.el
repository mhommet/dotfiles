;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Theme and font
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 14))
(setq doom-theme 'catppuccin)

;; Transparency
(set-frame-parameter (selected-frame) 'alpha '(90 . 90))
(add-to-list 'default-frame-alist '(alpha . (90 . 90)))

;; Remove window decorations
(add-to-list 'default-frame-alist '(undecorated . t))

;; Disable line numbers for performance
(setq display-line-numbers-type nil)

;; Prevents some cases of Emacs flickering.
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

;; Minimalistic startup
(setq fancy-splash-image (file-name-concat doom-user-dir "splash.png"))
(setq +doom-dashboard-functions '(doom-dashboard-widget-banner))

;; An evil mode indicator is redundant with cursor shape
(setq doom-modeline-modal nil
      doom-modeline-check-simple-format t)
