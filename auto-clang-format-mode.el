;;; auto-clang-format-mode.el --- Emacs
;;
;; Copyright (C) 2019 Joel Rosdahl
;;
;; Author: Joel Rosdahl <joel@rosdahl.net>
;; Version: 1.0
;; License: BSD-3-clause
;; Package-Requires: ((clang-format "20180406.1514"))
;; URL: https://github.com/jrosdahl/auto-clang-format-mode
;;
;; Redistribution and use in source and binary forms, with or without
;; modification, are permitted provided that the following conditions are met:
;;
;; * Redistributions of source code must retain the above copyright notice,
;;   this list of conditions and the following disclaimer.
;;
;; * Redistributions in binary form must reproduce the above copyright notice,
;;   this list of conditions and the following disclaimer in the documentation
;;   and/or other materials provided with the distribution.
;;
;; * Neither the name of the copyright holder nor the names of its contributors
;;   may be used to endorse or promote products derived from this software
;;   without specific prior written permission.
;;
;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
;; AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;; IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;; ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
;; LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
;; CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
;; SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;; INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
;; CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;; ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
;; POSSIBILITY OF SUCH DAMAGE.
;;
;; ============================================================================
;;
;;; Commentary:
;;
;; auto-clang-format-mode is a minor mode that runs clang-format-buffer
;; before the buffer is saved to its file.
;;
;; INSTALLATION
;; ============
;;
;; auto-clang-format-mode depends on the clang-format package, which can be
;; found here:
;;
;;   https://melpa.org/#/clang-format
;;
;; To load and enable auto-clang-format-mode, put something like this in your
;; Emacs configuration:
;;
;;   (require 'auto-clang-format-mode)
;;   (add-hook 'c++-mode-hook 'auto-clang-format-mode)
;;
;; CONFIGURATION
;; =============
;;
;; * auto-clang-format-mode-enable-p-function (default:
;;   auto-clang-format-mode-default-enable-p)
;;
;;   A function that should return non-nil if clang-format-buffer should be
;;   called when the mode is active, otherwise nil. The default function makes
;;   sure that clang-format-buffer is not called if clang-format-style is 'file
;;   (which is the default) but no .clang-format file is present.

;;; Code:

(require 'clang-format)

(defcustom auto-clang-format-mode-enable-p-function
  'auto-clang-format-mode-default-enable-p
  "A function that determines whether `clang-format-buffer'
should be called on buffer save."
  :group 'auto-clang-format-mode
  :type '(choice (const auto-clang-format-mode-default-enable-p)
                 function))

(defun auto-clang-format-mode-default-enable-p ()
  "If `clang-format-style' is 'file, only run
`clang-format-buffer' on save if a .clang-format file is found."
  (or (not (string= clang-format-style "file"))
      (locate-dominating-file "." ".clang-format")))

(defun auto-clang-format-mode--before-save ()
  (when (funcall auto-clang-format-mode-enable-p-function)
    (clang-format-buffer)))

;;;###autoload
(define-minor-mode auto-clang-format-mode
  "Toggle `auto-clang-format-mode'.

With a prefix argument ARG, enable `auto-clang-format-mode' if
ARG is positive, and disable it otherwise. If called from Lisp,
enable the mode if ARG is omitted or nil.

When `auto-clang-format-mode' is enabled, `clang-format-buffer'
will be run before the buffer is saved to its file."
  :init-value nil
  :lighter " ACF"
  (if auto-clang-format-mode
      (add-hook 'before-save-hook 'auto-clang-format-mode--before-save nil t)
    (remove-hook 'before-save-hook 'auto-clang-format-mode--before-save t)))

(defun turn-on-auto-clang-format-mode ()
  (clang-format-buffer)
  (auto-clang-format-mode 1))

(provide 'auto-clang-format-mode)
