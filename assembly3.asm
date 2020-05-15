##########################################################################
# Title: Assign02P3                   Author: J. Alejandro Carrillo
# Class: CS 2318-251, Spring 2019     Submitted: <date>
##########################################################################
# Program: MIPS tranlation of a given C++ program
##########################################################################
# Pseudocode description: supplied a2p2_SampSoln.cpp
############################ data segment ################################
#int  a1[12],
#     a2[12],
#     a3[12];
#char reply;
#int  used1,
#     used2,
#     used3,
#     remCount,
#     anchor;
#int* hopPtr1;
#int* hopPtr11;
#int* hopPtr2;
#int* hopPtr22;
#int* hopPtr222;
#int* hopPtr3;
#int* endPtr1;
#int* endPtr2;
#int* endPtr3;

#char begA1Str[] = "\nbeginning a1: ";
#char proA1Str[] = "processed a1: ";
#char comA2Str[] = "          a2: ";
#char comA3Str[] = "          a3: ";
#char einStr[]   = "Enter integer #";
#char moStr[]    = "Max of ";
#char ieStr[]    = " ints entered...";
#char emiStr[]   = "Enter more ints? (n or N = no, others = yes) ";
#char dacStr[]   = "Do another case? (n or N = no, others = yes) ";
#char dlStr[]    = "================================";
#char byeStr[]   = "bye...";						
			.data

iArr1:			.space 48
iArr2:			.space 48
iArr3:			.space 48
colSpace:		.asciiz ": "
begA1Str:		.asciiz "\nbeginning a1: "
proA1Str:		.asciiz "processed a1: "
comA2Str:		.asciiz "          a2: "
comA3Str:		.asciiz "          a3: "
einStr:			.asciiz "\nEnter integer #"
moStr:			.asciiz "Max of "
ieStr:			.asciiz " ints entered..."
emiStr:			.asciiz "Enter more ints? (n or N = no, others = yes) "
dacStr:			.asciiz "Do another case? (n or N = no, others = yes) "
dlStr:			.asciiz "================================"
byeStr:			.asciiz "bye..."
########################################
# Register Usage
########################################
# $a1: used1
# $a2: used2
# $a3: used3
# $t1: hopPtr1
# $s1: hpPtr11
# $t2: hopPtr2
# $s2: hopPtr22
# $t6: hopPtr222
# $t3: hopPtr3
# $t4: anchor
# $s4: hasDup
# $t5: short-lived temporary
# $t7: remCount
# $t8: endPtr1
# $t9: endPtr2
# $t0: endPtr3
# $v1: reply
############################ code segment ################################
#int main()
#{
			.text
			.globl main
main:
#            do
begDW1:#     {
#                used1 = 0;
			li $a1, 0
#                hopPtr1 = a1;
			la $t1, iArr1
#                do
begDW2:#         {
#                   cout << einStr;
			li $v0, 4
			la $a0, einStr
			syscall
#                   cout << (used1 + 1);
			li $v0, 1
			addi $a0, $a1, 1
			syscall
#                   cout << ':' << ' ';
                   	li $v0, 4
                   	la $a0, colSpace
                   	syscall
#                   cin >> *hopPtr1;
			li $v0, 5
			syscall
			sw $v0, 0($t1)
#                   ++used1;
                   	addi $a1, $a1, 1
#                   ++hopPtr1;
                   	addi $t1, $t1, 4
#                     if (used1 == 12)
#		    if (used1 != 12) goto else1;
			li $t5, 12
			bne $a1, $t5, else1	
begI1:#             {
#                    	cout << moStr;
			li $v0, 4
			la $a0, moStr
			syscall
#                      	cout << 12;
			li $v0, 1
			li $a0, 12
			syscall
#                      	cout << ieStr;
                      	li $v0, 4
                      	la $a0, ieStr
                      	syscall
#                      	cout << endl;
			li $v0, 11
			li $a0, '\n'
			syscall
#                     	reply = 'n';
			li $v1, 'n'
#                   }
#        	   goto endI1;
			j endI1
#                   else
else1:#             {
#                    	cout << emiStr;
                    	li $v0, 4
                    	la $a0, emiStr
                    	syscall
