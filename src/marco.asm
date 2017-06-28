dibujar_marco_juego:
  ;Impresion de la esquina superior izquierda
  mov ah,02h
  mov dl,201d ;Esquina superior izquierda Ascii Code.
  int 21h

  mov cx,06d
  call dibujar_marco_horizontal

  ;Impresion de la esquina superior derecha
  mov ah,02h
  mov dl,187d ;Esquina superior derecha Ascii Code.
  int 21h

  mov cl,13d
  call dibujar_marco_vertical

  ;Get cursor position
  mov ah,03h
  int 10h

  ;Set cursor position
  mov ah,02h
  dec dl
  inc dh
  int 10h

  ;Impresion esquina inferior derecha
  mov ah,02h
  mov dl,188d
  int 21h

  ;Get cursor position
  mov ah,03h
  int 10h

  ;Set cursor position
  mov ah,02h
  sub dl,8
  int 10h

  ;Impresion esquina inferior izquierda
  mov ah,02h
  mov dl,200d
  int 21h

  mov cx,06d
  call dibujar_marco_horizontal

  ;Set cursor position
  mov ah,02h
  mov dh,5
  mov dl,17
  mov bh,0x0
  int 10h

  mov cx,13d
  call dibujar_marco_vertical

  ret

dibujar_marco_horizontal:
  ;Dibuja una linea horizontal ¡¡CX!! veces
  mov ah,02h
  mov dl,205d ;Linea horizontal Ascii Code.
  int 21h

  loop dibujar_marco_horizontal
  ret

dibujar_marco_vertical:
  ;Dibuja una linea vertical ¡¡CL!! veces

  push cx

  ;Get cursor position
  mov ah,03h
  int 10h

  ;Set cursor position
  mov ah,02h
  dec dl
  inc dh
  int 10h

  mov ah,02h
  mov dl,186d ;Linea vertical Ascii Code.
  int 21h

  pop cx
  loop dibujar_marco_vertical

  ret

dibujar_texto_siguiente_bloque:

  ;Set cursor position
  mov ah,02h
  mov dh,6d
  mov dl,26d
  int 10h

  ;Print a string
  mov dx,msg_next_block
  mov ah,9
  int 21h

dibujar_marco_siguiente_bloque:

  ;Set cursor position
  mov ah,02h
  mov dh,7d
  mov dl,29d
  int 10h

  mov ah,0eh
  mov al,201d
  int 10h

  mov al,205d
  int 10h

  mov al,187d
  int 10h

  mov cx,3d

  call dibujar_marco_vertical

  ;Set cursor position
  mov ah,02h
  mov dh,7d
  mov dl,30d
  int 10h

  mov cx,3d

  call dibujar_marco_vertical

  ;Set cursor position
  mov ah,02h
  mov dh,11d
  mov dl,29d
  int 10h

  mov ah,0eh
  mov al,200d
  int 10h

  mov al,205d
  int 10h

  mov al,188d
  int 10h


dibujar_texto_bienvenido:

  ;Set cursor position
  mov ah,02h
  mov dh,01h
  mov dl,0fh
  int 10h

  mov ah,09h
  mov al,03d
  xor bx,bx
  mov bl,0ch
  xor cx,cx
  mov cl,01h
  int 10h

  ;Set cursor position
  mov ah,02h
  mov dh,01h
  mov dl,11h
  int 10h

  ;Print a string
  mov dx,msg_welcome
  mov ah,9
  int 21h

  ;Set cursor position
  mov ah,02h
  mov dh,01h
  mov dl,19h
  int 10h

  mov ah,09h
  mov al,03d
  xor bx,bx
  mov bl,0ch
  xor cx,cx
  mov cl,01h
  int 10h

  ;Set cursor position
  mov ah,02h
  mov dh,02h
  mov dl,11h
  int 10h

  mov cx,7d
  mov ah,0eh
  mov al,196d
  loop_subrayado_bienvenido:
      int 10h
      loop loop_subrayado_bienvenido
  ret

dibujar_texto_teclas:
  ;Set cursor position
  mov ah,02h
  mov dh,14d
  mov dl,04d
  int 10h

  ;Print a string
  mov dx,msg_teclas
  mov ah,09h
  int 21h

  ;Set cursor position
  mov ah,02h
  mov dh,15d
  mov dl,03d
  int 10h

  ;Print a string
  mov dx,msg_left
  mov ah,09h
  int 21h

  ;Set cursor position
  mov ah,02h
  mov dh,16d
  mov dl,03d
  int 10h

  ;Print a string
  mov dx,msg_right
  mov ah,09h
  int 21h

  ;Set cursor position
  mov ah,02h
  mov dh,17d
  mov dl,03d
  int 10h

  ;Print a string
  mov dx,msg_rotate
  mov ah,09h
  int 21h

  ;Set cursor position
  mov ah,02h
  mov dh,18d
  mov dl,03d
  int 10h

  ;Print a string
  mov dx,msg_down
  mov ah,09h
  int 21h

dibujar_marco_teclas:
  ;Set cursor position
  mov ah,02h
  mov dh,13d
  mov dl,01d
  int 10h

  mov ah,0eh
  mov al,201d
  int 10h

  mov al,205d

  int 10h
  int 10h
  int 10h
  int 10h
  int 10h
  int 10h
  int 10h
  int 10h
  int 10h

  mov al,187d
  int 10h

  mov cx,5d

  call dibujar_marco_vertical

  ;Set cursor position
  mov ah,02h
  mov dh,13d
  mov dl,02d
  int 10h

  mov cx,5d
  call dibujar_marco_vertical

  ;Set cursor position
  mov ah,02h
  mov dh,19d
  mov dl,01d
  int 10h

  mov ah,0eh
  mov al,200d
  int 10h

  mov cx,9d
  call dibujar_marco_horizontal

  mov ah,0eh
  mov al,188d
  int 10h

  ret

dibujar_texto_salir:
  xor bx,bx

  ;Set cursor position
  mov ah,02h
  mov dh,15d
  mov dl,24d
  int 10h

  ;Print a string
  mov dx,msg_exit
  mov ah,09h
  int 21h

  ret

dibujar_texto_score:
  xor bx,bx

  ;Set cursor position
  mov ah,02h
  mov dh,08d
  mov dl,03d
  int 10h

  ;Print a string
  mov dx,msg_score
  mov ah,09h
  int 21h

  ;Set cursor position
  mov ah,02h
  mov dh,9d
  mov dl,03d
  int 10h

  mov cx,5d
  mov ah,0eh
  mov al,196d
  loop_subrayado_score:
      int 10h
      loop loop_subrayado_score

  ret
