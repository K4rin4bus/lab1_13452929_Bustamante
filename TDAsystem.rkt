#lang racket

;===============================================================================================
; Capa Selectora - TDA System
; Descripción: Funciones que seleccionan un atributo del sistema operativo
;=============================================================================================== 
;; Dom: name (str)
;; Rec: Atributo del sistema
(define get-system-name car)  ;Nombre sistema
(define get-system-users cadr) ;Lista usuarios sistema
(define get-system-initialChat caddr) ;Codigo Initial Chatbot
(define get-system-chatbots cadddr) ;Lista de Chatbots 
(define get-system-loggedin (lambda (system) (car (cdr (cdr (cdr system))))));Usuario actual sistema
(define get-system-history (lambda (system) (car (cdr (cdr (cdr (cdr system))))))) ; History
(define get-system-fecha (lambda (system) (car (cdr (cdr (cdr (cdr (cdr system)))))))); fecha creacion sistema


(define (get-system-name system)
  (car system))

;;get-system-InitialChatbotCodeLink : permite obtener el InitialChatbotCodeLink de la funcion system
;;Dom: system
;;Rec: InitialChatbotCodeLink (integer)

(define (get-system-InitialChatbotCodeLink system)
  (cadr system))

;;get-system-chatbots : permite obtener el chatbots de la funcion system
;;Dom: system
;;Rec: chatbots (lista)

(define (get-system-chatbots system)
  (caddr system))

;;get-system-chatbot-history : permite obtener el historial de chatbot del sistema
;;Dom: system
;;Rec: history (lista)

(define (get-system-chatbot-history system)
  (cadddr system))

;;chatbot-exists? : Verifica si chatbot existe en system para evitar duplicados 
;;Dom: system X chatbot
;;Rec: bool (#t o #f)

(define (chatbot-exists? system chatbot)
  (member chatbot (get-system-chatbots system)))



;===============================================================================================
; Capa pertenencia - TDA System
; Descripción:
;=============================================================================================== 

(define (exists-system-user? username system)  ;existe el usuario en el sistema?
  (member username (get-system-users system)))

(define (exists-login-user? username system)
  (let ((loggedin (get-system-loggedin system)))
    (and (list? loggedin)
         (member username loggedin))))




;;get-chatbot-by-id : Verifica si chatbot existe en system para evitar duplicados 
;;Dom: system X chatbot-id
;;Rec: chatbot | bool (#f)

(define (get-chatbot-by-id system chatbot-id)
  (let* ((chatbots (get-system-chatbots system))
         (chatbot (find-chatbot-by-id chatbots chatbot-id)))
    (if chatbot
        chatbot
        #f)))