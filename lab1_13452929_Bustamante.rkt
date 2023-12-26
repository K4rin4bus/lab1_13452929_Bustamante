#lang racket

(require "TDAoption.rkt")
(require "TDAflow.rkt")
(require "TDAchatbot.rkt")
(provide option)
(provide flow)
(provide flow-add-option)
(provide chatbot)
;(provide chatbot-add-flow)
;(provide system)
;(provide )
;(provide )

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


;===============================================================================================
;TDA Flow - modificador. RF4
;Función modificadora para añadir opciones a un flujo.  
;===============================================================================================
;Dom: flow X option
;Rec: flow

(define (flow-add-option flow option)
  (if (not (option-exists? flow option))
      (let* ((flow-id (get-flow-id flow))
             (flow-name-msg (get-flow-name-msg flow))
             (existing-options (get-flow-options flow))
             (new-options (cons option existing-options)))
        (list flow-id flow-name-msg new-options))
      flow))


;===============================================================================================
;TDA chatbot - constructor. RF5
;Función constructora de un chatbot. 
;===============================================================================================
;Dom: chatbotID (int) X name (String) X welcomeMessage (String) X startFlowId(int) X flows
;     *(indicando que puede recibir 0 o más flujos) 
(define (chatbot chatbotID name welcomeMessage startFlowId . flows)
  (list chatbotID name welcomeMessage startFlowId flows))



;===============================================================================================
;TDA chatbot - modificador. RF6
;Función modificadora para añadir flujos a un chatbot.
;Recursion de cola
;===============================================================================================
;Dom: chatbot X flow
;Rec: chatbot
(define (chatbot-add-flow some-chatbot flow)
  (define (add-flow-to-list flows new-flow acc)
    (if (null? flows)
        (reverse (cons new-flow acc))
        (add-flow-to-list (cdr flows) new-flow (cons (car flows) acc))))

  (if (not (flow-exists? some-chatbot flow))
      (let* ((chatbotID (get-chatbot-chatbotID some-chatbot))
             (name (get-chatbot-name some-chatbot))
             (welcomeMessage (get-chatbot-welcomeMessage some-chatbot))
             (startFlowId (get-chatbot-startFlowId some-chatbot))
             (existing-flows (get-chatbot-flows some-chatbot))
             (new-flows (add-flow-to-list existing-flows flow '())))
        (list chatbotID name welcomeMessage startFlowId new-flows))
      some-chatbot))



;===============================================================================================
;TDA system - constructor. RF7
;Función constructora de un sistema de chatbots. Deja registro de la fecha  de creación.
;===============================================================================================
;Dom: name (string) X InitialChatbotCodeLink (Int) X chatbot*
;(indicando que pueden recibir 0 o más chatbots)     
;Rec: system
(define (system name initialChatbotCodeLink . chatbots)
  (list name '() initialChatbotCodeLink chatbots "" '() (current-seconds) ))

(define make-system
  (lambda(name users initialChatbotCodeLink chatbots loggedin history fecha)
    (list name users initialChatbotCodeLink chatbots loggedin history fecha)))






;===============================================================================================
;                            Script de pruebas 
;===============================================================================================
;Ejemplo de un sistema de chatbots basado en el esquema del enunciado general
;Opciones Chabot0
(define op1 (option  1 "1) Viajar" 1 1 "viajar" "turistear" "conocer"))
(define op2 (option  2 "2) Estudiar" 2 1 "estudiar" "aprender" "perfeccionarme"))

;Flujo 1 Chatbot 0
(define f10 (flow 1 "Flujo Principal Chatbot 1\nBienvenido\n¿Qué te gustaría hacer?" op1 op2 )) ;solo añade una ocurrencia de op2 y op1
(define f11 (flow-add-option f10 op1)) ;se intenta añadir opción duplicada

;Chabot0
(define cb0 (chatbot 0 "Inicial" "Bienvenido\n¿Qué te gustaría hacer?" 1 f10 ))  ;solo añade una ocurrencia de f10
;cb0

;Sistema
(define s0 (system "Chatbots Paradigmas" 0 cb0))
s0
(define s1 (system-add-chatbot s0 cb0)) ;igual a s0
;(define s2 (system-add-user s0 "user1"))
;(define s3 (system-add-user s2 "user2"))
