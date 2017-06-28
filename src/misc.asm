;Funciones miscelaneas

generar_numero_aleatorio:
    xor ah,ah

    mov al, byte [numero_aleatorio]
    add al, 31
    mov byte [numero_aleatorio], al

    div bl
    mov al, ah
    xor ah, ah
    ret

sleep:
  mov cx, 1
  mov dx, 2
  mov ah, 86h
  int 15h

  ret

nuevo_turno:
    call sleep

    mov al,[contador_tempos_gravedad]
    inc al
    mov [contador_tempos_gravedad],al
    ret

realizar_delay:
    push bx
    push cx
    push dx
    push ax

    ;Get system time
    xor bl, bl
    mov ah, 2Ch
    int 21h

    mov byte al, [numero_aleatorio]
    add al, dl
    mov byte [numero_aleatorio], al

    ;Save the seconds
    mov [delay_inicial], dh

    add dl, [delay_segundos]
    cmp dl, 100
    jb delay_ajustado_de_segundos_completo

    sub dl, 100
    mov bl, 1

    delay_ajustado_de_segundos_completo:
    mov [delay_punto_detencion_segundos], dl

    leer_tiempo:
    ;Get system time
    int 21h

    test bl, bl
    je modificar_segundos

    cmp dh, [delay_inicial]
    je leer_tiempo

    push dx
    sub dh, [delay_inicial]
    cmp dh, 2
    pop dx
    jae done_delay

    jmp check_punto_de_detencion

    modificar_segundos:

    cmp dh, [delay_inicial]
    jne done_delay

    check_punto_de_detencion:

    cmp dl, [delay_punto_detencion_segundos]
    jb leer_tiempo

    done_delay:
    pop ax
    pop dx
    pop cx
    pop bx

    ret
