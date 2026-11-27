# ebf-modding-utils
Useful Epic Battle Fantasy files (mostly for modding tho lo)  
If a file has a .pcode alternative I recommend using that one instead

## Main stuff

### log-traces
Finally see what all those ``trace()``s are saying

### better-foe-spawning
Makes bosses spawn foes relative to their level instead of being hardcoded  
Also reworks Rune Claw to use Akron's orb regardless of the latter's position or choose one at random if no Akron is present

### redirect-sendHits-to-magicGraphics
Remember the 4 copies of ```function luckystar()```? Now you can make them always redirect to ```magicGraphics``` instead

### safe-as-edit-player-foe-scripts
Moves some code from Foe and Player scripts to an independent class to isolate code that causes those scripts to brick when using ActionScript editing

### foe-resistance-percentage
When viewing the stats of a foe, you'll be able to see the degree of the foe's resistances (100% fire, -80% dark, etc.)  
Note that foes with long descriptions like the Dark Golem may have their text cut off so you'll have to modify the sprites that show foe descriptions.  
Ordered from least to most text lines it can show without issues:
- "bestiaryBox" (DefineSprite 6746)
- Frame 8 of DefineSprite 4065 (yeah it uses the same tooltip for equipment idk why)
- "scanBox" (DefineSprite 10)

## Save editing

### give-all-festival-exclusives
Drop in a ```input.meow``` file, run the script and an ```output.meow``` file will be created with all quests, equipments and skills tied to festivals given to you  
It also gives you 69000 red envelopes so you can upgrade the Coin Charm and the Lucky Fish

### respawn-devourer-encounter
Works the same way as above  
Name's self explainatory