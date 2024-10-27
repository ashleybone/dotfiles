;; Global settings.

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))								

;; Startup, appearance, and general setup
(setq inhibit-startup-message t)
(menu-bar-mode 0)
(transient-mark-mode 0)
(setq select-enable-clipboard t)
(setq initial-scratch-message nil)
(column-number-mode t)
(setq require-final-newline t)
(setq compile-command "scons")
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(desktop-save-mode 1)
(server-start)

;; Prompt for exit on C-x C-c.
(global-set-key "\C-x\C-c"
                '(lambda (&optional arg)
                   "Ask user if she wants to quit before killing emacs."
                   (interactive "P")
                   (if (yes-or-no-p "Are you sure you want to quit?")
                       (save-buffers-kill-emacs arg))))
;; clipboard support
(unless window-system
  (when (getenv "DISPLAY")
	(if (string= (getenv "XDG_SESSION_TYPE") "wayland")
	    (progn
	      (defun wlcopy-cut-function (text &optional push)
			(with-temp-buffer
			  (insert text)
			  (call-process-region (point-min) (point-max) "wl-copy")))
	      (defun wlpaste-paste-function ()
			(let ((wlpaste-output (shell-command-to-string "wl-paste")))
			  (unless (string= (car kill-ring) wlpaste-output)
				wlpaste-output)))
	      (setq interprogram-cut-function 'wlcopy-cut-function)
		  (setq interprogram-paste-function 'wlpaste-paste-function))
	  (progn
	    (defun xclip-cut-function (text &optional push)
	      (with-temp-buffer
			(insert text)
			(call-process-region (point-min) (point-max) "xclip" nil nil nil
								 "-i" "-selection" "clipboard")))
	    (defun xclip-paste-function ()
	      (let ((xclip-output (shell-command-to-string "xclip -o -selection clipboard")))
			(unless (string= (car kill-ring) xclip-output)
			  xclip-output)))
	    (setq interprogram-cut-function 'xclip-cut-function)
	    (setq interprogram-paste-function 'xclip-paste-function)))))

;; Shell script settings.
(add-hook 'sh-mode-hook '(lambda () (setq indent-tabs-mode nil)))

;; C++ settings.
(setq auto-mode-alist (cons '("\\.h$" . c++-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.i$" . c++-mode) auto-mode-alist))

(add-hook 'c++-mode-hook '(lambda () (c-set-style "stroustrup")))
(add-hook 'c++-mode-hook '(lambda () (setq indent-tabs-mode nil)))
(add-hook 'c++-mode-hook '(lambda () (define-key c++-mode-map "\C-m" 'newline-and-indent)))
(add-hook 'c++-mode-hook '(lambda () (define-key c++-mode-map "\C-cg" 'compile)))

;; C settings.
(add-hook 'c-mode-common-hook '(lambda () (c-set-style "stroustrup")))
(add-hook 'c-mode-common-hook '(lambda () (setq indent-tabs-mode nil)))
(add-hook 'c-mode-common-hook '(lambda () (define-key c-mode-base-map "\C-m" 'newline-and-indent)))
(add-hook 'c-mode-common-hook '(lambda () (define-key c-mode-base-map "\C-cg" 'compile)))

;; python settings and SCons file associations
(setq auto-mode-alist (cons '("SConstruct*" . python-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("Sconstruct*" . python-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("sconstruct*" . python-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("SConscript*" . python-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("Sconscript*" . python-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("sconscript*" . python-mode) auto-mode-alist))
(add-hook 'python-mode-hook '(lambda () (setq indent-tabs-mode nil)))
(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-m" 'newline-and-indent)))
(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-c\C-c" 'comment-region)))
(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-cg" 'compile)))

;; scheme settings
(add-hook 'scheme-mode-hook #'enable-paredit-mode)

;; markdown settings
(setq auto-mode-alist
	  (cons '("\.md" . markdown-mode) auto-mode-alist))

;; recent files
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; Package settings
(rg-enable-default-bindings)

;; custom variables

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(modus-vivendi))
 '(lua-indent-level 4)
 '(package-selected-packages
   '(rg markdown-mode lua-mode yaml-mode fish-mode geiser-guile fzf zoxide paredit geiser))
 '(tab-width 4))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