#                      	cin >> reply;
			li $v0, 12
			syscall
			move $v1, $v0
endI1:#             }
endDW2:#	}while (reply != 'n' && reply != 'N');

DWTest2:#	if (reply != 'n' && reply != 'N') goto begDW2
#		if (reply == 'n') goto xitDW2;
			li, $t5, 'n'
			beq $v1, $t5, xitDW2
#			  if (reply != 'N') goto begDW2;
			li $t5, 'N'
			bne $v1, $t5, begDW2
xitDW2:				
#                cout << begA1Str;
			li $v0, 4
			la $a0, begA1Str
			syscall
#                hopPtr1 = a1;
			la $t1, iArr1
#                endPtr1 = a1 + used1;
			la $t5, iArr1
			sll $t8, $a1, 2
			add $t8, $t8, $t5
#		goto WTest1;
			j WTest1
begW1:#          {
#                 if (hopPtr1 == endPtr1 - 1)
#		  if (hopPtr1 != (endPtr1 - 1)) goto else2;
		  	addi $t5, $t8, -4
		 	 bne $t1, $t5, else2
begI2:#            {
#                    	cout << *hopPtr1 << endl;
			li $v0, 1
			lw $a0, 0($t1)
			syscall
			li $v0, 11
			li $a0, '\n'
			syscall 
#                  }
#		   goto endI2;
		   j endI2
#                  else
else2:#            {
#                      	cout << *hopPtr1 << ' ';
                      	li $v0, 1
                      	lw, $a0, 0($t1)
                      	syscall
                      	li $v0, 11
                      	li $a0, ' '
                      	syscall
endI2:#            }
#                   	++hopPtr1;
                   	addi $t1, $t1, 4
WTest1:#		if (hopPtr1 < endPtr1) goto begW1;
			blt $t1, $t8, begW1		
                   
endW1:#          }
#                for (hopPtr1 = a1, hopPtr2 = a2, used2 = 0; // multiple initializations
#                     hopPtr1 < endPtr1;                     // loop test
#                     ++hopPtr1, ++hopPtr2, ++used2)         // multiple updates
#		hopPtr1 = a1;
			la $t1, iArr1	 
#		hopPtr2 = a2;
			la $t2, iArr2 
#		used2 = 0;
			li, $a2, 0
#		goto FTest1;
			j FTest1	
begF1:#          {
#                	*hopPtr2 = *hopPtr1;
			lw $t5, 0($t1)
			sw $t5, 0($t2)
#                   	++hopPtr1;
			addi $t1, $t1, 4 
#			++hopPtr2;
			addi $t2, $t2, 4 
#			++used2;
			addi $a2, $a2, 1
FTest1:#		if (hopPtr1 < endPtr1) goto begF1;
			blt $t1, $t8, begF1
                   
endF1:#          }

#                hopPtr2 = a2;
			la $t2, iArr2
#                endPtr2 = a2 + used2;
			la $t5, iArr2
			sll $t9, $a2, 2
			add $t9, $t9, $t5
#                while (hopPtr2 < endPtr2)
#		goto WTest2;
			j WTest2
begW2:#                {
#                   anchor = *hopPtr2;
			lw $t4, 0($t2)
#                   for (hopPtr22 = hopPtr2 + 1; hopPtr22 < endPtr2; ++hopPtr22)
#		hopPtr22 = hopPtr2 + 1;
			addi $s2, $t2, 4
#		goto FTest2;
			j FTest2
begF2:#             {
#                    	if (*hopPtr22 == anchor)
#			if (*hopPtr22 != anchor) goto endI3;
			lw $t5, 0($s2)
			bne $t5, $t4, endI3
begI3:#                {
#                          for (hopPtr222 = hopPtr22 + 1; hopPtr222 < endPtr2; ++hopPtr222)
#			   hopPtr222 = hopPtr22 + 1;
			addi $t6, $s2, 4
#			   goto FTest3;
			j FTest3
begF3:#                    {
#                            	*(hopPtr222 - 1) = *hopPtr222;
			lw $t5, 0($t6)
			sw $t5, -4($t6)	
