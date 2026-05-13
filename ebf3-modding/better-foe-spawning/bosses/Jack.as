class Jack extends Foe
{
   var graphic;
   var parent;
   var targetAll;
   var foeName = "Jack";
   var foeType = "Mechanical Pumpkin";
   var foeDescription = "Powerful robot boss. Attacks with fire, earth and bomb attacks.";
   var maxHP = 1600;
   var attack = 4;
   var defence = 4;
   var magicAttack = 4;
   var magicDefence = 4;
   var evade = 4;
   var accuracy = 4;
   var hit2HP = 0.04;
   var recall = 0;
   var experience = 100;
   var abilityPoints = 50;
   var gold = 200;
   var dropList = [];
   var mainGraphic = "Jack";
   var subGraphic = 1;
   var elementalResistance = ["fire",0.5,"water",1,"ice",1,"thunder",1.6,"wind",0,"poison",0,"earth",1.5,"dark",1,"holy",1,"bomb",1.7];
   var statusResistance = ["poison",0,"stun",0,"syphon",1,"death",0,"berserk",0,"dispel",1,"doom",1,"attackDown",1,"defenceDown",1,"magicAttackDown",1,"magicDefenceDown",1,"accuracyDown",1,"evadeDown",1];
   function Jack(a, b, c, d)
   {
      super(a,b,c,d);
      this.scaleGraphic = 85;
      this.dropList = [_root.defs.gear,_root.defs.steelplate,_root.defs.magnet,0,0,0];
      this.reposition(d);
   }
   function makeMove()
   {
      var _loc2_ = random(5);
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
      if(this.recall == 5)
      {
         _loc2_ = 5;
         this.recall = 0;
      }
      if(_loc2_ == 0)
      {
         this.graphic.gotoAndPlay("attack");
      }
      if(_loc2_ == 1)
      {
         this.graphic.gotoAndPlay("attack2");
      }
      if(_loc2_ == 2)
      {
         this.graphic.gotoAndPlay("attack3");
      }
      if(_loc2_ == 3)
      {
         this.graphic.gotoAndPlay("special");
      }
      if(_loc2_ == 4)
      {
         this.graphic.gotoAndPlay("special2");
      }
      if(_loc2_ == 5)
      {
         this.graphic.gotoAndPlay("special3");
      }
      this.recall++;
   }
   function attack1()
   {
      this.sendHit("attack",50,0.1,"null",0,"null",0.2,2,1,0.1);
   }
   function attack2()
   {
      this.sendHit("attack",23.333333333333332,0.1,"null",0,"null",0.2,2,0.9,0.1);
      var _loc3_;
      if(_root.defs.difficulty == "epic")
      {
         _loc3_ = random(2);
         if(_loc3_ == 0)
         {
            this.parent.spawnFoe2(PurpleBee,this.level);
         }
         if(_loc3_ == 1)
         {
            this.parent.spawnFoe2(YellowBee,this.level);
         }
      }
   }
   function attack3()
   {
      this.targetAll = "allPlayers";
      this.sendHit("attack",33,0.1,"earth",1,"null",0.2,2,1.1,0.1);
      if(_root.defs.difficulty == "epic")
      {
         this.special3();
      }
   }
   function special1()
   {
      this.targetAll = "allPlayers";
      this.sendHit("attack",6,0.1,"bomb",1,"null",0.3,0.2,0.9,0.1);
   }
   function special2()
   {
      this.targetAll = "allPlayers";
      this.sendHit("magic",11,0.1,"fire",1,"defenceDown",0.3,0.2,0.9,0.1);
      if(_root.defs.difficulty == "epic")
      {
         this.buff("attackUp",0.3);
      }
   }
   function special3()
   {
      var _loc3_ = random(4);
      if(_loc3_ == 0)
      {
         this.parent.spawnFoe(GreenBush,this.level + 1);
      }
      if(_loc3_ == 1)
      {
         this.parent.spawnFoe(KittenSoldier,this.level + 1);
      }
      if(_loc3_ == 2)
      {
         this.parent.spawnFoe(GreenSlime,this.level + 1);
      }
      if(_loc3_ == 3)
      {
         this.parent.spawnFoe(RedBush,this.level + 1);
      }
   }
}
