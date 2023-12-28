#lang racket
(require srfi/1)
(require "TDAoption.rkt")
(require "TDAflow.rkt")
(require "TDAchatbot.rkt")
(require "TDAsystem.rkt")
(provide option)
(provide flow)
(provide flow-add-option)
(provide chatbot)
(provide chatbot-add-flow)
(provide system)
(provide system-add-chatbot)
(provide system-add-user)
(provide system-login)
(provide system-logout)
(provide system-talk-rec)
(provide system-talk-rec-helper)
(provide process-user-input)
(provide system-update-history)

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
             (new-options (if (list? existing-options) 
                              (cons option existing-options)
                              (list option))))
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
      (let* ((chatbotID (get-chatbot-id some-chatbot))
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
  (list name initialChatbotCodeLink chatbots '() "" '() (current-seconds) ))




;===============================================================================================
;TDA system - constructor. RF8
;Función modificadora para añadir chatbots a un sistema.
;===============================================================================================
;Dom: System X chatbot 
;Rec: system
(define (system-add-chatbot some-system chatbot); le paso el sistema y un chatbot
  (define (add-chatbot-to-list chatbots new-chatbot acc); rutina para agregar chatbot a la lista de chatbots del sistema 
    (if (null? chatbots); lista chatbots vacia
        (reverse (cons new-chatbot acc)); invierte lista chatbots
        (add-chatbot-to-list (cdr chatbots) new-chatbot (cons (car chatbots) acc))))

  (if (not (chatbot-exists? some-system chatbot))
      (let* ((system-name (get-system-name some-system ))
             (system-initialChat (get-system-initialChat some-system))
             (existing-chatbots (get-system-chatbots some-system))
             (new-chatbots (add-chatbot-to-list existing-chatbots chatbot '()))
             (system-users (get-system-users some-system))
	     (system-loggedin (get-system-loggedin some-system))
	     (system-history (get-system-history some-system))
             (system-fecha (get-system-fecha some-system)))
	(list system-name system-initialChat new-chatbots system-users system-loggedin system-history system-fecha)) ; construye lista system
      some-system))


;===============================================================================================
;TDA system - modificador. RF9
;Función modificadora para añadir usuarios a un sistema.
;===============================================================================================
(define (system-add-user system username)
  (if (not (exists-system-user? username system))
      (system-register system username)
      system))


;===============================================================================================
; TDA system - modificador. RF10
; Función que permite iniciar una sesión en el sistema.
;===============================================================================================
(define (system-login system username)
  (if (and (user-registered? username system)
           (not (exists-login-user? username system))
           (not (equal? username (get-system-loggedin system))))
      (make-system (get-system-name system)
                   (get-system-initialChat system)
                   (get-system-chatbots system)
                   (get-system-users system)
                   username
                   (get-system-history system)
                   (get-system-fecha system))
      system))

;===============================================================================================
;TDA system - modificador. RF11
;Función que permite cerrar una sesión abierta.
;===============================================================================================
(define (system-logout system)
  (make-system (get-system-name system)
               (get-system-initialChat system)
               (get-system-chatbots system)
               (get-system-users system)
               ""
               (get-system-history system)
               (get-system-fecha system))) 



;===============================================================================================
; TDA system - modificador. RF12
; Función que permite interactuar con un chatbot, con recursividad.
;===============================================================================================
;===============================================================================================
; Función principal para la interacción recursiva con el chatbot
;===============================================================================================
; Dom: system X username
; Rec: system

(define (system-talk-rec system username)
  (if (exists-login-user? username system)
      (system-talk-rec-helper system username '())
      (begin
        (display "Usuario no registrado. Por favor, regístrese.\n")
        system)))

;===============================================================================================
; Función auxiliar recursiva para la interacción con el chatbot
;===============================================================================================
; Dom: system X username X chat-history
; Rec: system

(define (system-talk-rec-helper system username chat-history)
  (display "¡Bienvenido al chatbot!\n")
  (display "Ingrese su mensaje (o 'salir' para salir): ")
  (newline)
  (let ((user-input (read-line))) ; Leer la entrada del usuario
    (cond
      ((string-ci=? user-input "salir")
       (display "¡Hasta luego!\n")
       system) ; Salir del bucle de interacción
      (else
       (let* ((current-chatbot (get-system-initialChat system))
              (current-flow (find-flow-by-id (get-chatbot-flows current-chatbot) (get-chatbot-startFlowId current-chatbot)))
              (response (process-user-input system current-chatbot current-flow user-input)))
         (display response)
         (newline)
         (let ((new-chat-history (cons (list user-input response) chat-history)))
           (system-talk-rec-helper system username new-chat-history)))))))


;===============================================================================================
; Función para procesar la entrada del usuario y obtener la respuesta del chatbot
;===============================================================================================
; Dom: system X chatbot X flow X user-input
; Rec: response (String)

(define (process-user-input system chatbot flow user-input)
  (let ((option (find-option-by-keyword flow user-input)))
    (if option
        (let ((next-flow-id (get-option-initialFlowCodeLink option)))
          (let ((next-flow (find-flow-by-id (get-chatbot-flows chatbot) next-flow-id)))
            (let ((updated-system (system-update-history system user-input (get-option-message option))))
              (flow-add-option next-flow option) ; Agregar la opción al flujo actual
              (chatbot-add-flow updated-system chatbot next-flow)))) ; Actualizar el sistema y el chatbot con el nuevo flujo
        "Lo siento, no entendí. Por favor, intenta nuevamente.\n")))

;===============================================================================================
; Función para actualizar el historial del sistema con la interacción actual
;===============================================================================================
; Dom: system X user-input X chatbot-response
; Rec: updated-system

(define (system-update-history system user-input chatbot-response)
  (let ((current-history (get-system-history system)))
    (let ((new-history (cons (list user-input chatbot-response) current-history)))
      (make-system (get-system-name system)
                   (get-system-initialChat system)
                   (get-system-chatbots system)
                   (get-system-users system)
                   (get-system-loggedin system)
                   new-history
                   (get-system-fecha system)))))
;===============================================================================================
;                            Script de pruebas 
;===============================================================================================


