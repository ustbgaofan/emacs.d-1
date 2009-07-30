;;;  -*- Mode: emacs-lisp; Encoding: utf-8 -*-
;;; .emacs for luanma <mrSPAMluanma(remove SPAM)@gmail.com>
;;; Created in 2005
;;; Time-stamp: <luanma 07/30/2009 16:42:40>

;; I use Gentoo sometimes.
;; (load "/usr/share/emacs/site-lisp/site-gentoo")

(add-to-list 'load-path "~/.emacs.d/")
(require 'ellets)

(defun user-full-name ()
  "Xiaohong Zhao")

;; More color
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0/")
(require 'color-theme)
(color-theme-initialize)
(color-theme-clarity)

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

;; (setq initial-frame-alist
;;       `((left . 0) (top . 0)
;;        (width . 108) (height . 42)))

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

;; Enable Erlang-mode.
(add-to-list 'load-path "~/.emacs.d/erlang-mode/")
(setq erlang-root-dir "/usr/local/lib/erlang/")
(setq exec-path (cons "/usr/local/bin" exec-path))
(require 'erlang-start)

;; Enable Io-mode
(add-to-list 'load-path "~/.emacs.d/io-mode/")
(require 'io-mode)
(push '("\\.io$" . io-mode) auto-mode-alist)

;; Enable Lua-mode
(add-to-list 'load-path "~/.emacs.d/lua-mode/")
(setq auto-mode-alist (cons '("\\.lua$" . lua-mode) auto-mode-alist))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)

;; Enable Javascript-mode
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; Ruby
(add-to-list 'load-path "~/.emacs.d/ruby-mode/")
(push '("\\.rb$" . ruby-mode) auto-mode-alist)
(autoload 'ruby-mode "ruby-mode" "Ruby editing mode." t)
(add-hook 'ruby-mode-hook
          (lambda()
            (require 'ruby-electric)
            (ruby-electric-mode t)))

;;; Rails-mode
(add-to-list 'load-path "~/.emacs.d/emacs-rails/")
(require 'rails)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(case-fold-search t)
 '(global-font-lock-mode t nil (font-lock)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Todo
(setq todo-file-do "~/.emacs.d/do")
(setq todo-file-done "~/.emacs.d/done")
(setq todo-file-top "~/.emacs.d/top")

;; Diary & appt
(setq diary-file "~/.emacs.d/diary")
(setq diary-mail-addr "mrSPAMluanma(remove SPAM)@gmail.com")
(add-hook 'diary-hook 'appt-make-list)
(setq appt-issue-message t)

;; Display time
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(display-time)

(transient-mark-mode t)

;; Use emacs-w3m to browe WWW world.
;; Just to prove me a hard-core Emacs user.
;; (add-to-list 'load-path "~/.emacs.d/w3m/")
;; (require 'w3m-load)
;; (require 'mime-w3m)

;;; Email stuff.
(setq user-full-name "mrSPAMluanma(remove SPAM)")
(setq user-mail-address "mrSPAMluanma(remove SPAM)@gmail.com")

;; Basic VM setup
;; (add-to-list 'load-path "~/.emacs.d/vm/")
;; (autoload 'vm "vm" "Start VM on your primary inbox." t)
;; (autoload 'vm-other-frame "vm" "Like `vm' but starts in another frame." t)
;; (autoload 'vm-visit-folder "vm" "Start VM on an arbitrary folder." t)
;; (autoload 'vm-visit-virtual-folder "vm" "Visit a VM virtual folder." t)
;; (autoload 'vm-mode "vm" "Run VM major mode on a buffer" t)
;; (autoload 'vm-mail "vm" "Send a mail message using VM." t)
;; (autoload 'vm-submit-bug-report "vm" "Send a bug report about VM." t)
;; (setq vm-toolbar-pixmap-directory (concat (expand-file-name "~") "/bin/emacs/site-lisp/vm/pixmaps"))
;; (setq vm-image-directory (concat (expand-file-name "~") "/bin/emacs/site-lisp/vm/pixmaps"))
;; (setenv "PATH" (concat (concat (expand-file-name "~") "/bin/emacs/site-lisp/vm/bin") ":" (getenv "PATH")))
;; (setq send-mail-function 'sendmail-send-it)
(setq mail-archive-file-name "~/Mail/SENT")

;; Configure inbound mail (POP)
;; (setq vm-spool-files
;;       '(("~/INBOX" "pop-ssl:pop.gmail.com:995:pass:mrSPAMluanma(remove SPAM)@gmail.com:*" "~/INBOX.CRASH")))

;; Use W3M to read HTML email
;; (require 'w3m-load)
;; (setq vm-mime-use-w3-for-text/html nil)
;; (setq vm-url-browser 'w3m)
;; (load "vm-w3m")
;; (setq w3m-input-coding-system 'utf-8
;;       w3m-output-coding-system 'utf-8)

;; Configure outbound mail (SMTP)
;; (smtpmail didn't work for me.)

;; (setq smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
;;       smtpmail-smtp-server "smtp.gmail.com"
;;       smtpmail-default-smtp-server "smtp.gmail.com"
;;       send-mail-function 'smtpmail-send-it
;;       message-send-mail-function 'smtpmail-send-it
;;       smtpmail-smtp-service 587
;;       smtpmail-auth-credentials '(("smtp.gmail.com"
;;                                 587
;;                                 "mrSPAMluanma(remove SPAM)@gmail.com" nil)))

;; so we use ssmtp to send it.
;; (setq send-mail-function 'feedmail-send-it)

;; (setq feedmail-buffer-eating-function
;;       'feedmail-buffer-to-ssmtp)

;; (setq feedmail-ssmtp-template
;;       "sendmail -t")

;; (defun feedmail-buffer-to-ssmtp (prepped errors-to addr-listoid)
;;   "Function which actually calls ssmtp as a subprocess.
;; Feeds the buffer to it.
;; derived from feedmail-buffer-to-binmail"
;;   (set-buffer prepped)
;;   (apply
;;    'call-process-region
;;    (append (list (point-min) (point-max)
;;               "/bin/sh" nil errors-to nil "-c"
;;               (format feedmail-ssmtp-template)))))

;; Oh, the simplicity
;; (set-default-font "-misc-fixed-medium-r-normal--20-140-100-100-c-100-iso8859-1")
;; -adobe-courier-medium-r-normal--20-140-100-100-m-110-iso10646-1
;; -misc-fixed-medium-r-normal--20-140-100-100-c-100-iso8859-1

(push '("\\.m$" . objc-mode) auto-mode-alist)

;; reST file
(setq auto-mode-alist
      (append '(("\\.rst$" . rst-mode)
                ("\\.rest$" . rst-mode)) auto-mode-alist))

;;; Auto-insert
(setq auto-insert t)
(setq auto-insert-query t)
(add-hook 'find-file-hooks 'auto-insert)
(setq auto-insert-directory "~/.emacs.d/")
(setq auto-insert-copyright
      (format "%s <%s>" (user-full-name) user-mail-address))

;; build.xml
(define-auto-insert
  '("^build\\.xml\\'" . "Ant build script")
  '(nil
    ""))

;; Text file
(define-auto-insert
  '("\\.txt\\|\\README\\'" . "Text file")
  '(nil
    "File: " (file-name-nondirectory buffer-file-name)
    "  -*- Encoding: utf-8 -*-\n"
    "Time-stamp: <>\n\n"))

;; reST file
(define-auto-insert
  '("\\.rst\\|\\.rest\\'" . "reST file")
  '(nil
    ".. -*- Mode: rst -*- \n"
    "    File: " (file-name-nondirectory buffer-file-name)
    "  -*- Encoding: utf-8 -*-\n"
    "    Time-stamp: <>\n\n"))

;; C/C++/Java source file
(define-auto-insert
  '("\\.c\\|\\.cpp\\|\\.cc\\|\\.java\\'" . "C/C++/Java source file")
  '(nil
    "/*\n"
    "  File: " (file-name-nondirectory buffer-file-name)
    "  Time-stamp: <>\n\n"
    "  Copyright: " (substring (current-time-string) -4) " (C) "
    auto-insert-copyright "\n\n"
    "  Description:\n" _ "\n"
    "*/"))

;; Objective-C source file
(define-auto-insert
  '("\\.m$" . "Objective-C source file")
  '(nil
    "//\n"
    "// File: " (file-name-nondirectory buffer-file-name)
    " Time-stamp: <>\n//\n"
    "// Copyright: " (substring (current-time-string) -4) " (C) "
    auto-insert-copyright "\n//\n"
    "// Description:\n// " _ "\n"))

;; Lisp source file
(define-auto-insert
  '("\\.lisp\\'" . "Lisp source file")
  '(nil
    ";;; File: " (file-name-nondirectory buffer-file-name) "    -*- Mode: Lisp -*-\n"
    ";;; Time-stamp: <>\n;;;\n"
    ";;; Copyright: " (substring (current-time-string) -4) " (C) "
    auto-insert-copyright "\n;;;\n"
    ";;; Description:\n;;; " _ "\n"))

;; ASDF file
(define-auto-insert
  '("\\.asd\\'" . "ASDF file")
  '(nil
    ";;; File: " (file-name-nondirectory buffer-file-name) "    -*- Mode: Lisp -*-\n"
    ";;; Time-stamp: <>\n;;;\n"
    ";;; Copyright: " (substring (current-time-string) -4) " (C) "
    auto-insert-copyright "\n;;;\n"
    ";;; Description:\n;;; " _ "\n"))

;; Scheme source file
(setq auto-mode-alist (cons '("\\.ss$" . scheme-mode) auto-mode-alist))
(define-auto-insert
  '("\\.scm\\|\\.ss\\'" . "Scheme source file")
  '(nil
    ";;; File: " (file-name-nondirectory buffer-file-name) "    -*- Mode: Scheme -*-\n"
    ";;; Time-stamp: <>\n;;;\n"
    ";;; Copyright: " (substring (current-time-string) -4) " (C) "
    auto-insert-copyright "\n;;;\n"
    ";;; Description:\n;;; " _ "\n"))

;; Makefile
(define-auto-insert
  '("[Mm]akefile*\\'" . "Makefile")
  '(nil
    "# File: " (file-name-nondirectory buffer-file-name) "    -*- Mode: Makefile -*-\n"
    "# Time-stamp: <>\n#\n"
    "# Copyright: "  (substring (current-time-string) -4) " (C) "
    auto-insert-copyright "\n#\n"
    "# Description:\n# Makefile for " _ "\n"))

;; Perl
(define-auto-insert
  '("\\.pl\\'" . "Perl Program")
  '(nil
    "#! /usr/bin/perl -w\n# -*- Encoding: utf-8 -*-\n"
    "# File: " (file-name-nondirectory buffer-file-name) "\n"
    "# Time-stamp: <>\n#\n"
    "# Copyright: " (substring (current-time-string) -4) " (C) "
    auto-insert-copyright "\n#\n"
    (progn (save-buffer)
;;;            (shell-command (format "chmod +x %s" (buffer-file-name)))
           "")
    "# Description:\n# " _ "\n"))

;; Erlang source file
(define-auto-insert
  '("\\.erl\\'" . "Erlang source file")
  '(nil
    "%%% File: " (file-name-nondirectory buffer-file-name) "    -*- Mode: erlang -*-\n"
    "%%% Time-stamp: <>\n%%%\n"
    "%%% Copyright: " (substring (current-time-string) -4) " (C) "
    auto-insert-copyright "\n%%%\n"
    "%%% Description:\n%%% " _ "\n"))

;; Erlang header file
(define-auto-insert
  '("\\.hrl\\'" . "Erlang header file")
  '(nil
    "%%% File: " (file-name-nondirectory buffer-file-name) "    -*- Mode: erlang -*-\n"
    "%%% Time-stamp: <>\n%%%\n"
    "%%% Copyright: " (substring (current-time-string) -4) " (C) "
    auto-insert-copyright "\n%%%\n"
    "%%% Description:\n%%% " _ "\n"))

;; Python
(define-auto-insert
  '("\\.py\\'" . "Python Program")
  '(nil
    "# File: " (file-name-nondirectory buffer-file-name) " -*- Encoding: utf-8 -*-\n"
    "# Time-stamp: <>\n#\n"
    "# Copyright: " (substring (current-time-string) -4) " (C) "
    auto-insert-copyright "\n#\n"
    (progn (save-buffer)
;;;            (shell-command (format "chmod +x %s" (buffer-file-name)))
           "")
    "# Description:\n# " _ "\n"))

;; Ruby
(define-auto-insert
  '("\\.rb\\'" . "Ruby Program")
  '(nil
    "# File: " (file-name-nondirectory buffer-file-name)  " -*- Encoding: utf-8 -*-\n"
    "# Time-stamp: <>\n#\n"
    "# Copyright: " (substring (current-time-string) -4) " (C) "
    auto-insert-copyright "\n#\n"
    (progn (save-buffer)
;;;            (shell-command (format "chmod +x %s" (buffer-file-name)))
           "")
    "# Description:\n# " _ "\n"))

;; Io source file
(define-auto-insert
  '("\\.io\\'" . "Io source file")
  '(nil
    "// File: " (file-name-nondirectory buffer-file-name) "\n"
    "// Time-stamp: <>\n//\n"
    "// Copyright: " (substring (current-time-string) -4) " (C) "
    auto-insert-copyright "\n//\n"
    "// Description:\n// " _ "\n"))

;; Lua source file
(define-auto-insert
  '("\\.lua\\'" . "Lua source file")
  '(nil
    "-- File: " (file-name-nondirectory buffer-file-name) "\n"
    "-- Time-stamp: <>\n--\n"
    "-- Copyright: " (substring (current-time-string) -4) " (C) "
    auto-insert-copyright "\n--\n"
    "-- Description:\n-- " _ "\n"))

;; Hakell source file
(define-auto-insert
  '("\\.hs\\'" . "Haskell source file")
  '(nil
    "-- File: " (file-name-nondirectory buffer-file-name) "\n"
    "-- Time-stamp: <>\n--\n"
    "-- Copyright: " (substring (current-time-string) -4) " (C) "
    auto-insert-copyright "\n--\n"
    "-- Description:\n-- " _ "\n"))