#                            	++hopPtr222;
			addi $t6, $t6, 4
FTest3:#                   if (hopPtr222 < endPtr2) goto begF3;
			blt $t6, $t9, begF3      	
                            	
endF3:#                    }
#                          --used2;
			addi $a2, $a2, -1
#                          --endPtr2;
			addi $t9, $t9, -4
#                          --hopPtr22;
			addi $s2, $s2, -4                  	
endI3:#                }
#                    	++hopPtr22;
			addi $s2, $s2, 4
FTest2:#	if (hopPtr22 < endPtr2) goto begF2;
			blt $s2, $t9, begF2                     
                      
endF2:#             }
#                   ++hopPtr2;
			addi $t2, $t2, 4
WTest2:#	if (hopPtr2 < endPtr2) goto begW2;
			blt $t2, $t9, begW2
                   
endW2:#                }

#                used3 = 0;
			li $a3, 0
#                hopPtr3 = a3;
			la $t3, iArr3
#                hopPtr1 = a1;
			la $t1, iArr1
#                while (hopPtr1 < endPtr1)
#		 goto WTest3;
			j WTest3
begW3:#          {
#                   *hopPtr3 = *hopPtr1;
			lw $t5, 0($t1)
			sw $t5, 0($t3)
#                   ++used3;
			addi $a3, $a3, 1
#                   ++hopPtr3;
			addi $t3, $t3, 4
#                   anchor = *hopPtr1;
			lw $t4, 0($t1)
#                   remCount = 0;
			li $t7, 0
#                   for (hopPtr11 = hopPtr1 + 1; hopPtr11 < endPtr1; ++hopPtr11)
#		hopPtr11 = hopPtr1 + 1;
			addi $s1, $t1, 4
#		goto FTest4;
			j FTest4	
begF4:#             {
#                    	if (*hopPtr11 == anchor)
#			if (*hopPtr11 != anchor) goto else4;
			lw $t5, 0($s1)
			bne $t5, $t4, else4
begI4:#                {
#                        	++remCount;
			addi $t7, $t7, 1
#                      }
#		       goto endI4;
			j endI4
#                      else
else4:#                {
#                        	*(hopPtr11 - remCount) = *hopPtr11;
                        lw $t5, 0($s1)
                        sll $s3, $t7, 2
                        sub $s3, $s1, $s3
                        sw $t5 0($s3)	
endI4:#                }
#                      	++hopPtr11;
			addi $s1, $s1, 4
FTest4:#	if (hopPtr11 < endPtr1) goto begF4;
			blt $s1, $t8, begF4                     
                      
endF4:#             }
#                   used1 -= remCount;
			sub $a1, $a1, $t7
#                   endPtr1 -= remCount;
			sll $t5, $t7, 2
			sub $t8, $t8, $t5
#                   ++hopPtr1;
			addi $t1, $t1, 4
WTest3:#         if (hopPtr1 < endPtr1) goto begW3;
			blt $t1, $t8, begW3         
                   
endW3:#          }

#                cout << proA1Str;
			li $v0, 4
			la $a0, proA1Str
			syscall
#                for (hopPtr1 = a1; hopPtr1 < endPtr1; ++hopPtr1)
#		 hopPtr1 = a1;
			la $t1, iArr1
#		 goto FTest5;
			j FTest5
begF5:#          {

#                	if (hopPtr1 == endPtr1 - 1)
#			if (hopPtr1 != (endPtr1 - 1)) goto else5;
			addi $t5, $t8, -4
			bne $t1, $t5, else5
begI5:#            {
#                    	cout << *hopPtr1 << endl;
			li $v0, 1
			lw $a0, 0($t1)
			syscall
			li $v0, 11
			li $a0, '\n'
			syscall
#                  }
#                   	goto endI5;
			j endI5
#                  else
else5:#            {
#                    	cout << *hopPtr1 << ' ';
			li $v0, 1
			lw $a0, 0($t1)
			syscall
			li $v0, 11
			li $a0, ' '
			syscall
endI5:#            }
#                   	++hopPtr1;
			addi $t1, $t1, 4
