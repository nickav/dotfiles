;;
;; init
;;

;; increase gc limit
(setq gc-cons-threshold 50000000)

;; auto install packages on startup
(add-hook 'after-init-hook (lambda () (package-install-selected-packages)))

;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; No splash screen please ... jeez
(setq inhibit-startup-message t)

;; window
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;;
;; packages
;;

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; built-in config
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(async-bytecomp-package-mode nil)
 '(column-number-mode t)
 '(compilation-message-face (quote default))
 '(custom-enabled-themes (quote (naysayer)))
 '(custom-safe-themes
   (quote
    ("b374cf418400fd9a34775d3ce66db6ee0fb1f9ab8e13682db5c9016146196e9c" "a03b86edca4a901e1576ddef72332d47dccec66dd487bb900a4f85ef5b8c8b68" "248bdfa49a90a83804b3d88f762bf114dd81de37756323fe168529d68a6a62a5" "a2ec1b9fb1001e0ff20cf4d8081d274e9e4ea5d54b41111bc018aab481868fd5" "f8e4c37299ce73336c4bc742b6e21bce0488d4914bf0f39db249d20255f68278" "d2e9c7e31e574bf38f4b0fb927aaff20c1e5f92f72001102758005e53d77b8c9" "10461a3c8ca61c52dfbbdedd974319b7f7fd720b091996481c8fb1dded6c6116" "a3fa4abaf08cc169b61dea8f6df1bbe4123ec1d2afeb01c17e11fdc31fc66379" "8aca557e9a17174d8f847fb02870cb2bb67f3b6e808e46c0e54a44e3e18e1020" "cd736a63aa586be066d5a1f0e51179239fe70e16a9f18991f6f5d99732cabb32" "fe666e5ac37c2dfcf80074e88b9252c71a22b6f5d2f566df9a7aa4f9bea55ef8" "49ec957b508c7d64708b40b0273697a84d3fee4f15dd9fc4a9588016adee3dad" "93a0885d5f46d2aeac12bf6be1754faa7d5e28b27926b8aa812840fe7d0b7983" "75d3dde259ce79660bac8e9e237b55674b910b470f313cdf4b019230d01a982a" "151bde695af0b0e69c3846500f58d9a0ca8cb2d447da68d7fbf4154dcf818ebc" "100e7c5956d7bb3fd0eebff57fde6de8f3b9fafa056a2519f169f85199cc1c96" "f0dc4ddca147f3c7b1c7397141b888562a48d9888f1595d69572db73be99a024" "7e78a1030293619094ea6ae80a7579a562068087080e01c2b8b503b27900165c" "d1b4990bd599f5e2186c3f75769a2c5334063e9e541e37514942c27975700370" "4697a2d4afca3f5ed4fdf5f715e36a6cac5c6154e105f3596b44a4874ae52c45" "6d589ac0e52375d311afaa745205abb6ccb3b21f6ba037104d71111e7e76a3fc" "6b2636879127bf6124ce541b1b2824800afc49c6ccd65439d6eb987dbf200c36" "1c082c9b84449e54af757bcae23617d11f563fc9f33a832a8a2813c4d7dfb652" default)))
 '(display-battery-mode t)
 '(display-line-numbers-type (quote relative))
 '(electric-pair-mode t)
 '(fci-rule-color "#3C3D37")
 '(global-display-line-numbers-mode t)
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-tail-colors
   (quote
    (("#3C3D37" . 0)
     ("#679A01" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#3C3D37" . 100))))
 '(jdee-db-active-breakpoint-face-colors (cons "#1B2229" "#fd971f"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1B2229" "#b6e63e"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1B2229" "#525254"))
 '(linum-format " %5i ")
 '(magit-diff-use-overlays nil)
 '(package-selected-packages
   (quote
    (csharp-mode pdf-tools diminish ranger highlight-numbers naysayer-theme tide slim-mode sass-mode coffee-mode graphql-mode company-flx company ahk-mode typescript-mode exec-path-from-shell dumb-jump package-lint key-chord rainbow-mode rust-mode evil-magit cmake-mode haskell-mode clang-format flx counsel lua-mode eyebrowse which-key ivy markdown-mode multi-compile ag git-link web-mode yasnippet rainbow-delimiters emmet-mode format-all magit use-package powerline projectile git-gutter evil monokai-theme doom-themes ##)))
 '(pos-tip-background-color "#FFFACE")
 '(pos-tip-foreground-color "#1B1D1E")
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#F92672")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#A6E22E")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#A1EFE4")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#66D9EF"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#1B1D1E" "#3C3D37" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(whitespace-tab ((t (:foreground "#636363")))))


;;
;; plugins
;;

;; evil
(use-package evil
  :ensure t
  :init
    (setq evil-want-C-u-scroll t)
    (setq evil-want-C-d-scroll t)

  :config
    (evil-mode 1)

    ;; vim emulation
    (evil-ex-define-cmd "Explore" 'dired)

    ;; leader key
    (define-prefix-command 'leader-map)
    (define-key evil-normal-state-map (kbd "SPC") leader-map)
    (define-key leader-map "b" 'list-buffers)
    (define-key leader-map "q" 'evil-quit)
    (define-key leader-map "l" 'run-current-file)
    (define-key leader-map (kbd "RET") 'run-current-project)
    (define-key leader-map "p" 'run-current-project)
    (define-key leader-map "g" 'magit-status)

    (define-key evil-normal-state-map (kbd "S-s") 'save-buffer)

    ;; keybindings
    (define-key evil-normal-state-map (kbd ";") #'evil-ex)
    (define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
    (define-key evil-normal-state-map (kbd "C-/") 'ag-project)

    ;; splits
    (defun evil-window-vsplit-focus ()
      ;; split vertically and foucs new split
      (interactive)(evil-window-vsplit) (other-window 1))

    (defun evil-window-split-focus ()
      ;; split horizontally and foucs new split
      (interactive)(evil-window-split) (other-window 1))

    (define-key evil-normal-state-map (kbd "C-w \\") 'evil-window-vsplit-focus)
    (define-key evil-normal-state-map (kbd "C-w C-\\") 'evil-window-vsplit-focus)
    (define-key evil-normal-state-map (kbd "C-w -") 'evil-window-split-focus)
    (define-key evil-normal-state-map (kbd "C-w C--") 'evil-window-split-focus)
    (define-key evil-normal-state-map (kbd "C-w <right>") 'evil-window-right)
    (define-key evil-normal-state-map (kbd "<right>") 'evil-window-right)
    (define-key evil-normal-state-map (kbd "C-w <left>") 'evil-window-left)
    (define-key evil-normal-state-map (kbd "<left>") 'evil-window-left)
    (define-key evil-normal-state-map (kbd "C-w <down>") 'evil-window-down)
    (define-key evil-normal-state-map (kbd "C-w <up>") 'evil-window-up)

    ;; toggle comment on current line
    (define-key evil-normal-state-map (kbd "C-;") 'comment-line)

    ;; scrolling
    (define-key evil-normal-state-map (kbd "C-e") (lambda() (interactive) (evil-scroll-line-down 16)))
    (define-key evil-normal-state-map (kbd "C-y") (lambda() (interactive) (evil-scroll-line-up 16)))

    ;; M-x
    (define-key evil-normal-state-map (kbd "C-m") 'execute-extended-command)
    (global-set-key (kbd "C-c") 'keyboard-quit)

    ;; escape key
    (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)

    ;; zoom in and out
    (define-key evil-normal-state-map (kbd "s-=") 'text-scale-increase)
    (define-key evil-normal-state-map (kbd "s--") 'text-scale-decrease)
    (define-key evil-normal-state-map (kbd "s-0") (lambda() (interactive) (text-scale-set 0)))
    (setq text-scale-mode-step 1.2)

    ;; cmd+backspace
    (defun evil-delete-to-first-non-blank ()
      (interactive)
      (evil-delete (point) (save-excursion (evil-first-non-blank) (point)) t))

    (define-key evil-insert-state-map (kbd "s-<backspace>") 'evil-delete-to-first-non-blank)

    (use-package key-chord
      :config
        ;; bind jk to escape
        (key-chord-define evil-insert-state-map  "jk" 'evil-normal-state)
      )
  )

(use-package evil-surround)

;; projectile
(use-package projectile
  :ensure t
  :init
    (setq projectile-project-search-path '("~/dev/" "~/dotfiles/"))
    (setq projectile-completion-system 'ivy)
    (setq projectile-enable-caching 1)
  :config
    (projectile-mode +1)
    (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
    (define-key evil-normal-state-map (kbd "C-p") nil)
    (define-key projectile-mode-map (kbd "C-p") 'projectile-find-file)
    (define-key projectile-mode-map (kbd "C-S-P") 'projectile-find-file-other-window)
    (define-key projectile-mode-map (kbd "<f5>") 'projectile-invalidate-cache)
    (define-key evil-normal-state-map (kbd "C-w C-p") 'projectile-find-file-other-window)

    (defun projectile-find-file-nocache ()
      (interactive)
      (projectile-invalidate-cache nil)
      (projectile-find-file))

    (defun run-current-project ()
      (interactive)
      (projectile-compile-project 'nil))
  )

;; git
(use-package git-gutter
  :ensure t
  :config
    (global-git-gutter-mode +1)
  )

;; format-all
(use-package format-all
  :config
    (define-key evil-normal-state-map (kbd "F") 'format-all-buffer)
    (defvar clang-format-style-option  "google")
  )

;; magit
(use-package magit
  :ensure t
  :config
    (global-set-key (kbd "C-x g") 'magit-status)
    ;; emulate some fugitive shortcuts
    (evil-ex-define-cmd "Gdiff" 'magit-diff-buffer-file)
    (evil-ex-define-cmd "Gstatus" 'magit-status)
    (setq magit-completing-read-function 'ivy-completing-read)
    (use-package evil-magit)
  )

;; company mode
(use-package company
  :ensure t
  :init
    (setq company-require-match 'never)
    (setq company-dabbrev-downcase nil)
    (setq company-dabbrev-ignore-case nil)
    (setq company-idle-delay 0.01)
    (setq company-minimum-prefix-length 2)
    (setq company-ddabbrev-code-everywhere t)
    (setq company-dabbrev-code-modes t)
    (setq company-dabbrev-code-other-buffers 'all)
    (setq company-dabbrev-ignore-buffers "\\`\\'")
    (add-hook 'after-init-hook 'global-company-mode)

    (setq company-frontends
          '(company-pseudo-tooltip-unless-just-one-frontend
            company-preview-frontend
            company-echo-metadata-frontend))
  :config
    (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
    (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)
    (define-key company-active-map (kbd "S-TAB") 'company-select-previous)
    (define-key company-active-map (kbd "<backtab>") 'company-select-previous)

    (defun my-company-visible-and-explicit-action-p ()
      (and (company-tooltip-visible-p)
            (company-explicit-action-p)))

    (defun company-ac-setup ()
      "Sets up `company-mode' to behave similarly to `auto-complete-mode'."
      (setq company-require-match nil)
      (setq company-auto-complete #'my-company-visible-and-explicit-action-p)
      (setq company-frontends '(company-echo-metadata-frontend
                                company-pseudo-tooltip-unless-just-one-frontend-with-delay
                                company-preview-frontend))
      (define-key company-active-map [tab] 'company-select-next-if-tooltip-visible-or-complete-selection)
      (define-key company-active-map (kbd "TAB") 'company-select-next-if-tooltip-visible-or-complete-selection))

    (company-ac-setup)

    (company-flx-mode +1)
    (define-key company-active-map (kbd "C-n") (lambda () (interactive) (company-complete-common-or-cycle 1)))
    (define-key company-active-map (kbd "C-j") (lambda () (interactive) (company-complete-common-or-cycle 1)))
    (define-key company-active-map (kbd "C-p") (lambda () (interactive) (company-complete-common-or-cycle -1)))
    (define-key company-active-map (kbd "C-k") (lambda () (interactive) (company-complete-common-or-cycle -1)))

    (set-face-attribute 'company-preview nil :background (face-attribute 'company-preview-common :background))
  )

;; rainbow delimeters
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; emmet
(use-package emmet-mode
  :init
    (define-key evil-insert-state-map (kbd "C-y") 'emmet-expand-line)
  )

;; ivy
(use-package ivy
  :init
    (setq ivy-use-virtual-buffers t)
    (setq enable-recursive-minibuffers t)
    (setq ivy-re-builders-alist
          '((ivy-switch-buffer . ivy--regex-plus)
            (t . ivy--regex-fuzzy)))
  :config
    (ivy-mode 1)
    (global-set-key (kbd "C-s") 'swiper)
    (global-set-key (kbd "M-x") 'counsel-M-x)
    (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  )

;; which key
(use-package which-key
  :config
    (which-key-mode)
  )

;; eyebrowse
(use-package eyebrowse
  :ensure t
  :init
    (setq eyebrowse-wrap-around t)
    (setq eyebrowse-new-workspace t)
  :config
    (eyebrowse-mode t)
    (eyebrowse-setup-opinionated-keys)

    ;; tmux-esque switching
    (define-key evil-normal-state-map (kbd "tp") 'eyebrowse-prev-window-config)
    (define-key evil-normal-state-map (kbd "tn") 'eyebrowse-next-window-config)
    (define-key evil-normal-state-map (kbd "tq") 'eyebrowse-close-window-config)

    ;; super+number
    (define-key evil-normal-state-map (kbd "s-1") 'eyebrowse-switch-to-window-config-1)
    (define-key evil-normal-state-map (kbd "s-2") 'eyebrowse-switch-to-window-config-2)
    (define-key evil-normal-state-map (kbd "s-3") 'eyebrowse-switch-to-window-config-3)
    (define-key evil-normal-state-map (kbd "s-4") 'eyebrowse-switch-to-window-config-4)
    (define-key evil-normal-state-map (kbd "s-5") 'eyebrowse-switch-to-window-config-5)
    (define-key evil-normal-state-map (kbd "s-6") 'eyebrowse-switch-to-window-config-6)
    (define-key evil-normal-state-map (kbd "s-7") 'eyebrowse-switch-to-window-config-7)
    (define-key evil-normal-state-map (kbd "s-8") 'eyebrowse-switch-to-window-config-8)
    (define-key evil-normal-state-map (kbd "s-9") 'eyebrowse-switch-to-window-config-9)

    ;; ctrl+number
    (define-key evil-normal-state-map (kbd "C-1") 'eyebrowse-switch-to-window-config-1)
    (define-key evil-normal-state-map (kbd "C-2") 'eyebrowse-switch-to-window-config-2)
    (define-key evil-normal-state-map (kbd "C-3") 'eyebrowse-switch-to-window-config-3)
    (define-key evil-normal-state-map (kbd "C-4") 'eyebrowse-switch-to-window-config-4)
    (define-key evil-normal-state-map (kbd "C-5") 'eyebrowse-switch-to-window-config-5)
    (define-key evil-normal-state-map (kbd "C-6") 'eyebrowse-switch-to-window-config-6)
    (define-key evil-normal-state-map (kbd "C-7") 'eyebrowse-switch-to-window-config-7)
    (define-key evil-normal-state-map (kbd "C-8") 'eyebrowse-switch-to-window-config-8)
    (define-key evil-normal-state-map (kbd "C-9") 'eyebrowse-switch-to-window-config-9)
  )

;; snippets
(use-package yasnippet
  :config
    (setq yas-snippet-dirs (append '("~/dotfiles/snippets") yas-snippet-dirs))
    (yas-global-mode 1)
  )

;; dumb-jump
;; jump to definition
(use-package dumb-jump
  :defer t
  :init
    (setq dumb-jump-selector 'ivy)
  :config
    (define-key evil-normal-state-map (kbd "<C-return>") 'dumb-jump-go)
  )

;; multi compile
(use-package multi-compile
  :init
    (setq multi-compile-alist '(
      (rust-mode . (("rust-debug" . "cargo run")))
      (c++-mode . (("cpp-run" . "make --no-print-directory -C %make-dir")))
      (c-mode . (("cpp-run" . "make --no-print-directory -C %make-dir")))
      (makefile-mode . (("make-run" . "make --no-print-directory -C %make-dir")))
      (makefile-bsdmake-mode . (("make-run" . "make --no-print-directory -C %make-dir")))
      (lua-mode . (("lua-run" . "lua %file-name")))
      (haskell-mode . (("haskell-run" . "ghc --make %file-name && ./%file-sans")))
      ("\\.lisp\\'" . (("lisp-script" . "sbcl --script %file-name")))
      ("\\.js\\'" . (("node-run" . "node %file-name")))
      ("\\.mjs\\'" . (("node-harmony-run" . "node --experimental-modules %file-name")))
    ))

  :config
    (defun run-current-file ()
      (interactive)
      (if (derived-mode-p 'emacs-lisp-mode)
        (load-file buffer-file-name)
        (multi-compile-run)))
  )

;; highlight numbers
(add-hook 'prog-mode-hook #'highlight-numbers-mode)

;; ranger
;; file explorer
(use-package ranger
  :init
    (setq ranger-cleanup-on-disable t)
    (setq ranger-show-hidden t)
  :config
    (global-set-key (kbd "s-b") 'ranger)
    (global-set-key (kbd "C-x C-d") 'ranger)
    (define-key leader-map "d" 'ranger)
    (defun explore () (interactive) (ranger))
    (evil-ex-define-cmd "Explore" 'ranger)
  )

;; diminish
(use-package diminish)

;;
;; languages
;;

;; javascript
(setq js2-basic-offset 2)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx$" . js2-jsx-mode))
(add-to-list 'auto-mode-alist '("\\.mjs$" . js2-mode))

;; typescript
(use-package tide
  :init
    (setq js2-basic-offset 2)
    (setq typescript-indent-level 2)
    (setq company-tooltip-align-annotations t)

    (defun setup-tide-mode ()
      "Set up Tide mode."
      (interactive)
      (tide-setup)
      (flycheck-mode +1)
      (setq flycheck-check-syntax-automatically '(save-mode-enabled))
      (eldoc-mode +1)
      (tide-hl-identifier-mode +1)
      (company-mode +1))
  :config
    (add-hook 'typescript-mode-hook #'setup-tide-mode)
    (add-hook 'before-save-hook 'tide-format-before-save)
  )

(use-package typescript-mode
  :no-require t
  :disabled
  :defer t
  :mode ("\\.tsx?$" . typescript-mode)
  :config
    (add-to-list 'auto-mode-alist '("\\.tsx?$" . web-mode))
)

;; html
(use-package web-mode
  :defer t
  :mode
    ("\\.html$" . web-mode)
    ("\\.jsx$" . web-mode)
  :init
    (setq web-mode-code-indent-offset 2)
    (setq web-mode-css-indent-offset 2)
    (setq web-mode-markup-indent-offset 2)
    (setq css-indent-offset 2)
    (setq web-mode-enable-auto-closing t)
    (setq web-mode-enable-auto-quoting nil)
  )

;; rust
(use-package rust-mode
  :no-require t
  :mode ("\\.rs$" . rust-mode)
  :interpreter "rust"
  )

;; lua
(use-package lua-mode
  :mode ("\\.lua$" . lua-mode)
  :interpreter ("lua" . lua-mode)
  :init
    (setq lua-indent-level 2)
  )

;; ember
(use-package slim-mode
  :no-require t
  :defer t
  :mode ("\\.emblem$" . slim-mode)
  )

;; pdf
(use-package pdf-tools
  :pin manual
  :init
    (setq pdf-view-display-size 'fit-page)
    (setq pdf-annot-activate-created-annotations t)
    (setq pdf-view-use-scaling t)
  :config
    (pdf-tools-install)
    (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
  )

;; c++
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;;
;; theme
;;

(use-package naysayer-theme
  :ensure t
  :config
    (load-theme 'naysayer t)
  )

;;
;; system
;;

;; TODO: handle other systems
(setq system-type 'darwin)
(if (eq window-system 'w32)
  (setq system-type 'win32))

;; exec path fix
(if (not (eq system-type 'win32))
  (exec-path-from-shell-initialize))

;;
;; windows setup
;;

(if (eq system-type 'win32)
  (add-to-list 'default-frame-alist '(font . "Meslo LG S-9")))

(setq-default frame-title-format '("%b - Emacs"))

(if (>= emacs-major-version 25)
      (setq w32-pipe-buffer-size (* 64 1024)))

;;
;; config
;;

;; config vars
(setq ring-bell-function 'ignore)
(setq confirm-kill-emacs 'y-or-n-p)

; highlight current line
(global-hl-line-mode +1)

(setq vc-follow-symlinks t)

;; show matching braces
(setq show-paren-delay 0)
(show-paren-mode 1)

;; insert matching braces automatically
(electric-pair-mode 1)
(setq scroll-margin 4)

;; default to vertical splits (when opening mutliple files, e.g.)
(setq split-height-threshold nil)
(setq split-width-threshold 0)

;; add underscore as word delimeter
(add-hook 'prog-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
(setq case-fold-search t) ; case insensitive

;; better lisp indentation
(setq lisp-indent-function 'common-lisp-indent-function)
(setq completions-format 'vertical)

; disable menu bar
(menu-bar-mode -1)

; enable redo
(undo-tree-mode 1)

;; backups
(setq backup-dir (expand-file-name "~/.backups/"))
(setq autosave-dir (expand-file-name "~/.saves/"))

(setq delete-old-versions t)
(setq kept-new-versions 6)
(setq kept-old-versions 2)
(setq version-control t)
(setq vc-make-backup-files t)
(setq backup-directory-alist (list (cons ".*" backup-dir)))
(setq auto-save-list-file-prefix autosave-dir)
(setq auto-save-file-name-transforms `((".*" ,autosave-dir t)))

;; escape key
(define-key key-translation-map (kbd "ESC") (kbd "C-g"))

;; tabs
;; ---
;; Create a variable for our preferred tab width
(setq custom-tab-width 2)

;; Two callable functions for enabling/disabling tabs in Emacs
(defun disable-tabs ()
  (local-set-key (kbd "TAB") 'tab-to-tab-stop)
  (setq indent-tabs-mode nil)
  (setq tab-width custom-tab-width))
(defun enable-tabs  ()
  (local-set-key (kbd "TAB") 'tab-to-tab-stop)
  (setq indent-tabs-mode t)
  (setq tab-width custom-tab-width))

(add-hook 'prog-mode-hook 'disable-tabs)

;; Language-Specific Tweaks
(setq-default python-indent-offset custom-tab-width) ;; Python
(setq-default js-indent-level custom-tab-width)      ;; Javascript

;; Making electric-indent behave sanely
(setq-default electric-indent-inhibit t)

;; Make the backspace properly erase the tab instead of
;; removing 1 space at a time.
(setq-default backward-delete-char-untabify-method 'hungry)
(setq backward-delete-char-untabify-method 'hungry)

;; (OPTIONAL) Shift width for evil-mode users
;; For the vim-like motions of ">>" and "<<".
(setq-default evil-shift-width custom-tab-width)
;; ---

;; indentation
(electric-indent-mode +1)

;; whitespace
(setq-default fill-column 80)
(add-hook 'text-mode-hook 'auto-fill-mode)

(setq-default whitespace-line-column 80)
(setq whitespace-style '(face empty tabs tab-mark trailing))
;; (OPTIONAL) Visualize tabs as a pipe character - "|"
(setq whitespace-display-mappings
  '((tab-mark 9 [124 9] [92 9]))) ; 124 is the ascii ID for '\|'
(global-whitespace-mode t)

;; make links clickable
(goto-address-mode t)

;; make comiplation mode use terminal colors
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region compilation-filter-start (point))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

;; revert files when they change on disk
(global-auto-revert-mode t)

;; webjump shortcut
(global-set-key (kbd "C-x w") 'webjump)

;; add stack overflow to webjump
(eval-after-load "webjump"
  '(add-to-list 'webjump-sites
                '("Stack Overflow" .
                  [simple-query
                  "www.stackoverflow.com"
                   "https://stackoverflow.com/search?q="
                  ""])))

;; Save point position between sessions
(use-package saveplace
  :init (save-place-mode))

;; exit shell with C-d
(defun comint-delchar-or-eof-or-kill-buffer (arg)
  (interactive "p")
  (if (null (get-buffer-process (current-buffer)))
      (kill-buffer)
    (comint-delchar-or-maybe-eof arg)))

(add-hook 'shell-mode-hook
  (lambda ()
    (define-key shell-mode-map
      (kbd "C-d") 'comint-delchar-or-eof-or-kill-buffer)))

;;
;; functions
;;

;; shortcut to edit emacs config
(defun edit-emacs-config ()
  (interactive)
  (find-file "~/.emacs"))

(defun rename-current-buffer-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (if (get-buffer new-name)
            (error "A buffer named '%s' already exists!" new-name)
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil)
          (message "File '%s' successfully renamed to '%s'"
                   name (file-name-nondirectory new-name)))))))

(global-set-key (kbd "C-x C-r") 'rename-current-buffer-file)

(defun delete-current-buffer-file ()
  "Removes file connected to current buffer and kills buffer."
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (ido-kill-buffer)
      (when (yes-or-no-p "Are you sure you want to remove this file? ")
        (delete-file filename)
        (kill-buffer buffer)
        (message "File '%s' successfully removed" filename)))))

(global-set-key (kbd "C-x C-k") 'delete-current-buffer-file)

(defun toggle-term ()
  "Opens and closes a terminal in a buffer."
  (interactive)
  (if (get-buffer "*terminal*")
      (kill-buffer "*terminal*")
    (progn (split-window-below)
      (other-window 1)
      (enlarge-window -18)
      (term "/bin/zsh")
      (set-window-dedicated-p (selected-window) t))))

(defun kill-all-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer
    (delq (current-buffer)
      (remove-if-not 'buffer-file-name (buffer-list)))))

(defun switch-to-scratch-buffer ()
  "Opens the scratch buffer."
  (interactive)
  (switch-to-buffer (get-buffer-create "*scratch*")))

;;
;; inline plugins
;;

;;; livedown.el --- Realtime Markdown previews for Emacs.

;; Copyright (C) 2014-2016 Hrvoje Simic

;; Author: Hrvoje Simic <hrvoje@twobucks.co>
;; Version: 1.0.0
;; Keywords: markdown, preview, live
;; URL: https://github.com/shime/emacs-livedown

;;; Commentary:

;; Realtime Markdown previews for Emacs.

;;; Code:

(defgroup livedown nil "Realtime Markdown previews" :group 'livedown :prefix "livedown-")
(defcustom livedown-port 1337 "Port on which livedown server will run." :type 'integer :group 'livedown)
(defcustom livedown-open t "Open browser automatically." :type 'boolean :group 'livedown)
(defcustom livedown-browser nil "Open alternative browser." :type 'string :group 'livedown)
(defcustom livedown-autostart nil "Auto-open previews when opening markdown files." :type 'boolean :group 'livedown)

;;;###autoload
(defun livedown-preview ()
  "Preview the current file in livedown."
  (interactive)

  (call-process-shell-command
   (format "livedown stop --port %s &"
           livedown-port))

  (start-process-shell-command
   (format "emacs-livedown")
   (format "emacs-livedown-buffer")
   (format "livedown start %s --port %s %s %s "
           buffer-file-name
           livedown-port
           (if livedown-browser (concat "--browser " livedown-browser) "")
           (if livedown-open "--open" "")))
  (print (format "%s rendered @ %s" buffer-file-name livedown-port) (get-buffer "emacs-livedown-buffer")))

;;;###autoload
(defun livedown-kill (&optional async)
  "Stops the livedown process."
  (interactive)
  (let ((stop-livedown (if async 'async-shell-command 'call-process-shell-command)))
    (funcall stop-livedown
             (format "livedown stop --port %s &"
                     livedown-port))))

(if livedown-autostart
    (eval-after-load 'markdown-mode '(livedown-preview)))

(add-hook 'kill-emacs-query-functions (lambda () (livedown-kill t)))

(provide 'livedown)
;;; livedown.el ends here
