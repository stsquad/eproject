;;; eproject-ibuffer.el --- eproject ibuffer support

;; Copyright (C) 2009  Jonathan Rockway

;; Author: Jonathan Rockway <jon@jrock.us>
;; Keywords: eproject ibuffer

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

;; This used to be in eproject-extras but has been split apart.

;;; Code:

(require 'eproject)
(require 'ibuffer)
(require 'ibuf-ext)
(require 'ibuf-macs)

(define-ibuffer-filter eproject-root
    "Filter buffers that have the provided eproject root"
  (:reader (read-directory-name "Project root: " (ignore-errors (eproject-root)))
   :description "project root")
  (with-current-buffer buf
    (equal (file-name-as-directory (expand-file-name qualifier))
           (ignore-errors (eproject-root)))))

(define-ibuffer-filter eproject
    "Filter buffers that have the provided eproject name"
  (:reader (eproject--do-completing-read "Project name: " (eproject-project-names))
   :description "project name")
  (with-current-buffer buf
    (equal qualifier
           (ignore-errors (eproject-name)))))

(define-ibuffer-column eproject (:name "Project" :inline t)
  (ignore-errors (eproject-name)))

;;;###autoload
(defun eproject-ibuffer (prefix)
  "Open an IBuffer window showing all buffers in the current project, or named project if PREFIX arg is supplied."
  (interactive "p")
  (if (= prefix 4)
      (call-interactively #'eproject--ibuffer-byname)
    (ibuffer nil "*Project Buffers*"
             (list (cons 'eproject-root (eproject-root))))))

(defun eproject--ibuffer-byname (project-name)
  "Open an IBuffer window showing all buffers in the project named PROJECT-NAME."
  (interactive (list
                (eproject--do-completing-read
                 "Project name: " (eproject-project-names))))
  (ibuffer nil (format "*%s Buffers*" project-name)
           (list (cons 'eproject project-name))))

(provide 'eproject-ibuffer)
;;; eproject-ibuffer.el ends here
