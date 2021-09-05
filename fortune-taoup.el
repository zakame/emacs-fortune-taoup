;;; fortune-taoup.el --- Fortune cookies from taoup -*- lexical-binding: t -*-

;; Copyright (C) 2021 Zak B. Elep

;; URL                     : https://github.com/zakame/emacs-fortune-taoup
;; Author                  : Zak B. Elep <zakame@zakame.net>
;; Version                 : 0.0.1
;; Date Created            : Sun Sep  5 12:25:11 UTC 2021
;; Keywords                : games
;; Package-Requires        : ((emacs "24.4") (xterm-color "2.0"))

;; This file is NOT part of GNU Emacs.

;; Permission is hereby granted, free of charge, to any person obtaining
;; a copy of this software and associated documentation files (the
;; "Software"), to deal in the Software without restriction, including
;; without limitation the rights to use, copy, modify, merge, publish,
;; distribute, sublicense, and/or sell copies of the Software, and to
;; permit persons to whom the Software is furnished to do so, subject to
;; the following conditions:

;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
;; BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
;; ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
;; CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.

;;; Commentary:

;; This is a simple library to show fortune cookies from `taoup'.

;;; Code:

(require 'xterm-color)

(defgroup fortune-taoup nil
  "Generate fortune cookies from taoup."
  :prefix "fortune-taoup-"
  :group 'games)

(defcustom fortune-taoup-text-scale 5
  "Size of text for `fortune-taoup'."
  :group 'fortune-taoup
  :type '(restricted-sexp
          :match-alternatives (natnump)))

(defun fortune-taoup ()
  "Generate fortune via taoup-fortune."
  (interactive)
  (let* ((fortune-buffer-name "*taoup*")
         (fortune-buffer (get-buffer-create fortune-buffer-name)))
    (with-current-buffer fortune-buffer
      (read-only-mode)
      (text-scale-increase 0)
      (let ((buffer-read-only nil))
        (erase-buffer)
        (call-process-shell-command "taoup-fortune" nil t nil)
        (xterm-color-colorize-buffer 'use-overlays)
        (goto-char (point-min))
        (fill-paragraph))
      (text-scale-increase fortune-taoup-text-scale)
      (switch-to-buffer (get-buffer fortune-buffer))
      (goto-char (point-max))
      (current-buffer))))

(provide 'fortune-taoup)

;;; fortune-taoup.el ends here
