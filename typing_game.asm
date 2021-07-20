include irvine32.inc

.data
   blank1 BYTE "apple", 0
   blank2 BYTE "ipad", 0
   blank3 BYTE "secu", 0
   blank4 BYTE "info", 0
   blank5 BYTE "water", 0
   blank6 BYTE "media", 0
   blank7 BYTE "card", 0
   blank8 BYTE "dise", 0
   blank9 BYTE "bmo", 0
   blank10 BYTE "huchu", 0
   
   print1 BYTE "===================="
         BYTE "===================="
         BYTE "====================", 0
   print2 BYTE "��° �ܾ� �Է�: ", 0
   print3 BYTE "(", 0
   print4 BYTE ")", 0
   print5 BYTE "��", 0
   print6 BYTE "/10", 0
   print7 BYTE "%", 0

   loop_count DWORD 0
   temp DWORD 0      
   enter_set DWORD 0

   perfect DWORD 0            ;����
   perfect2 DWORD 100         ;��Ȯ��

   TotalTime DWORD 0         ;�ɸ� �ð�
   TotalTime2 DWORD 0         ;�ɸ� �ð� ����
   TotalTime3 DWORD 0

   ok_count DWORD 0         ;���� Ƚ��

   userinput BYTE 50 DUP(?)   ;���ڿ� �迭
   word_length DWORD 0         ;���� ����
   total_length DWORD 0      ;���� ���� ����
   temp2 DWORD 0

   msg1 BYTE "(1) �� ����: ", 0
   msg2 BYTE "(2) �� �ð�: ", 0
   msg3 BYTE "(3) ���� Ƚ��: ", 0
   msg9 BYTE "(4) ��Ȯ��: ", 0

   msg4 BYTE "���� Ƚ��: ", 0
   msg5 BYTE "���� Ƚ��: ", 0 
   msg6 BYTE "����: ", 0
   msg7 BYTE "�Է��� ���� ��: ", 0
   msg8 BYTE "���� ���ڼ�: ", 0

   nt1 BYTE "(Matching)", 0
   nt2 BYTE "(Miss-Matching)", 0

.code
main PROC
   call game_loop      ;���� ���� ���ν��� ȣ��
   call result_game   ;��� ȭ�� ���ν��� ȣ��
   exit
main ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;���� ������ ���� ������ ��� �ִ� ���ν���
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

game_loop PROC
   mov ecx, 10         ;��ü �ܾ� 10��
   
   L1:
   mov loop_count, ecx   
   call print_str         ;���� ��� ���ν��� ȣ��

   call Getmseconds      ;�̺�Ʈ ���� �ð� ���� ����
   mov TotalTime, eax   

   call input_str         ;Ű���� �Է� ó�� ���ν��� ȣ��

   call Getmseconds      ;�ð� ���� ����
   sub eax, TotalTime
   mov TotalTime, eax
   add TotalTime2, eax   ;�ð� ����

   call comp_str1         ;���ڿ� �� ���ν��� ȣ��
   call comp_str2         
   
   mov ecx, loop_count   ;ī���� ����
   loop L1
   
   ret
game_loop ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;���� ���� �� ��� ��� ���ν���
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
result_game PROC
   mov dh, 13
   mov dl, 45
   call gotoxy
   mov edx, OFFSET msg1
   mov eax, perfect
   call writestring            ;"(1) �� ����: "
   call writedec                  ;���� ���

   mov dh, 14
   mov dl, 45
   call gotoxy 
   mov edx, OFFSET msg2
   call writestring            ;"(2) �� �ð�: "
   mov edx, 0
   mov eax, TotalTime2      
   mov ecx, 1000
   div ecx                           ;�и��� -> �� ���� ��ȯ
   call writedec                  ;�ð� ���
   mov edx, OFFSET print5   ;"��"
   call writestring

   mov dh, 15
   mov dl, 45
   call gotoxy
   mov edx, OFFSET msg3
   mov eax, ok_count            
   call writestring            ;"(3) ���� Ƚ��: "
   call writedec                  ;Ƚ�� ���
   mov edx, OFFSET print6
   call writestring            ;"/10"


   mov dh, 16
   mov dl, 45
   call gotoxy
   mov edx, OFFSET msg9
   mov eax, perfect2            
   call writestring            ;"(4) ��Ȯ��: "
   call writedec                  ;��Ȯ�� ���
   mov edx, OFFSET print7
   call writestring            ;"%"
   
   call crlf
   ret
