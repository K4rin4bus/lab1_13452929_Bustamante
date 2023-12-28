#lang racket
(require "TDAflow.rkt")
;(provide )
(provide get-chatbot-id)
(provide get-chatbot-name)
(provide get-chatbot-welcomeMessage)
(provide get-chatbot-startFlowId)
(provide get-chatbot-flows)
(provide flow-exists?)
(provide find-chatbot-by-id)

;===============================================================================================
;TDA Chatbot - Capa Selectora
;===============================================================================================
(define get-chatbot-id car); obtiene el id del chatbot
(define get-chatbot-name cadr) ;obtiene el name del chatbot
(define get-chatbot-welcomeMessage caddr) ; obtienen el mensaje del chatbot
(define get-chatbot-startFlowId cadddr); obtiene el startFlowId del chatbot
(define get-chatbot-flows (lambda (chatbot) (car (cdr (cdr (cdr (cdr chatbot))))))); obtiene la lista flujos del chatbot


;===============================================================================================
;TDA Chatbot - Capa Pertenencia
;Verifica si flow existe en la lista de chatbot para evitar duplicados 
;===============================================================================================
(define (flow-exists? chatbot flow)
  (member (get-flow-id flow) (map get-flow-id (get-chatbot-flows chatbot))))


;===============================================================================================
; Funcion que busca un chatbot por su id
;=============================================================================================== 
(define (find-chatbot-by-id chatbots chatbot-id)
    (cond
      ((null? chatbots) #f)
      ((= (get-chatbot-id (car chatbots)) chatbot-id) (car chatbots))
      (else (find-chatbot-by-id (cdr chatbots) chatbot-id))))

