#lang racket


;TDA Option - costructor.
;Función constructora de una opción para flujo de un chatbot.
;Cada opción se enlaza a un chatbot y flujo especificados por sus respectivos códigos.

;Dom: code(Int) X message(String) X ChatbotCodeLink(Int) X InitialFlowCodeLink(Int)
;     X Keyword* (en referencia a 0 o más palabras claves)    
;
;Rec: option

(define (option code message ChatbotCodeLink InitialFlowCodeLink . Keywords)
  (list code message ChatbotCodeLink InitialFlowCodeLink Keywords))



;TDA Flow - constructor. Función constructora de un flujo de un chatbot. 
;Dom: id (int) X name-msg (String) X Option*  (Indica que puede recibir cero o más opciones)
;Rec: flow

(define (flow name . options)
  (list name options))





;Script de pruebas
(define op1 (option 1 "viajar" 2 4 "turistear" "conocer"))
op1
(define op2 (option 2 "estudiar" 1 3 "ejecucion" "civil"))
op2

;creando un nuevo flow
(define f10 (flow 1   "Flujo1: mensaje de prueba"))
f10
;alternativamente podría usarse:
(define f12 (flow 1 "Flujo1: mensaje de prueba" op1 op2))
f12
