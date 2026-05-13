class Abyss extends Foe
{
   var berserk;
   var buff;
   var castSpell;
   var getHpPercent;
   var graphic;
   var level;
   var parent;
   var poison;
   var reposition;
   var scaleGraphic;
   var sendHit;
   var syphon;
   var targetAll;
   var turnStart;
   var foeName = "Abyss";
   var foeType = "Red Hydra Head";
   var foeDescription = "Attacks with dark and poison magic.";
   var maxHP = 1800;
   var attack = 4;
   var defence = 4;
   var magicAttack = 6;
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
   var subGraphic = 1;
   var elementalResistance = ["fire",-0.5,"water",1,"ice",1,"thunder",1.9,"wind",1,"poison",-0.3,"earth",1,"dark",-1,"holy",2,"bomb",1];
   var statusResistance = ["poison",1,"stun",0,"syphon",0.1,"death",0,"berserk",1,"dispel",1,"doom",1,"attackDown",1,"defenceDown",1,"magicAttackDown",1,"magicDefenceDown",1,"accuracyDown",1,"evadeDown",1];
   function Abyss(a, b, c, d)
   {
      super(a,b,c,d);
      this.scaleGraphic = 90;
      this.dropList = [_root.defs.darkmatter,_root.defs.solidspike,_root.defs.dragonscales,_root.defs.dragonscales,_root.defs.dragonscales,0];
      this.reposition(d);
      if(_root.defs.difficulty == "epic")
      {
         this.poison = 3;
      }
   }
   function specialHit5()
   {
      "ABSS CALLS OUT";
      this.parent.foes[1].deadDragon();
      this.parent.foes[2].deadDragon();
      this.parent.foes[3].deadDragon();
   }
   function deadDragon()
   {
      this.deadDragons += 1;
      "DRAGON DEATH";
      this.buff("magicDefenceUp",0.7);
      this.buff("magicAttackUp",0.7);
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
      var _loc2_ = random(7);
      if(this.getHpPercent() <= 50)
      {
         _loc2_ = random(5) + 2;
      }
      if(this.syphon or this.berserk)
      {
         _loc2_ = random(2);
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
         this.graphic.gotoAndPlay("magic2");
      }
      if(_loc2_ == 3)
      {
         this.graphic.gotoAndPlay("magic2");
      }
      if(_loc2_ == 4)
      {
         this.graphic.gotoAndPlay("magic2");
      }
      if(_loc2_ == 5)
      {
         this.graphic.gotoAndPlay("special5");
      }
      if(_loc2_ == 6)
      {
         this.graphic.gotoAndPlay("special5");
      }
      if(this.spawnWait <= 0 and this.deadDragons == 2)
      {
         this.spawnWait = 4;
         _loc2_ = random(4);
         if(_loc2_ == 0)
         {
            this.parent.spawnFoe(SwiftCrow,this.level + 1);
         }
         if(_loc2_ == 1)
         {
            this.parent.spawnFoe(DarkClay,this.level + 1);
         }
         if(_loc2_ == 2)
         {
            this.parent.spawnFoe(SkullGhost,this.level + 1);
         }
         if(_loc2_ == 3)
         {
            this.parent.spawnFoe(HolyEye,this.level + 1);
         }
      }
      this.spawnWait -= 1;
   }
   function attack1()
   {
      this.sendHit("attack",60,0.1,"null",1,"null",0.6,0.2,1,0.1);
   }
   function attack2()
   {
      this.sendHit("attack",50,0.1,"null",1,"null",0.6,0.2,1,0.1);
   }
   function special5()
   {
      this.targetAll = "allPlayers";
      var _loc3_ = 0.3;
      if(_root.defs.difficulty == "epic")
      {
         _loc3_ = 1;
      }
      this.sendHit("magic",55,0.1,"dark",1,"doom",_loc3_,3,1.2,0.1);
   }
   function magic2()
   {
      var _loc2_ = random(3);
      if(_loc2_ == 0)
      {
         this.targetAll = "allPlayers";
         this.castSpell("thedead");
      }
      if(_loc2_ == 1)
      {
         this.castSpell("death");
      }
      if(_loc2_ == 2)
      {
         this.castSpell("poisoncloud");
      }
   }
   function effect2()
   {
      this.castSpell("dragondark");
   }
}
