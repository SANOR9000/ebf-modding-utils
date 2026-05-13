function spawnFoe2(cla, lvl)
{
   trace("spawning something");
   var _loc2_;
   if(foes[3].dead)
   {
      trace("is was dead");
      delete foes[3].graphic;
      delete foes[3];
      _loc2_ = new cla(3,lvl,this,point6);
      foes[3] = _loc2_;
   }
   updateFoeBars();
}
