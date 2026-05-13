function spawnClaws(lvl)
{
   if(lvl == undefined)
   {
      lvl = 30;
   }
   trace("spawning WORM");
   if(foes[1].dead)
   {
      trace("it was dead");
      delete foes[1].graphic;
      delete foes[1];
      foe1 = new RuneClaw(1,lvl,this,pointB2);
      foes[1] = foe1;
      updateFoeBars();
   }
   if(foes[3].dead)
   {
      trace("it was dead");
      delete foes[3].graphic;
      delete foes[3];
      foe3 = new RuneClaw(3,lvl,this,pointB4);
      foes[3] = foe3;
      updateFoeBars();
   }
}
