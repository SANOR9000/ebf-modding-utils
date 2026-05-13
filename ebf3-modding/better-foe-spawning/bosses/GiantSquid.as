class GiantSquid extends Foe
{
   var graphic;
   var parent;
   var targetAll;
   var foeName = "Giant Squid";
   var foeType = "Huge Sea Creature";
   var foeDescription = "Spawns tentacles and attacks with water and dark magic.";
   var maxHP = 2200;
   var attack = 4;
   var defence = 4;
   var magicAttack = 4;
   var magicDefence = 4;
   var evade = 3.7;
   var accuracy = 4;
   var hit2HP = 0.03333333333333333;
   var recall = 0;
   var recall2 = 5;
   var experience = 400;
   var abilityPoints = 70;
   var gold = 400;
   var dropList = [];
   var mainGraphic = "squid";
   var subGraphic = 1;
   var elementalResistance = ["fire",0.2,"water",-2,"ice",1.6,"thunder",1.7,"wind",1,"poison",1,"earth",1,"dark",1,"holy",1,"bomb",1];
   var statusResistance = ["poison",1,"stun",0,"syphon",1,"death",0,"berserk",0,"dispel",1,"doom",1,"attackDown",1,"defenceDown",1,"magicAttackDown",1,"magicDefenceDown",1,"accuracyDown",1,"evadeDown",1];
   function GiantSquid(a, b, c, d)
   {
      super(a,b,c,d);
      this.scaleGraphic = 100;
      this.dropList = [_root.defs.rainbowgems,_root.defs.purplepotion,_root.defs.bubblestone,0,0,0];
      this.reposition(d);
      if(_root.defs.difficulty == "epic")
      {
         this.recall2 = 2;
      }
   }
   function makeMove()
   {
      var _loc2_ = random(6);
      this.turnStart();
      if(this.syphon)
      {
         _loc2_ = random(3);
      }
      else if(this.getHpPercent() >= 30)
      {
         _loc2_ = random(4) + 1;
      }
      else if(this.getHpPercent() >= 60)
      {
         _loc2_ = random(3) + 2;
      }
      if(this.berserk)
      {
         _loc2_ = 0;
      }
      else if(this.syphon)
      {
         _loc2_ = 2;
      }
      if(this.recall == this.recall2)
      {
         _loc2_ = 6;
         this.recall = 0;
      }
      if(_loc2_ == 0)
      {
         this.graphic.gotoAndPlay("special");
      }
      if(_loc2_ == 1)
      {
         this.graphic.gotoAndPlay("special2");
      }
      if(_loc2_ == 2)
      {
         this.graphic.gotoAndPlay("special3");
      }
      if(_loc2_ == 3)
      {
         this.graphic.gotoAndPlay("magic");
      }
      if(_loc2_ == 4)
      {
         this.graphic.gotoAndPlay("magic");
      }
      if(_loc2_ == 5)
      {
         this.graphic.gotoAndPlay("magic");
      }
      if(_loc2_ == 6)
      {
         this.graphic.gotoAndPlay("special4");
      }
      this.recall++;
   }
   function special1()
   {
      this.targetAll = "allPlayers";
      this.sendHit("magic",40,0.1,"water",1,"evadeDown",0.6,0.2,0.9,0);
   }
   function special2()
   {
      this.targetAll = "allPlayers";
      this.sendHit("magic",28,0.1,"dark",1,"accuracyDown",0.4,0.2,1.1,0);
   }
   function special3()
   {
      this.castSpell("ink");
   }
   function special4()
   {
      this.parent.spawnArms();
      this.buff("defenceUp",0.3);
      this.buff("magicDefenceUp",0.3);
      if(_root.defs.difficulty == "epic")
      {
         this.buff("magicAttackUp",0.7);
         this.buff("attackUp",0.7);
      }
   }
   function magic1()
   {
      var _loc3_ = random(7);
      if(this.getHpPercent() < 50)
      {
         _loc3_ = random(5) + 2;
      }
      if(_loc3_ == 0)
      {
         this.castSpell("flood");
      }
      if(_loc3_ == 2)
      {
         this.castSpell("narwhal");
      }
      if(_loc3_ == 1)
      {
         this.castSpell("iceshard");
      }
      if(_loc3_ == 3)
      {
         this.parent.spawnFoe(BlueJelly,this.level);
      }
      if(_loc3_ == 4)
      {
         this.parent.spawnFoe(BlueSlime,this.level);
      }
      if(_loc3_ == 5)
      {
         this.parent.spawnFoe(BlueClay,this.level);
      }
      if(_loc3_ == 6)
      {
         this.parent.spawnFoe(SpiralCrab,this.level);
      }
   }
   function die2()
   {
      this.parent.foe1.dead;
      if(!this.parent.foe1.dead)
      {
         this.parent.foe1.dead = true;
         this.parent.foe1.HP = 0;
         this.parent.foe1.graphic.gotoAndPlay("die");
      }
      if(!this.parent.foe3.dead)
      {
         this.parent.foe3.dead = true;
         this.parent.foe3.HP = 0;
         this.parent.foe3.graphic.gotoAndPlay("die");
      }
      this.parent.spawnFoe(SpiralCrab,this.level);
      this.parent.updateFoeBars();
   }
}
