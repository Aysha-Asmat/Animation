
; hello world in assembly
[org 0x0100]
jmp start
;--------------------------------------------------------------------
; subroutine to clear the screen
;--------------------------------------------------------------------
clrscr:		push es
			push ax
			push di

			mov ax, 0xb800
			mov es, ax					; point es to video base
			mov di, 0					; point di to top left column
			mov ax, 0x3A00              ; color cyan

sky:	    mov word [es:di], AX	; clear next char on screen
			add di,2					; move to next screen location
			cmp di, 5280		; 132x20x2
			jne sky		         	; if no clear next position
			
			mov ax,0x0720          ; for the road 
		
road:
            mov word [es:di],ax
            add di,2
            cmp di,8184             ;  132x2x31
            jne road
			
			mov ax, 0x1A20             ;for the sea
			
sea:			
            mov word [es:di],ax
			add di,2
            cmp di,11352			;132x43x2
         	jne sea
		
			pop di
			pop ax
			pop es
			ret
			
;-----------------------------------------------------------------------------			

			
;----------------------------------------------------------------------------
zebra:	

            push es
			push ax
			push di
			push cx
		
            
			mov ax, 0xb800
			mov es, ax	
			mov di,6608                   ;starting index
			mov ax,0xFA20	             ;ascii and attribute for zebra zrossing
			mov cx,6
	
crossing:
            mov word[es:di],ax
			add di,2
			loop crossing                ;the number of cells a cross should have cells
			mov cx,6
			add di,14                    ;the space between 2 zebra crossings
			cmp di,6864                                  ;end index limit
			jbe crossing                      


            pop di
			pop ax
			pop es
			pop cx
			ret

;-------------------------------------------------------------------------------------
vehicle:

            push es
			push ax
			push di
			push dx
            push cx
            push bx			
            mov ax,0xb800
            mov es,ax
 
	        mov ax, 0xb800
			mov es, ax	
		    mov ax,0x5420
			
		   mov bx,4                     ;instructions for car
		   mov dx,12
		    mov di,6516
			mov cx,dx
			mov si,2
	
vehic:
            mov word[es:di],ax
            add di,2                     ;printing every line
			loop vehic
		   add dx,si                    ;adding number of cells by 2
			mov cx,dx
			add di,238                ;moving to next line
			sub bx,1
			cmp bx,2                     ;this code for first 2 lines
			jne vehic
	;		
			add cx,3                    ;printing next 2 lines with e more cells 
			mov dx,cx
            sub di,10
			mov si,1


            
veh:
            mov word[es:di],ax
            add di,2
			loop veh
			add dx,1                     ;adding one cell
			mov cx,dx
		    add di,226
		    sub bx,1
			cmp bx,0
			jne veh          






			mov ax,0x705F
			mov di,6784                  ;instructions for window size
			mov dx,2
			mov bx,6794
			
window:
            mov word[es:di],ax
            add di,2
			cmp di,bx                     ;limit for the window size
			jne window
			
			add di,254
			sub dx,1                         ;for second row of window
			add bx,264
			cmp dx,1                         
			mov ax,0x7020
            je window
			
			mov ax,0x707C
			mov di,6788                                 ;instructions for the characters
			mov dx,2

wind:
            mov word[es:di],ax
            add di,264
			sub dx,1                               ;char in centre
			cmp dx,1
			je wind
			
			mov ax, 0xb800
			mov es, ax	
			mov di,7306
			mov ax,0x074F	
			;mov si,2
			mov si,1                       ;instructions for wheel
			mov dx,si                            ;no. of cells
			mov cx,2
			;mov bx,16
			mov bx,20                    

whel:
            mov word[es:di],ax
            add di,2
			sub dx,1                    
            cmp dx,0
            jne whel
			add di,bx           ;second wheel
			mov dx,si
			loop whel
			
			add si,2                    ;next line
			mov dx,si                   
			;add di,222
			add di,218              ;next line
			mov cx, 2
			sub bx,4                 ;reducing cells between 2 wheels
			cmp di,7570               ;only for 2nd line              
            jbe whel

			sub si,4
			mov dx,si                                    
			add di,4
			mov cx, 2            ;next line
			add bx,8

            cmp di,7920                                              ;max wheel size 3rd line
			jbe whel

            pop di
			pop ax
			pop es
			pop dx
			pop bx
			pop cx
			ret


