; Suikoden Guardian of Earth Glitch
; Written by Pyriel
;
; Repair the Guardian of Earth spell (Mother Earth Rune), which has no effect
; in the game.  This file uses the character's total defense (including armor)
; as the source value.
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

.org 0x801124EC
.area 0x801124F0-.
	ori	$v0, zero, 5		; correct the number of states
.endarea

.org 0x80112844
.area 0x80112860-.
	lhu	$v0, 0x32($a0)		; total defense
	lhu	$1, 0x32($a0)		; total defense (keep pattern rather than optimize)
	sra	$v1, $v0, 1		; half of base
	addu	$1, $1, $v1		; add to total
	sh	$1, 0x32($a0)		; store new total
	nop
	nop				; next op stores (base/2) bonus at 0x42
.endarea

.close