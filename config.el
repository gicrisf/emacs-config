;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; DO NOT EDIT THIS FILE DIRECTLY
;; This is a file generated from a literate programing source file located at
;; https://github.com/gicrisf/emacs-config
;; You should make any changes there and regenerate it from Emacs org-mode
;; using org-babel-tangle (C-c C-v t)

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "gicrisf"
      user-mail-address "giovanni.crisalfi@protonmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Noto Sans Mono" :size 16 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "sans" :size 16))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-city-lights)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Theme switcher functions
(defvar quick-switch-themes
  (let ((themes-list (list 'doom-city-lights
                           'doom-one
                           'spacemacs-light
                           'doom-one-light)))
    (nconc themes-list themes-list))
  "A circular list of themes to keep switching between.
Make sure that the currently enabled theme is at the head of this
list always.

A nil value implies no custom theme should be enabled.")

;; Thanks to narendraj9, user of emacs.stackexchange.com
;; https://emacs.stackexchange.com/questions/24088/make-a-function-to-toggle-themes
;; I just tweaked his code.
(defun toggle-theme ()
  (interactive)
  (if-let* ((next-theme (cadr quick-switch-themes)))
      (progn (when-let* ((current-theme (car quick-switch-themes)))
               (disable-theme (car quick-switch-themes)))
             (load-theme next-theme t)
             (message "Loaded theme: %s" next-theme))
    ;; Always have the dark mode-line theme
    (mapc #'disable-theme (delq 'smart-mode-line-dark custom-enabled-themes)))
  (setq quick-switch-themes (cdr quick-switch-themes)))

(map! :leader
      :desc "Quick toggle theme" "t t" #'toggle-theme)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Maximize the window upon startup
;; TODO testing this one
(setq initial-frame-alist '((top . 1) (left . 1) (width . 114) (height . 32)))

;; Transparency
(set-frame-parameter (selected-frame)'alpha '(99 . 100))
(add-to-list 'default-frame-alist'(alpha . (99 . 100)))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; org journal
;; in ~/.doom.d/+bindings.el
;; From: https://www.rousette.org.uk/archives/doom-emacs-tweaks-org-journal-and-org-super-agenda/
(map! :leader
      (:prefix ("j" . "journal") ;; org-journal bindings
        :desc "Create new journal entry" "j" #'org-journal-new-entry
        :desc "Open previous entry" "p" #'org-journal-open-previous-entry
        :desc "Open next entry" "n" #'org-journal-open-next-entry
        :desc "Search journal" "s" #'org-journal-search-forever))

;; The built-in calendar mode mappings for org-journal
;; conflict with evil bindings
(map!
 (:map calendar-mode-map
   :n "o" #'org-journal-display-entry
   :n "p" #'org-journal-previous-entry
   :n "n" #'org-journal-next-entry
   :n "O" #'org-journal-new-date-entry))

;; Local leader (<SPC m>) bindings for org-journal in calendar-mode
;; I was running out of bindings, and these are used less frequently
;; so it is convenient to have them under the local leader prefix
(map!
 :map (calendar-mode-map)
 :localleader
 "w" #'org-journal-search-calendar-week
 "m" #'org-journal-search-calendar-month
 "y" #'org-journal-search-calendar-year)

(setq org-journal-dir "~/org/amalgam")
(setq org-journal-file-format "%Y-%m.org")
(setq org-journal-file-type 'monthly)

;; (custom-set-variables '(wikinforg-wikipedia-edition-code "it"))

;; Generate ORG/Zola frontmatter
;; TODO Section management
;; MAYBE Add hook to org file IF hugo_base_dir or hugo_section is present at top
(defun org-zola-frontmatter (slug)
  "Insert org-mode properties under a paragraph to setup ox-hugo/zola exports"
  (interactive "sEnter slug: ")
  (insert ":PROPERTIES:\n"
          (concat ":EXPORT_HUGO_SECTION: 2022/" slug "\n")
          ":EXPORT_FILE_NAME: index\n"
          ":END:\n"))

;; add "CLOSED" when an item is set with DONE state
(setq org-log-done 'time)

;; org-capture
(setq org-capture-templates `(
	("p" "Protocol" entry (file+headline ,(concat org-directory "notes.org") "Inbox")
        "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
	("L" "Protocol Link" entry (file+headline ,(concat org-directory "notes.org") "Inbox")
        "* %? [[%:link][%:description]] \nCaptured On: %U")
))

(setq org-latex-logfiles-extensions (quote ("lof" "lot" "tex~" "aux" "idx" "log" "out" "toc" "nav" "snm" "vrb" "dvi" "fdb_latexmk" "blg" "brf" "fls" "entoc" "ps" "spl" "bbl" "xmpi" "run.xml" "bcf")))

(org-babel-do-load-languages
    'org-babel-load-languages
    '((d2 . t)))

(add-to-list 'exec-path "~/.local/bin/")

(require 'elfeed-goodies)
(elfeed-goodies/setup)
(setq elfeed-goodies/entry-pane-size 0.5)

;; Support for Typescript/React
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))

(add-hook 'dired-mode-hook 'org-download-enable)

;; Generate TOML frontmatter
(defun new-toml-frontmatter ()
  "Insert a TOML frontmatter for Markdown files"
  (interactive)
  (insert "+++\n"
          "title=\"\"\n"
          "date=\n"
          "\n"
          "[taxonomies]\n"
          "categories=[\"\"]\n"
          "tags=[\"\"]\n"
          "\n"
          "[extra]\n"
          "+++"))

(add-hook 'markdown-mode-hook
          (lambda ()
            (if (= (buffer-size) 0)
            (new-toml-frontmatter))
            (message "markdown hook")))

;; Generate Zola Shortcodes
(defun new-social-shortcode ()
  "Generate new twitter shortcode"
  (interactive)
  (insert "{% social\(\n"
          "social=\"tw\",\n"
          "url=\"\",\n"
          "author=\"\",\n"
          "date=\"\"\n"
          "\) %}"
          "\n"
          "{% end %}"))

(setq mastodon-instance-url "https://fosstodon.org"
      mastodon-active-user "gicrisf")

;; Play Lo-Fi
;; Implementation of the knuth shuffle
;; TODO Start amberol or other music player
(defun nshuffle (sequence)
  (cl-loop for i from (length sequence) downto 2
        do (cl-rotatef (elt sequence (random i))
                    (elt sequence (1- i))))
  sequence)

(setq lofi-links '("https://www.youtube.com/watch?v=8nXqcugV2Y4" ;; 3:30 music session
                   "https://www.youtube.com/watch?v=FVue6P2VoTc"
                   "https://www.youtube.com/watch?v=NrJiXKwUjPI" ;; Music to put you in a better mood
                   "https://www.youtube.com/watch?v=kgx4WGK0oNU"
                   "https://www.youtube.com/watch?v=5qap5aO4i9A"))

(setq vaporwave-links '("https://www.youtube.com/watch?v=nVCs83gSYD0"  ;; architecture in tokyo - Summer Paradise
                        ))

(defun play-lofi ()
  "Play random lofi music on your browser"
  (interactive)
  (shell-command (concat "python -mwebbrowser " (car (nshuffle lofi-links)))))

(defun play-vaporwave ()
  "Play random lofi music on your browser"
  (interactive)
  (shell-command (concat "python -mwebbrowser " (car (nshuffle vaporwave-links)))))

(defun bf-pretty-print-xml-region (begin end)
  "Pretty format XML markup in region. You need to have nxml-mode
http://www.emacswiki.org/cgi-bin/wiki/NxmlMode installed to do
this.  The function inserts linebreaks to separate tags that have
nothing but whitespace between them.  It then indents the markup
by using nxml's indentation rules."
  (interactive "r")
  (save-excursion
    (nxml-mode)
    (goto-char begin)
    (while (search-forward-regexp "\>[ \\t]*\<" nil t)
      (backward-char) (insert "\n") (setq end (1+ end)))
    (indent-region begin end)
    (normal-mode))
  (message "Ah, much better!"))

(setq which-key-idle-delay 0.5) ;; I need the help, I really do

;; (setq racer-rust-src-path "~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library")

(setq rustic-lsp-server 'rust-analyzer)

(after! lsp-rust
  (setq lsp-rust-server 'rust-analyzer))

(after! org
  ;; Import ox-latex to get org-latex-classes and other funcitonality
  ;; for exporting to LaTeX from org
  (use-package! ox-latex
    :init
    ;; code here will run immediately
    :config
    ;; code here will run after the package is loaded
    (setq org-latex-pdf-process
          '("pdflatex -interaction nonstopmode -output-directory %o %f"
            "bibtex %b"
            "pdflatex -interaction nonstopmode -output-directory %o %f"
            "pdflatex -interaction nonstopmode -output-directory %o %f"))
    (setq org-latex-with-hyperref nil) ;; stop org adding hypersetup{author..} to latex export
    ;; (setq org-latex-prefer-user-labels t)

    ;; deleted unwanted file extensions after latexMK
    ;; (setq org-latex-logfiles-extensions
    ;;      (quote ("lof" "lot" "tex~" "aux" "idx" "log" "out" "toc" "nav" "snm" "vrb" "dvi" "fdb_latexmk" "blg" "brf" "fls" "entoc" "ps" "spl" "bbl" "xmpi" "run.xml" "bcf" "acn" "acr" "alg" "glg" "gls" "ist")))

    (unless (boundp 'org-latex-classes)
      (setq org-latex-classes nil))))

(after! org
  (use-package! ox-extra
    :config
    (ox-extras-activate '(latex-header-blocks ignore-headlines))))

(add-hook 'Info-selection-hook 'info-colors-fontify-node)

(setq config-org-file-name "config.org"
      config-org-directory "~/.doom.d")

(defun open-config-org ()
  "Open your private config.org file."
  (interactive)
  (find-file (expand-file-name config-org-file-name config-org-directory)))

(map! :leader
      (:prefix-map ("o" . "open")
       :desc "Open your private config.org file." "c" #'open-config-org))

(setf (nth 5 +doom-dashboard-menu-sections) '("Open org configuration" :icon (all-the-icons-octicon "tools" :face 'doom-dashboard-menu-title) :action open-config-org))

(map! :leader
      (:prefix-map ("e" . "elfeed")
       :desc "Enter elfeed." "e" #'elfeed))

(setf (nth 2 +doom-dashboard-menu-sections) '("Open elfeed" :icon (all-the-icons-octicon "rss" :face 'doom-dashboard-menu-title) :action elfeed))

(map! :leader
      (:prefix-map ("e" . "elfeed")
       :desc "Update all the feeds in elfeed." "u" #'elfeed-update))

(map! :leader
      (:prefix-map ("q" . "quit/session")
       :desc "Switch to the dashboard in the current window, of the current FRAME." "h" #'+doom-dashboard/open))

(setf (nth 3 +doom-dashboard-menu-sections) '("Open info" :icon (all-the-icons-octicon "info" :face 'doom-dashboard-menu-title) :action info))

(setf (nth 0 +doom-dashboard-menu-sections) '("Open project" :icon (all-the-icons-octicon "briefcase" :face 'doom-dashboard-menu-title) :action projectile-switch-project))

(map! :leader
      (:prefix-map ("o" . "open")
       :desc "Open org manual." "i" #'org-info))

(setf (nth 6 +doom-dashboard-menu-sections) '("Doom documentation" :icon (all-the-icons-octicon "book" :face 'doom-dashboard-menu-title) :action doom/help))

(setq wttrin-default-cities '("Caltagirone" "Bologna" "Ferrara" "Catania"))
(setq wttrin-default-accept-language '("Accept-Language" . "it-IT"))

(defun mol2chemfig (mol)
  "Generate chemfig code from mol or SMILES."
  (interactive "sEnter molecule: ")
  (insert (shell-command-to-string (concat "python -m mol2chemfigPy3 -w -i direct " mol))))

(setq tochemfig-default-input "direct")
(setq tochemfig-default-relative-angles t)
(setq tochemfig-default-fancy-bonds t)
(setq tochemfig-default-wrap-chemfig t)

(use-package whisper
  :bind ("C-H-r" . whisper-run)
  :config
  (setq whisper-install-directory "/tmp/"
        whisper-model "base"
        whisper-language "en"
        whisper-translate nil))
