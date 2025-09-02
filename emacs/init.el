(load-theme 'catppuccin :no-confirm)
(setq catppuccin-flavor 'macchiato)
(catppuccin-reload)

(setq ring-bell-function 'ignore)
(tool-bar-mode -1)
(menu-bar-mode -1)

(add-hook 'server-after-make-frame-hook
  (lambda ()				
    (scroll-bar-mode -1)))

(doom-modeline-mode 1)
(setq doom-modeline-icon t)

(vertico-mode)
(setq vertico-cycle t)

(setq default-frame-alist '((font . "JetBrains Mono NL-12")))

(setq vc-follow-symlinks t)
(setq make-backup-files nil)
(global-display-line-numbers-mode)
(global-hl-line-mode)
(blink-cursor-mode -1)
(setq inhibit-startup-screen t)

(setq-default tab-width 2)
