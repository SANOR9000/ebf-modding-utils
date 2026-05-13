class Akron extends Foe
{
   var buff;
   var castSpell;
   var getHpPercent;
   var graphic;
   var level;
   var orb1;
   var orb2;
   var orb3;
   var orb4;
   var parent;
   var poison;
   var reposition;
   var scaleGraphic;
   var sendHit;
   var target;
   var targetAll;
   var turnStart;
   var foeName = "Akron";
   var foeType = "Ancient Deity";
   var foeDescription = "Has lived for billions of years. Can change elements and attack patterns.";
   var maxHP = 5000;
   var attack = 3.5;
   var defence = 4;
   var magicAttack = 3.5;
   var magicDefence = 4;
   var evade = 4;
   var accuracy = 4;
   var recall = 5;
   var minBuff = 0.8;
   var experience = 0;
   var abilityPoints = 0;
   var gold = 0;
   var dropList = [];
   var mainGraphic = "satan";
   var subGraphic = 1;
   var elementalResistance = ["fire",1,"water",1,"ice",1,"thunder",1,"wind",1,"poison",1,"earth",1,"dark",1,"holy",1,"bomb",1];
   var fireSet = ["fire",-1,"water",2,"ice",1.7,"thunder",1,"wind",1.7,"poison",1,"earth",1,"dark",1,"holy",1,"bomb",-1];
   var iceSet = ["fire",2,"water",-1,"ice",-1,"thunder",1,"wind",0.3,"poison",1,"earth",1.8,"dark",1,"holy",1,"bomb",1];
   var thunderSet = ["fire",1,"water",1,"ice",1,"thunder",-1,"wind",1,"poison",1,"earth",1.9,"dark",1,"holy",0,"bomb",1];
   var earthSet = ["fire",1,"water",1,"ice",1,"thunder",1,"wind",2.3,"poison",-1,"earth",-1,"dark",1,"holy",1,"bomb",1.9];
   var darkSet = ["fire",1,"water",1,"ice",1,"thunder",1.9,"wind",1,"poison",0,"earth",0,"dark",-1,"holy",2,"bomb",1];
   var holySet = ["fire",1,"water",-1,"ice",1,"thunder",1,"wind",1,"poison",1.7,"earth",1,"dark",2,"holy",-1,"bomb",1];
   var statusResistance = ["poison",1,"stun",0,"syphon",0,"death",0,"berserk",0,"dispel",1,"doom",0,"attackDown",1,"defenceDown",1,"magicAttackDown",1,"magicDefenceDown",1,"accuracyDown",1,"evadeDown",1];
   var elements = ["earth","ice","fire","holy","dark","thunder"];
   var charge = false;
   var raised = false;
   var spawnWait = 7;
   var clawWait = 4;
   var raisedWait = 5;
   var formDamage = 0;
   var swapWait = 5;
   var speck = false;
   function Akron(a, b, c, d)
   {
      super(a,b,c,d);
      this.scaleGraphic = 100;
      this.dropList = [0,0,0,0,0,0,0];
      this.reposition(d);
      this.orb1 = this.elements[random(6)];
      this.orb2 = this.elements[random(6)];
      this.orb3 = this.elements[random(6)];
      this.orb4 = this.elements[random(6)];
      this.newWeakness();
   }
   function specialHit2(hit)
   {
      this.formDamage += hit.damage;
      "FORM DAMAGE: " + this.formDamage;
      if(this.getHpPercent() <= 70)
      {
         this.graphic.scars = 2;
      }
      if(this.getHpPercent() <= 40)
      {
         this.graphic.scars = 3;
      }
      if(hit.damage >= 20000)
      {
         this.graphic.gotoAndPlay("hit6");
         return true;
      }
      if(hit.damage >= 10000)
      {
         this.graphic.gotoAndPlay("hit2");
         return true;
      }
      return false;
   }
   function newWeakness()
   {
      if(this.orb1 == "fire")
      {
         this.elementalResistance = this.fireSet;
      }
      if(this.orb1 == "earth")
      {
         this.elementalResistance = this.earthSet;
      }
      if(this.orb1 == "thunder")
      {
         this.elementalResistance = this.thunderSet;
      }
      if(this.orb1 == "ice")
      {
         this.elementalResistance = this.iceSet;
      }
      if(this.orb1 == "holy")
      {
         this.elementalResistance = this.holySet;
      }
      if(this.orb1 == "dark")
      {
         this.elementalResistance = this.darkSet;
      }
   }
   function element()
   {
      this.orb1 = this.orb2;
      this.orb2 = this.orb3;
      this.orb3 = this.orb4;
      this.orb4 = this.elements[random(6)];
      this.buff("magicAttackUp",0.5);
      this.newWeakness();
      this.accuracy = 9;
      this.evade = 11;
   }
   function makeMove()
   {
      if(!this.speck)
      {
         this.speck = true;
      }
      else
      {
         this.parent.doSpeech(199);
         this.parent.doSpeech(200);
         this.parent.doSpeech(201);
         this.parent.doSpeech(202);
         this.parent.doSpeech(203);
         this.parent.doSpeech(204);
         this.parent.doSpeech(205);
         this.parent.doSpeech(206);
         this.parent.doSpeech(207);
         this.parent.doSpeech(208);
         this.parent.doSpeech(209);
         this.speck = false;
      }
      "AKRON PATTERN:";
      "Raised: " + this.graphic.raised;
      "Charge: " + this.charge;
      "Til Claw: " + this.clawWait;
      "Til Up: " + this.raisedWait;
      "Til Element: " + this.swapWait;
      this.turnStart();
      var _loc2_;
      var _loc3_;
      var _loc4_;
      if(this.graphic.raised)
      {
         _loc2_ = random(5);
         if(this.raisedWait <= 0 and this.getHpPercent() >= 25)
         {
            _loc2_ = 6;
         }
         if(this.charge)
         {
            _loc2_ = 5;
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
            this.graphic.gotoAndPlay("special4");
         }
         if(_loc2_ == 3)
         {
            this.graphic.gotoAndPlay("special5");
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
            this.graphic.gotoAndPlay("down");
            this.poison = 0;
            this.formDamage = 0;
            this.clawWait = 5;
         }
         this.raisedWait -= 1;
      }
      else
      {
         _loc3_ = [0,0,0,0,0,0];
         if(this.orb1 == "fire")
         {
            _loc3_[0] = _loc3_[1] = _loc3_[2] = 0;
         }
         if(this.orb1 == "thunder")
         {
            _loc3_[0] = _loc3_[1] = _loc3_[2] = 1;
         }
         if(this.orb1 == "ice")
         {
            _loc3_[0] = _loc3_[1] = _loc3_[2] = 2;
         }
         if(this.orb1 == "earth")
         {
            _loc3_[0] = _loc3_[1] = _loc3_[2] = 4;
         }
         if(this.orb1 == "dark")
         {
            _loc3_[0] = _loc3_[1] = _loc3_[2] = 5;
         }
         if(this.orb1 == "heal")
         {
            _loc3_[0] = _loc3_[1] = _loc3_[2] = 6;
         }
         _loc4_ = 2;
         while(_loc4_ < 5)
         {
            if(this["orb" + _loc4_] == "fire")
            {
               _loc3_[_loc4_ + 1] = 0;
            }
            if(this["orb" + _loc4_] == "thunder")
            {
               _loc3_[_loc4_ + 1] = 1;
            }
            if(this["orb" + _loc4_] == "ice")
            {
               _loc3_[_loc4_ + 1] = 2;
            }
            if(this["orb" + _loc4_] == "earth")
            {
               _loc3_[_loc4_ + 1] = 4;
            }
            if(this["orb" + _loc4_] == "dark")
            {
               _loc3_[_loc4_ + 1] = 5;
            }
            if(this["orb" + _loc4_] == "heal")
            {
               _loc3_[_loc4_ + 1] = 6;
            }
            _loc4_ += 1;
         }
         "CHOICES: " + _loc3_;
         _loc2_ = _loc3_[random(6)];
         if(this.clawWait <= 0)
         {
            _loc2_ = 3;
         }
         if(this.formDamage >= this.maxHP / 15)
         {
            _loc2_ = 7;
         }
         if(this.swapWait <= 0)
         {
            _loc2_ = 8;
            this.swapWait = 10;
         }
         if(_loc2_ == 0)
         {
            this.graphic.gotoAndPlay("special8");
         }
         if(_loc2_ == 1)
         {
            this.graphic.gotoAndPlay("special9");
         }
         if(_loc2_ == 2)
         {
            this.graphic.gotoAndPlay("special10");
         }
         if(_loc2_ == 3)
         {
            this.graphic.gotoAndPlay("special11");
            this.clawWait = 5;
         }
         if(_loc2_ == 4)
         {
            this.graphic.gotoAndPlay("special12");
         }
         if(_loc2_ == 5)
         {
            this.graphic.gotoAndPlay("special13");
         }
         if(_loc2_ == 6)
         {
            this.graphic.gotoAndPlay("special14");
         }
         if(_loc2_ == 8)
         {
            this.graphic.gotoAndPlay("element");
         }
         if(_loc2_ == 7)
         {
            this.graphic.gotoAndPlay("up");
            this.poison = 0;
            this.formDamage = 0;
            this.raisedWait = 3;
         }
         this.clawWait -= 1;
      }
      if(this.spawnWait == 0)
      {
         this.spawnWait = 8;
         _loc2_ = random(3);
         if(_loc2_ == 0)
         {
            this.parent.spawnFoe(DarkClay,this.level);
         }
         if(_loc2_ == 2)
         {
            this.parent.spawnFoe2(CosmicMonolith,this.level);
         }
         if(_loc2_ == 1)
         {
            this.parent.spawnFoe(SkullGhost,this.level);
         }
      }
      this.spawnWait -= 1;
      this.swapWait -= 1;
   }
   function special1()
   {
      this.castSpell("darkeyes");
   }
   function darkeyes()
   {
      this.targetAll = "allPlayers";
      this.sendHit("magic",80,0.1,"dark",1,"doom",0.7,3,1.9,0.1);
   }
   function special2()
   {
      this.sendHit("attack",120,0.1,"bomb",1,"null",1,0.3,1.1,0.2);
      this.target = this.parent.randomPlayer();
   }
   function special3()
   {
      this.parent.spawnWorm(this.level + 2);
   }
   function special4()
   {
      this.targetAll = "allPlayers";
      this.sendHit("magic",130,0.1,"dark",1,"defenceDown",0.8,0.3,1.5,0.1);
   }
   function special5()
   {
      this.targetAll = "allPlayers";
      this.sendHit("attack",130,0.1,"thunder",0.5,"stun",0.3,1,0.9,0.1);
   }
   function special6()
   {
      this.charge = true;
      this.buff("magicAttackUp",0.5);
   }
   function special7()
   {
      this.targetAll = "allPlayers";
      this.sendHit("attack",20,0.1,"dark",0.5,"death",0.05,1,0.9,0.1);
   }
   function special77()
   {
      this.targetAll = "allPlayers";
      this.castSpell("darkball");
   }
   function darkball()
   {
      this.targetAll = "allPlayers";
      this.sendHit("attack",190,0.1,"dark",0.5,"death",0.1,1,2,0.1);
      this.charge = false;
   }
   function special8()
   {
      this.sendHit("magic",62.5,0.1,"fire",1,"berserk",0.07,1,1.4,0.1);
      this.target = this.parent.randomPlayer();
   }
   function special9()
   {
      this.targetAll = "allPlayers";
      this.sendHit("magic",70,0.1,"thunder",1,"stun",0.1,1,1.4,0.1);
   }
   function special10()
   {
      this.sendHit("magic",160,0.1,"ice",1,"freeze",1,1,0.9,0.1);
   }
   function special11()
   {
      this.parent.spawnClaws(this.level);
      this.buff("magicDefenceUp",0.5);
      this.buff("defenceUp",0.5);
   }
   function special12()
   {
      this.targetAll = "allPlayers";
      this.sendHit("magic",85,0.1,"earth",1,"null",0.1,1,1.5,0.1);
   }
   function special13()
   {
      this.targetAll = "allPlayers";
      this.sendHit("magic",50,0.1,"dark",1,"dispel",0.6,1,1.5,0.1);
   }
   function special14()
   {
      this.targetAll = "allFoes";
      var _loc2_ = 0;
      while(_loc2_ < 5)
      {
         this.parent.foes[_loc2_].getHeal(30000,0.1);
         this.parent.foes[_loc2_].regen += 3;
         _loc2_ += 1;
      }
   }
   function hideFoes()
   {
      var _loc2_ = 0;
      while(_loc2_ < 5)
      {
         this.parent.foes[_loc2_].graphic._visible = false;
         _loc2_ += 1;
      }
      this.graphic._visible = true;
   }
}
