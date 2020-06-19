; Suikoden Clay Guardian Glitch
; Written by Pyriel
;
; Repair the Clay Guardian spell (Earth Rune), which has no effect in the
; game.  This file uses the character's base defense (excluding armor) as
; the source value.
; 
; The routine has three errors.  First, it bypasses its fifth state, which is
; where it actually applies the bonuses, believing that value is out of bounds.
; Second, it calculates the bonus from the bonus variable.  Since that starts
; as zero, the value can never become anything else.  Even if the fifth state
; was executable, the game would always apply a zero bonus.  Third, the spell
; is described in guides as multiplying defense by 1.5.  What the logic would
; actually do is create a ~2.5 multiplier by adding 1.5x defense to the value.
;
; Fixing the bug means correcting the bounds check on states, using the right
; variable as a source, and changing the calculation to match expectations.

.psx
.align 4

.open MAIN.EXE, 0x800C0000

.org 0x801108A0
.area 0x801108A4-.
	ori	$v0, zero, 5		; correct the number of states
.endarea

.org 0x80110A64
.area 0x80110A80-.
	lhu	$a0, 0x28($v1)		; base defense
	lhu	$1, 0x32($v1)		; total defense
	sra	$v0, $a0, 1		; half of base
	addu	$1, $1, $v0		; add to total
	sh	$1, 0x32($v1)		; store new total
	nop
	nop				; next op stores (base/2) bonus at 0x42
.endarea

.close