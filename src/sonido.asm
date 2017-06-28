;FUNCION DE SONIDO OBTENIDA DE STACKOVERFLOW;
;
;
;https://stackoverflow.com/questions/29714604/make-beep-sound-in-bios
;
;
;

emitir_sonido_match:
  mov al, 182         ;Prepara el "SPEAKER" para un sonido
  out 43h, al
  mov ax, 2380    ; Frequency number (in decimal)
                         ;  for C.
  out 42h, al     ; Output low byte.
  mov al, ah      ; Output high byte.
  out 42h, al
  in  al, 62h     ; Turn on note (get value from
                         ;  port 61h).
  or al, 00000011b   ; Set bits 1 and 0.
  out 61h, al         ; Send new value.
  mov bx, 4       ; Pause for duration of note.
.pause1:
  mov cx, 65535
.pause2:
  dec cx
  jne .pause2
  dec bx
  jne .pause1
  in   al, 61h         ; Turn off note (get value from
                              ;  port 61h).
  and  al, 11111100b   ; Reset bits 1 and 0.
  out  61h, al         ; Send new value.
  ret


emitir_sonido_game_over:
  mov al, 182         ;Prepara el "SPEAKER" para un sonido
  out 43h, al
  mov ax, 2380    ; Frequency number (in decimal)
                         ;  for C.
  out 42h, al     ; Output low byte.
  mov al, ah      ; Output high byte.
  out 42h, al
  in  al, 61h     ; Turn on note (get value from
                         ;  port 61h).
  or al, 00000011b   ; Set bits 1 and 0.
  out 61h, al         ; Send new value.
  mov bx, 4       ; Pause for duration of note.
._pause1:
  mov cx, 65535
._pause2:
  dec cx
  jne ._pause2
  dec bx
  jne ._pause1
  in   al, 61h         ; Turn off note (get value from
                              ;  port 61h).
  and  al, 11111100b   ; Reset bits 1 and 0.
  out  61h, al         ; Send new value.
  ret
