#|
 This file is a part of Qtools-UI
 (c) 2015 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#


(asdf:defsystem qtools-ui-repl
  :license "Artistic"
  :author "Nicolas Hafner <shinmera@tymoon.eu>"
  :maintainer "Nicolas Hafner <shinmera@tymoon.eu>"
  :description "An implementation of a REPL."
  :homepage "https://github.com/Shinmera/qtools-ui"
  :serial T
  :components ((:file "repl"))
  :depends-on (:qtools-ui-base
               :trivial-gray-streams
               :bordeaux-threads))
