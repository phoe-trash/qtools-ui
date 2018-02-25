#|
This file is a part of Qtools-UI
(c) 2015 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
Author: Michał "phoe" Herda <phoe@teknik.io>
|#

(in-package #:org.shirakumo.qtools.ui)
(in-readtable :qtools)

;;; MIME-DATA-WITH-QOBJECT

(defvar *mime-data-with-object-type*
  "application/qtools-mime-data-with-object")

(define-widget mime-data-with-object (QMimeData)
  ((object :accessor object
           :initarg :object
           :initform nil)))

(defmethod initialize-instance :after
    ((object mime-data-with-object) &key mime-type)
  (setf (q+:data object mime-type) ""))

;;; DRAGGABLE

(define-widget draggable (QWidget)
  ((mime-type :accessor mime-type
              :initarg :mime-type
              :initform *mime-data-with-object-type*)))

(define-override (draggable mouse-press-event) (event)
  (when (eq (enum-value (q+:button event)) (q+:qt.left-button))
    (let ((drag (q+:make-qdrag draggable))
          (mime-data (make-instance 'mime-data-with-object
                                    :object draggable
                                    :mime-type mime-type)))
      (setf (q+:mime-data drag) mime-data)
      (let ((drop-action (q+:exec drag (q+:qt.move-action))))
        (when (= (enum-value drop-action) (q+:qt.ignore-action))
          (print "drop ignored, finalizing")
          (q+:delete-later drag)
          (q+:delete-later mime-data)))))
  (stop-overriding))

;;; DROP-TARGET

(define-widget drop-target (QWidget)
  ((mime-type :accessor mime-type
              :initarg :mime-type
              :initform *mime-data-with-object-type*)))

(define-initializer (drop-target initialize-drop-target)
  (setf (q+:accept-drops drop-target) t))

(define-override (drop-target drag-enter-event) (event)
  (when (q+:has-format (q+:mime-data event) mime-type)
    (q+:accept-proposed-action event))
  (stop-overriding))

(define-override (drop-target drop-event) (event)
  (let ((mime-data (q+:mime-data event)))
    (q+:accept-proposed-action event)
    (drop mime-data drop-target))
  (stop-overriding))

;;; DROP-ACCEPTABLE-P

(defgeneric drop-acceptable-p (item target)
  (:method (item target) NIL))

(defmethod drop-acceptable-p ((item mime-data-with-object) target)  T)

;;; DROP

(defgeneric drop (item target))

(defmethod drop :around (item target)
  (when (drop-acceptable-p item target)
    (call-next-method)))

(defmethod drop ((item mime-data-with-object) target)
  (drop (object item) target))