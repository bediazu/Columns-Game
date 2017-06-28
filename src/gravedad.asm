activar_gravedad:
  mov al,[contador_tempos_gravedad]
  mov ah,[tempo_gravedad]

  cmp al,ah
  jg realizar_gravedad ; Se comprueba si se debe hacer uso de la grevedad c:

  ret

realizar_gravedad:
  mov ah,[velocidad_gravedad]
  add al,ah
  mov [tempo_gravedad],al

  mov al,[bloque_y]

  cmp al,18d
  je sin_gravedad

  inc al
  mov [bloque_y],al

  ret

sin_gravedad:
  ret

reiniciar_gravedad:
  xor al,al
  mov [contador_tempos_gravedad],al  ;RESETEO DE LOS VALORES (GRAVEDAD)
  mov [tempo_gravedad],al

  ret


realizar_gravedad_a_todo:
  mov dh,18
  mov dl,22

  mov byte [tamanio_caida_gravedad],0

  gravedad_loop:
        ;Set cursor position
        mov ah,02h
        xor bh,bh
        int 10h

        ;Read a char
        mov ah,08h
        int 10h

        mov [color_analisis],ah  ; Guardamos el color

        cmp al,219d ;Cuadrado Ascii Code
        je posicion_gravedad

        mov al,[tamanio_caida_gravedad]
        inc al
        mov [tamanio_caida_gravedad],al

        jmp siguiente_gravedad

    posicion_gravedad:
        mov al,[tamanio_caida_gravedad]  ; Comprobamos si es que
        cmp al,0             ; hay que aplicar
        je siguiente_gravedad      ; gravedad

        ;=====================
          ;Borrar Cuadrado
        ;====================

        ;Write a char
        mov ah,09h
        mov al,0
        xor bx,bx
        mov cx,1
        int 10h

        ;Set cursor position
        mov ah,02h
        add dh,[tamanio_caida_gravedad]
        int 10h

        ;Write a char
        mov ah,09h
        mov al,219d ;Cuadrado Ascii Code
        mov bl,[color_analisis]
        mov cx,1
        int 10h

        mov byte [tamanio_caida_gravedad],0  ; reseteamos la gravedad

        jmp gravedad_loop

    siguiente_gravedad:
        cmp dh,6
        je gravedad_columna

        dec dh
        jmp gravedad_loop


gravedad_columna:
  cmp dl,17
  je terminar_gravedad

  dec dl
  mov dh,18

  mov byte [tamanio_caida_gravedad],0

  jmp gravedad_loop

terminar_gravedad:
  call dibujar_puntos
  call emitir_sonido_match

  jmp detectar_match
