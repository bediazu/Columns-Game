detectar_tecla:

  ;Check for keystroke
  mov ah,01h
  int 16h
  ;Activa la flag Zero en caso de ¡¡NO!! detectar una tecla
  ;(Por eso usamos 'jnz')
  jnz leer_tecla_presionada
  ret

leer_tecla_presionada:
  ;Get keystroke
  xor ax,ax
  int 16h

  ;Esta funcion actual como un fflush(stdin)
  ;Dado que la interrupcion 16 con ah=06h imprime un valor directamente. Imprimimos un valor no valido

  push ax
  mov ah,06h
  mov dl,0FFh
  int 21h
  pop ax
  ;Esto evita muchas veces la doble lectura y errores del dosbox muy extraños
  ;Solucion obtenida por ayuda de otro compañero,que presentaba el mismo problema.


  ;Deteccion de la tecla presionando
  ;Podemos hacer uso del "BIOS SCAN CODE". NASM permite la comparacion directa

  cmp al,'w'
  je rotar_colores

  cmp al,'s'
  je mover_abajo

  cmp al,'d'
  je mover_derecha

  cmp al,'a'
  je mover_izquierda

  cmp al,'q'
  je _end

  cmp al,02h ;ESC bios scan code
  je _end

  ret

mover_abajo:

  ;Deteccion de un bloque por debajo
  call detectar_colision_inferior
  mov al,[bloque_y]

  ;Deteccion del limite del marco
  cmp al,18d ;Posicion limite inferior del eje y (El marco)
  je sin_movimiento

  inc al
  mov [bloque_y],al
  ret

mover_derecha:

  ;Deteccion de un bloque a la derecha.
  call detectar_colision_derecha
  mov al,[bloque_x]

  ;Deteccion del limite del marco.
  cmp al,22d ;Posicion limite derecho del eje x (El marco)
  je sin_movimiento

  inc al
  mov [bloque_x],al
  ret

mover_izquierda:
  call detectar_colision_izquierda
  mov al,[bloque_x]

  ;Deteccion del limite del marco
  cmp al,17d ;Posicion limite izquierdo del eje x (El marco)
  je sin_movimiento

  dec al
  mov [bloque_x],al
  ret

sin_movimiento:
  ret

rotar_colores:
  ;Orden de rotacion:

  ;Color_2 = Color_1
  ;Color_3 = Color_2
  ;Color_1 = Color_3

  mov al,[actual_color_bloque_1]
  mov ah,[actual_color_bloque_2]
  mov [actual_color_bloque_2],al
  mov al,[actual_color_bloque_3]
  mov [actual_color_bloque_3],ah
  mov [actual_color_bloque_1],al

  ret
