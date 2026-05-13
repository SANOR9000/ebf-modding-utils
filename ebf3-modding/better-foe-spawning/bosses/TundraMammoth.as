class TundraMammoth extends Foe
{
   var berserk;
   var castSpell;
   var getHpPercent;
   var getXY;
   var graphic;
   var level;
   var parent;
   var reposition;
   var scaleGraphic;
   var sendHit;
   var syphon;
   var target;
   var targetAll;
   var turnStart;
   var foeName = "Tundra Mammoth";
   var foeType = "Living Fossil";
   var foeDescription = "Attacks with earth, fire and ice. Summons a variety of backup.";
   var maxHP = 3200;
   var attack = 6;
   var defence = 4;
   var magicAttack = 6;
   var magicDefence = 4;
   var evade = 4.3;
   var accuracy = 4;
   var hit2HP = 0.04;
   var recall = 0;
   var minBuff = 0.8;
   var experience = 600;
   var abilityPoints = 100;
   var gold = 600;
   var dropList = [];
   var mainGraphic = "mammoth";
   var subGraphic = 1;
   var elementalResistance = ["fire",1.6,"water",0.5,"ice",-1,"thunder",1,"wind",0.5,"poison",1.5,"earth",1,"dark",1.5,"holy",1,"bomb",1];
   var statusResistance = ["poison",0.8,"stun",0,"syphon",0.5,"death",0,"berserk",0,"dispel",1,"doom",1,"attackDown",1,"defenceDown",1,"magicAttackDown",1,"magicDefenceDown",1,"accuracyDown",1,"evadeDown",1];
   function TundraMammoth(a, b, c, d)
   {
      super(a,b,c,d);
      this.scaleGraphic = 95;
      this.dropList = [_root.defs.curlyhorn,_root.defs.solidspike,_root.defs.finefur,0,0,0];
      this.reposition(d);
   }
   function makeMove()
   {
      var _loc3_ = random(5);
      this.turnStart();
      if(this.berserk)
      {
         _loc3_ = 3;
      }
      else if(this.syphon)
      {
         _loc3_ = random(4);
      }
      else if(this.getHpPercent() >= 50)
      {
         _loc3_ = random(4) + 1;
      }
      if(_loc3_ == 0)
      {
         this.graphic.gotoAndPlay("attack");
      }
      if(_loc3_ == 1)
      {
         this.graphic.gotoAndPlay("attack2");
      }
      if(_loc3_ == 2)
      {
         this.graphic.gotoAndPlay("attack3");
      }
      if(_loc3_ == 3)
      {
         this.graphic.gotoAndPlay("attack4");
      }
      if(_loc3_ == 4)
      {
         this.graphic.gotoAndPlay("magic");
      }
      this.recall++;
      if(this.recall == 2 or this.recall == 4)
      {
         _loc3_ = random(2);
         if(_loc3_ == 0)
         {
            this.parent.spawnFoe(IceBit,this.level + 2);
         }
         if(_loc3_ == 1)
         {
            this.parent.spawnFoe(FireBit,this.level + 2);
         }
      }
      if(this.recall == 4)
      {
         this.recall = 0;
         _loc3_ = random(5);
         if(_loc3_ == 0)
         {
            this.parent.spawnFoe2(VikingMonolith,this.level + 2);
         }
         if(_loc3_ == 1)
         {
            this.parent.spawnFoe2(IceElemental,this.level + 2);
         }
         if(_loc3_ == 2)
         {
            this.parent.spawnFoe2(HolyEye,this.level + 2);
         }
         if(_loc3_ == 3)
         {
            this.parent.spawnFoe2(GlacierEater,this.level + 2);
         }
         if(_loc3_ == 4)
         {
            this.parent.spawnFoe2(LavaEater,this.level + 2);
         }
      }
   }
   function attack1()
   {
      if(_root.defs.difficulty == "epic")
      {
         this.parent.spawnFoe(FireBit,this.level + 2);
      }
      this.sendHit("attack",58,0.1,"null",1,"null",0.6,0.2,1,0.2);
   }
   function attack2()
   {
      this.targetAll = "allPlayers";
      if(_root.defs.difficulty == "epic")
      {
         this.sendHit("attack",40,0.1,"earth",1,"dispel",0.8,1,1.2,0.1);
      }
      else
      {
         this.sendHit("attack",30,0.1,"earth",1,"dispel",0.2,1,1.2,0.1);
      }
      this.target = this.parent.randomPlayer();
      this.targetAll = "onePlayer";
      this.getXY(2);
      var _loc3_ = random(3);
      if(_loc3_ == 0)
      {
         this.castSpell("eruption");
      }
      if(_loc3_ == 1)
      {
         this.castSpell("icespike");
      }
      if(_loc3_ == 2)
      {
         this.castSpell("rockslide");
      }
   }
   function attack3()
   {
      if(_root.defs.difficulty == "epic")
      {
         this.parent.spawnFoe2(VikingMonolith,this.level + 2);
      }
      this.sendHit("attack",90,0.1,"null",1,"stun",0.8,3,1.1,0.1);
   }
   function attack4()
   {
      this.targetAll = "allPlayers";
      this.castSpell("stampede");
   }
   function magic1()
   {
      this.castSpell("snow");
   }
   function die2()
   {
      this.parent.spawnFoe(FireBit,this.level + 2);
   }
}