result_game ENDP
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;���� ó�� �� ������ �Է¹��� ���ڿ��� ó���ϴ� ���ν���
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
input_str PROC
   mov edx, OFFSET userinput
   mov ecx, SIZEOF userinput
   call readstring            ;Ű���� �Է� ó��

   mov word_length, ecx  ;���� ���� ����
      
   call crlf      
   ret
input_str ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;���ڿ��� ���� �ܾ� ������ ��ġ/����ġ�� �Ǵ��ϴ� ���ν���
;Str_compare ���̺귯�� : ���ڿ� �� �� ���� ��ġ�� �� ZERO = 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
comp_str1 PROC
  .IF temp==0                        ;1�� �ܾ�� ��
    INVOKE Str_compare, ADDR userinput, ADDR blank1
    ret 
  .ELSEIF temp==1                  ;2�� �ܾ�� ��
    INVOKE Str_compare, ADDR userinput, ADDR blank2
    ret  
  .ELSEIF temp==2                  ;3�� �ܾ�� ��
    INVOKE Str_compare, ADDR userinput, ADDR blank3
    ret 
  .ELSEIF temp==3                  ;4�� �ܾ�� ��
    INVOKE Str_compare, ADDR userinput, ADDR blank4
    ret 
  .ELSEIF temp==4
    INVOKE Str_compare, ADDR userinput, ADDR blank5
    ret 
  .ELSEIF temp==5
    INVOKE Str_compare, ADDR userinput, ADDR blank6
    ret 
  .ELSEIF temp==6
    INVOKE Str_compare, ADDR userinput, ADDR blank7
    ret 
  .ELSEIF temp==7
    INVOKE Str_compare, ADDR userinput, ADDR blank8
    ret 
  .ELSEIF temp==8
    INVOKE Str_compare, ADDR userinput, ADDR blank9
    ret 
  .ELSEIF temp==9
    INVOKE Str_compare, ADDR userinput, ADDR blank10
    ret
  .ENDIF
  ret
