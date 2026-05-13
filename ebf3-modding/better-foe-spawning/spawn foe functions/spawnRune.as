function spawnRune(n, lvl)
{
   if(lvl == undefined)
   {
      lvl = 24;
   }
   g = random(4);
   if(g == 0)
   {
      cla = RockRune;
   }
   if(g == 1)
   {
      cla = FireRune;
   }
   if(g == 2)
   {
      cla = BoltRune;
   }
   if(g == 3)
   {
      cla = HolyRune;
   }
   trace("spawning RUNE");
   if(foes[n].dead)
   {
      trace("it was dead");
      delete foes[n].graphic;
      delete foes[n];
      this["foe" + n] = new cla(n,lvl,this,this["point" + (3 + n)]);
      foes[n] = this["foe" + n];
      updateFoeBars();
      return true;
   }
   return false;
}
