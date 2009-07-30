;;; ellets.el --- My Emacs Lisp snippets

;; Copyright (C) 2008  mrSPAMluanma(remove SPAM)

;; Author: Xiaohong Zhao <mrSPAMluanma(remove SPAM)@gmail.com>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

(eval-when-compile (require 'cl))
(require 'font-lock)

(defun type-watch-post-command-function ()
  ""
  (case this-command
    (self-insert-command
     (when (find (char-to-string (aref (buffer-substring (- (point) 1) (point)) 0))
                 '("。" "，" "；")
                 :test #'string=)
       (message "Watch out!  You just typed a watched character.")))))

;;;###autoload
(define-minor-mode type-watch-mode
    "Toggle type-watch minor mode.
With prefix arg, turn type watch  mode on if arg is positive.
"
  :lighter " Type-Watch"
  (if type-watch-mode
      (progn
        (add-hook 'post-command-hook 'type-watch-post-command-function t nil)
        ;; font-lock-lize the characters as a warning
        (font-lock-add-keywords
         nil
         '(("\\([。，；]\\)" 1 font-lock-warning-face t))))
      (remove-hook 'post-command-hook 'type-watch-post-command-function)))

;;; caps-lock-mode
(defvar caps-lock-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map [remap self-insert-command] 'self-insert-upcased)
    map))

(define-minor-mode caps-lock-mode
    "When enabled, convert all self-inserting characters to uppercase."
  :lighter " CapsLock")

(defun self-insert-upcased (arg)
  (interactive "p")
  (setq last-command-char (upcase last-command-char))
  (self-insert-command arg))

;;; neaten C or C++ file
(defun neaten-c-file ()
  "Takes a poorly-commented and poorly-indented C or C++ file, and
removes the comments (and possibly reindents it) so that it is
\(perhaps) comprehensible."
  (interactive)

  (when buffer-read-only
    (setq buffer-read-only nil)
    (auto-save-mode 0))

  (with-temp-message "Removing comments ..."
    (goto-char (point-min))

    (while (search-forward "/*" (point-max) t)

      ;; if our `/*' occurs anywhere but inside a comment -- like, e.g.,
      ;; a string constant -- do nothing.
      (if (eq 'c (c-in-literal))
          (let ((comment-start (- (point) 2)))
            (search-forward "*/")
            (delete-region comment-start (point)))))

    (goto-char (point-min))

    (while (re-search-forward (rx "//" (zero-or-more not-newline) eol) (point-max) t)

      (if (eq 'c++ (save-match-data (c-in-literal)))
          (replace-match "")))
    )
  (message "done")

  (with-temp-message "Calling `astyle' ... "
    ;; in case the file has carriage-returns at the ends of lines,
    ;; which might confuse `astyle': we ensure that we don't write
    ;; them out.
    (set-buffer-file-coding-system 'no-conversion)

    (call-process-region (point-min)
                         (point-max)
                         "astyle"
                         t t nil "--style=gnu"
                         "--convert-tabs"))
  (message "Done")

  (delete-trailing-whitespace)

  (goto-char (point-min))
  (flush-lines "^$")
  (while (looking-at "\\`\n+")
    (delete-char 1)))

(provide 'ellets)

;;; ellets.el ends here
