class Protector extends Foe
{
   var graphic;
   var parent;
   var target;
   var targetAll;
   var foeName = "Protector";
   var foeType = "Ancient Guardian";
   var foeDescription = "Stores energy and unleashes massive particle beams. Summons Runes.";
   var maxHP = 2500;
   var attack = 4;
   var defence = 4;
   var magicAttack = 4;
   var magicDefence = 4;
   var evade = 3.8;
   var accuracy = 4;
   var hit2HP = 0.02;
   var recall = 4;
   var minBuff = 0.8;
   var experience = 1000;
   var abilityPoints = 120;
   var gold = 800;
   var dropList = [];
   var mainGraphic = "protectorBot";
   var subGraphic = 1;
   var elementalResistance = ["fire",0.3,"water",2.2,"ice",1,"thunder",1.8,"wind",1,"poison",0,"earth",0,"dark",1,"holy",0.3,"bomb",1.9];
   var statusResistance = ["poison",0,"stun",0,"syphon",0,"death",0,"berserk",0,"dispel",1,"doom",1,"attackDown",1,"defenceDown",1,"magicAttackDown",1,"magicDefenceDown",1,"accuracyDown",1,"evadeDown",1];
   var obeam = false;
   var ybeam = false;
   var spawnNumber = 0;
   var spawnWait = 3;
   var cannonWait = 6;
   function Protector(a, b, c, d)
   {
      super(a,b,c,d);
      this.scaleGraphic = 90;
      this.dropList = [_root.defs.lightrune,_root.defs.goldplate,_root.defs.goldplate,0,0,0];
      this.reposition(d);
   }
   function specialHit1(h)
   {
      if(this.getHpPercent() <= 33)
      {
         this.graphic.monster = 3;
      }
      else if(this.getHpPercent() <= 66)
      {
         this.graphic.monster = 2;
      }
   }
   function makeMove()
   {
      this.spawnNumber = 0;
      this.turnStart();
      var _loc3_ = random(5);
      if(this.getHpPercent() <= 66)
      {
         _loc3_ = random(6);
      }
      if(this.ybeam)
      {
         _loc3_ = 7;
      }
      if(this.obeam)
      {
         _loc3_ = 6;
      }
      if(this.cannonWait == 0)
      {
         _loc3_ = 8;
         this.cannonWait = 6;
      }
      _loc3_ = 8;
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
         this.graphic.gotoAndPlay("special");
      }
      if(_loc3_ == 4)
      {
         this.graphic.gotoAndPlay("special2");
      }
      if(_loc3_ == 5)
      {
         this.graphic.gotoAndPlay("special4");
      }
      if(_loc3_ == 6)
      {
         this.graphic.gotoAndPlay("special3");
         this.obeam = false;
      }
      if(_loc3_ == 7)
      {
         this.graphic.gotoAndPlay("special5");
         this.ybeam = false;
      }
      if(_loc3_ == 8)
      {
         this.graphic.gotoAndPlay("special6");
      }
      if(this.spawnWait == 0)
      {
         this.spawnWait = 6;
         _loc3_ = random(5);
         if(_loc3_ == 0)
         {
            this.parent.spawnFoe(Thunderbird,this.level + 1);
         }
         if(_loc3_ == 1)
         {
            this.parent.spawnFoe(DarkClay,this.level);
         }
         if(_loc3_ == 2)
         {
            this.parent.spawnFoe(LightClay,this.level);
         }
         if(_loc3_ == 3)
         {
            this.parent.spawnFoe(Gunslinger,this.level);
         }
         if(_loc3_ == 4)
         {
            this.parent.spawnFoe(Swordslinger,this.level);
         }
      }
      this.cannonWait--;
      this.spawnWait--;
   }
   function attack1()
   {
      this.sendHit("attack",69,0.1,"null",1,"null",0.6,0.2,0.9,0.3);
   }
   function attack3()
   {
      this.targetAll = "allPlayers";
      this.sendHit("attack",30,0.1,"earth",1,"null",0.8,1,1.2,0.1);
      this.target = this.parent.randomPlayer();
      this.targetAll = "onePlayer";
      this.getXY(2);
      var _loc2_ = random(2);
      if(_loc2_ == 0)
      {
         this.castSpell("eruption");
      }
      if(_loc2_ == 1)
      {
         this.castSpell("rockslide");
      }
   }
   function attack2()
   {
      this.target = this.parent.randomPlayer();
      this.targetAll = "onePlayer";
      this.getXY(2);
      this.sendHit("attack",100,0.1,"bomb",0.8,"null",0.8,3,1,0.1);
   }
   function special2()
   {
      if(_root.defs.difficulty == "epic")
      {
         this.buff("magicAttackUp",0.7);
      }
      this.obeam = true;
   }
   function special4()
   {
      if(_root.defs.difficulty == "epic")
      {
         this.buff("magicAttackUp",0.7);
      }
      this.ybeam = true;
   }
   function special3()
   {
      this.targetAll = "allPlayers";
      this.sendHit("magic",140,0.1,"null",1,"dispel",1,1,1.2,0.1);
   }
   function special5()
   {
      this.targetAll = "allPlayers";
      this.sendHit("magic",200,0.1,"thunder",1,"stun",0.2,1,1.2,0.1);
      if(_root.defs.difficulty == "epic")
      {
         this.castSpell("thunderstorm");
      }
   }
   function special1()
   {
      this.targetAll = "allPlayers";
      this.castSpell("handbomb");
   }
   function special6()
   {
      if(!this.parent.spawnRune(this.spawnNumber,this.level - 1))
      {
         this.targetAll = "allPlayers";
         this.castSpell("handbomb");
      }
      this.spawnNumber++;
      if(this.spawnNumber == 2)
      {
         this.spawnNumber++;
      }
   }
}
