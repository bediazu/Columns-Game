detectar_colision:

  mov dh,[bloque_y]

  cmp dh,18d ;Limite inferior del marco
  je colision_inferior

  ;Set cursor position
  mov ah,02h
  xor bh,bh
  inc dh
  mov dl,[bloque_x]
  int 10h

  ;Read a char
  mov ah,08h
  int 10h

  cmp al,219d ;Cuadrado Ascii Code
  je colision_inferior

  ret

ultimo_movimiento:
  ;==PERMITE EL ULTIMO MOVIMIENTO JUSTO AL COLISIONAR CON UN BLOQUE==;
  ;REQUISITO DE LA TAREA;;
  call realizar_delay
  loop ultimo_movimiento

  mov al,1d             ;Actualiza la posibilidad de una nueva opcion de ultimo movimiento
  mov [colision],al
  jmp main_game

colision_inferior:

  pop ax
  xor cx,cx
  mov cl,10d

  ;Comprobacion de un ultimo movimiento al impactar
  mov al,[colision]
  cmp al,0
  je ultimo_movimiento

  call dibujar_bloque
  call detectar_match   ;Comprobacion de eliminacion de bloques.
  call usar_bloque
  call generar_bloque
  call dibujar_siguiente_bloque
  call nuevo_bloque
  call reiniciar_gravedad ; Se resetean todos los valores para el efecto de gravedad

  xor al,al           ;Se actuliza el contador de ultima oportunidad
  mov [colision],al  

  jmp main_game

detectar_colision_derecha:
  ;Set cursor position
  mov ah,02h
  xor bh,bh
  mov dl,[bloque_x]
  mov dh,[bloque_y]
  inc dl
  int 10h

  ;Read char
  mov ah,08h
  int 10h

  cmp al,219d ;Cuadrado Ascii Code
  jne sin_colision

  pop ax
  ret

detectar_colision_izquierda:
  ;Set cursor position
  mov ah,02h
  xor bh,bh
  mov dh,[bloque_y]
  mov dl,[bloque_x]
  dec dl
  int 10h

  ;Read char
  mov ah,08h
  int 10h

  cmp al,219d;Cuadrado Ascii Code
  jne sin_colision

  pop ax
  ret

detectar_colision_inferior:

  ;Set cursor position
  mov ah,02h
  xor bh,bh
  mov dh,[bloque_y]
  mov dl,[bloque_x]
  inc dh
  int 10h

  ;Read char
  mov ah,08h
  int 10h

  cmp al,219d ;Cuadrado Ascii Code
  jne sin_colision

  pop ax
  ret

sin_colision:
  ret
