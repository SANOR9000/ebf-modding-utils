function spawnFoe(cla, lvl)
{
   trace("spawning");
   trace(foes[0].foeName);
   trace(foes[0].dead);
   var _loc3_;
   if(foes[0].dead)
   {
      trace("is was dead at depth ");
      trace(foes[0].graphic.getDepth());
      delete foes[0].graphic;
      delete foes[0];
      _loc3_ = new cla(0,lvl,this,point3);
      foes[0] = _loc3_;
   }
   var _loc2_;
   if(foes[4].dead)
   {
      trace("is was dead at depth ");
      trace(foes[4].graphic.getDepth());
      delete foes[4].graphic;
      delete foes[4];
      _loc2_ = new cla(4,lvl,this,point7);
      foes[4] = _loc2_;
   }
   updateFoeBars();
}
