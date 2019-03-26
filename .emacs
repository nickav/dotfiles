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
 '(column-number-mode t)
 '(compilation-message-face (quote default))
 '(custom-enabled-themes (quote (tsdh-dark)))
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
 '(magit-diff-use-overlays nil)
 '(package-selected-packages
   (quote
    (yasnippet rainbow-delimiters auto-complete emmet-mode format-all prettier-js magit use-package powerline projectile git-gutter evil monokai-theme ##)))
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

;; evil
(setq evil-want-C-u-scroll t)
(setq evil-want-C-d-scroll t)
(require 'evil)
(evil-mode 1)

;; theme
(setq monokai-background "#1B1D1E" monokai-highlight-line "#293739")
(load-theme 'monokai t)

;; projectile
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "s-t") 'projectile-find-file)
(define-key evil-normal-state-map (kbd "C-p") nil)
(define-key projectile-mode-map (kbd "C-p") 'projectile-find-file)
(setq projectile-project-search-path '("~/dev/"))

;; powerline
(require 'powerline)
(powerline-default-theme)

;; git
(global-git-gutter-mode +1)

;; prettier
(require 'prettier-js)
(define-key evil-normal-state-map (kbd "F") 'prettier-js)

;; magit
(global-set-key (kbd "C-x g") 'magit-status)

;; autocomplete
(ac-config-default)

;; config
(setq inhibit-startup-screen t)
(setq ring-bell-function 'ignore)
(global-hl-line-mode +1)
(setq vc-follow-symlinks t)
(setq show-trailing-whitespace t)
(setq show-paren-delay 0)
(show-paren-mode 1)

;; keybindings
(define-key evil-normal-state-map (kbd ";") #'evil-ex)
(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)

;; splits
(defun evil-window-vsplit-focus ()
	;; split vertically and foucs new split
	(interactive)(evil-window-vsplit) (other-window 1))

(defun evil-window-split-focus ()
	;; split horizontally and foucs new split
	(interactive)(evil-window-split) (other-window 1))

(define-key evil-normal-state-map (kbd "C-w \\") 'evil-window-vsplit-focus)
(define-key evil-normal-state-map (kbd "C-w -") 'evil-window-split-focus)
(define-key evil-normal-state-map (kbd "C-w <right>") 'evil-window-right)
(define-key evil-normal-state-map (kbd "<right>") 'evil-window-right)
(define-key evil-normal-state-map (kbd "C-w <left>") 'evil-window-left)
(define-key evil-normal-state-map (kbd "<left>") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-w <down>") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-w <up>") 'evil-window-up)

;; scrolling
(define-key evil-normal-state-map (kbd "C-e") (lambda() (interactive) (evil-scroll-line-down 16)))
(define-key evil-normal-state-map (kbd "C-y") (lambda() (interactive) (evil-scroll-line-up 16)))

;; M-x
(define-key evil-normal-state-map (kbd "<s-escape>") 'execute-extended-command)
(define-key evil-normal-state-map (kbd "<s-x>") 'execute-extended-command)

;; electric pair
;; insert matching braces automatically
(electric-pair-mode 1)

;; rainbow delimeters
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; snippets
(yas-global-mode 1)

;; tabs
;; source: https://dougie.io/emacs/indentation/
;; Create a variable for our preferred tab width
(setq custom-tab-width 2)

;; Two callable functions for enabling/disabling tabs in Emacs
(defun disable-tabs () (setq indent-tabs-mode nil))
(defun enable-tabs  ()
  (local-set-key (kbd "TAB") 'tab-to-tab-stop)
  (setq indent-tabs-mode t)
  (setq tab-width custom-tab-width))

;; Hooks to Enable Tabs
(add-hook 'prog-mode-hook 'enable-tabs)
;; Hooks to Disable Tabs
(add-hook 'lisp-mode-hook 'disable-tabs)
(add-hook 'emacs-lisp-mode-hook 'disable-tabs)

;; Language-Specific Tweaks
(setq-default python-indent-offset custom-tab-width) ;; Python
(setq-default js-indent-level custom-tab-width)      ;; Javascript

;; Making electric-indent behave sanely
(setq-default electric-indent-inhibit t)

;; Make the backspace properly erase the tab instead of
;; removing 1 space at a time.
(setq backward-delete-char-untabify-method 'hungry)

;; (OPTIONAL) Shift width for evil-mode users
;; For the vim-like motions of ">>" and "<<".
(setq-default evil-shift-width custom-tab-width)

;; WARNING: This will change your life
;; (OPTIONAL) Visualize tabs as a pipe character - "|"
;; This will also show trailing characters as they are useful to spot.
(setq whitespace-style '(face tabs tab-mark trailing))

(setq whitespace-display-mappings
  '((tab-mark 9 [124 9] [92 9]))) ; 124 is the ascii ID for '\|'
(global-whitespace-mode) ; Enable whitespace mode everywhere
;; end tabs

(defun infer-indentation-style ()
	;; if our source file uses tabs, we use tabs, if spaces spaces, and if
	;; neither, we use the current indent-tabs-mode
	(let ((space-count (how-many "^  " (point-min) (point-max)))
				(tab-count (how-many "^\t" (point-min) (point-max))))
		(if (> space-count tab-count) (setq indent-tabs-mode nil))
		(if (> tab-count space-count) (setq indent-tabs-mode t))))
(infer-indentation-style)

;; whitespace
(setq-default fill-column 80)
(add-hook 'text-mode-hook 'auto-fill-mode)

(require 'whitespace)
(setq-default whitespace-line-column 80)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(global-whitespace-mode t)

;; leader
(define-prefix-command 'leader-map)
(define-key evil-normal-state-map (kbd "SPC") leader-map)
(define-key leader-map "b" 'list-buffers)
(define-key leader-map "q" 'evil-quit)

;; run file
(defun xah-run-current-go-file ()
  "Run or build current golang file.

To build, call `universal-argument' first.

Version 2018-10-12"
  (interactive)
  (when (not (buffer-file-name)) (save-buffer))
  (when (buffer-modified-p) (save-buffer))
  (let* (
         ($outputb "*xah-run output*")
         (resize-mini-windows nil)
         ($fname (buffer-file-name))
         ($fSuffix (file-name-extension $fname))
         ($prog-name "go")
         $cmd-str)
    (setq $cmd-str (concat $prog-name " \""   $fname "\" &"))
    (if current-prefix-arg
        (progn
          (setq $cmd-str (format "%s build \"%s\" " $prog-name $fname)))
      (progn
        (setq $cmd-str (format "%s run \"%s\" &" $prog-name $fname))))
    (progn
      (message "running %s" $fname)
      (message "%s" $cmd-str)
      (shell-command $cmd-str $outputb )
      ;;
      )))

(defun xah-run-current-file ()
  "Execute the current file.
For example, if the current buffer is x.py, then it'll call 「python x.py」 in a shell.
Output is printed to buffer “*xah-run output*”.

The file can be Emacs Lisp, PHP, Perl, Python, Ruby, JavaScript, TypeScript, golang, Bash, Ocaml, Visual Basic, TeX, Java, Clojure.
File suffix is used to determine what program to run.

If the file is modified or not saved, save it automatically before run.

URL `http://ergoemacs.org/emacs/elisp_run_current_file.html'
Version 2018-10-12"
  (interactive)
  (let (
        ($outputb "*xah-run output*")
        (resize-mini-windows nil)
        ($suffix-map
         ;; (‹extension› . ‹shell program name›)
         `(
           ("php" . "php")
           ("pl" . "perl")
           ("py" . "python")
           ("py3" . ,(if (string-equal system-type "windows-nt") "c:/Python32/python.exe" "python3"))
           ("rb" . "ruby")
           ("go" . "go run")
           ("hs" . "runhaskell")
           ("js" . "node")
           ("mjs" . "node --experimental-modules ")
           ("ts" . "tsc") ; TypeScript
           ("tsx" . "tsc")
           ("sh" . "bash")
           ("clj" . "java -cp ~/apps/clojure-1.6.0/clojure-1.6.0.jar clojure.main")
           ("rkt" . "racket")
           ("ml" . "ocaml")
           ("vbs" . "cscript")
           ("tex" . "pdflatex")
           ("latex" . "pdflatex")
           ("java" . "javac")
           ;; ("pov" . "/usr/local/bin/povray +R2 +A0.1 +J1.2 +Am2 +Q9 +H480 +W640")
           ))
        $fname
        $fSuffix
        $prog-name
        $cmd-str)
    (when (not (buffer-file-name)) (save-buffer))
    (when (buffer-modified-p) (save-buffer))
    (setq $fname (buffer-file-name))
    (setq $fSuffix (file-name-extension $fname))
    (setq $prog-name (cdr (assoc $fSuffix $suffix-map)))
    (setq $cmd-str (concat $prog-name " \""   $fname "\" &"))
    (run-hooks 'xah-run-current-file-before-hook)
    (cond
     ((string-equal $fSuffix "el")
      (load $fname))
     ((or (string-equal $fSuffix "ts") (string-equal $fSuffix "tsx"))
      (if (fboundp 'xah-ts-compile-file)
          (progn
            (xah-ts-compile-file current-prefix-arg))
        (if $prog-name
            (progn
              (message "Running")
              (shell-command $cmd-str $outputb ))
          (error "No recognized program file suffix for this file."))))
     ((string-equal $fSuffix "go")
      (xah-run-current-go-file))
     ((string-equal $fSuffix "java")
      (progn
        (shell-command (format "java %s" (file-name-sans-extension (file-name-nondirectory $fname))) $outputb )))
     (t (if $prog-name
            (progn
              (message "Running")
              (shell-command $cmd-str $outputb ))
          (error "No recognized program file suffix for this file."))))
    (run-hooks 'xah-run-current-file-after-hook)))
;; run file
