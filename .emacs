;;;  -*- Mode: emacs-lisp; Encoding: utf-8 -*-

(setq user-mail-address "mrluanma#gmail#com")

(defun user-login-name ()
  "luanma")

(defun user-full-name ()
  "Xiaohong Zhao")

(add-to-list 'load-path "~/.emacs.d/")
(require 'minor-modes)

;; More color
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0/")
(require 'color-theme)
(color-theme-initialize)
(color-theme-clarity)

;; Remove trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Maximize-frame
(require 'maxframe)
(add-hook 'window-setup-hook 'maximize-frame t)
(add-hook 'before-make-frame-hook
          (lambda ()
            (setq default-frame-alist
                  (append default-frame-alist
                          (list (cons 'width  (frame-width))
                                (cons 'height (frame-height))))))
          nil)

;;; Some shortcuts
(global-set-key [(f2)] 'todo-show)
(global-set-key [(f3)] 'python-mode)
(global-set-key [(f4)] 'ruby-mode)
(global-set-key [(f5)] 'view-mode)
(global-set-key [(f7)] 'auto-fill-mode)
(global-set-key [(f8)] 'calendar)
(global-set-key [(f9)] 'zone)
(global-set-key "\C-cc"  'comment-region)
(global-set-key "\C-cu"  'uncomment-region)
(global-set-key [f11] 'x-frame-fullscreenize)

(setq scheme-program-name "mzscheme")
(global-set-key [(f10)]
                '(lambda ()
                  (interactive)
                  (require 'quack)
                  (run-scheme scheme-program-name)))

(defun x-frame-fullscreenize ()
  "Full screen-ize current frame under X."
  (interactive)
  (cond ((eq window-system 'x)
         (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                                '(2 "_NET_WM_STATE_FULLSCREEN" 0)))))

;; haskell-mode
(load "~/.emacs.d/haskell-mode-2.7.0/haskell-site-file.el")
(add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

;; erlang-mode
(add-to-list 'load-path "~/.emacs.d/erlang-mode/")
(setq erlang-root-dir "/usr/local/lib/erlang/")
(setq exec-path (cons "/usr/local/bin" exec-path))
(require 'erlang-start)

;; lua-mode
(add-to-list 'load-path "~/.emacs.d/lua-mode/")
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)

;; js2-mode
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; ruby-mode
(add-to-list 'load-path "~/.emacs.d/ruby-mode/")
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(autoload 'ruby-mode "ruby-mode" "Ruby editing mode." t)
(add-hook 'ruby-mode-hook
          (lambda()
            (require 'ruby-electric)
            (ruby-electric-mode t)))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(case-fold-search t)
 '(column-number-mode t)
 '(display-time-mode t)
 '(global-font-lock-mode t nil (font-lock))
 '(show-paren-mode t)
 '(transient-mark-mode (quote (only . t))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 143 :width normal :foundry "outline" :family "Courier New")))))

;; Todo
(setq todo-file-do "~/.emacs.d/do")
(setq todo-file-done "~/.emacs.d/done")
(setq todo-file-top "~/.emacs.d/top")

;; Diary & appt
(setq diary-file "~/.emacs.d/diary")
(setq diary-mail-addr "mrluanma#gmail#com")
(add-hook 'diary-hook 'appt-make-list)
(setq appt-issue-message t)

;; Display time
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(display-time)

(transient-mark-mode t)

(add-to-list 'auto-mode-alist '("\\.m$" . objc-mode))

;; reST file
(autoload 'rst-mode "rst" "A major mode for reST file." t)
(add-to-list 'auto-mode-alist '("\\.rst$\\|\\.rest$" . rst-mode))

;;; Auto-insert
(setq auto-insert t)
(setq auto-insert-query t)
(add-hook 'find-file-hooks 'auto-insert)
(setq auto-insert-directory "~/.emacs.d/")
(setq auto-insert-copyright
      (format "%s <%s>" (user-full-name) user-mail-address))

;; Text file
(define-auto-insert
    '("\\.txt$\\|README$" . "Text file")
    '(nil
      "File: " (file-name-nondirectory buffer-file-name)
      "  -*- Encoding: utf-8 -*-\n"))

;; No annoying backup files
(setq make-backup-files nil
      backup-inhibited t)

;; Software that beeps just sucks
(setq visible-bell t)

;; Don't show me the startup message
(setq inhibit-startup-message t)

;; Show me the parens, please
(show-paren-mode t)

;; Time-stamp
(add-hook 'write-file-hooks 'time-stamp)
(setq time-stamp-format "%:u %02m/%02d/%04y %02H:%02M:%02S")

;; No tool-bar & menu-bar & scroll-bar
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq scroll-bar-mode nil)

;; Show line number and column
(line-number-mode t)
(column-number-mode t)

;; (add-to-list 'load-path "~/lisp/slime-2.0/")
;; (setq inferior-lisp-program "sbcl --noinform")       ; your Lisp system
;; (require 'slime)
;; (slime-setup)

;; Session
(add-to-list 'load-path "~/.emacs.d/session/lisp/")
(require 'session)
(add-hook 'after-init-hook 'session-initialize)
(desktop-save-mode t)
(add-hook 'kill-emacs-hook '(lambda () (desktop-save "~/")))

;; I love comment, but I have my style.
(defun kill-cpp-comment ()
  "Kill all the cpp style comment from current buffer."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (not (eobp))
      (if (looking-at "//") (kill-line))
      (forward-char))))

;; Indent whole buffer.
(global-set-key [(meta i)] 'iwb)
(defun iwb ()
  "Indent whole buffer."
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))

;;; Emacs fortune
(require 'find-lisp)
(defvar fortune-files (find-lisp-find-files "~/.emacs.d/fortune/" "\\.ft$")
  "The files that fortunes come from.")

(defvar fortune-strings nil
  "The fortunes in the fortune file.")

(defun open-fortune-file (file)
  (find-file file)
  (if (null fortune-strings)
      (let ((strings nil)
            (prev 1))
        (goto-char (point-min))
        (while (re-search-forward "^%$" (point-max) t)
          (push (buffer-substring-no-properties prev (- (point) 1))
                strings)
          (setq prev (1+ (point))))
        (push (buffer-substring-no-properties prev (point-max)) strings)
        (setq fortune-strings (apply 'vector strings)))))

(defun fortune ()
  "Get a fortune to display."
  (interactive)
  (when (null fortune-strings)
    ;; seed the random sequence generator
    (random t)
    ;; read fortune string from file
    (open-fortune-file (nth (random (length fortune-files)) fortune-files))
    (kill-buffer (current-buffer)))
  (let* ((n (random (length fortune-strings)))
         (string (aref fortune-strings n)))
    (if (interactive-p)
        (message (format "%s" string))
        string)))

;; Override standard startup message
(defun startup-echo-area-message ()
  (fortune))

;;; move current line up or down
(global-set-key [(meta up)] 'move-line-up)
(global-set-key [(meta down)] 'move-line-down)

(defun move-line (&optional n)
  "Move current line N (1) lines up/down leaving point in place."
  (interactive "p")
  (when (null n)
    (setq n 1))
  (let ((col (current-column)))
    (beginning-of-line)
    (next-line 1)
    (transpose-lines n)
    (previous-line 1)
    (move-to-column col)))

(defun move-line-up (n)
  "Moves current line N (1) lines up leaving point in place."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Moves current line N (1) lines down leaving point in place."
  (interactive "p")
  (move-line (if (null n) 1 n)))

;;; the vim ctrl-o open next line functionality
(global-set-key [(control o)] 'vi-open-next-line)

(defun vi-open-next-line (arg)
  "Move to the next line (like vi) and then opens a line."
  (interactive "p")
  (end-of-line)
  (open-line arg)
  (next-line 1)
  (indent-according-to-mode))

(defadvice kill-ring-save (before slickcopy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
       (list (line-beginning-position)
             (line-beginning-position 2)))))

(defadvice kill-region (before slickcut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
       (list (line-beginning-position)
             (line-beginning-position 2)))))

;;; match paren
(global-set-key "%" 'match-paren)
(defun match-paren (arg)
  "Go to the matching parenthesis if on parenthesis otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Recreating killed buffers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; If the *scratch* buffer is killed, recreate it automatically
(save-excursion
  (set-buffer (get-buffer-create "*scratch*"))
  (lisp-interaction-mode)
  (make-local-variable 'kill-buffer-query-functions)
  (add-hook 'kill-buffer-query-functions 'kill-scratch-buffer))

(defun kill-scratch-buffer ()
  ;; Kill the current (*scratch*) buffer
  (remove-hook 'kill-buffer-query-functions 'kill-scratch-buffer)
  (kill-buffer (current-buffer))

  ;; Make a brand new *scratch* buffer
  (set-buffer (get-buffer-create "*scratch*"))
  (lisp-interaction-mode)
  (make-local-variable 'kill-buffer-query-functions)
  (add-hook 'kill-buffer-query-functions 'kill-scratch-buffer)

  ;; Since we killed it, don't let caller do that.
  nil)

;; If the *Messages* buffer is killed, recreate it automatically
(save-excursion
  (set-buffer (get-buffer-create "*Messages*"))
  (lisp-interaction-mode)
  (make-local-variable 'kill-buffer-query-functions)
  (add-hook 'kill-buffer-query-functions 'kill-message-buffer))

(defun kill-message-buffer ()
  ;; Kill the current (*Messages*) buffer
  (remove-hook 'kill-buffer-query-functions 'kill-message-buffer)
  (kill-buffer (current-buffer))

  ;; Make a brand new *Messages* buffer
  (set-buffer (get-buffer-create "*Messages*"))
  (lisp-interaction-mode)
  (make-local-variable 'kill-buffer-query-functions)
  (add-hook 'kill-buffer-query-functions 'kill-message-buffer)

  ;; Since we killed it, don't let caller do that.
  nil)

;; asp-mode
(autoload 'asp-mode "asp-mode")
(add-to-list 'auto-mode-alist '("\\.asp$" . asp-mode))

;; haml-mode & sass-mode
(require 'haml-mode)
(require 'sass-mode)

;; php-mode
(require 'php-mode)
(add-to-list 'auto-mode-alist
             '("\\.php[345]?$\\|\\.phtml$\\|\\.inc$\\|\\.module$" . php-mode))

;; yaml-mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; markddown-mode
(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist
             '("\\.md$\\|\\.mkd$\\|\\.txt$\\|\\.markdown$" . markdown-mode))

;; clojure-mode
(add-to-list 'load-path "~/.emacs.d/clojure-mode")
(autoload 'clojure-mode "clojure-mode" "A major mode for Clojure" t)
(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))

;; yasnippet
(add-to-list 'load-path "~/.emacs.d/yasnippet")
(require 'yasnippet)
(setq yas/root-directory "~/.emacs.d/yasnippet/snippets")
(yas/load-directory yas/root-directory)

;; jekyll
(require 'jekyll)
(global-set-key (kbd "C-c b n") 'jekyll-draft-post)
(global-set-key (kbd "C-c b P") 'jekyll-publish-post)
(global-set-key (kbd "C-c b p") (lambda ()
                                  (interactive)
                                  (find-file "~/Sources/blog/_posts/")))
(global-set-key (kbd "C-c b d") (lambda ()
                                  (interactive)
                                  (find-file "~/Sources/blog/_drafts/")))

;; po-mode
(add-to-list 'load-path "~/.emacs.d/po-mode")
(autoload 'po-mode "po-mode"
  "Major mode for translators to edit PO files" t)
(add-to-list 'auto-mode-alist '("\\.po\\'\\|\\.po\\." . po-mode))

;; Gist
(add-to-list 'load-path "~/.emacs.d/gist")
(require 'gist)
(setq github-user "xxxxxxxx")
(setq github-token "xxxxxxxx4f672520ac6aa8744xxxxxx")