;; Ocaml source file
(define-auto-insert
  '("\\.ml\\'" . "Ocaml source file")
  '(nil
    "(*\n"
    "  File: " (file-name-nondirectory buffer-file-name)
    "  Time-stamp: <>\n\n"
    "  Copyright: " (substring (current-time-string) -4) " (C) "
    auto-insert-copyright "\n\n"
    "  Description:\n" _ "\n"
    "*)"))

;; Setting proper hooks for c/c++-mode

;; I seldom need M-c (capitalize word) in C/C++
;; If you use many hooks, use command add-hook instead.
;; (require 'c-comment-edit)

;; (setq c++-mode-hook  'c++-my-hook)
;; (defun c++-my-hook ()
;;   (local-set-key "\M-c" 'c-comment-edit))

;; (setq c-mode-hook  'c-my-hook)
;; (defun c-my-hook ()
;;   (local-set-key "\M-c" 'c-comment-edit))

;; (setq c-coment-edit-after-hook 'untabify-buffer)
;; (defun untabify-buffer ()
;;   "C-comment-edit cleanup."
;;     ;;  To preserve indentation. Remember that C-comment markers are
;;     ;;  added to the beginning
;;     (untabify (point-min) (point-max)))

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
(tool-bar-mode nil)
(menu-bar-mode nil)
(scroll-bar-mode nil)
(setq scroll-bar-mode nil)

;; Show line number and column
(line-number-mode t)
(column-number-mode t)

;; Line number
;; (require 'wb-line-number)
;; (wb-line-number-toggle)

;; (add-to-list 'load-path "~/lisp/slime-2.0/")
;; (setq inferior-lisp-program "sbcl --noinform")       ; your Lisp system
;; (require 'slime)
;; (slime-setup)

;; Common Lisp indentation.
(autoload 'common-lisp-indent-function "cl-indent")
(setq lisp-indent-function 'common-lisp-indent-function)

;; (if window-system
;;     (autoload 'keisen-mode "keisen-mouse" "MULE table" t)
;;     (autoload 'keisen-mode "keisen-mule" "MULE table" t))

;; Pbook
;; (require 'pbook)

;; Session
(add-to-list 'load-path "~/.emacs.d/session/lisp/")
(require 'session)
(add-hook 'after-init-hook 'session-initialize)
(desktop-save-mode t)
(add-hook 'kill-emacs-hook '(lambda () (desktop-save "~/")))

;; I'm writing to Li Sen.
(let ((save-fill-column fill-column))
  (defun write-to-lisen ()
    "Change the fill-column value to 50."
    (interactive)
    (setq save-fill-column fill-column
          fill-column 50)
    (auto-fill-mode t))
  (defun write-to-lisen-stop ()
    "Restor the fill-column value."
    (interactive)
    (setq fill-column save-fill-column)))

(add-hook 'text-mode-hook 'write-to-lisen)

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
(defvar fortune-file "~/.emacs.d/fortune.txt"
  "The file that fortunes come from.")

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
    (open-fortune-file fortune-file)
    (kill-buffer (current-buffer)))
  (let* ((n (random (length fortune-strings)))
         (string (aref fortune-strings n)))
    (if (interactive-p)
        (message (format "%s" string))
      string)))

;; Override standard startup message
(defun startup-echo-area-message ()
  (fortune))

;; tpp-mode
(autoload 'tpp-mode "tpp-mode" "TPP mode." t)
(add-to-list 'auto-mode-alist '("\\.tpp$" . tpp-mode))

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

(autoload 'asp-mode "asp-mode")
(setq auto-mode-alist
      (cons '("\\.asp\\'" . asp-mode) auto-mode-alist))

(require 'haml-mode)
(require 'sass-mode)

;; YAML mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
