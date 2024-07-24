;; clean screen
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; remove initial page
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)

;; less cowbell
(setq ring-bell-function 'ignore)

;; y/n for  answering yes/no questions
(fset 'yes-or-no-p 'y-or-n-p)

;; automatically update buffer content
(setq load-prefer-newer t)

;; substitute marked region when start typing
(delete-selection-mode 1)

;; space instead tabs
(set-default 'indent-tabs-mode nil)

;; use ⌘ as meta
(setq mac-command-modifier 'meta)

;; safely remove files
(setq delete-by-moving-to-trash t)
(setq trash-directory "~/.Trash") ; warn: probably macos only

;; clean files on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; typography
(set-frame-font "mononoki 13" nil t)
(setq-default line-spacing 2)

;; cursor
(setq-default cursor-type 'bar)
(global-hl-line-mode t)

;; package management
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; use-package auto install packages
(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; clean dired
(use-package dired
  :ensure nil
  :config
  (setq dired-recursive-deletes 'always)
  (setq dired-deletion-confirmer '(lambda (x) t))
  (setq dired-recursive-copies 'always)
  (add-hook 'dired-mode-hook (lambda () (dired-hide-details-mode 1))))

;; fix path
(use-package exec-path-from-shell
  :if
  (memq window-system '(mac ns))
  :config
  (exec-path-from-shell-initialize))

;; theme
(use-package spacemacs-theme
  :defer t
  :init
  (add-hook 'ns-system-appearance-change-functions
	    #'(lambda (appearance)
		(pcase appearance
		  ('light (load-theme 'spacemacs-light t))
		  ('dark (load-theme 'spacemacs-dark t))))))

;; version control
(use-package magit)

;; code format
(use-package apheleia
  :init (apheleia-global-mode +1))

;; minibuffer enhancement
(use-package vertico
  :init (vertico-mode))

(use-package marginalia
  :init (marginalia-mode))

;; autocompletion menu
(use-package corfu
  :custom
  (corfu-auto t)
  :init
  (global-corfu-mode))

;; improve sorting and filtering
(use-package prescient
  :config
  (push 'prescient completion-styles)
  (prescient-persist-mode))

(use-package vertico-prescient
  :after prescient vertico
  :config
  (vertico-prescient-mode))

(use-package corfu-prescient
  :after prescient corfu
  :config
  (corfu-prescient-mode))

;; find things
(use-package consult
  :bind
  (("C-c s" . consult-ripgrep)
   ("C-c f" . consult-find)
   ("C-c l" . consult-line))
  :custom
  ((consult-find-args "find . -not ( -wholename */.* -prune -o -name node_modules -prune )")))

;; enable ide-like features
(use-package eglot
  :ensure nil
  :hook
  ((css-ts-mode go-ts-mode js-ts-mode json-ts-mode tsx-ts-mode typescript-ts-mode) . eglot-ensure))

;; ensure tree-sitter
(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

;; config langs
(use-package js
  :ensure nil
  :custom
  (js-indent-level 2))
