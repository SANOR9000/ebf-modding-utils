function spawnBush(lvl)
{
   if(lvl == undefined)
   {
      lvl = 8;
   }
   trace("spawning bushes");
   trace(foes[0].foeName);
   trace(foes[0].dead);
   var _loc3_;
   if(foes[0].dead)
   {
      trace("is was dead");
      delete foes[0].graphic;
      delete foes[0];
      _loc3_ = new GreenBush(0,lvl,this,point15);
      foes[0] = _loc3_;
   }
   var _loc4_;
   if(foes[2].dead)
   {
      trace("is was dead");
      delete foes[2].graphic;
      delete foes[2];
      _loc4_ = new GreenBush(2,lvl,this,point7);
      foes[2] = _loc4_;
   }
   updateFoeBars();
}
