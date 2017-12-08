;;; init.el --- Where all the magic begins
;;
;; This file loads Org-mode and then loads the rest of our Emacs initialization from Emacs lisp
;; embedded in literate Org-mode files.

;; Load up Org Mode and (now included) Org Babel for elisp embedded in Org Mode files
(package-initialize)
(require 'org-install)
(require 'org)
(setq dotfiles-dir (file-name-directory (or (buffer-file-name) load-file-name)))
(setq bootstrap-dir (expand-file-name "bootstrap" dotfiles-dir))
(add-to-list 'load-path bootstrap-dir)

(let* ((org-dir (expand-file-name
                 "lisp" (expand-file-name
                         "org-mode" (expand-file-name
                                "src" dotfiles-dir))))
       (org-contrib-dir (expand-file-name
                         "lisp" (expand-file-name
                                 "contrib" (expand-file-name
                                            ".." org-dir))))
       (load-path (append (list org-dir org-contrib-dir)
                          (or load-path nil))))
  ;; load up Org-mode and Org-babel
  (require 'org-install)
  (require 'ob-tangle)
)

;; Load any libraries (anything in extras/*.org) first, so
;; we can use it in our own files
(setq zmalltalker-extras-dir (expand-file-name "extras" dotfiles-dir))
(setq zmalltalker-extras-files (directory-files zmalltalker-extras-dir t "\\.org$"))

(defun zmalltalker-literal-load-file (file)
  "Load an org file from ~/.emacs.d/extras - assuming it contains
code blocks which can be tangled"
  (org-babel-load-file (expand-file-name file
                                         zmalltalker-extras-dir)))

(mapc #'zmalltalker-literal-load-file zmalltalker-extras-files)


(add-to-list 'load-path zmalltalker-extras-dir)

;; load up all literate org-mode files in the bootstrap directory
(mapc #'org-babel-load-file (directory-files bootstrap-dir t "\\.org$"))


;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(coffee-command "/opt/node/bin/node /opt/node/bin/coffee")
 '(coffee-tab-width 2)
 '(column-number-mode t)
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#657b83")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes (quote (sanityinc-tomorrow-eighties)))
 '(custom-safe-themes
   (quote
    ("1a1a45e7c59a010f05a73a628df26734319ae918c2bbe2231ac2656b04e6667d" "ba6d8b7d5e7a87eda72464b1f57039da08793d2f52f813485965b7183c183080" "f5b591870422cd28da334552aae915cdcae3edfcfedb6653a9f42ed84bbec69f" "6ee6f99dc6219b65f67e04149c79ea316ca4bcd769a9e904030d38908fd7ccf9" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "52b5da0a421b020e2d3429f1d4929089d18a56e8e43fe7470af2cea5a6c96443" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "88bce56c65a570e04a01ef3908aac348448f0bb9a3922a3f595e555e8cf0705f" "36a309985a0f9ed1a0c3a69625802f87dee940767c9e200b89cdebdb737e5b29" "501caa208affa1145ccbb4b74b6cd66c3091e41c5bb66c677feda9def5eab19c" "72cc9ae08503b8e977801c6d6ec17043b55313cda34bcf0e6921f2f04cf2da56" default)))
 '(go-guru-debug t)
 '(gud-gdb-command-name "gdb --annotate=1")
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#fdf6e3" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#586e75")
 '(hl-bg-colors
   (quote
    ("#DEB542" "#F2804F" "#FF6E64" "#F771AC" "#9EA0E5" "#69B7F0" "#69CABF" "#B4C342")))
 '(hl-fg-colors
   (quote
    ("#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3")))
 '(large-file-warning-threshold nil)
 '(make-backup-files nil)
 '(menu-bar-mode nil)
 '(mu4e-mu-binary "/opt/mu/bin/mu")
 '(org-agenda-files (quote ("~/org/gtd.org")))
 '(org-babel-load-languages (quote ((emacs-lisp . t) (ruby . t))))
 '(org-confirm-babel-evaluate nil)
 '(safe-local-variable-values
   (quote
    ((eval setq exec-path
	   (append exec-path
		   (\`
		    ((\, project-gobin)
		     (\, "/Users/nfair/quant-src/kamke/go-1.7.3/bin")))))
     (eval setenv "GOROOT" "/Users/nfair/quant-src/kamke/go-1.7.3")
     (eval setenv "GOPATH"
	   (format "%s:%s:%s:%s" project-gopath project-rootpath vendor-go gb-src))
     (eval setq gb-src
	   (string-join
	    (directory-files "~/.gb/cache" 1 "^[0-9a-z].*")
	    ":"))
     (eval setq vendor-go
	   (concatenate
	    (quote string)
	    project-rootpath "vendor"))
     (eval setenv "GOPATH"
	   (format "%s:%s" project-gopath project-rootpath))
     (eval setq project-go-src
	   (concatenate
	    (quote string)
	    project-rootpath "src"))
     (eval setq compile-command
	   (format "%s/gb build && %s/gb test -v" project-gobin project-gobin))
     (eval setq project-gobin
	   (concatenate
	    (quote string)
	    project-gopath "/bin"))
     (eval make-local-variable
	   (quote compile-command))
     (eval message "new GOPATH `%s'"
	   (getenv "GOPATH"))
     (eval message "here 4")
     (eval setq exec-path
	   (append exec-path
		   (\`
		    ((\, project-gobin)))))
     (eval setenv "GOPATH" project-gopath)
     (eval setq project-gobin
	   (concatenate
	    (quote string)
	    project-gopath "bin"))
     (eval setq project-gopath
	   (concatenate
	    (quote string)
	    project-rootpath "build"))
     (eval setq project-rootpath
	   (replace-regexp-in-string "~"
				     (getenv "HOME")
				     (locate-dominating-file buffer-file-name ".dir-locals.el")))
     (eval make-local-variable
	   (quote project-rootpath))
     (eval make-local-variable
	   (quote exec-path))
     (eval make-local-variable
	   (quote process-environment))
     (encoding . utf-8)
     (encoding . binary))))
 '(show-paren-mode t)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(term-default-bg-color "#fdf6e3")
 '(term-default-fg-color "#657b83")
 '(tool-bar-mode nil))

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-done ((t (:foreground "PaleGreen" :weight normal :strike-through t))))
 '(org-headline-done ((((class color) (min-colors 16) (background dark)) (:foreground "LightSalmon" :strike-through t)))))
