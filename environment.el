(defun environment--path-from-home (path)
  (setq-local home (getenv "HOME"))
  (concat (file-name-as-directory home) path))

(defun environment--append-path (path)
  (setq-local current-path (getenv "PATH"))
  (concat current-path ":" path))

;; Deno
(setenv "DENO_INSTALL" (environment--path-from-home ".deno"))
(setenv "PATH" (environment--append-path (environment--path-from-home ".deno/bin")))

;; Yarn tools
(setenv "PATH" (environment--append-path (environment--path-from-home ".yarn/bin")))

;; PNPM tools
(setenv "PNPM_HOME" (environment--append-path (environment--path-from-home ".local/share/pnpm")))
(setenv "PATH" (environment--append-path (getenv "PNPM_HOME")))

;; Android tools
(setenv "PATH" (environment--append-path (environment--path-from-home "Android/Sdk/bin")))

;; Flutter
(setenv "PATH" (environment--append-path (environment--path-from-home ".pub-cache/bin")))
(setenv "CHROME_EXECUTABLE" "brave")

;; Golang
(setenv "GOARCH" "amd64")
(setenv "GOPATH" (environment--path-from-home "Repositories/GO"))
(setenv "PATH" (environment--append-path (concat (getenv "GOPATH") "/bin")))
(setenv "PATH" (environment--append-path (concat (getenv "GOROOT") "/bin")))

;; Rust
(setenv "PATH" (environment--append-path (environment--path-from-home ".cargo/bin")))
