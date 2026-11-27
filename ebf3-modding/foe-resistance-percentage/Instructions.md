They're methods in Foe script. All ya have to do is replace them.  
Idealy you should do it with PCode though it may not be needed if you already applied the safe-edit snippet.  
Note that foes with long descriptions like the Dark Golem may have their text cut off so you'll have to modify the sprites that show foe descriptions.  
Ordered from least to most text lines it can show without issues:
- "bestiaryBox" (DefineSprite 6746)
- Frame 8 of DefineSprite 4065 (yeah it uses the same tooltip for equipment idk why)
- "scanBox" (DefineSprite 10)