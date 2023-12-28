#lang racket
(require "TDAchatbot.rkt")
(provide get-system-name)
(provide get-system-users)
(provide get-system-initialChat)
(provide get-system-chatbots)
(provide get-system-loggedin)
(provide get-system-history)
(provide get-system-fecha)
(provide make-system)
(provide chatbot-exists?)
(provide exists-system-user?)
(provide exists-login-user?)
(provide system-register)
(provide system-register-login)
(provide user-registered?)





;===============================================================================================
; TDA System - Constructor
;=============================================================================================== 
(define make-system
  (lambda(name initialChatbotCodeLink chatbots users loggedin history fecha)
    (list name initialChatbotCodeLink chatbots users loggedin history fecha)))

;===============================================================================================
; Capa Selectora - TDA System
; Descripción: Funciones que seleccionan un atributo del sistema operativo
;=============================================================================================== 
;; Dom: name (str)
;; Rec: Atributo del sistema
(define get-system-name car)  ;Nombre sistema
(define get-system-initialChat cadr) ;Codigo Initial Chatbot
(define get-system-chatbots caddr) ;Lista de Chatbots
(define get-system-users cadddr) ;Lista usuarios sistema
(define get-system-loggedin (lambda (system) (car (cdr (cdr (cdr (cdr system)))))));Usuario actual sistema
(define get-system-history (lambda (system) (car (cdr (cdr (cdr (cdr (cdr system)))))))) ; History
(define get-system-fecha (lambda (system) (car (cdr (cdr (cdr (cdr (cdr (cdr system))))))))); fecha creacion sistema


;===============================================================================================
; Capa Modificadora - TDA System
;=============================================================================================== 
; Descripción: Función que crea un user del sistema operativo
;; Dom: user
;; Rec: system
(define system-register
  (lambda (system new-user)
    (make-system (get-system-name system)
                 (get-system-initialChat system)
                 (get-system-chatbots system)
                 (cons new-user (get-system-users system))
                 (get-system-loggedin system)
                 (get-system-history system)
                 (get-system-fecha system))))


; Descripción: Función que permite iniciar sesion a un user en el sistema
;; Dom: user
;; Rec: system
(define system-register-login
  (lambda (system username)
    (make-system (get-system-name system)
                 (get-system-initialChat system)
                 (get-system-chatbots system)
                 (get-system-users system)
                  username
                 (get-system-history system)
                 (get-system-fecha system))))


;===============================================================================================
; Capa pertenencia - TDA System
;=============================================================================================== 
;;Verifica si chatbot existe en la lista de chatbots del system para evitar duplicados 
(define (chatbot-exists? system chatbot)
  (member (get-chatbot-id chatbot) (map get-chatbot-id (get-system-chatbots system))))

;;Verifica si existe usuario en la lista de usuarios del system para evitar duplicados 
(define (exists-system-user? username system)  ;existe el usuario en el sistema?
  (member username (get-system-users system)))


;; Verifica si un usuario está registrado en el sistema
(define (user-registered? username system)
  (member username (get-system-users system)))

;; Verifica si existe un usuario logueado en el sistema
(define (exists-login-user? username system)
  (let ((loggedin (get-system-loggedin system)))
    (and (string? loggedin)
         (not (equal? loggedin "")))))
