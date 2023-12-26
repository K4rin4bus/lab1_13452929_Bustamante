#lang racket
(provide get-flow-id)
(provide get-flow-name-msg)
(provide get-flow-options)
(provide find-flow-by-id)
;(provide )
;;get-flow-id : permite obtener el id de la funcion flow 
;;Dom: flow
;;Rec: id (integer)

(define (get-flow-id flow)
  (car flow))

;;get-flow-name-msg : permite obtener el name-msg de la funcion flow 
;;Dom: flow
;;Rec: name-msg 

(define (get-flow-name-msg flow)
  (cadr flow))
    
;;get-flow-options : permite obtener el options de la funcion flow 
;;Dom: flow
;;Rec: options (lista)

(define (get-flow-options flow)
  (caddr flow))


;; find-flow-by-id: Encuentra un flujo por su ID en una lista de flujos
;; Dom: flows (lista de flujos) X flow-id (integer)
;; Rec: flow | bool (#f)

(define (find-flow-by-id flows flow-id)
  (cond
    ((null? flows) #f)
    ((= (get-flow-id (car flows)) flow-id) (car flows))
    (else (find-flow-by-id (cdr flows) flow-id))))

;===============================================================================================
;TDA Flow - Capa Pertenencia
;===============================================================================================




