#|
 This file is a part of Qtools-UI
 (c) 2015 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.qtools.ui)
(in-readtable :qtools)

(define-widget layout (QWidget)
  ())

(defgeneric widget (place layout))
(defgeneric (setf widget) (widget place layout))
(defgeneric widget-position (widget layout))
(defgeneric add-widget (widget layout))
(defgeneric insert-widget (widget place layout))
(defgeneric remove-widget (place layout))
(defgeneric swap-widget (a b layout))
(defgeneric update (layout))
(defgeneric widget-acceptable-p (widget layout))

(defmethod update ((layout layout)))

(defmethod widget-acceptable-p (widget (layout layout))
  NIL)

(defmethod widget-acceptable-p ((widget qobject) (layout layout))
  T)

(defun check-widget-permitted (widget layout)
  (unless (widget-acceptable-p widget layout)
    (cerror "~a does not accept ~a." layout widget))
  (when (eql (parent widget) layout)
    (error "~a is already contained in ~a." widget layout)))

(defmethod (setf widget) :around (widget place (layout layout))
  (check-widget-permitted widget layout)
  (call-next-method))

(defmethod add-widget :around (widget (layout layout))
  (check-widget-permitted widget layout)
  (call-next-method))

(defmethod insert-widget :around (widget place (layout layout))
  (check-widget-permitted widget layout)
  (call-next-method))

(define-override (layout resize-event) (ev)
  (update layout)
  (stop-overriding))

(define-override (layout event) (ev)
  (when (= (enum-value (q+:type ev)) (q+:qevent.layout-request))
    (update layout))
  (stop-overriding))
