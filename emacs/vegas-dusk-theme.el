;;; vegas-dusk-theme.el --- Dark theme inspired by desert dusk skyline -*- lexical-binding: t; -*-

;;; Commentary:
;; A dark theme derived from a Las Vegas desert dusk palette, balanced for
;; perceptual contrast and syntax differentiation.

;;; Code:

(deftheme vegas-dusk
  "Dark theme inspired by a desert dusk skyline.")

(let (;; Solid background & UI surfaces
      (bg-main      "#100812") ; Deep obsidian-plum base
      (bg-dim       "#170D1B") ; Code blocks, subtle secondary background
      (bg-plum      "#241930") ; hl-line, popups, inactive mode-line
      (bg-violet    "#34254A") ; Region selection
      (bg-indigo-1  "#1F1D43") ; Subtle borders, hunk headers
      (bg-indigo-2  "#27234A") ; Active mode-line, completion selection
      (bg-indigo-3  "#322D5E") ; Search match & symbol highlight surface
      (border       "#3A2D4C") ; Window dividers and popup borders

      ;; Semantic background tints (Diffs & Diagnostics)
      (bg-err       "#2B1013") ; Error / diff-removed background
      (bg-err-hl    "#4A191E") ; Refined diff-removed highlight
      (bg-ok        "#192318") ; Diff-added background
      (bg-ok-hl     "#273824") ; Refined diff-added highlight
      (bg-warn      "#2B2113") ; Warning background tint

      ;; Foregrounds
      (fg-main      "#CAC2B6") ; Primary text (10.8:1)
      (fg-dim       "#A3998A") ; Secondary text, variables, punctuation (6.9:1)
      (fg-muted     "#7D6058") ; Comments, line numbers, shadow (3.5:1)

      ;; Syntax & Semantic Accents
      (gold-bright  "#D6AF4B") ; Functions, methods, headings (9.2:1)
      (gold-ochre   "#B5913B") ; Properties, fields, attributes (6.6:1)
      (tan          "#B8A372") ; Strings, docstrings (8.0:1)
      (orange       "#D4732A") ; Keywords, operators (5.8:1)
      (bronze       "#B87B48") ; Builtins, preprocessor, escape chars (5.6:1)
      (lavender     "#948EC9") ; Types, classes, interfaces (6.5:1)
      (slate-blue   "#7A96B8") ; Constants, numbers, booleans (6.4:1)
      (crimson      "#D14D41") ; Errors, deletions (4.8:1)
      (sage         "#8FA86A")) ; Success, additions, staged changes (7.1:1)

  (custom-theme-set-faces
   'vegas-dusk

   ;; --- Core UI & Frame ---
   `(default ((t (:background ,bg-main :foreground ,fg-main))))
   `(cursor ((t (:background ,gold-bright :foreground ,bg-main))))
   `(region ((t (:background ,bg-violet :extend t))))
   `(highlight ((t (:background ,bg-indigo-2))))
   `(hl-line ((t (:background ,bg-plum :extend t))))
   `(fringe ((t (:background ,bg-main :foreground ,fg-muted))))
   `(vertical-border ((t (:foreground ,border))))
   `(window-divider ((t (:foreground ,border))))
   `(window-divider-first-pixel ((t (:foreground ,border))))
   `(window-divider-last-pixel ((t (:foreground ,border))))
   `(minibuffer-prompt ((t (:foreground ,gold-bright :weight bold))))
   `(shadow ((t (:foreground ,fg-muted))))
   `(secondary-selection ((t (:background ,bg-indigo-1 :extend t))))
   `(trailing-whitespace ((t (:background ,bg-err-hl))))
   `(escape-glyph ((t (:foreground ,bronze :weight bold))))
   `(homoglyph ((t (:foreground ,bronze))))

   ;; --- Semantic Status ---
   `(error ((t (:foreground ,crimson :weight bold))))
   `(warning ((t (:foreground ,orange :weight bold))))
   `(success ((t (:foreground ,sage :weight bold))))
   `(link ((t (:foreground ,slate-blue :underline t))))
   `(link-visited ((t (:foreground ,lavender :underline t))))

   ;; --- Line Numbers ---
   `(line-number ((t (:background ,bg-main :foreground ,fg-muted))))
   `(line-number-current-line ((t (:background ,bg-plum :foreground ,gold-bright :weight bold))))

   ;; --- Mode Line & Header Line ---
   `(mode-line ((t (:background ,bg-indigo-2 :foreground ,fg-main :box (:line-width 1 :color ,border)))))
   `(mode-line-inactive ((t (:background ,bg-dim :foreground ,fg-muted :box (:line-width 1 :color ,bg-plum)))))
   `(mode-line-buffer-id ((t (:foreground ,gold-bright :weight bold))))
   `(mode-line-emphasis ((t (:foreground ,tan :weight bold))))
   `(header-line ((t (:background ,bg-dim :foreground ,fg-main :box (:line-width 1 :color ,bg-plum)))))

   ;; --- Doom Modeline ---
   `(doom-modeline-bar ((t (:background ,gold-bright))))
   `(doom-modeline-bar-inactive ((t (:background ,fg-muted))))
   `(doom-modeline-buffer-file ((t (:foreground ,fg-main :weight bold))))
   `(doom-modeline-buffer-modified ((t (:foreground ,crimson :weight bold))))
   `(doom-modeline-project-dir ((t (:foreground ,gold-ochre :weight bold))))
   `(doom-modeline-info ((t (:foreground ,sage))))
   `(doom-modeline-warning ((t (:foreground ,orange))))
   `(doom-modeline-urgent ((t (:foreground ,crimson :weight bold))))

   ;; --- Search & Matching ---
   `(isearch ((t (:background ,gold-bright :foreground ,bg-main :weight bold))))
   `(isearch-fail ((t (:background ,bg-err-hl :foreground ,crimson :weight bold))))
   `(lazy-highlight ((t (:background ,bg-indigo-3 :foreground ,fg-main))))
   `(match ((t (:background ,bg-indigo-3 :foreground ,gold-bright :weight bold))))
   `(show-paren-match ((t (:background ,bg-indigo-3 :foreground ,gold-bright :weight bold))))
   `(show-paren-mismatch ((t (:background ,crimson :foreground ,bg-main :weight bold))))

   ;; --- Syntax Highlighting (Font Lock & Emacs 29+ Tree-sitter) ---
   `(font-lock-comment-face ((t (:foreground ,fg-muted :slant italic))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,fg-muted :slant italic))))
   `(font-lock-doc-face ((t (:foreground ,tan :slant italic))))
   `(font-lock-doc-markup-face ((t (:foreground ,bronze :slant italic))))
   `(font-lock-string-face ((t (:foreground ,tan))))
   `(font-lock-keyword-face ((t (:foreground ,orange :weight semi-bold))))
   `(font-lock-builtin-face ((t (:foreground ,bronze))))
   `(font-lock-function-name-face ((t (:foreground ,gold-bright :weight semi-bold))))
   `(font-lock-function-call-face ((t (:foreground ,gold-bright))))
   `(font-lock-variable-name-face ((t (:foreground ,fg-main))))
   `(font-lock-variable-use-face ((t (:foreground ,fg-dim))))
   `(font-lock-property-name-face ((t (:foreground ,gold-ochre))))
   `(font-lock-property-use-face ((t (:foreground ,gold-ochre))))
   `(font-lock-type-face ((t (:foreground ,lavender))))
   `(font-lock-constant-face ((t (:foreground ,slate-blue))))
   `(font-lock-number-face ((t (:foreground ,slate-blue))))
   `(font-lock-operator-face ((t (:foreground ,orange))))
   `(font-lock-preprocessor-face ((t (:foreground ,bronze))))
   `(font-lock-escape-face ((t (:foreground ,bronze :weight bold))))
   `(font-lock-regexp-grouping-backslash ((t (:foreground ,bronze :weight bold))))
   `(font-lock-regexp-grouping-construct ((t (:foreground ,lavender :weight bold))))
   `(font-lock-punctuation-face ((t (:foreground ,fg-dim))))
   `(font-lock-bracket-face ((t (:foreground ,fg-dim))))
   `(font-lock-delimiter-face ((t (:foreground ,fg-dim))))
   `(font-lock-misc-punctuation-face ((t (:foreground ,fg-dim))))
   `(font-lock-warning-face ((t (:foreground ,orange :background ,bg-warn :weight bold))))
   `(font-lock-negation-char-face ((t (:foreground ,crimson :weight bold))))

   ;; --- Minad Stack (Vertico, Corfu, Orderless, Consult, Marginalia, Embark) ---
   `(vertico-current ((t (:background ,bg-indigo-2 :foreground ,fg-main :weight semi-bold :extend t))))
   `(corfu-default ((t (:background ,bg-plum :foreground ,fg-main))))
   `(corfu-current ((t (:background ,bg-indigo-2 :foreground ,gold-bright :weight semi-bold))))
   `(corfu-bar ((t (:background ,fg-muted))))
   `(corfu-border ((t (:background ,border))))
   `(corfu-annotations ((t (:foreground ,fg-muted :slant italic))))
   `(orderless-match-face-0 ((t (:foreground ,gold-bright :weight bold))))
   `(orderless-match-face-1 ((t (:foreground ,orange :weight bold))))
   `(orderless-match-face-2 ((t (:foreground ,lavender :weight bold))))
   `(orderless-match-face-3 ((t (:foreground ,slate-blue :weight bold))))
   `(marginalia-documentation ((t (:foreground ,fg-muted :slant italic))))
   `(marginalia-key ((t (:foreground ,orange))))
   `(marginalia-type ((t (:foreground ,lavender))))
   `(marginalia-size ((t (:foreground ,slate-blue))))
   `(consult-file ((t (:foreground ,fg-main))))
   `(consult-bookmark ((t (:foreground ,gold-ochre))))
   `(consult-line-number ((t (:foreground ,fg-muted))))
   `(consult-preview-match ((t (:background ,bg-indigo-3 :foreground ,gold-bright :weight bold))))
   `(embark-target ((t (:background ,bg-indigo-3 :foreground ,gold-bright :weight bold))))
   `(embark-keybinding ((t (:foreground ,orange :weight bold))))

   ;; --- Tempel ---
   `(tempel-field ((t (:background ,bg-indigo-1 :foreground ,gold-bright :box (:line-width -1 :color ,border)))))
   `(tempel-form ((t (:background ,bg-plum :foreground ,lavender))))
   `(tempel-default ((t (:background ,bg-plum :foreground ,fg-dim :slant italic))))

   ;; --- Eglot & Flymake ---
   `(eglot-highlight-symbol-face ((t (:background ,bg-indigo-2 :underline (:color ,border)))))
   `(eglot-diagnostic-tag-unnecessary-face ((t (:foreground ,fg-muted :underline (:style wave :color ,fg-muted)))))
   `(eglot-diagnostic-tag-deprecated-face ((t (:foreground ,fg-muted :strike-through t))))
   `(flymake-error ((t (:underline (:style wave :color ,crimson)))))
   `(flymake-warning ((t (:underline (:style wave :color ,orange)))))
   `(flymake-note ((t (:underline (:style wave :color ,slate-blue)))))

   ;; --- Magit & Diff ---
   `(magit-section-heading ((t (:foreground ,gold-bright :weight bold))))
   `(magit-section-highlight ((t (:background ,bg-plum :extend t))))
   `(magit-branch-local ((t (:foreground ,slate-blue :weight bold))))
   `(magit-branch-remote ((t (:foreground ,sage :weight bold))))
   `(magit-tag ((t (:foreground ,gold-ochre))))
   `(magit-hash ((t (:foreground ,fg-muted))))
   `(magit-diff-file-heading ((t (:foreground ,fg-main :weight bold))))
   `(magit-diff-hunk-heading ((t (:background ,bg-indigo-1 :foreground ,fg-dim :extend t))))
   `(magit-diff-hunk-heading-highlight ((t (:background ,bg-indigo-2 :foreground ,gold-bright :weight bold :extend t))))
   `(magit-diff-context ((t (:foreground ,fg-dim))))
   `(magit-diff-context-highlight ((t (:background ,bg-dim :foreground ,fg-main :extend t))))
   `(magit-diff-added ((t (:background ,bg-ok :foreground ,sage :extend t))))
   `(magit-diff-added-highlight ((t (:background ,bg-ok-hl :foreground ,sage :weight semi-bold :extend t))))
   `(magit-diff-removed ((t (:background ,bg-err :foreground ,crimson :extend t))))
   `(magit-diff-removed-highlight ((t (:background ,bg-err-hl :foreground ,crimson :weight semi-bold :extend t))))
   `(diff-added ((t (:background ,bg-ok :foreground ,sage :extend t))))
   `(diff-removed ((t (:background ,bg-err :foreground ,crimson :extend t))))
   `(diff-refine-added ((t (:background ,bg-ok-hl :foreground ,fg-main :weight bold))))
   `(diff-refine-removed ((t (:background ,bg-err-hl :foreground ,fg-main :weight bold))))

   ;; --- Dired & Compilation ---
   `(dired-directory ((t (:foreground ,gold-bright :weight bold))))
   `(dired-symlink ((t (:foreground ,slate-blue :slant italic))))
   `(dired-flagged ((t (:foreground ,crimson :weight bold))))
   `(dired-marked ((t (:foreground ,sage :weight bold))))
   `(compilation-info ((t (:foreground ,sage))))
   `(compilation-warning ((t (:foreground ,orange))))
   `(compilation-error ((t (:foreground ,crimson :weight bold))))
   `(compilation-mode-line-run ((t (:foreground ,gold-bright :weight bold))))

   ;; --- Org / Outline / Markdown ---
   `(outline-1 ((t (:foreground ,gold-bright :weight bold))))
   `(outline-2 ((t (:foreground ,orange :weight bold))))
   `(outline-3 ((t (:foreground ,lavender :weight bold))))
   `(outline-4 ((t (:foreground ,slate-blue :weight bold))))
   `(outline-5 ((t (:foreground ,tan :weight bold))))
   `(org-code ((t (:foreground ,bronze :background ,bg-dim))))
   `(org-verbatim ((t (:foreground ,tan :background ,bg-dim))))
   `(org-block ((t (:background ,bg-dim :extend t))))
   `(org-block-begin-line ((t (:background ,bg-dim :foreground ,fg-muted :slant italic :extend t))))
   `(org-block-end-line ((t (:background ,bg-dim :foreground ,fg-muted :slant italic :extend t))))
   `(org-todo ((t (:foreground ,crimson :weight bold))))
   `(org-done ((t (:foreground ,sage :weight bold))))

   ;; --- ANSI Colors (Eshell, Comint, Vterm, Term) ---
   `(ansi-color-black ((t (:foreground ,bg-main :background ,bg-main))))
   `(ansi-color-red ((t (:foreground ,crimson :background ,crimson))))
   `(ansi-color-green ((t (:foreground ,sage :background ,sage))))
   `(ansi-color-yellow ((t (:foreground ,gold-bright :background ,gold-bright))))
   `(ansi-color-blue ((t (:foreground ,slate-blue :background ,slate-blue))))
   `(ansi-color-magenta ((t (:foreground ,lavender :background ,lavender))))
   `(ansi-color-cyan ((t (:foreground ,bronze :background ,bronze))))
   `(ansi-color-white ((t (:foreground ,fg-main :background ,fg-main))))
   `(ansi-color-bright-black ((t (:foreground ,fg-muted :background ,fg-muted))))
   `(ansi-color-bright-red ((t (:foreground ,orange :background ,orange))))
   `(ansi-color-bright-green ((t (:foreground ,sage :background ,sage))))
   `(ansi-color-bright-yellow ((t (:foreground ,gold-bright :background ,gold-bright))))
   `(ansi-color-bright-blue ((t (:foreground ,slate-blue :background ,slate-blue))))
   `(ansi-color-bright-magenta ((t (:foreground ,lavender :background ,lavender))))
   `(ansi-color-bright-cyan ((t (:foreground ,tan :background ,tan))))
   `(ansi-color-bright-white ((t (:foreground ,fg-main :background ,fg-main))))))

;;;###autoload
(when (and (boundp 'custom-theme-load-path) load-file-name)
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'vegas-dusk)
;;; vegas-dusk-theme.el ends here
