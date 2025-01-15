;;; ~/.config/doom/config.el -*- lexical-binding: t; -*-
(setq user-full-name "Milan Hommet"
      user-mail-address "milan.hommet@protonmail.com")

(add-to-list 'custom-theme-load-path "~/dotfiles/doom/themes/atom-one-dark-theme/")

(setq doom-theme 'doom-rose-pine
      doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 15))

;; Set a default indentation level
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; An evil mode indicator is redundant with cursor shape
(setq doom-modeline-modal nil)

;; UI
(setq fancy-splash-image (file-name-concat doom-user-dir "splash.png"))
;; Hide the menu for as minimalistic a startup screen as possible.
(setq +doom-dashboard-functions '(doom-dashboard-widget-banner))

;; Open dashboard
(map! :leader
      :desc "Open dashboard"
      "d b" #'+doom-dashboard/open)

;; Focus new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t)

;; ORG MODE
(use-package org
  :defer t
  :config
  (setq org-directory "~/Documents/")
  (add-hook 'org-mode-hook 'org-make-toc-mode)
  (setq org-hide-emphasis-markers t)
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
  (use-package org-modern
    :config
    (setq org-modern-label-border nil)
    (global-org-modern-mode)))

;; OPTIMIZATIONS
;; Increase the garbage collection threshold to 100MB
(setq gc-cons-threshold (* 100 1024 1024)) ;; Default is 800KB
;; Prevents some cases of Emacs flickering.
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))
;; Set a higher delay for idle updates (default is 0.5)
(setq idle-update-delay 1.0)

