;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; DO NOT EDIT THIS FILE DIRECTLY
;; This is a file generated from a literate programing source file located at
;; https://github.com/gicrisf/emacs-config
;; You should make any changes there and regenerate it from Emacs org-mode
;; using org-babel-tangle (C-c C-v t)

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")

;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)

(package! spacemacs-theme)

(package! org-download)

(package! org-drill)

(package! anki-editor)

(package! org-journal)

(package! wikinforg)

;; (package! helm-org-rifle)

(package! org-web-tools)

(package! ox-hugo :recipe (:host github :repo "gicrisf/ox-zola"))

(package! citeproc)

(package! ob-d2 :recipe (:host github :repo "dmacvicar/ob-d2"))

(package! elfeed-goodies)

(package! vala-mode)

(package! pyvenv)

(package! eltweet :recipe (:host github :repo "gicrisf/eltweet"))

(package! mastodon)

(package! racer :disable t)

(package! info-colors)

(package! wttrin :recipe (:host github :repo "gicrisf/emacs-wttrin"))

(package! tochemfig :recipe (:host github :repo "gicrisf/tochemfig"))

(package! whisper)
