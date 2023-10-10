#lang racket
;(require "TDAoption.rkt")



;===============================================================================================
;TDA Option - costructor. RF2
;Función constructora de una opción para flujo de un chatbot.
;Cada opción se enlaza a un chatbot y flujo especificados por sus respectivos códigos.
;===============================================================================================
;Dom: code(Int) X message(String) X ChatbotCodeLink(Int) X InitialFlowCodeLink(Int)
;     X Keyword* (en referencia a 0 o más palabras claves)    
;Rec: option
(define (option code message chatbotCodeLink initialFlowCodeLink . keywords)
  (list code message chatbotCodeLink initialFlowCodeLink keywords))


;===============================================================================================
;TDA Flow - constructor. RF3
;Función constructora de un flujo de un chatbot.
;===============================================================================================
;Dom: id (int) X name-msg (String) X Option* (Indica que puede recibir cero o más opciones)
;Rec: flow
(define (flow id name-msg . options)
  (list id name-msg options))

; falta hacer id autoincrementable


;===============================================================================================
;TDA Flow - modificador. RF4
;Función modificadora para añadir opciones a un flujo.  
;===============================================================================================
;Dom: flow X option
;Rec: flow
(define (flow-add-option some-flow option)
  (cons option some-flow))
;falta
;verifica que las opciones añadidas no se repitan en base al id de éstos.


;===============================================================================================
;TDA chatbot - constructor. RF5
;Función constructora de un chatbot. 
;===============================================================================================
;Dom: chatbotID (int) X name (String) X welcomeMessage (String) X startFlowId(int) X flows
;     *(indicando que puede recibir 0 o más flujos) 
(define (chatbot chatbotID name welcomeMessage startFlowId . flows)
  (list chatbotID name welcomeMessage startFlowId flows))

;Falta
;Chatbots quedan identificados por un ID único.
;verificar unicidad antes de agregarlo a un sistema.
;verificar que los flujos añadidos no se repitan, en base al id de éstos.


;===============================================================================================
;TDA chatbot - modificador. RF6
;Función modificadora para añadir flujos a un chatbot.
;===============================================================================================
;Dom: chatbot X flow
;Rec: chatbot
(define (chatbot-add-flow some-chatbot flow)
  (cons flow some-chatbot))
;(define (chatbot-add-flow some-chatbot flow)
;  (if (null? some-chatbot)        ; Si la lista está vacía
 ;     (some-chatbot flow)         ; Entrega la lista con el nuevo elemento
;      (cons (car some-chatbot)    ; Agrega primer elemento de lista original
 ;           (chatbot-add-flow     ; llamada recursiva a la funcion
;             (cdr some-chatbot))  ; Toma el resto de la lista
;            flow)))


;falta
;verifica que los flujos añadidos no se repitan en base al id de éstos.
;recursion natural genera conflicto de aridad


;===============================================================================================
;TDA system - constructor. RF7
;Función constructora de un sistema de chatbots. Deja registro de la fecha  de creación.
;===============================================================================================
;Dom: name (string) X InitialChatbotCodeLink (Int) X chatbot*
;(indicando que pueden recibir 0 o más chatbots)     
;Rec: system
(define (system name initialChatbotCodeLink . chatbots)
  (list (current-seconds) name initialChatbotCodeLink chatbots))






;===============================================================================================
;Script de pruebas N°1
;===============================================================================================
;creando opciones
;opción 1 vinculada al chatbot 2 con su flujo 4 (asumiendo su existencia) en sistema
(define op1 (option 1 "1) Viajar" 2 1 "viajar" "turistear" "conocer"))
op1
;opción 2 vinculada al chatbot 4 con su flujo 3 (asumiendo su existencia) en sistema
(define op2 (option 2 "2) Estudiar" 3 1 "estudiar" "aprender" "perfeccionarme"))
op2

;creando un nuevo flow
(define f10 (flow 1 "Flujo1" op1 op2 op2));solo añade una incidencia de op2
f10