#lang racket
(require "TDAflow.rkt")
(provide get-option-code)
(provide get-option-message)
(provide get-option-chatbotCodeLink)
(provide get-option-initialFlowCodeLink)
(provide get-option-keyword)
(provide option-exists?)

;===============================================================================================
;TDA Option - 
;Función que verifica unicidad de opcion antes de agregarla.
;===============================================================================================

;===============================================================================================
;TDA Option - Capa selectora
;===============================================================================================

;(define get-option-code car); obtiene el code de la option
;(define get-option-message cadr); obtiene el el mensaje de la funcion option 
;(define get-option-chatbotCodeLink caddr); obtiene el ChatbotCodeLink de la funcion option 
;(define get-option-initialFlowCodeLink cadddr); obtiene el InitialFlowCodeLink de la funcion option 
;(define get-option-keyword (lambda (option) (car (cdr (cdr (cdr option)))))); obtiene el keyword de la funcion option

(define (get-option-code option)
  (car option))


(define (get-option-message option)
  (cadr option))

(define (get-option-chatbotCodeLink option)
  (caddr option))


(define (get-option-initialFlowCodeLink option)
  (cadddr option))


(define (get-option-keyword option)
  (cddddr option))



;===============================================================================================
;TDA Option - Capa Pertenencia
;===============================================================================================

;;Funcion que verifica unicidad de option en la lista de flow
;;Dom: flow X option
;;Rec: bool (#t o #f)

(define (option-exists? flow option)
  (member (get-option-code option) (map get-option-code (get-flow-options flow))))