;-------------------------------------------------------------------------------------------------------------------------


 ;-----------------------------------------------------------------------------           
 
;-------------------------------------------------------------------------------------
mountain:
            push es
			push ax
			push di
			push dx
            push cx
            push bx	
			push si
           
            mov ax, 0xb800                     ;instructions for 1 mountain
			mov es, ax	
			mov di,2658
			mov ax,0x6A20	
basemoun:			
          	mov si,1
			mov cx,si
            mov dx,260	                    ;strting index
            mov bx,	0		
		
mountains:

            mov word[es:di],ax
			add di,2                           ;for 1st row
			loop mountains
			add si,2
			mov cx,si                                ;addition for every row
			add di,dx              ;moving to next line
			sub di,bx              ;exact index
			add bx,4                                 ;increment every time
			cmp bx,36                           ;max lines
			jbe mountains
			sub di,228   
			sub di,2374                          ;for next mountains
			add di,18
			sub byte [mounc],1                ;for mountain counts standard 6
			cmp byte [mounc],0
			jne basemoun                ;jumping to start thing
			mov di,5268                 ;mountain for the space left
			mov si,6
			mov cx,si
			mov bx,10
mount:
            mov word[es:di],ax                      
			add di,2                     
			loop mount
			sub di,264                          ;uper line
			sub si,1                      ;max cells
			sub di,bx                         ;exact index
			sub bx,2
			mov cx,si                      ;cells record
			cmp bx,0
			jge mount
            
            			
            pop si
            pop di
			pop ax
			pop es
			pop dx
			pop bx
			pop cx
			ret
;----------------------------------------------------------------------------
 grasses:
            push es
			push ax
			push di
			push dx
            push cx
            push bx	
			push si
           
            mov ax, 0xb800
			mov es, ax	
			mov di,4230           ;start index
			mov ax,0x2A20
			mov dx,33

gr:           
			mov bx,260
			mov word[es:di],ax              ;for the one piece 1st line
			add di,2
			add di,bx
			mov si,2          ;no. of cells			
            mov cx,si
              
grass:
            mov word[es:di],ax
			add di,2
			loop grass                  ;cells count
			sub bx,2
			add di,bx              ;next line
            add si,1
			mov cx,si
			cmp si,5                  ;no. of ines chheck
			jne grass
			sub dx,1
			;add di,2
            sub di,1040              ;1038         ;exact index
            cmp dx,0                          ;no. of total grass pieces
			jne gr
 
 
            pop si
            pop di
			pop ax
			pop es
			pop dx
			pop bx
			pop cx
			ret
 
;------------------------------------------------------------------------
sunn:
            mov bp,sp
            push es
            push bx	
			push si
          
			 
            mov ax, 0xb800
			mov es, ax	                          ;passing parameters
            mov ax,[bp+6]
			mov di,[bp+4]
			mov dx,[bp+2]
			mov cx,[bp+8]
			mov si,2
			mov bx,cx
sun:
			mov word[es:di],ax		
            add di,dx                              ;number of times at first
			loop sun
			add di,dx
            sub si,1
            mov cx,bx               ;the jump over dot
			cmp si,0
			jne sun
			
			
			pop si
			pop es
			pop bx
			ret 8
;------------------------------------------------------------------------
chars: 
            mov bp,sp
            push es
            push bx	
			push si
             
			mov ax, 0xb800
			mov es, ax	
            mov ax,[bp+6]               ;passing parameters
			mov di,[bp+4]
			mov dx,[bp+2]
			mov cx,2
			mov si,cx
			
slash:
	    
			mov word[es:di],ax	
			add di,dx                      ;the number of times vertically
		    loop slash
			add di,dx                    ;the jump
			add di,2
			sub si,1
			mov cx,2
			cmp si,0                   
			jne slash
			
			pop si
			pop es
			pop bx
			ret 8			
