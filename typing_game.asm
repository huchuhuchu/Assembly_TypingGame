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
   print2 BYTE "번째 단어 입력: ", 0
   print3 BYTE "(", 0
   print4 BYTE ")", 0
   print5 BYTE "초", 0
   print6 BYTE "/10", 0
   print7 BYTE "%", 0

   loop_count DWORD 0
   temp DWORD 0      
   enter_set DWORD 0

   perfect DWORD 0            ;점수
   perfect2 DWORD 100         ;정확도

   TotalTime DWORD 0         ;걸린 시간
   TotalTime2 DWORD 0         ;걸린 시간 누적
   TotalTime3 DWORD 0

   ok_count DWORD 0         ;정답 횟수

   userinput BYTE 50 DUP(?)   ;문자열 배열
   word_length DWORD 0         ;문자 갯수
   total_length DWORD 0      ;문자 갯수 누적
   temp2 DWORD 0

   msg1 BYTE "(1) 총 점수: ", 0
   msg2 BYTE "(2) 총 시간: ", 0
   msg3 BYTE "(3) 정답 횟수: ", 0
   msg9 BYTE "(4) 정확도: ", 0

   msg4 BYTE "남은 횟수: ", 0
   msg5 BYTE "정답 횟수: ", 0 
   msg6 BYTE "점수: ", 0
   msg7 BYTE "입력한 글자 수: ", 0
   msg8 BYTE "누적 글자수: ", 0

   nt1 BYTE "(Matching)", 0
   nt2 BYTE "(Miss-Matching)", 0

.code
main PROC
   call game_loop      ;게임 루프 프로시저 호출
   call result_game   ;결과 화면 프로시저 호출
   exit
main ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;게임 시작을 위한 루프를 담고 있는 프로시저
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

game_loop PROC
   mov ecx, 10         ;전체 단어 10개
   
   L1:
   mov loop_count, ecx   
   call print_str         ;문장 출력 프로시저 호출

   call Getmseconds      ;이벤트 수행 시간 측정 시작
   mov TotalTime, eax   

   call input_str         ;키보드 입력 처리 프로시저 호출

   call Getmseconds      ;시간 측정 종료
   sub eax, TotalTime
   mov TotalTime, eax
   add TotalTime2, eax   ;시간 누적

   call comp_str1         ;문자열 비교 프로시저 호출
   call comp_str2         
   
   mov ecx, loop_count   ;카운터 복구
   loop L1
   
   ret
game_loop ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;게임 종료 후 결과 출력 프로시저
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
result_game PROC
   mov dh, 13
   mov dl, 45
   call gotoxy
   mov edx, OFFSET msg1
   mov eax, perfect
   call writestring            ;"(1) 총 점수: "
   call writedec                  ;점수 출력

   mov dh, 14
   mov dl, 45
   call gotoxy 
   mov edx, OFFSET msg2
   call writestring            ;"(2) 총 시간: "
   mov edx, 0
   mov eax, TotalTime2      
   mov ecx, 1000
   div ecx                           ;밀리초 -> 초 단위 변환
   call writedec                  ;시간 출력
   mov edx, OFFSET print5   ;"초"
   call writestring

   mov dh, 15
   mov dl, 45
   call gotoxy
   mov edx, OFFSET msg3
   mov eax, ok_count            
   call writestring            ;"(3) 정답 횟수: "
   call writedec                  ;횟수 출력
   mov edx, OFFSET print6
   call writestring            ;"/10"


   mov dh, 16
   mov dl, 45
   call gotoxy
   mov edx, OFFSET msg9
   mov eax, perfect2            
   call writestring            ;"(4) 정확도: "
   call writedec                  ;정확도 출력
   mov edx, OFFSET print7
   call writestring            ;"%"
   
   call crlf
   ret
result_game ENDP
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;엔터 처리 될 때까지 입력받은 문자열을 처리하는 프로시저
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
input_str PROC
   mov edx, OFFSET userinput
   mov ecx, SIZEOF userinput
   call readstring            ;키보드 입력 처리

   mov word_length, ecx  ;문자 갯수 저장
      
   call crlf      
   ret
