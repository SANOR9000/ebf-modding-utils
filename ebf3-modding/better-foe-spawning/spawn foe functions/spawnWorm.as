function spawnWorm(lvl)
{
   if(lvl == undefined)
   {
      lvl = 32;
   }
   trace("spawning WORM");
   if(foes[0].dead)
   {
      trace("it was dead");
      delete foes[0].graphic;
      delete foes[0];
      foe0 = new EvilWorm(0,lvl,this,pointB1);
      foes[0] = foe0;
      updateFoeBars();
   }
   if(foes[4].dead)
   {
      trace("it was dead");
      delete foes[4].graphic;
      delete foes[4];
      foe4 = new EvilTail(4,lvl,this,pointB5);
      foes[4] = foe4;
      updateFoeBars();
   }
}
