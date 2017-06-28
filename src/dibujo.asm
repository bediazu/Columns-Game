dibujar_bloque:
;===============================
  ;Eliminado del bloque actual
;================================
  mov byte [bloque_existente],1

  ;Set cursor position
  mov ah,02h
  mov dh,[prev_bloque_y]
  mov dl,[prev_bloque_x]
  mov cx,1
  xor bl,bl
  int 10h

  ;Write a char
  mov ah,09h
  mov al,0d ;Imprimimos un vacio
  int 10h

  ;Set cursor position
  mov ah,02h
  mov dl,[prev_bloque_x]
  dec dh
  int 10h

  ;Write a char
  mov ah,09h
  mov al,0d ;Imprimimos un vacio
  int 10h

  ;Set cursor positon
  mov ah,02h
  mov dl,[prev_bloque_x]
  dec dh
  int 10h

  ;Write a char
  mov ah,09h
  mov al,0
  int 10h

;============================
  ;Dibujo del bloque actual
;============================

  ;Set cursor position
  mov ah,02h
  mov dh,[bloque_y]
  mov dl,[bloque_x]
  int 10h

  ;Write a char
  mov ah,09h
  mov al,219d ;Cuadrado Ascii Code
  mov bl,[actual_color_bloque_1]
  mov cx,1d
  int 10h

  ;Set cursor position
  mov ah,02h
  dec dh
  int 10h

  ;Write a char
  mov ah,09h
  mov al,219d ;Cuadrado Ascii Code
  mov bl,[actual_color_bloque_2]
  mov cx,1d
  int 10h

  ;Set cursor position
  mov ah,02h
  dec dh
  int 10h

  ;Write a char
  mov ah,09h
  mov al,219d ;Cuadrado Ascii Code
  mov bl,[actual_color_bloque_3]
  mov cx,1d
  int 10h

;================================
  ;Actualizacion de posiciones
;================================

  mov al,[bloque_x]
  mov [prev_bloque_x],al

  mov al,[bloque_y]
  mov [prev_bloque_y],al

  ret


dibujar_siguiente_bloque:

  ;Set cursor position
  mov ah,02h
  xor bh,bh
  mov dh,8d
  mov dl,30d
  int 10h

  ;Write a char
  mov ah,09h
  mov al,219d ;Cuadrado ascii code
  mov bl,[color_bloque_3]
  mov cx,1
  int 10h

  ;Set cursor position
  mov ah,02h
  inc dh
  int 10h

  ;Write a char
  mov ah,09h
  mov bl,[color_bloque_2]
  int 10h

  ;Set cursor position
  mov ah,02h
  inc dh
  int 10h

  ;Write a char
  mov ah,09h
  mov bl,[color_bloque_1]
  int 10h

  ret


dibujar_puntos_inicial:
  ;Set cursor position
  mov ah,02h
  mov dl,09d
  mov dh,08d
  int 10h

  mov ah,0eh
  mov al,30h
  int 10h
  int 10h
  int 10h
  ret

dibujar_puntos:

  ;Set cursor position
  mov ah,02h
  mov dl,11d
  mov dh,08d
  int 10h

  mov al,[puntaje_1]
  cmp al,9h
  jae modificar_valor
  inc al
  mov [puntaje_1],al
  add al,30h
  mov ah,0Ah
  int 10h

  ;set cursor position
  mov ah,02h
  mov dl,10d
  mov dh,08d
  int 10h

  mov al,[puntaje_2]
  add al,30h
  mov ah,0Ah
  int 10h

  ;Set cursor position
  mov ah,02h
  mov dl,09d
  mov dh,8d
  int 10h

  mov al,[puntaje_3]
  add al,30h
  mov ah,0Ah
  int 10h

  ret


modificar_valor:
  mov al,0h
  mov [puntaje_1],al

  mov al,[puntaje_2]
  inc al
  cmp al,9h
  jae modificar_valor_2
  mov [puntaje_2],al
  jmp dibujar_puntos


modificar_valor_2:
  mov al,0
  mov [puntaje_2],al

  mov al,[puntaje_3]
  inc al
  jmp dibujar_puntos
