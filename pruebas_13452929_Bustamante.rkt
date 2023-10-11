#lang racket
(require "lab1_13452929_Bustamante.rkt")



;===============================================================================================
;                            Script de pruebas 
;===============================================================================================
;creando opciones
;opción 1 vinculada al chatbot 2 con su flujo 1 (asumiendo su existencia) en sistema
(define op1 (option 1 "1) Viajar" 2 1 "viajar" "turistear" "conocer"))
op1
;opción 2 vinculada al chatbot 3 con su flujo 1 (asumiendo su existencia) en sistema
(define op2 (option 2 "2) Estudiar" 3 1 "estudiar" "aprender" "perfeccionarme"))
op2
;opción 3 vinculada al chatbot 4 con su flujo 1 (asumiendo su existencia) en sistema
(define op3 (option 3 "3) Arrendar auto" 4 1 "Arrendar" "terminal"))
op3
;opción 4 vinculada al chatbot 5 con su flujo 1 (asumiendo su existencia) en sistema
(define op4 (option 4 "4) Pedir hora medica" 3 1 "Examenes" "preventico" "chequeo"))
op4
;creando un nuevo flow
(define f10 (flow 1 "Flujo1" op1 op2 op2));solo añade una incidencia de op2
f10

;creando un nuevo flow
(define f12 (flow 2 "Flujo2" op2 op3 op4))
f12
(define f11 (flow-add-option f10 op1)) ;se intenta añadir opción duplicada
(define cb0 (chatbot 0 "Inicial" "Bienvenido\n¿Qué te gustaría hacer?" 1 f10 f10))  ;solo añade una ocurrencia de f10
(define s0 (system "Chatbots Paradigmas" 0 cb0 cb0))
s0
;(define s1 (system-add-chatbot s0 cb0)) ;igual a s0
