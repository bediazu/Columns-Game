detectar_match:
  ;Set cursor position
  mov ah,02h
  mov dh,18d
  mov dl,22d
  xor bh,bh
  int 10h

detectar_match_loop:
  mov ah,08h
  int 10h
  cmp al,219d ;Cuadrado Ascii code

  je analizar_posicion_actual
  jmp siguiente_deteccion

analizar_posicion_actual:
  mov [posicion_analisis_x],dl
  mov [posicion_analisis_y],dh

  ;Read a char
  mov ah,08h
  int 10h

  mov [color_analisis],ah

  call reiniciar_valores_analisis
  call deteccion_horizontal
  call reiniciar_valores_analisis
  call deteccion_vertical
  call reiniciar_valores_analisis
  call deteccion_diagonal_1
  call reiniciar_valores_analisis
  call deteccion_diagonal_2
  call reiniciar_valores_analisis

  ;Set cursor position
  mov ah,02h
  dec dh
  int 10h

  jmp detectar_match_loop


deteccion_diagonal_1:

  ;Set cursor position
  mov ah,02h
  inc dl
  inc dh
  int 10h

  ;Read a char
  mov ah,08h
  int 10h

  mov al,[color_analisis]

  cmp ah,al
  jne posible_match_diagonal_1

  ret

posible_match_diagonal_1:
  pop cx
  dec dl
  dec dh

  jmp match_diagonal_1_loop

match_diagonal_1_loop:
  mov al,[contador_match]
  inc al
  mov [contador_match],al

  push dx

  ;Set cursor position
  mov ah,02h
  dec dh
  dec dl
  int 10h

  ;Read a char
  mov ah,08h
  int 10h

  mov al,[color_analisis]
  cmp al,ah
  je match_diagonal_1_loop

  jmp analizar_match


deteccion_diagonal_2:

  ;Set cursor position
  mov ah,02h
  inc dl
  dec dh
  int 10h

  ;Read a char
  mov ah,08h
  int 10h

  mov al,[color_analisis]

  cmp ah,al
  jne posible_match_diagonal_2

  ret

posible_match_diagonal_2:
  pop cx
  dec dl
  inc dh

  jmp match_diagonal_2_loop

match_diagonal_2_loop:
  mov al,[contador_match]
  inc al
  mov [contador_match],al

  push dx

  ;Set cursor position
  mov ah,02h
  inc dh
  dec dl
  int 10h

  ;Read a char
  mov ah,08h
  int 10h

  mov al,[color_analisis]
  cmp al,ah
  je match_diagonal_2_loop

  jmp analizar_match

deteccion_horizontal:
  ;Set cursor position
  mov ah,02h
  inc dl
  int 10h

  ;Read a char
  mov ah,08h
  int 10h

  mov al,[color_analisis]

  cmp ah,al
  jne posible_match_horizontal

  ret

posible_match_horizontal:
  pop cx
  dec dl

  jmp match_horizontal_loop

match_horizontal_loop:

  mov al,[contador_match]
  inc al
  mov [contador_match],al

  push dx

  mov ah,02h
  dec dl
  int 10h

  mov ah,08h
  int 10h

  mov al,[color_analisis]
  cmp al,ah
  je match_horizontal_loop

  jmp analizar_match

deteccion_vertical:
  ;Set cursor position
  mov ah,02h
  inc dh
  int 10h

  ;Read a char
  mov ah,08h
  int 10h

  mov al,[color_analisis]

  cmp ah,al
  jne posible_match_vertical

  ret

posible_match_vertical:
  pop cx
  dec dh

  jmp match_vertical_loop

match_vertical_loop:

  mov al,[contador_match]
  inc al
  mov [contador_match],al

  push dx

  ;Set cursor position
  mov ah,02h
  dec dh
  int 10h

  ;Read a char
  mov ah,08h
  int 10h

  mov al,[color_analisis]
  cmp ah,al
  je match_vertical_loop

  jmp analizar_match

analizar_match:
  mov al,[contador_match]


  ;COMPROBACION DE DOS O MAS PIEZAS ADYACENTES
  cmp al,2
  jle sin_match

  jmp match_final

sin_match:
  ;SE DEBE ELIMINAR TODAS LAS POSICIONES DE LA PILA (CONSIDERANDO QUE NO HAY UNA JUGADA EXITOSA)
  mov ax,cx
  xor cx,cx
  mov cl,[contador_match]
  jmp sin_match_loop

sin_match_loop:
  pop dx
  loop sin_match_loop

  push ax
  ret

match_final:
  mov al,[contador_match]
  mov ah,[contador_piezas_match]
  add ah,al

  mov [contador_piezas_match],ah
  push cx
  ret

reiniciar_valores_analisis:
  mov byte [contador_match],0
  mov dl,[posicion_analisis_x]
  mov dh,[posicion_analisis_y]
  ret

terminar_deteccion:
  mov al,[contador_piezas_match]
  cmp al,0

  jne limpiar_match

  ret

limpiar_match:
  ;Set cursor position
  mov ah,02h
  pop dx
  int 10h

  ;Write a char
  mov ah,09h
  mov al,0
  xor bx,bx
  mov cx,1
  int 10h

  mov al,[puntaje]
  add al,11
  sub al,[velocidad_gravedad]
  mov [puntaje],al


  mov al,[contador_piezas_match]
  dec al
  mov [contador_piezas_match],al

  cmp al,0
  je realizar_gravedad_a_todo  ;EJECUTAR TODA LA GRAVEDAD, PARA LA REPOSICION DE BLOQUES FLOTANTES

  jmp limpiar_match


siguiente_deteccion:
  cmp dl,16d ;Limite inferior
  je terminar_deteccion

  ;Set cursor position
  mov ah,02h
  mov dh,18
  dec dl
  int 10h

  jmp detectar_match_loop
