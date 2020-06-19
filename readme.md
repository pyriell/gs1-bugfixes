# <i>Suikoden/Genso Suikoden</i> Bug Fix Patch
This patch fixes several bugs that are present in the retail, North American version of <i>Suikoden I</i>.  All patches are optional, unless they are requirements for other patches you might choose to apply.  You can keep the infinite-use Escape Talismans while fixin the Earth Rune spells, if you like.
## Requirements
1. A disc image of the original game in your preferred language*.  Files with .bin, .img, and .iso extensions may be supported, but the image must be plain with no additional headers or other changes that certain rippers or compression tools might introduce.  When in doubt, try to convert the image to a standard ISO image first.
2. A copy of this patch.
3. About 1 GB of total space on your HDD.

**Currently only the North American (US/Canada) version 1.0 may be patched.  There is a version 1.1 in this region, but it's fairly rare unless you've set out to find it.**

## Applying
1. Run <i>gs1patcher.bat</i> to launch the patch dialog.  The message indicating an error loading lua-interface.lua can be ignored.
2. Choose the version of the game you want to patch from the drop-down list.
3. Use the browse button by "Original Image" to select your original copy of the game.
4. Use the browse button by "Patched Image" to select a location for your patched file.  The process will not allow you to patch directly to the original, it must create a copy.  If you just want the copy to be the original name plus " patched" or something like that, the easiest way to browse again to your original file, select it, and then change the name within the "Save File..." dialog.  You should also not create your patch file in any of the bug fix patch's folders.
5. Select the patches you wish to apply by highlighting them in the list and then clicking the appropriate arrow button.  You can see a brief description of the patch by highlighting it.

By default, all bugs are fixed and the most common options are chosen for bugs with multiple fix options, e.g. Clay Guardian which has a fix that uses base defense as the default and an optional replacement using total defense that is a little cheaty and exploitable.

Some patches you select may exclude or require others, these will be activated or deactivated automatically as needed.
6. When you are satisfied with your selections, click "Apply Patch" and wait for the process to finish.  A progress bar will show changes periodically.
7. The patcher will notify you of success or failure.  A log file will be created in the same directory as gs1patcher.bat and should be provided if you need support.

# Patches Provided by Current Release
##Bribe Fix
Konami allows you to dismiss notifications early by rapidly pressing buttons, but in the event they are skipped, an important check to see if the enemy should allow a bribe is bypassed.  This permits the player to bribe any enemy, including bosses.  This fix adds the required check to the button-mashing path.
	
## Clay Guardian Fix
The Earth Rune has a single-character and whole-party version of a spell that is meant to increase defense by adding 1.5x the original value to the total (2.5x multiplier).  Both versions skip applying the bonus, and calculate the value from a running total of bonuses that starts at zero (and therefore always stays zero) instead of from the character's defense values.

Two possible fixes are provided for each spell.  The default version uses the base defense stat, and is believed to be what Konami intended.  Recasting the spell with this version will just extend the duration.  The optional version uses total defense, and is exploitable.  Recasting with this version will continue to increase defense as the total will include armor and the bonus from previous casts.

The optional fix is not recommended, and is provided more as a curiosity.  We can't know what Konami actually meant to use just looking at the code, but an exploitable version seems unlikely.  It's also not known if Konami has proper bounds checking for combined stats.  You could find yourself with negative defense, if you go overboard and cast the spell as many times as possible.

## Escape Talisman Fixes
Stallion and Krin start the game with Escape Talismans that have a quantity of zero.  The game doesn't expect this, and subtracting 1 on first use will give these specific item instances 255 uses remaining instead of depleting them.  This has mistakenly been described as "infinite" in the past.  It's a fair assessment, but the item will eventually run out of uses, if you have a peculiar play style.
	
This fix changes the quantity in Stallion and Krin's inititialization data to 1.

## Guardian of Earth Fix
See "Clay Guardian Fix".
