STACK SEGMENT PARA STACK
    DB 64 DUP (' ')
STACK ENDS

DATA SEGMENT PARA 'DATA' ;데이터를 저장하는 segment

    BALL_X DW 0Ah
    BALL_Y DW 0Ah
    BALL_SIZE DW 04h ;size of the ball

DATA ENDS

CODE SEGMENT PARA 'CODE'

    MAIN PROC FAR
    ASSUME CS:CODE,DS:DATA,SS:STACK ;assume as code,data, stack segment the respective registers
    PUSH DS                         ;push to the stack the DS segment
    SUB AX,AX                       ;clean the AX register
    PUSH AX                         ;push AX to the stack
    MOV AX,DATA                     ;save on the AX register the contents of the DATA segment
    MOV DS,AX                       ;save on the DS segment the contents of AX
    POP AX                          ;release the top item from the stack to the AX register
    POP AX

        MOV AH,00h ;set the configuration to video mode
        MOV AL,13h ;choose the video mode
        INT 10h    ;execute the configuration

        MOV AH, 0Bh ;set the configuration 
        MOV BH, 00h ; to the background color
        MOV BL, 00h ;choose black as background color
        INT 10h


        CALL DRAW_BALL


        RET
    MAIN ENDP

    DRAW_BALL PROC NEAR 

        MOV CX, BALL_X ;set the column (X 축)
        MOV DX, BALL_Y ;set the line (Y 축)

        DRAW_BALL_HORIZONTAL:
            MOV AH, 0Ch ;set the configuration to writing a pixel
            MOV AL, 0Fh ;choose white as color
            MOV BH, 00h ;set the page number
            INT 10h     ;execute the configuration
            
            INC CX      ;CX = CX + 1
            MOV AX,CX
            SUB AX,BALL_X
            CMP AX,BALL_SIZE
            JNG DRAW_BALL_HORIZONTAL
            
            MOV CX,BALL_X
            INC DX
            
            MOV AX,DX
            SUB AX,BALL_Y
            CMP AX,BALL_SIZE
            JNG DRAW_BALL_HORIZONTAL


        RET
    DRAW_BALL ENDP

CODE ENDS
END