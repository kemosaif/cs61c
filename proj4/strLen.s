StringLen:
    sw $r1, $r2, 0x00
    beq $r2, $r0, exit
    addi $r1, $r1, 0x01
    j StringLen
exit:
    disp $r1, 0
    jr $r3
