generar_bloque:

  call sleep
  mov  bl,06h ;Para un color entre 0 y 6
  call generar_numero_aleatorio

  ;===============================;
  ; NOTA: TANTO EL COLOR NEGRO (CLARAMENTE NO SIRVE PORQUE EL FONDO ES NEGRO :v),
  ; COMO EL BLANCO (PARPADEA DE MANERA EXTRAÑA) NO PERMITEN UNA CORRECTA EJECUCION
  ; ... (NUNCA SABREMOS PORQUE :C ...)

  inc al ;Por eso sumamos uno, para evitar el negro :D
  mov [color_bloque_1],al

  call sleep
  mov  bl,06h
  call generar_numero_aleatorio

  inc al
  mov [color_bloque_2],al

  call sleep
  mov  bl,06h
  call generar_numero_aleatorio

  inc al
  mov [color_bloque_3],al
  ret

usar_bloque:
  push ax

  ;SE UTILIZAN LOS COLORES ALMACENADOS PREVIAMENTE (COMO SIGUIENTE BLOQUE).

  mov al, byte [color_bloque_1]
  mov byte [actual_color_bloque_1], al

  mov al, byte [color_bloque_2]
  mov byte [actual_color_bloque_2], al

  mov al, byte [color_bloque_3]
  mov byte [actual_color_bloque_3], al

  pop ax
  ret

nuevo_bloque:

  ;SE COMPRUEBA QUE EL SIGUIENTE BLOQUE PUEDE SER DIBUJADO

  ;Set cursor position
  mov ah,02h
  xor bh,bh
  mov dh,8
  mov dl,18
  int 10h

  ;Read char
  mov ah,08h
  int 10h

  cmp al,219d ;Cuadrado Ascii Code
  je _end 

  mov [bloque_x],dl
  mov [prev_bloque_x],dl

  mov [bloque_y],dh
  mov [prev_bloque_y],dh

  mov al,[contador_velocidad]
  inc al
  mov [contador_velocidad],al

  cmp al,5
  je aumentar_velocidad_gravedad

  ret

aumentar_velocidad_gravedad:
  mov al,[velocidad_gravedad]

  cmp al,1
  je no_aumentar_velocidad_gravedad

  dec al
  mov [velocidad_gravedad],al

  mov byte [contador_velocidad],0

  ret

no_aumentar_velocidad_gravedad:
  ret
