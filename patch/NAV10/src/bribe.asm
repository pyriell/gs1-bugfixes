; Suikoden Bribe Glitch
; Written by Pyriel
;
; Fix an issue that allows the player to bribe any enemy, if the confirmation
; button (cross) is pressed quickly enough.  Konami allows the messages to be
; dismissed, and cloned logic to do it, but they left out a check that prevents
; boss battles from being escaped in this manner.

.psx
.align 4

.open MAIN.EXE, 0x800C0000

.org 0x800F6E7C
.area 0x800F6F1C-.
	lui	$a3, 0x8018		;use $a3 to save on repeating this operation.
	lw	$a0, 0x157C($a3)	;pointer to battle work area
  	lw	$a2, 0x1B18($a3)	;pointer to play data area
  	lw	$1, 0x1340($a0)	;pointer to battle flags
	lw	$v0, 0x1260($a0)	;enemy money
	lw	$1, 0xC($1)		;bribable?
  	lw	$a1, 0x1C($a2)		;player money
  	bltz	$1, failed_bribe	
  	sll	$v1, $v0, 1		;multiply enemy money
  	addu	$v1, $v0		;by 3, cost = (enemy money * 2) + enemy money
	slt	$v0, $a1, $v1		;player money < cost?
	beqz	$v0, paid_bribe
	subu	$v0, $a1, $v1
	lw	$v0, 0x1C($a0)
  	nop
	blez	$v0, failed_bribe
	li	$a0, 1
	li	$a1, 1
	addiu	$v1, $s1, 0x54
loop:
  	lw	$v0, 0x157C($a3)
	sb	$a1, 0x47($v1)
	lw	$v0, 0x1C($v0)
	addiu	$a0, 1
	slt	$v0, $a0
	beqz	$v0, loop
	addiu	$v1, 0x54

failed_bribe:
	sll	$v1, $s0, 2
	li	$v0, 0x800F6F58
	li	$1, 0x80181A88
	addu	$1, $v1
	sw	$v0, 0($1)
	j	0x800F6F44
	addiu	$v0, zero, 0xFFFF

paid_bribe:
	sw	$v0, 0x1C($a2)
	li	$v0, 1
	sw	$v0, 0x34($a0)
	j	0x800F6F44
	sw	$0, 0x38($a0)
.endarea
.close