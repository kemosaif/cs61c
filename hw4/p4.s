jal mul

mul:
addu $a0, $a0, $a1
addiu $a2, $a2, -1
bne $a2, $0, mul
add $v0, $a0, $0
jr $ra