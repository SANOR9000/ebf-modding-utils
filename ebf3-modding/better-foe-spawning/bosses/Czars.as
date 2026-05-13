class Czars extends Foe
{
   var berserk;
   var buff;
   var castSpell;
   var getHpPercent;
   var graphic;
   var level;
   var parent;
   var reposition;
   var scaleGraphic;
   var sendHit;
   var syphon;
   var targetAll;
   var turnStart;
   var foeName = "Czars";
   var foeType = "Red Hydra Head";
   var foeDescription = "Attacks with holy skills and heals allies. Can inflict dispel.";
   var maxHP = 1700;
   var attack = 4;
   var defence = 4;
   var magicAttack = 4;
   var magicDefence = 4;
   var evade = 4.3;
   var accuracy = 4;
   var hit2HP = 0.04;
   var spawnWait = 4;
   var minBuff = 0.8;
   var deadDragons = 0;
   var experience = 400;
   var abilityPoints = 60;
   var gold = 400;
   var dropList = [];
   var mainGraphic = "dragon";
   var subGraphic = 3;
   var elementalResistance = ["fire",-0.5,"water",1,"ice",1,"thunder",1,"wind",1,"poison",1,"earth",1.8,"dark",2,"holy",-1,"bomb",1];
   var statusResistance = ["poison",1,"stun",0,"syphon",0.1,"death",0,"berserk",0.1,"dispel",1,"doom",1,"attackDown",1,"defenceDown",1,"magicAttackDown",1,"magicDefenceDown",1,"accuracyDown",1,"evadeDown",1];
   function Czars(a, b, c, d)
   {
      super(a,b,c,d);
      this.scaleGraphic = 90;
      this.dropList = [_root.defs.ruby,_root.defs.ruby,_root.defs.dragonscales,_root.defs.dragonscales,_root.defs.dragonscales,0];
      this.reposition(d);
   }
   function specialHit5()
   {
      "CZR CALLS OUT";
      this.parent.foes[1].deadDragon();
      this.parent.foes[2].deadDragon();
      this.parent.foes[3].deadDragon();
   }
   function deadDragon()
   {
      this.deadDragons += 1;
      "DRAGON DEATH";
      this.buff("evadeUp",0.7);
      this.buff("accuracyUp",0.7);
      if(this.deadDragons == 1)
      {
         this.attack *= 1.5;
         this.magicAttack *= 1.5;
      }
      if(this.deadDragons == 2)
      {
         this.attack *= 2;
         this.magicAttack *= 2;
         this.evade *= 1.5;
      }
      if(this.deadDragons == 3)
      {
         _root.defs.medals.medalGet("boss5");
      }
   }
   function makeMove()
   {
      this.turnStart();
      var _loc2_ = random(8);
      if(this.getHpPercent() <= 50)
      {
         _loc2_ = random(7) + 1;
      }
      if(this.syphon or this.berserk)
      {
         _loc2_ = 0;
      }
      if(_loc2_ == 0)
      {
         this.graphic.gotoAndPlay("attack");
      }
      if(_loc2_ == 1)
      {
         this.graphic.gotoAndPlay("magic");
      }
      if(_loc2_ == 2)
      {
         this.graphic.gotoAndPlay("magic");
      }
      if(_loc2_ == 3)
      {
         this.graphic.gotoAndPlay("magic");
      }
      if(_loc2_ == 4)
      {
         this.graphic.gotoAndPlay("special6");
      }
      if(_loc2_ == 5)
      {
         this.graphic.gotoAndPlay("special7");
      }
      if(_loc2_ == 6)
      {
         this.graphic.gotoAndPlay("special8");
      }
      if(_loc2_ == 7)
      {
         this.graphic.gotoAndPlay("special8");
      }
      if(this.spawnWait <= 0 and this.deadDragons == 2)
      {
         this.spawnWait = 4;
         _loc2_ = random(3);
         if(_loc2_ == 0)
         {
            this.parent.spawnFoe(LightClay,this.level + 1);
         }
         if(_loc2_ == 1)
         {
            this.parent.spawnFoe(AncientEye,this.level + 1);
         }
         if(_loc2_ == 2)
         {
            this.parent.spawnFoe(MageBird,this.level + 1);
         }
      }
      this.spawnWait -= 1;
   }
   function attack1()
   {
      this.sendHit("attack",50,0.1,"null",1,"null",0.6,0.2,1,0.1);
   }
   function attack2()
   {
      this.sendHit("attack",40,0.1,"null",1,"null",0.6,0.2,1,0.1);
   }
   function special6()
   {
      var _loc2_ = 0;
      while(_loc2_ < 5)
      {
         this.parent.foes[_loc2_].buff("defenceUp",0.3);
         this.parent.foes[_loc2_].buff("attackUp",0.3);
         this.parent.foes[_loc2_].getHeal(20000,0.1);
         _loc2_ += 1;
      }
   }
   function special7()
   {
      this.targetAll = "allPlayers";
      this.sendHit("magic",45,0.1,"holy",1,"dispel",0.4,1,1.2,0.1);
   }
   function special8()
   {
      this.targetAll = "allFoes";
      var _loc2_ = 0;
      while(_loc2_ < 5)
      {
         this.parent.foes[_loc2_].buff("magicDefenceUp",0.3);
         this.parent.foes[_loc2_].buff("magicAttackUp",0.3);
         this.parent.foes[_loc2_].regen += 3;
         _loc2_ += 1;
      }
   }
   function magic1()
   {
      var _loc2_ = random(3);
      this.targetAll = "allPlayers";
      if(_loc2_ == 0)
      {
         this.castSpell("thunderstorm");
      }
      if(_loc2_ == 1)
      {
         this.castSpell("icestorm");
      }
      if(_loc2_ == 2)
      {
         this.castSpell("firestorm");
      }
   }
   function effect3()
   {
      this.castSpell("dragonlight");
   }
}
