; Infinite Escape Talisman Glitch (Krin)
; Written by Pyriel
;
; Krin has an Escape Talisman with zero quantity, which allows it to be used
; infinitely.  In-game, the quantity is fixed when stored, but otherwise
; players can continue to exploit it, even if they move it to another character.

.psx
.align 4

.open SLUS_002.92, 0x8000F800

.org 0x80046C68
.area 0x80046C6C-.

	.halfword	0x0049		; item identifier (Escape Talisman)
	.byte		0x00		; flags (unequipped)
	.byte		0x01		; quantity

.endarea
.close
