class RuneClaw extends Foe
{
   var graphic;
   var parent;
   var targetAll;
   var foeName = "Rune Claw";
   var foeType = "Energized Blade";
   var foeDescription = "Casts elemental spells based on it\'s master\'s status. Can also heal and buff.";
   var maxHP = 240;
   var attack = 3.5;
   var defence = 4;
   var magicAttack = 4;
   var magicDefence = 4;
   var evade = 5;
   var accuracy = 4;
   var experience = 0;
   var abilityPoints = 0;
   var gold = 0;
   var dropList = [];
   var mainGraphic = "claw";
   var subGraphic = 1;
   var elementalResistance = ["fire",1,"water",1,"ice",1,"thunder",1,"wind",1,"poison",1,"earth",1,"dark",1,"holy",1,"bomb",1];
   var beam = false;
   var statusResistance = ["poison",0,"stun",0.5,"syphon",0.5,"death",0.7,"berserk",1,"dispel",1,"doom",1,"attackDown",1,"defenceDown",1,"magicAttackDown",1,"magicDefenceDown",1,"accuracyDown",0,"evadeDown",1];
   var spell1 = "cataclysm";
   var spell2 = "vines";
   var spellT1 = "onePlayer";
   var spellT2 = "onePlayer";
   var akr = null;
   var akrs = [];
   var orbb = "earth";
   function RuneClaw(a, b, c, d)
   {
      super(a,b,c,d);
      this.scaleGraphic = 110;
      this.dropList = [0,0,0,0,0,0];
      this.reposition(d);
      this.buff("evadeUp",0.5);
      this.accuracy = 10;
      this.evade = 13;
   }
   function makeMove()
   {
      akrs = [];
      for(fo in this.parent.foes)
      {
         if(fo instanceof Akron)
         {
            akrs.push(fo);
         }
      }
      akr = null;
      if(akrs.length >= 1)
      {
         akr = akrs[Math.floor(Math.random() * akrs.length)];
      }
      orbb = ["earth","ice","fire","thunder","holy","dark"][Math.floor(Math.random() * 6)];
      if(akr != null)
      {
         orbb = akr.orb1;
      }
      if(orbb == "earth")
      {
         this.spell1 = "cataclysm";
         this.spell2 = "vines";
         this.spellT1 = "onePlayer";
         this.spellT2 = "onePlayer";
      }
      if(orbb == "ice")
      {
         this.spell1 = "icestorm";
         this.spell2 = "frost";
         this.spellT1 = "allPlayers";
         this.spellT2 = "onePlayer";
      }
      if(orbb == "fire")
      {
         this.spell1 = "hellfire";
         this.spell2 = "firestorm";
         this.spellT1 = "onePlayer";
         this.spellT2 = "allPlayers";
      }
      if(orbb == "thunder")
      {
         this.spell1 = "thunderbolt";
         this.spell2 = "thunderstorm";
         this.spellT1 = "onePlayer";
         this.spellT2 = "allPlayers";
      }
      if(orbb == "holy")
      {
         this.spell1 = "shine";
         this.spell2 = "megalixir";
         this.spellT1 = "onePlayer";
         this.spellT2 = "allFoes";
      }
      if(orbb == "dark")
      {
         this.spell1 = "haunt";
         this.spell2 = "darkflare";
         this.spellT1 = "onePlayer";
         this.spellT2 = "onePlayer";
      }
      this.turnStart();
      var _loc2_ = random(8);
      if(this.beam)
      {
         _loc2_ = 8;
      }
      if(this.berserk)
      {
         _loc2_ = 1;
      }
      else if(this.syphon)
      {
         _loc2_ = random(2);
      }
      if(_loc2_ == 0)
      {
         this.graphic.gotoAndPlay("attack2");
      }
      if(_loc2_ == 1)
      {
         this.graphic.gotoAndPlay("attack3");
      }
      if(_loc2_ == 2)
      {
         this.graphic.gotoAndPlay("attack4");
      }
      if(_loc2_ == 3)
      {
         this.graphic.gotoAndPlay("special");
      }
      if(_loc2_ == 4)
      {
         this.graphic.gotoAndPlay("magic2");
      }
      if(_loc2_ == 5)
      {
         this.graphic.gotoAndPlay("magic2");
      }
      if(_loc2_ == 6)
      {
         this.graphic.gotoAndPlay("magic2");
      }
      if(_loc2_ == 7)
      {
         this.graphic.gotoAndPlay("magic");
      }
      if(_loc2_ == 8)
      {
         this.graphic.gotoAndPlay("special2");
         this.beam = false;
      }
   }
   function attack2()
   {
      this.sendHit("attack",40,0.1,"null",0.5,"null",0.1,2,1,0.1);
   }
   function attack3()
   {
      this.sendHit("attack",20,0.1,"null",0.5,"null",0.1,2,1,0.1);
   }
   function attack4()
   {
      this.sendHit("magic",70,0.1,"null",0.5,"null",0.1,2,1,0.1);
   }
   function magic1()
   {
      this.targetAll = "allFoes";
      var _loc2_ = 0;
      while(_loc2_ < 5)
      {
         this.parent.foes[_loc2_].getHeal(10000,0.1);
         this.parent.foes[_loc2_].buff("defenceUp",0.2);
         _loc2_ += 1;
      }
   }
   function magic2()
   {
      if(random(2))
      {
         this.targetAll = this.spellT1;
         this.castSpell(this.spell1);
      }
      else
      {
         this.targetAll = this.spellT2;
         this.castSpell(this.spell2);
      }
   }
   function special1()
   {
      this.beam = true;
      this.buff("magicAttackUp",0.5);
   }
   function special2()
   {
      this.sendHit("magic",120,0.1,"null",0.5,"dispel",0.7,1,1,0.1);
   }
}
