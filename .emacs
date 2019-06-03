;; packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; config
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
 '(custom-enabled-themes (quote (tsdh-dark)))
 '(custom-safe-themes
   (quote
    ("f8e4c37299ce73336c4bc742b6e21bce0488d4914bf0f39db249d20255f68278" "d2e9c7e31e574bf38f4b0fb927aaff20c1e5f92f72001102758005e53d77b8c9" "10461a3c8ca61c52dfbbdedd974319b7f7fd720b091996481c8fb1dded6c6116" "a3fa4abaf08cc169b61dea8f6df1bbe4123ec1d2afeb01c17e11fdc31fc66379" "8aca557e9a17174d8f847fb02870cb2bb67f3b6e808e46c0e54a44e3e18e1020" "cd736a63aa586be066d5a1f0e51179239fe70e16a9f18991f6f5d99732cabb32" "fe666e5ac37c2dfcf80074e88b9252c71a22b6f5d2f566df9a7aa4f9bea55ef8" "49ec957b508c7d64708b40b0273697a84d3fee4f15dd9fc4a9588016adee3dad" "93a0885d5f46d2aeac12bf6be1754faa7d5e28b27926b8aa812840fe7d0b7983" "75d3dde259ce79660bac8e9e237b55674b910b470f313cdf4b019230d01a982a" "151bde695af0b0e69c3846500f58d9a0ca8cb2d447da68d7fbf4154dcf818ebc" "100e7c5956d7bb3fd0eebff57fde6de8f3b9fafa056a2519f169f85199cc1c96" "f0dc4ddca147f3c7b1c7397141b888562a48d9888f1595d69572db73be99a024" "7e78a1030293619094ea6ae80a7579a562068087080e01c2b8b503b27900165c" "d1b4990bd599f5e2186c3f75769a2c5334063e9e541e37514942c27975700370" "4697a2d4afca3f5ed4fdf5f715e36a6cac5c6154e105f3596b44a4874ae52c45" "6d589ac0e52375d311afaa745205abb6ccb3b21f6ba037104d71111e7e76a3fc" "6b2636879127bf6124ce541b1b2824800afc49c6ccd65439d6eb987dbf200c36" "1c082c9b84449e54af757bcae23617d11f563fc9f33a832a8a2813c4d7dfb652" default)))
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
 '(magit-diff-use-overlays nil)
 '(package-selected-packages
   (quote
    (key-chord rainbow-mode rust-mode evil-magit cmake-mode haskell-mode clang-format flx counsel lua-mode eyebrowse which-key ivy markdown-mode multi-compile ag git-link prettier-js web-mode yasnippet rainbow-delimiters auto-complete emmet-mode format-all magit use-package powerline projectile git-gutter evil monokai-theme doom-themes ##)))
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

;; window
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;;
;; plugins
;;

;; evil
(setq evil-want-C-u-scroll t)
(setq evil-want-C-d-scroll t)
(evil-mode 1)

;; theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(setq monokai-background "#1B1D1E" monokai-highlight-line "#293739")
;(load-theme 'monokai t)
(load-theme 'naysayer t)

;; projectile
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
;(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(define-key evil-normal-state-map (kbd "C-p") nil)
(define-key projectile-mode-map (kbd "C-S-p") 'projectile-find-file-other-window)
(define-key projectile-mode-map (kbd "C-p") 'projectile-find-file)
(define-key projectile-mode-map (kbd "<f5>") 'projectile-invalidate-cache)
(define-key evil-normal-state-map (kbd "C-w C-p") 'projectile-find-file-other-window)
(setq projectile-project-search-path '("~/dev/" "~/dotfiles/"))
(setq projectile-completion-system 'ivy)
(setq projectile-enable-caching 0)

;; powerline
(powerline-default-theme)

;; git
(global-git-gutter-mode +1)
(global-auto-revert-mode t)

;; prettier
(add-hook 'javascript-mode-hook 'prettier-js-mode)
(add-hook 'web-mode-hook 'prettier-js-mode)
(add-hook 'markdown-mode-hook 'prettier-js-mode)

;; format-all
(define-key evil-normal-state-map (kbd "F") 'format-all-buffer)

;; rust
(add-to-list 'auto-mode-alist '("\\.rs?$" . rust-mode))

;; magit
(global-set-key (kbd "C-x g") 'magit-status)
;; emulate some fugitive shortcuts
(evil-ex-define-cmd "Gdiff" 'magit-diff-buffer-file)
(evil-ex-define-cmd "Gstatus" 'magit-status)
(setq magit-completing-read-function 'ivy-completing-read)
(evil-magit-init)

;; autocomplete
(ac-config-default)
(global-auto-complete-mode t)
(ac-set-trigger-key "TAB")

;; rainbow delimeters
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; snippets
(yas-global-mode 1)

;; javascript (web mode)
(add-to-list 'auto-mode-alist '("\\.jsx?$" . web-mode))
(setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))
(defun web-mode-init-hook ()
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-markup-indent-offset 2))
(add-hook 'web-mode-hook  'web-mode-init-hook)
;(setq web-mode-enable-auto-closing t)
;(setq sgml-quick-keys 'close)
(setq css-indent-offset 2)
(add-to-list 'auto-mode-alist '("\\.mjs$" . javascript-mode))

;; emmet
(define-key evil-insert-state-map (kbd "C-y") 'emmet-expand-line)

;; ivy
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(setq ivy-re-builders-alist
      '((ivy-switch-buffer . ivy--regex-plus)
        (t . ivy--regex-fuzzy)))
;(setq ivy-initial-inputs-alist nil)

(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)

;; which key
(which-key-mode)

;; eyebrowse
(eyebrowse-mode t)
(eyebrowse-setup-opinionated-keys)
(setq eyebrowse-wrap-around t)
(setq eyebrowse-new-workspace t)
(define-key evil-normal-state-map (kbd "tp") 'eyebrowse-prev-window-config)
(define-key evil-normal-state-map (kbd "tn") 'eyebrowse-next-window-config)
(define-key evil-normal-state-map (kbd "tq") 'eyebrowse-close-window-config)
(define-key evil-normal-state-map (kbd "s-1") 'eyebrowse-switch-to-window-config-1)
(define-key evil-normal-state-map (kbd "s-2") 'eyebrowse-switch-to-window-config-2)
(define-key evil-normal-state-map (kbd "s-3") 'eyebrowse-switch-to-window-config-3)
(define-key evil-normal-state-map (kbd "s-4") 'eyebrowse-switch-to-window-config-4)
(define-key evil-normal-state-map (kbd "s-5") 'eyebrowse-switch-to-window-config-5)
(define-key evil-normal-state-map (kbd "s-6") 'eyebrowse-switch-to-window-config-6)
(define-key evil-normal-state-map (kbd "s-7") 'eyebrowse-switch-to-window-config-7)
(define-key evil-normal-state-map (kbd "s-8") 'eyebrowse-switch-to-window-config-8)
(define-key evil-normal-state-map (kbd "s-9") 'eyebrowse-switch-to-window-config-9)

;; lua
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))
(setq lua-indent-level 2)

;; c header guards
(defun get-include-guard ()
  "Return a string suitable for use in a C/C++ include guard"
  (let* ((fname (buffer-file-name (current-buffer)))
         (fbasename (replace-regexp-in-string ".*/" "" fname))
         (inc-guard-base (replace-regexp-in-string "[.-]"
                                                   "_"
                                                   fbasename)))
    (upcase inc-guard-base)))

(defun auto-c-header-guard ()
  (interactive)
  (let ((file-name (buffer-file-name (current-buffer))))
    (when (string= ".h" (substring file-name -2))
      (let ((include-guard (get-include-guard)))
        (insert "#ifndef " include-guard)
        (newline)
        (insert "#define " include-guard)
        (newline 4)
        (insert "#endif")
        (newline)
        (previous-line 3)
        (set-buffer-modified-p nil)))))

(add-hook 'find-file-not-found-hooks 'auto-c-header-guard)

;;
;; config
;;

;; config vars
(setq inhibit-startup-screen t)
(setq ring-bell-function 'ignore)
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
; increase gc limit during startup
(setq gc-cons-threshold 50000000)
(add-hook 'emacs-startup-hook 'my/set-gc-threshold)
(defun my/set-gc-threshold ()
  "Reset `gc-cons-threshold' to its default value."
  (setq gc-cons-threshold 800000))

;; backups
(setq
  backup-by-copying t
  backup-directory-alist '(("." . "~/.saves/"))
  delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

;; keybindings
(define-key evil-normal-state-map (kbd ";") #'evil-ex)
(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-normal-state-map (kbd "<tab>") 'next-buffer)
(define-key evil-normal-state-map (kbd "<backtab>") 'previous-buffer)

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
(define-key evil-normal-state-map (kbd "<s-escape>") 'execute-extended-command)
(define-key evil-normal-state-map (kbd "<s-x>") 'execute-extended-command)

;; escape key
(define-key key-translation-map (kbd "ESC") (kbd "C-g"))
(define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)

;; zoom in and out
(define-key evil-normal-state-map (kbd "s-=") 'text-scale-increase)
(define-key evil-normal-state-map (kbd "s--") 'text-scale-decrease)
(define-key evil-normal-state-map (kbd "s-0") (lambda() (interactive) (text-scale-set 0)))
(setq text-scale-mode-step 1.2)

;; tabs
; START TABS CONFIG
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
; END TABS CONFIG
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

;; vim emulation
(evil-ex-define-cmd "Explore" 'dired)

;; leader key
(define-prefix-command 'leader-map)
(define-key evil-normal-state-map (kbd "SPC") leader-map)
(define-key leader-map "b" 'list-buffers)
(define-key leader-map "q" 'evil-quit)
(define-key leader-map "l" 'run-current-file)
(define-key leader-map (kbd "RET") 'run-current-project)
(define-key leader-map "g" 'magit-status)
(define-key leader-map (kbd "SPC") 'execute-extended-command)
(define-key evil-normal-state-map (kbd "s-r") 'run-current-file)
(define-key evil-normal-state-map (kbd "s-s") 'save-buffer)

(defun run-current-project ()
  (interactive)
  (projectile-compile-project 'nil))

;; run file
(defun run-current-file ()
  (interactive)
  (if (derived-mode-p 'emacs-lisp-mode)
    (load-file buffer-file-name)
    (multi-compile-run)))

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

;; DONT DELETE ME!!!!
;; make comiplation mode use terminal colors
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region compilation-filter-start (point))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

;; vim escape sequences
;; bind jk to escape
(key-chord-mode 1)
(key-chord-define evil-insert-state-map  "jk" 'evil-normal-state)
(define-key evil-insert-state-map (kbd "C-c") 'evil-normal-state)
(define-key evil-insert-state-map (kbd "C-f") 'evil-normal-state)

;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))