input_str ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;문자열과 비교할 단어 대조후 일치/불일치를 판단하는 프로시저
;Str_compare 라이브러리 : 문자열 비교 후 서로 일치할 때 ZERO = 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
comp_str1 PROC
  .IF temp==0                        ;1번 단어와 비교
    INVOKE Str_compare, ADDR userinput, ADDR blank1
    ret 
  .ELSEIF temp==1                  ;2번 단어와 비교
    INVOKE Str_compare, ADDR userinput, ADDR blank2
    ret  
  .ELSEIF temp==2                  ;3번 단어와 비교
    INVOKE Str_compare, ADDR userinput, ADDR blank3
    ret 
  .ELSEIF temp==3                  ;4번 단어와 비교
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
;Zero가 존재할 때 여러 점수를 출력하는 프로시저
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
comp_str2 PROC
  .IF ZERO? ;문자열 일치 판단          
   INVOKE Str_length, ADDR userinput
   mov word_length, eax         ;문자열 길이 반환
   
   mov dh, 22
   mov dl, 35
   call gotoxy
   mov edx, OFFSET msg6
   call writestring            ;"점수: "
   mov eax, perfect
   add eax, 10
   mov perfect, eax            ;점수 10점 증가
   call writeint               ;점수 출력
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
   call writestring            ;"정답 횟수: "
   mov eax, ok_count
   add eax, 1
   mov ok_count, eax
   call writedec               ;정답 횟수 출력
   mov edx, OFFSET print6
   call writestring

   mov dh, 23
   mov dl, 35
   call gotoxy
   mov edx, OFFSET msg7         ;"입력한 글자 수: "
   call writestring
   mov eax, word_length
   call writedec               ;입력한 글자 수 출력
   call crlf

   mov dh, 23
   mov dl, 65
   call gotoxy
   mov edx, OFFSET msg8         ;"누적 글자 수: "
   call writestring
   mov eax, word_length
   add total_length, eax
   mov eax, total_length
   call writedec               ;누적 글자 수 출력
   call crlf


   ;문자열 불일치 판단
  .ELSE   
     INVOKE Str_length, ADDR userinput
   mov word_length, eax

   mov dh, 22
   mov dl, 35
   call gotoxy
   mov edx, OFFSET msg6
   call writestring               ;"점수: "
   mov eax, perfect
   
   ;점수가 0 이하면 감소 없음
   .IF eax>0         
      sub eax, 5
   .ENDIF
   mov perfect, eax               ;점수 감소
   call writeint                  ;점수 출력
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
   call writestring               ;"정답 횟수: "
   mov eax, ok_count
   call writedec                  ;정답 횟수 출력
   call crlf

   mov dh, 23
   mov dl, 35
   call gotoxy
   mov edx, OFFSET msg7            ;"입력한 글자 수: "
   call writestring
   mov eax, word_length
   call writedec
   call crlf

   mov dh, 23
   mov dl, 65
   call gotoxy
   mov edx, OFFSET msg8            ;"누적 글자수: "
   call writestring
   mov eax, total_length
   call writedec
   call crlf


  .ENDIF
   mov dh, 24
   mov dl, 35
   call gotoxy
   mov edx, OFFSET msg4            ;"남은 횟수: "
   call writestring
   mov eax, loop_count
   sub eax, 1
   call writedec                  ;남은 횟수 출력
   
   ;mov ecx, loop_count            ;카운터 복구
   add temp, 1                     ;다음 단어 이동
   
   mov dh, 26
   mov dl, 45
   call gotoxy
   call waitmsg

   call clrscr
   ret
comp_str2 ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;좌표에 맞게 단어를 출력하는 프로시저
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_str PROC
   mov dh, 5               
   mov dl, 15               
   call gotoxy               
   mov edx, OFFSET blank1
   call writestring      ;blank1 출력
   
   mov dh, 5      
   mov dl, 35      
   call gotoxy         
   mov edx, OFFSET blank2
   call writestring      ;blank2 출력

   mov dh, 5
   mov dl, 55
   call gotoxy
   mov edx, OFFSET blank3
   call writestring      ;blank3 출력
   
   mov dh, 5
   mov dl, 75
   call gotoxy
   mov edx, OFFSET blank4
   call writestring      ;blank4 출력
   
   mov dh, 5   
   mov dl, 95   
   call gotoxy      
   mov edx, OFFSET blank5
   call writestring      ;blank5 출력
   
   mov dh, 9      
   mov dl, 15            
   call gotoxy               
   mov edx, OFFSET blank6
   call writestring      ;blank6 출력

   mov dh, 9
   mov dl, 35
   call gotoxy
   mov edx, OFFSET blank7
   call writestring      ;blank7 출력
   
   mov dh, 9
   mov dl, 55
   call gotoxy
   mov edx, OFFSET blank8
   call writestring      ;blank8 출력
   
   mov dh, 9
   mov dl, 75
   call gotoxy
   mov edx, OFFSET blank9
   call writestring      ;blank9 출력

      
   mov dh, 9
   mov dl, 95
   call gotoxy
   mov edx, OFFSET blank10
   call writestring      ;blank10 출력


   mov dh, 17
   mov dl, 28
   call gotoxy
   mov edx, OFFSET print1
   call writestring      ;띠 출력

   mov dh, 19
   mov dl, 28
   call gotoxy
   mov edx, OFFSET print1
   call writestring      ;띠 출력
   
   mov dh, 18
   mov dl, 38
   call gotoxy            ;안내
   mov eax, temp
   add eax, 1
   call writedec         
   mov edx, OFFSET print2
   call writestring

   mov dh, 18
   mov dl, 58
   call gotoxy            ;입력받는 위치 설정
   ret
print_str ENDP

END main