; TAREA FINAL
; ARQUITECTURA DE HARDWARE 2017 - 1 SEMESTRE

;Bruno Díaz Ureta
;Daniel Delgado Zambrano
;Ignacio Castro Garcia

[bits 16]
org 100h

;=========Declaraciones===========;
section .data

msg_score db 'SCORE:',0x0D,0x0A,'$'
msg_welcome db 'WELCOME',0x0D,0x0A,'$'
msg_next_block db 'NEXT BLOCK:',0x0D,0x0A,'$'
msg_teclas db 'PRESS',0x0D,0x0A,'$'
msg_left db 'L:LEFT',0x0D,0x0A,'$'
msg_right db 'R:RIGHT',0x0D,0x0A,'$'
msg_down db 'S:DOWN',0x0D,0x0A,'$'
msg_rotate db'W:ROTATE',0x0D,0x0A,'$'
msg_exit db 'PRESS Q TO QUIT',0x0D,0x0A,'$'

;=============VARIABLES============;

;==================;
;NUMERO ALEATORIO;
;=================;
numero_aleatorio db 0

;============================;
;COLORES DEL BLOQUE SIGUIENTE;
;============================;
color_bloque_1 db 0
color_bloque_2 db 0
color_bloque_3 db 0

;===========================;
;COLORES DEL BLOQUE EN CAIDA;
;===========================;
actual_color_bloque_1 db 0
actual_color_bloque_2 db 0
actual_color_bloque_3 db 0

;=========================;
;FLAG DE ULTIMO MOVIMIENTO;
;=========================;
colision db 0

;========================;
;COORDENADAS DEL BLOQUE;
;=======================;
bloque_x db 0
bloque_y db 0

;==========================================;
;SIMULACION DE LA ACELERACION DE LA GRAVEDAD
;(Ya le habiamos puesto velocidad xd)
;==========================================
velocidad_gravedad db 10
contador_velocidad db 0

;==================;
;Puntaje del juego;
;=================;
puntaje db 0
puntaje_1 db 0 ;Puntaje a mostrar en el marcador del juego! xx0
puntaje_2 db 0 ;Puntaje a mostrar en el marcador del juego! x0x
puntaje_3 db 0 ;Puntaje a mostrar en el marcador del juego! 0xx

;=================================================================;
;VARIABLES PARA LA EJECUCION DE LA ELIMINACION CORRECTA DE BLOQUES;
;================================================================;
posicion_analisis_x db 0
posicion_analisis_y db 0
color_analisis db 0
contador_match db 0
contador_piezas_match db 0
contador_tempos_gravedad db 0
tempo_gravedad db 0
tamanio_caida_gravedad db 0
bloque_existente db 0
prev_bloque_x db 0
prev_bloque_y db 0

;==================================================================;
;VARIABLES PARA EL DELAY DEL ULTIMO MOVIMIENTO
;NOTA: SE IMPLEMENTARON DOS DELAYS, YA QUE AL SELECCIONAR LOS MICROSEGUNDOS,
; NO MOSTRABA CORRECTAMENTE LOS BLOQUES;
;===================================================================;
delay_inicial db 0
delay_segundos db 5
delay_punto_detencion_segundos db 0


;==========Directorios============
%include "src/marco.asm"
%include "src/genBloque.asm"
%include "src/misc.asm"
%include "src/dibujo.asm"
%include "src/teclado.asm"
%include "src/colisiones.asm"
%include "src/gravedad.asm"
%include "src/match.asm"
%include "src/sonido.asm"
;==========Prototipos=============

global _start
global _end

;============Codigo===============

section .text
_start:
  call modo_grafico
  call dibujar_interfaz
  call iniciar_juego
  ret

_end:

  call emitir_sonido_game_over
  ;Set video mode;
  mov ah,00h
  mov al,03h
  int 10h
  ;DOS: TERMINATE WITH RETURN CODE
  mov ah,4ch
  int 21h
  xor ax,ax
  int 21h

;===========Funciones Principales=============

dibujar_interfaz:
  ;Set cursor position
  mov ah,02h
  mov dh,5
  mov dl,16
  xor bh,bh
  int 10h

  ;Impresion del marco
  call dibujar_marco_juego ;("marco.asm")
  call dibujar_marco_siguiente_bloque ;("marco.asm")
  call dibujar_marco_teclas ;("marco.asm")
  call dibujar_texto_siguiente_bloque ;("marco.asm")
  call dibujar_texto_bienvenido ;("marco.asm")
  call dibujar_texto_score ;("marco.asm")
  call dibujar_texto_teclas ;("marco.asm")
  call dibujar_texto_salir ;("marco.asm")
  ret

iniciar_juego:
  call generar_bloque ;("genBloque.asm")
  call usar_bloque ;("genBloque.asm")
  call generar_bloque ;("genBloque.asm") ;Para el siguiente bloque a crear.
  call dibujar_siguiente_bloque ;("dibujo.asm")
  call nuevo_bloque ;("GenBloque.asm");NOTA:No dibuja el bloque, solo lo instancia
  call dibujar_puntos_inicial ;("dibujo.asm")
  call main_game ;PROCEDIMIENTO PRINCIPAL
  ret

main_game:
  call detectar_tecla ;("teclado.asm")
  call dibujar_bloque ;("dibujo.asm")
  call detectar_colision ;("colisiones.asm")
  call dibujar_bloque ;("dibujo.asm")
  call activar_gravedad ;("gravedad.asm")
  call nuevo_turno ;("misc.asm")
  jmp main_game
  ret

modo_grafico:

  ;Habilita el modo grafico de texto
  mov ah,00h
  mov al,01h
  int 10h

  ;Desactiva el parpadeo del cursor
  mov ah,01h
  mov cx,2607h
  int 10h
  ret
