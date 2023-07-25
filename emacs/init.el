(load-theme 'modus-operandi t)

(setq ring-bell-function 'ignore)
(tool-bar-mode -1)
(set-frame-font "MesloLGS Nerd Font Mono 12" nil t)
(setq vc-follow-symlinks t)
(setq make-backup-files nil)
(setq create-lockfiles nil)
(global-display-line-numbers-mode)
(global-hl-line-mode)
(blink-cursor-mode -1)
(setq frame-title-format "%b - GNU Emacs")
(setq inhibit-startup-screen t)
(setq scroll-step 1
      scroll-conservatively 10000
      scroll-margin 5)
(setq read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t
      completion-ignore-case t)

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(setq use-package-always-ensure t)

(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1)) 

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package vertico
  :bind (:map vertico-map
         ("C-j" . vertico-next)
         ("C-k" . vertico-previous))
  :init
  (vertico-mode)
  (setq vertico-cycle t))

(use-package savehist
  :init
  (savehist-mode))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package magit
  :ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("7887cf8b470098657395502e16809523b629249060d61607c2225d2ef2ad59f5" "cca1d386d4a3f645c2f8c49266e3eb9ee14cf69939141e3deb9dfd50ccaada79" default))
 '(package-selected-packages
   '(evil-collection magit evil-surround vertico evil modus-themes)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'dired-find-alternate-file 'disabled nil)
