#lang racket
(provide get-flow-id)
(provide get-flow-name-msg)
(provide get-flow-options)
(provide find-flow-by-id)
;(provide )
;;get-flow-id : 
;;Dom: flow
;;Rec: id (integer)

;===============================================================================================
;TDA Flow - Capa Selectora
;===============================================================================================
(define get-flow-id car); Obtiene el id de la funcion flow 
(define get-flow-name-msg cdr); Obtiene el name-msg de la funcion flow 
(define get-flow-options cddr); Obtiene el options de la funcion flow 


;; Encuentra un flujo por su ID en una lista de flujos
;; Dom: flows (lista de flujos) X flow-id (integer)
;; Rec: flow | bool (#f)

(define (find-flow-by-id flows flow-id)
  (cond
    ((null? flows) #f)
    ((= (get-flow-id (car flows)) flow-id) (car flows))
    (else (find-flow-by-id (cdr flows) flow-id))))

