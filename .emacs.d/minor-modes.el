;;;  -*- Mode: emacs-lisp; Encoding: utf-8 -*-

;;; ----------------------------------------------------------------
;;; twisted-mode, Miles Bader <miles /at/ gnu.org>
(defvar twisted-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map [remap self-insert-command] 'self-insert-twisted)
    (define-key map [remap delete-backward-char] 'delete-char)
    (define-key map [remap backward-delete-char] 'delete-char)
    (define-key map [remap backward-delete-char-untabify] 'delete-char)
    map)
  "Keymap for `twisted-mode'.")

(define-minor-mode twisted-mode
  "When enabled, self-inserting characters are inserted in \"twisted\" form
   See the variable `twisted-mapping' for the mapping used."
  :lighter " pǝʇsᴉʍT")

(defvar twisted-mapping
  '((?a . ?ɐ) (?b . ?q) (?c . ?ɔ) (?d . ?p)
    (?e . ?ǝ)           (?g . ?ᵷ) (?h . ?ɥ)
    (?i . ?ᴉ)           (?k . ?ʞ) ;(?l . ?ꞁ)
    (?m . ?ɯ) (?n . ?u)            (?p . ?d)
    (?q . ?b) (?r . ?ɹ)           (?t . ?ʇ)
    (?u . ?n) (?v . ?ʌ) (?w . ?ʍ)
    (?y . ?ʎ)
    (?, . ?‘) (?' . ?‚)
    (?. . ?˙) (?? . ?¿) (?! . ?¡)
    (?( . ?)) (?) . ?() (?[ . ?]) (?] . ?[)
    (?< . ?>) (?> . ?<)
    (?“ . ?„)
    )
  "Mapping from normal characters to twisted characters used by `self-insert-twisted'.")

(defun self-insert-twisted (arg)
  "Like `self-insert-command', but try to insert a twisted variant.
   The mapping from normal character to twisted characters is taken
   from `twisted-mapping'."
  (interactive "p")
  (setq last-command-event
        (or (cdr (assq last-command-event twisted-mapping))
            last-command-event))
  (self-insert-command arg)
  (backward-char arg))

;;; ----------------------------------------------------------------
;;; caps-lock-mode, Miles Bader <miles /at/ gnu.org>
(defvar caps-lock-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map [remap self-insert-command] 'self-insert-upcased)
    map))

(define-minor-mode caps-lock-mode
  "When enabled, convert all self-inserting characters to uppercase."
  :lighter " CapsLock")

(defun self-insert-upcased (arg)
  (interactive "p")
  (setq last-command-event (upcase last-command-event))
  (self-insert-command arg))

;;; ----------------------------------------------------------------
;;; literal-tab-mode, Miles Bader <miles /at/ gnu.org>
(defvar literal-tab-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map [?\t] 'self-insert-command)
    map))

(define-minor-mode literal-tab-mode
  "When enabled, force the TAB key to insert a literal tab character."
  :lighter " LitTab")

(define-globalized-minor-mode global-literal-tab-mode literal-tab-mode
  turn-on-literal-tab-mode)

(defun turn-on-literal-tab-mode () (literal-tab-mode 1))

;;; ----------------------------------------------------------------
;;; list-fonts-display, Miles Bader <miles@gnu.org>
(defun list-fonts-display (&optional matching)
  "Display a list of font-families available via font-config, in a new buffer.
   If the optional argument MATCHING is non-nil, only font families
   matching that regexp are displayed; interactively, a prefix
   argument will prompt for the regexp.
   The name of each font family is displayed using that family, as
   well as in the default font (to handle the case where a font
   cannot be used to display its own name)."
  (interactive
   (list
    (and current-prefix-arg
         (read-string "Display font families matching regexp: "))))
  (let (families)
    (with-temp-buffer
      (shell-command "fc-list : family" t)
      (goto-char (point-min))
      (while (not (eobp))
        (let ((fam (buffer-substring (line-beginning-position)
                                     (line-end-position))))
          (when (or (null matching) (string-match matching fam))
            (push fam families)))
        (forward-line)))
    (setq families
          (sort families
                (lambda (x y) (string-lessp (downcase x) (downcase y)))))
    (let ((buf (get-buffer-create "*Font Families*")))
      (with-current-buffer buf
        (erase-buffer)
        (dolist (family families)
          ;; We need to pick one of the comma-separated names to
          ;; actually use the font; choose the longest one because some
          ;; fonts have ambiguous general names as well as specific
          ;; ones.
          (let ((family-name
                 (car (sort (split-string family ",")
                            (lambda (x y) (> (length x) (length y))))))
                (nice-family (replace-regexp-in-string "," ", " family)))
            (insert (concat (propertize nice-family
                                        'face (list :family family-name))
                            " (" nice-family ")"))
            (newline)))
        (goto-char (point-min)))
      (display-buffer buf))))

;; --------------------------------------------------------
;; nice little alternative visual bell; Miles Bader <miles /at/ gnu.org>
(defcustom echo-area-bell-string "*DING* " ;"♪"
  "Message displayed in mode-line by `echo-area-bell' function."
  :group 'user)
(defcustom echo-area-bell-delay 0.1
  "Number of seconds `echo-area-bell' displays its message."
  :group 'user)
;; internal variables
(defvar echo-area-bell-cached-string nil)
(defvar echo-area-bell-propertized-string nil)
(defun echo-area-bell ()
  "Briefly display a highlighted message in the echo-area.
    The string displayed is the value of `echo-area-bell-string',
    with a red background; the background highlighting extends to the
    right margin.  The string is displayed for `echo-area-bell-delay'
    seconds.
    This function is intended to be used as a value of `ring-bell-function'."
  (unless (equal echo-area-bell-string echo-area-bell-cached-string)
    (setq echo-area-bell-propertized-string
          (propertize
           (concat
            (propertize
             "x"
             'display
             `(space :align-to (- right ,(+ 2 (length echo-area-bell-string)))))
            echo-area-bell-string)
           'face '(:background "red")))
    (setq echo-area-bell-cached-string echo-area-bell-string))
  (message echo-area-bell-propertized-string)
  (sit-for echo-area-bell-delay)
  (message ""))
(setq ring-bell-function 'echo-area-bell)

(provide 'minor-modes)
