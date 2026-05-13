function spawnArms()
{
   trace("spawning arms");
   var xd = 0;
   while(xd < foes.length)
   {
      if(foes[xd] instanceof SquidArm)
      {
         foes[xd].graphic.gotoAndPlay("intro2");
         foes[xd].HP = foes[1].maxHP;
         foes[xd].dead = false;
      }
      xd++;
   }
   updateFoeBars();
}