FTest5:#      	if(hopPtr1 < endPtr1) goto begF5;
			blt $t1, $t8, begF5	             
                   
endF5:#          }
#                cout << comA2Str;
			li $v0, 4
			la $a0, comA2Str
			syscall 
#                for (hopPtr2 = a2; hopPtr2 < endPtr2; ++hopPtr2)
#		hopPtr2 = a2;
			la $t2, iArr2
#		goto FTest6;
			j FTest6
begF6:#          {
#                  if (hopPtr2 == endPtr2 - 1)
#		   if (hopPtr2 != (endPtr2 - 1)) goto else6;
			addi $t5, $t9, -4
			bne $t2, $t5, else6
begI6:#            {
#                    	cout << *hopPtr2 << endl;
			li $v0, 1
			lw $a0, 0($t2)
			syscall
			li $v0, 11
			li $a0, '\n'
			syscall
#                  }
#                   	goto endI6;
			j endI6
#                  else
else6:#            {
#                    	cout << *hopPtr2 << ' ';
			li $v0, 1
			lw $a0, 0($t2)
			syscall
			li $v0, 11
			li $a0, ' '
			syscall
endI6:#            }
#                   	++hopPtr2
			addi $t2, $t2, 4
FTest6:#      	if (hopPtr2 < endPtr2) goto begF6;
			blt $t2, $t9, begF6            
                   
endF6:#          }
#                cout << comA3Str;
			li $v0, 4
			la $a0, comA3Str
			syscall
#                hopPtr3 = a3;
			la $t3, iArr3
#                endPtr3 = a3 + used3;
			la $t0, iArr3
			sll $t5, $a3, 2
			add $t0, $t0, $t5
#                while (hopPtr3 < endPtr3)
#		goto WTest4;
			j WTest4
begW4:#          {  
#                   if (hopPtr3 == endPtr3 - 1)
#		    if (hopPtr3 != (endPtr3 - 1)) goto else7;
			addi $t5, $t0, -4
			bne $t3, $t5, else7
begI7:#             {
#                      cout << *hopPtr3 << endl;
			li $v0, 1
			lw $a0, 0($t3)
			syscall
			li $v0, 11
			li $a0, '\n'
			syscall
#                   }
#                   goto endI7;
			j endI7
#                   else
else7:#             {
#                      cout << *hopPtr3 << ' ';
			li $v0, 1
			lw $a0, 0($t3)
			syscall
			li $v0, 11
			li $a0, ' '
			syscall
endI7:#             }
#                   ++hopPtr3;
                   	addi $t3, $t3, 4
WTest4:#         if (hopPtr3 < endPtr3) goto begW4;
			blt $t3, $t0, begW4          
                   
endW4:#          }

#                cout << endl;
			li $a0, '\n'
			syscall
#                cout << dacStr;
			li $v0, 4
			la $a0, dacStr
			syscall
#                cin >> reply;
			li $v0, 12
			syscall
			move $v1, $v0
#                cout << endl;
			li $v0, 11
			li $a0, '\n'
			syscall
endDW1:#     }while (reply != 'n' && reply != 'N');
            
DWTest1:#    if (reply != 'n' && reply != 'N') goto begDW1			
#	     if (reply == 'n') goto xitDW1;
			li $t5, 'n'
			beq $v1, $t5, xitDW1 
#	     if (reply != 'N') goto begDW1;
	     		li $t5, 'N'
	     		bne $v1, $t5, begDW1
xitDW1:      
#            cout << dlStr;
			li $v0, 4
			la $a0, dlStr
			syscall
#            cout << '\n';
			li $v0, 11
			li $a0, '\n'
			syscall
#            cout << byeStr;
			li $v0, 4
			la $a0, byeStr
			syscall
#            cout << '\n';
			li $v0, 11
			li $a0, '\n'
			syscall
#            cout << dlStr;
			li $v0, 4
			la $a0, dlStr
			syscall
#            cout << '\n';
			li $v0, 11
			li $a0, '\n'
			syscall
#            return 0;
			li $v0, 10
			syscall			 			 					 			 					