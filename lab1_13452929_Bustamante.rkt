#lang racket

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
;Script de pruebas
;===============================================================================================
;creando opciones
;opción 1 vinculada al chatbot 2 con su flujo 4 (asumiendo su existencia) en sistema
(define op1 (option 1 "Viajar" 2 4 "viajar" "turistear" "conocer"))
op1
;opción 2 vinculada al chatbot 4 con su flujo 3 (asumiendo su existencia) en sistema
(define op2 (option 2 "Estudiar" 4 3 "aprender" "perfeccionarme"))
op2

;creando un nuevo flow
(define f10 (flow 1 "Flujo1: mensaje de prueba"))
f10
;alternativamente podría usarse:
(define f12 (flow 1 "Flujo1: mensaje de prueba" op1 op2))
f12

;añadiendo opciones 1 y 2 al flujo f10
(define f11 (flow-add-option f10 op1))


;creando un nuevo chatbot
(define cb10 (chatbot 0 "Asistente" "Bienvenido, ¿Qué te gustaría hacer?" 1))
cb10
;alternativamente podría usarse:
(define cb11 (chatbot 0 "Asistente" "Bienvenido, ¿Qué te gustaría hacer?" 1 f12))
cb11

;añadiendo flujo a un chatbot
;el resultado alcanzado en cb11 es equivalente al ilustrado en cb11 de la función 5.
(define cb12 (chatbot-add-flow cb10 f12))
cb12