comp_str1 ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Zero�� ������ �� ���� ������ ����ϴ� ���ν���
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
comp_str2 PROC
  .IF ZERO? ;���ڿ� ��ġ �Ǵ�          
   INVOKE Str_length, ADDR userinput
   mov word_length, eax         ;���ڿ� ���� ��ȯ
   
   mov dh, 22
   mov dl, 35
   call gotoxy
   mov edx, OFFSET msg6
   call writestring            ;"����: "
   mov eax, perfect
   add eax, 10
   mov perfect, eax            ;���� 10�� ����
   call writeint               ;���� ���
   call crlf

   mov dh, 22
   mov dl, 50
   call gotoxy
   mov edx, OFFSET nt1 
   call writestring            ;"(Matching)"
   call crlf

   mov dh, 22
   mov dl, 65
   call gotoxy
   mov edx, OFFSET msg5
   call writestring            ;"���� Ƚ��: "
   mov eax, ok_count
   add eax, 1
   mov ok_count, eax
   call writedec               ;���� Ƚ�� ���
   mov edx, OFFSET print6
   call writestring

   mov dh, 23
   mov dl, 35
   call gotoxy
   mov edx, OFFSET msg7         ;"�Է��� ���� ��: "
   call writestring
   mov eax, word_length
   call writedec               ;�Է��� ���� �� ���
   call crlf

   mov dh, 23
   mov dl, 65
   call gotoxy
   mov edx, OFFSET msg8         ;"���� ���� ��: "
   call writestring
   mov eax, word_length
   add total_length, eax
   mov eax, total_length
   call writedec               ;���� ���� �� ���
   call crlf


   ;���ڿ� ����ġ �Ǵ�
  .ELSE   
     INVOKE Str_length, ADDR userinput
   mov word_length, eax

   mov dh, 22
   mov dl, 35
   call gotoxy
   mov edx, OFFSET msg6
   call writestring               ;"����: "
   mov eax, perfect
   
   ;������ 0 ���ϸ� ���� ����
   .IF eax>0         
      sub eax, 5
   .ENDIF
   mov perfect, eax               ;���� ����
   call writeint                  ;���� ���
   call crlf

   mov edx, OFFSET print7
   mov eax, perfect2 
   .IF eax>0
      sub eax, 10
   .ENDIF
   mov perfect2, eax

   mov dh, 22
   mov dl, 50
   call gotoxy
    mov edx, OFFSET nt2 
    call writestring               ;"(Miss-Matching)"
   call crlf

   mov dh, 22
   mov dl, 65
   call gotoxy
   mov edx, OFFSET msg5
   call writestring               ;"���� Ƚ��: "
   mov eax, ok_count
   call writedec                  ;���� Ƚ�� ���
   call crlf

   mov dh, 23
   mov dl, 35
   call gotoxy
   mov edx, OFFSET msg7            ;"�Է��� ���� ��: "
   call writestring
   mov eax, word_length
   call writedec
   call crlf

   mov dh, 23
   mov dl, 65
   call gotoxy
   mov edx, OFFSET msg8            ;"���� ���ڼ�: "
   call writestring
   mov eax, total_length
   call writedec
   call crlf


  .ENDIF
   mov dh, 24
   mov dl, 35
   call gotoxy
   mov edx, OFFSET msg4            ;"���� Ƚ��: "
   call writestring
   mov eax, loop_count
   sub eax, 1
   call writedec                  ;���� Ƚ�� ���
   
   ;mov ecx, loop_count            ;ī���� ����
   add temp, 1                     ;���� �ܾ� �̵�
   
   mov dh, 26
   mov dl, 45
   call gotoxy
   call waitmsg

   call clrscr
   ret
comp_str2 ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;��ǥ�� �°� �ܾ ����ϴ� ���ν���
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_str PROC
   mov dh, 5               
   mov dl, 15               
   call gotoxy               
   mov edx, OFFSET blank1
   call writestring      ;blank1 ���
   
   mov dh, 5      
   mov dl, 35      
   call gotoxy         
   mov edx, OFFSET blank2
   call writestring      ;blank2 ���

   mov dh, 5
   mov dl, 55
   call gotoxy
   mov edx, OFFSET blank3
   call writestring      ;blank3 ���
   
   mov dh, 5
   mov dl, 75
   call gotoxy
   mov edx, OFFSET blank4
   call writestring      ;blank4 ���
   
   mov dh, 5   
   mov dl, 95   
   call gotoxy      
   mov edx, OFFSET blank5
   call writestring      ;blank5 ���
   
   mov dh, 9      
   mov dl, 15            
   call gotoxy               
   mov edx, OFFSET blank6
   call writestring      ;blank6 ���

   mov dh, 9
   mov dl, 35
   call gotoxy
   mov edx, OFFSET blank7
   call writestring      ;blank7 ���
   
   mov dh, 9
   mov dl, 55
   call gotoxy
   mov edx, OFFSET blank8
   call writestring      ;blank8 ���
   
   mov dh, 9
   mov dl, 75
   call gotoxy
   mov edx, OFFSET blank9
   call writestring      ;blank9 ���

      
   mov dh, 9
   mov dl, 95
   call gotoxy
   mov edx, OFFSET blank10
   call writestring      ;blank10 ���


   mov dh, 17
   mov dl, 28
   call gotoxy
   mov edx, OFFSET print1
   call writestring      ;�� ���

   mov dh, 19
   mov dl, 28
   call gotoxy
   mov edx, OFFSET print1
   call writestring      ;�� ���
   
   mov dh, 18
   mov dl, 38
   call gotoxy            ;�ȳ�
   mov eax, temp
   add eax, 1
   call writedec         
   mov edx, OFFSET print2
   call writestring

   mov dh, 18
   mov dl, 58
   call gotoxy            ;�Է¹޴� ��ġ ����
   ret
print_str ENDP

END main