;--------------------------------------------------------------------
clouds:
            push es
			push ax
			push di
			push dx
            push cx
            push bx	
			push si
           
            mov ax, 0xb800
			mov es, ax	
		    mov di,558      
			mov ax,0x7320
			mov si,4
			mov bx,4                                     ;instructions for start
			
			mov cx,bx
			mov dx,100
			mov byte [mounc],3
			mov byte [size],2
				
cloud:			
            mov word[es:di],ax
			add di,2
            loop cloud
			add di,dx
			mov cx,bx
            sub byte [mounc],1                                      ;vertical cloud
			cmp  byte [mounc],0
			jg cloud
			mov byte [mounc],3
			sub di,60
			sub si,1
			cmp si,0
			jne cloud
			mov di,814 
			mov si,2
			mov bx,12
			mov cx,bx
			mov dx,84
			mov byte [mounc],3
			sub byte [size],1
			cmp byte [size],0
			jne cloud


		

        	pop si
            pop di
			pop ax
			pop es
			pop dx
			pop bx
			pop cx
			ret

;------------------------------------------------------------------------------
birds:
            push es
			push ax
			push di
			push dx
            push cx
            push bx	
			push si
           
            mov ax, 0xb800    
			
			mov es, ax	
		    mov di,880 
			mov ax,0x317E
			mov si,7       ;instructions
			mov cx,si
			mov dx,252
bird: 
            mov word[es:di],ax
			add di,2             ;for one row
			loop bird
			sub si,2         ;dec
			mov cx,si
			add di,dx
			add dx,4
			mov word[es:di],ax
			add di,2                 ;number of rows
			loop bird                                 
			mov di,1258          ; sun centre
			mov ax,0x342E
            mov word[es:di],ax	

         	pop si
            pop di
			pop ax
			pop es
			pop dx
			pop bx
			pop cx
			ret

;---------------------------------------------------------------------
printscreen:
            call clrscr ; call the clrscr subroutine to color the whole screen accordingly
            call zebra      ;call the zebra function to print zebra crossing on the road
              
		   call vehicle           ;call the vehicle function to print car 
           ; call wheel          ;this funcction prints the wheel of the car
            call mountain       ; this function will print the row of mountains
            call grasses            ; this function will print grass in front of the mountains
			
			
			
            		
			
			
			
			mov cx,4                ;the no. of times you want to print char
			push cx
			mov ax,0x3E5F             ; the color attribute and the character ascii
			push ax
			mov di,1250               ; the starting location of verticle rays 
			push di
			mov dx,2            ; printing the horizontal rays and moving to next location by adding 2
			push dx
           
			call sunn            ; this function will print the sun rays in horizontal form
			
			mov cx,2                  ;the no. of times you want to print char
			push cx
        	mov ax,0x3E7C                  ; the color attribute and the character ascii
			push ax
			mov di,730                       ; the starting location of verticle rays 
			push di
			mov dx,264                     ; printing the verticle rays and moving to next line by adding 264
			push dx
		
            call sunn               ; this function will print the sun rays in verticle form                  
			
	
        	mov ax,0x3E5C               ; the color attribute and the character ascii
			push ax
			mov di,724                       ; the starting location of verticle rays 
			push di
			mov dx,266                     ; printing the verticle rays and moving to next line by adding 264
			push dx
			call chars
			
			mov ax,0x3E2F               ; the color attribute and the character ascii
			push ax
			mov di,738                    ; the starting location of verticle rays 
			push di
			mov dx,260                   
			push dx
			call chars
			
			
			call birds            ; this function will print birds
           

		   call clouds              ;this function will print clouds in the sky
			
			ret

;--------------------------------------------------------------------
start:	
; following code just changes your screen resolution to 43x132 Mode
mov AH,0x00
mov al, 0x54
int 0x10



call printscreen            ;calling printscreen function to display scen

mov ax, 0x4c00 ; terminate program
int 0x21

mounc: db 7
size: db 2
add :dw 264