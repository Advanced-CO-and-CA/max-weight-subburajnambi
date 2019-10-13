@ DATA SECTION
.data

data_start: .word 0x205A15E3; #(0010 0000 0101 1010 0001 0101 1101 0011 – 13 1's)
    .word 0x256C8700; #(0010 0101 0110 1100 1000 0111 0000 0000 – 11 1's)
    .word 0x295469FF ; #(0010 1001 0101 0100 0110 1001 1111 1111 – 18 1's)
	.word 0x295468F2; #(0010 1001 0101 0100 0110 1000 1111 0010 – 14 1's)
    .word 0x295468FF ; #(0010 1001 0101 0100 0110 1000 1111 1111 – 17 1's)
data_end:   .word 0x295468FF ; #(0010 1001 0101 0100 0110 1000 1111 1111 – 17 1's)


Output: 
	NUM:  .word 0x0;
    WEIGHT: .word 0x0;


ldr R0,=data_start  @ addess of data_start
ldr R2,=NUM         @ address of out param NUM
ldr R3,=WEIGHT      @ address of out param WEIGHT
ldr R9,=data_end    @ address of data_end
MOV R5,#0
MOV R8,#0


LOOP_DATASET:
ldr R7,[R0],#4   @ Load data from dataset
MOV R4,R7        @ Temp holder for data element
MOV R8,#0    	 @ Temp holder for the weight of data element

CONDITIONAL_LOOP_BITS:
and R1,R7,#1	     @ Find out LSB of data
ADD R8,R1	         @ Increment weight
LSR R7,R7,#1	
CMP R7,#0       
BNE CONDITIONAL_LOOP_BITS
CMP R8,R5
bge UPDATE_MAX


CONTINUE_LOOP_DATASET:
CMP R0,R9
BGT LOAD_OUTPUTS
B LOOP_DATASET


UPDATE_MAX:
MOV R5,R8     @ MAX WEIGHT is updated
MOV R6,R4     @ MAX NUM is updated
B CONTINUE_LOOP_DATASET

LOAD_OUTPUTS:
STR R6,[R2]
STR R5,[R3]