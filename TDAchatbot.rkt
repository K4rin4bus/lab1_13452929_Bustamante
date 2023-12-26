#lang racket
(require "TDAflow.rkt")
;(provide )
(provide get-chatbot-chatbotID)
(provide get-chatbot-name)
(provide get-chatbot-welcomeMessage)
(provide get-chatbot-startFlowId)
(provide get-chatbot-flows)
(provide flow-exists?)

;;get-chatbot-chatbotID : permite obtener el chatbotID de la funcion chatbot 
;;Dom: chatbot
;;Rec: chatbotID (integer)

(define (get-chatbot-chatbotID chatbot)
  (car chatbot))

;;get-chatbot-name : permite obtener el name de la funcion chatbot 
;;Dom: chatbot
;;Rec: name (string)

(define (get-chatbot-name chatbot)
  (cadr chatbot))

;;get-chatbot-welcomeMessage : permite obtener el chatbotID de la funcion chatbot 
;;Dom: chatbot
;;Rec: welcomeMessage (string)

(define (get-chatbot-welcomeMessage chatbot)
  (caddr chatbot))

;;get-chatbot-startFlowId : permite obtener el startFlowId de la funcion chatbot 
;;Dom: chatbot
;;Rec: startFlowId (integer)

(define (get-chatbot-startFlowId chatbot)
  (cadddr chatbot))


;;get-chatbot-flows : permite obtener el flows de la funcion chatbot 
;;Dom: chatbot
;;Rec: flows (lista)

(define (get-chatbot-flows chatbot)
  (cddddr chatbot))

;;flow-exists? : Verifica si flow existe en la lista de chatbot para evitar duplicados 
;;Dom: chatbot X flow
;;Rec: bool (#t o #f)

(define (flow-exists? chatbot flow)
  (member (get-flow-id flow) (map get-flow-id (get-chatbot-flows chatbot))))

