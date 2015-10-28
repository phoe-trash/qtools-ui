#|
 This file is a part of Qtools-UI
 (c) 2015 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:cl-user)
(asdf:defsystem qtools-ui
  :version "0.0.0"
  :license "Artistic"
  :author "Nicolas Hafner <shinmera@tymoon.eu>"
  :maintainer "Nicolas Hafner <shinmera@tymoon.eu>"
  :serial T
  :components ((:file "package")
               (:file "toolkit")
               (:file "layout")
               (:file "compass")
               (:file "container")
               (:file "draggable")
               (:file "splitter")
               (:file "panel")
               (:file "panel-container")
               (:file "keychord-editor"))
  :depends-on (:qtools
               :qtcore
               :qtgui))
