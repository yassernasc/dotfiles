;; package management stuff
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; themes
(use-package spacemacs-theme
  :defer t
  :init
  (add-hook 'ns-system-appearance-change-functions ; load theme based on OS appearence mode
    #'(lambda (appearance)
      (pcase appearance
        ('light (load-theme 'spacemacs-light t))
        ('dark (load-theme 'spacemacs-dark t))))))

;; typography
(set-frame-font "mononoki 13" nil t)
(setq-default line-spacing 2)

;; cursor
(setq-default cursor-type 'bar)
(global-hl-line-mode t)

;; enable ide-like features
(use-package eglot
  :hook
  (js-ts-mode . eglot-ensure)
  (typescript-ts-mode . eglot-ensure)
  (json-ts-mode . eglot-ensure)
  (go-ts-mode . eglot-ensure))

;; ensure tree-sitter mode based on file extension
(add-to-list 'auto-mode-alist '("\\.js\\'" . js-ts-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-ts-mode))

;; version control
(use-package magit)

;; code formatting
(use-package apheleia
  :init (apheleia-global-mode +1))

;; autocompletion menu
(use-package corfu
  :custom (corfu-auto t)
  :init (global-corfu-mode))

;; overwrite defaults
(use-package dired
  :ensure nil
  :config
  (setq dired-recursive-deletes 'always) ; minimize confirmations because laziness
  (setq dired-deletion-confirmer '(lambda (x) t))
  (setq dired-recursive-copies 'always)
  (add-hook 'dired-mode-hook (lambda () (dired-hide-details-mode 1)))) ; simplify dired view

;; remove initial page
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)

;; clean screen
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; just behave like a normal editor please
(delete-selection-mode 1)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq load-prefer-newer t) ; automatically update buffer content
(setq ring-bell-function 'ignore) ; quiet

;; use ⌘ as meta
(setq mac-command-modifier 'meta)

;; safely remove files
(setq delete-by-moving-to-trash t)
(setq trash-directory "~/.Trash") ; warn: probably macos only

;; y/n for  answering yes/no questions
(fset 'yes-or-no-p 'y-or-n-p)

;; more flexible completion instead just initial match
(setq completion-styles '(basic substring))
