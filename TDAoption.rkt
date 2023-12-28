#lang racket
(require "TDAflow.rkt")
(provide get-option-code)
(provide get-option-message)
(provide get-option-chatbotCodeLink)
(provide get-option-initialFlowCodeLink)
(provide get-option-keyword)
(provide option-exists?)
(provide find-option-by-keyword)
;===============================================================================================
;TDA Option - 
;Función que verifica unicidad de opcion antes de agregarla.
;===============================================================================================

;===============================================================================================
;TDA Option - Capa selectora
;===============================================================================================

(define get-option-code car); obtiene el code de la option
(define get-option-message cadr); obtiene el el mensaje de la funcion option 
(define get-option-chatbotCodeLink caddr); obtiene el ChatbotCodeLink de la funcion option 
(define get-option-initialFlowCodeLink cadddr); obtiene el InitialFlowCodeLink de la funcion option 
(define get-option-keyword (lambda (option) (car (cdr (cdr (cdr (cdr option))))))); obtiene el keyword de la funcion option


;===============================================================================================
;TDA Option - Capa Pertenencia
;===============================================================================================

;;Funcion que verifica unicidad de option en la lista de flow
;;Dom: flow X option
;;Rec: bool (#t o #f)

(define (option-exists? flow option)
  (member (get-option-code option) (map get-option-code (get-flow-options flow))))

;===============================================================================================
;busca una opción en un flujo por keyword.
;===============================================================================================
(define (find-option-by-keyword flow keyword)
  (define (find-option-in-flow flow keyword)
    (cond
      ((null? (get-flow-options flow)) #f)
      ((find-option (car (get-flow-options flow)) keyword) => values)
      (else (find-option-in-flow (list (get-flow-id flow) (get-flow-name-msg flow) (cdr (get-flow-options flow))) keyword))))

  (define (find-option option keyword)
    (if (member keyword (get-option-keyword option))
        option
        #f))

  (if (find-option-in-flow flow keyword)
      (find-option-in-flow flow keyword)
      #f))
