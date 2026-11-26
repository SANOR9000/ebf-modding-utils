class Foe extends Target
{
   var HP;
   var X;
   var Y;
   var _parent;
   var _x;
   var _y;
   var a;
   var abilityPoints;
   var c;
   var dead;
   var depth;
   var dropList;
   var experience;
   var foeData;
   var foeName;
   var foeNumber;
   var foeType;
   var gold;
   var gotoAndPlay;
   var graphic;
   var mainGraphic;
   var maxHP;
   var parent;
   var removeMovieClip;
   var subGraphic;
   var target;
   var targetAll;
   var foeDescription = "default";
   var level = 1;
   var busy = true;
   var turnTaken = false;
   var hit2HP = 0.25;
   var attack = 1;
   var defence = 1;
   var magicAttack = 1;
   var magicDefence = 1;
   var evade = 1;
   var accuracy = 1;
   var attackBuff = 1;
   var defenceBuff = 1;
   var magicAttackBuff = 1;
   var magicDefenceBuff = 1;
   var evadeBuff = 1;
   var accuracyBuff = 1;
   var scaleGraphic = 100;
   var stun = 0;
   var poison = 0;
   var syphon = 0;
   var berserk = 0;
   var regen = 0;
   var doom = 0;
   var autolife = 0;
   var elementalResistance = ["fire",1,"water",1,"ice",1,"thunder",1,"wind",1,"poison",1,"earth",1,"dark",1,"holy",1,"bomb",1];
   var statusResistance = ["poison",1,"stun",1,"syphon",1,"blind",1,"death",1,"berserk",1,"dispel",1,"doom",1,"attackDown",1,"defenceDown",1,"magicAttackDown",1,"magicDefenceDown",1,"accuracyDown",1,"evadeDown",1];
   var act = false;
   var maxBuff = 1.7;
   var minBuff = 0.5;
   var gettingHit = false;
   function Foe(n, m, p, point)
   {
      super();
      this.parent = p;
      this.levelUp(m);
      this.foeNumber = n;
      FoeBrickers.handleGraphicData(this,n,p,point);
   }
   function dropItems()
   {
      var _loc2_ = 0;
      var _loc3_;
      while(_loc2_ < this.dropList.length)
      {
         _loc3_ = false;
         if(_loc2_ == 0 or _loc2_ == 1 and Math.random() > 0.2 or _loc2_ == 2 and Math.random() > 0.4 or _loc2_ == 3 and Math.random() > 0.6 or _loc2_ == 4 and Math.random() > 0.8 or _loc2_ == 5 and Math.random() > 0.9 or _loc2_ == 6 and Math.random() > 0.95)
         {
            _loc3_ = true;
         }
         if(_loc3_)
         {
            this.parent.dropItem(this.dropList[_loc2_]);
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function getClass()
   {
      return "Foe";
   }
   function doomed()
   {
      if(this.doom > 0)
      {
         this.doom = this.doom - 1;
         if(this.doom == 0)
         {
            this.busy = true;
            this.getHit(FoeBrickers.makeDamageObject("magic",this.maxHP * this.hit2HP * this.magicDefence,0.1,"null",1,"death",3,1,999,0));
         }
      }
      this.graphic.idle.stats.update();
      this.graphic.stats.update();
   }
   function unbusy()
   {
      this.busy = false;
      this.parent.checkBusy();
   }
   function getPower(t)
   {
      var _loc2_;
      if(t == "attack")
      {
         _loc2_ = this.attack * this.attackBuff;
      }
      if(t == "magic")
      {
         _loc2_ = this.magicAttack * this.magicAttackBuff;
      }
      return _loc2_;
   }
   function getHpPercent()
   {
      return Math.round(this.HP / this.maxHP * 100) + 1;
   }
   function sendHeal(pow, ran)
   {
      var _loc3_ = pow * this.magicAttack * this.magicAttackBuff;
      trace("healing for " + _loc3_);
      var _loc2_;
      if(this.targetAll == "allFoes")
      {
         _loc2_ = 0;
         while(_loc2_ < this.parent.foes.length)
         {
            if(!this.parent.foes[_loc2_].dead)
            {
               this.parent.foes[_loc2_].getHeal(_loc3_,ran);
            }
            _loc2_ = _loc2_ + 1;
         }
      }
      if(this.targetAll == "oneFoe")
      {
         this.target.getHeal(_loc3_,ran);
      }
   }
   function sendHit(type, power, randomness, element, e, stat, s, ss, acc, critP)
   {
      var _loc3_ = this.getPower(type) * power;
      _loc3_ = this.randomize(_loc3_,randomness);
      acc = acc * this.accuracy * this.accuracyBuff;
      if(this.berserk)
      {
         _loc3_ *= 2;
      }
      if(this.targetAll == "onePlayer")
      {
         this.target.getHit(FoeBrickers.makeDamageObject(type,_loc3_,randomness,element,e,stat,s,ss,acc,critP));
      }
      var _loc2_;
      if(this.targetAll == "allPlayers")
      {
         _loc2_ = 0;
         while(_loc2_ < this.parent.players.length)
         {
            if(!this.parent.players[_loc2_].dead)
            {
               this.parent.players[_loc2_].getHit(FoeBrickers.makeDamageObject(type,_loc3_,randomness,element,e,stat,s,ss,acc,critP));
            }
            _loc2_ = _loc2_ + 1;
         }
      }
      if(this.targetAll == "oneFoe")
      {
         this.target.getHit(FoeBrickers.makeDamageObject(type,_loc3_,randomness,element,e,stat,s,ss,acc,critP));
      }
      if(this.targetAll == "allFoes")
      {
         _loc2_ = 0;
         while(_loc2_ < this.parent.foes.length)
         {
            this.parent.foes[_loc2_].getHit(FoeBrickers.makeDamageObject(type,_loc3_,randomness,element,e,stat,s,ss,acc,critP));
            _loc2_ = _loc2_ + 1;
         }
      }
      if(this.targetAll == "all")
      {
      }
   }
   function swapLayer(b)
   {
      if(b)
      {
         this.graphic.swapDepths(this.target.getGraphicDepth() + 1);
      }
      else
      {
         this.graphic.swapDepths(this.depth);
      }
   }
   function getGraphicDepth()
   {
      return this.depth;
   }
   function randomize(damage, randomness)
   {
      damage = damage - damage * randomness / 2 + random(damage) * randomness;
      damage = Math.round(damage);
      return damage;
   }
   function specialHit1(h)
   {
   }
   function specialHit2(h)
   {
   }
   function specialHit3(h)
   {
   }
   function specialHit4(h)
   {
   }
   function specialHit5(h)
   {
   }
   function getHit(hit)
   {
      trace("foe takes damage: " + hit.damage + " element: " + hit.element + " status: " + hit.statusEffect + " chance: " + hit.statusChance);
      if(!this.dead)
      {
         this.busy = true;
         this.gettingHit = true;
         this.graphic.createEmptyMovieClip("delay",100);
         this.graphic.delay.a = this;
         this.graphic.delay.onEnterFrame = function()
         {
            this.a.gettingHit = false;
            this.removeMovieClip();
         };
         trace("Accuracy: " + hit.accuracy + " Evade: " + this.evade);
         if(Math.random() > hit.accuracy / (this.evade * this.evadeBuff) and !this.stun)
         {
            this.graphic.gotoAndPlay("evade");
            this.showDamage(0,3);
            this.parent.user.dealt = 0;
         }
         else
         {
            this.specialHit1(hit);
            hit.damage = this.randomize(hit.damage,hit.randomness);
            if(hit.t == "attack")
            {
               if(this.berserk)
               {
                  hit.damage /= 2;
               }
               hit.damage /= this.defence * this.defenceBuff;
            }
            if(hit.t == "magic")
            {
               hit.damage /= this.magicDefence * this.magicDefenceBuff;
            }
            if(hit.crit > Math.random())
            {
               hit.damage *= 1.5;
            }
            else
            {
               hit.crit = 0;
            }
            if(hit.element == "ice")
            {
               this.berserk = 0;
            }
            if(hit.element != "null")
            {
               hit.damage = hit.damage * this.getElementalResistance(hit.element) * hit.elementDegree + hit.damage * (1 - hit.elementDegree);
            }
            hit.damage = Math.round(hit.damage);
            if(hit.statusEffect != "null")
            {
               if(Math.random() < hit.statusChance * this.getStatusResistance(hit.statusEffect))
               {
                  trace("Inflicted with " + hit.statusEffect);
                  if(hit.statusEffect == "stun")
                  {
                     this.stun += hit.statusDegree;
                     this.parent.showStatus(this.getX(3),this.getY(3),8);
                  }
                  else if(hit.statusEffect == "poison")
                  {
                     this.poison += hit.statusDegree;
                     this.parent.showStatus(this.getX(3),this.getY(3),11);
                     if(this.poison > 9)
                     {
                        this.poison = 9;
                     }
                  }
                  else if(hit.statusEffect == "syphon")
                  {
                     this.syphon += hit.statusDegree;
                     this.parent.showStatus(this.getX(3),this.getY(3),9);
                  }
                  else if(hit.statusEffect == "berserk")
                  {
                     this.berserk += hit.statusDegree;
                     this.parent.showStatus(this.getX(3),this.getY(3),13);
                  }
                  else if(hit.statusEffect == "dispel")
                  {
                     this.dispel();
                     this.parent.showStatus(this.getX(3),this.getY(3),10);
                  }
                  else if(hit.statusEffect == "doom" and !this.doom)
                  {
                     this.doom = hit.statusDegree;
                     this.parent.showStatus(this.getX(3),this.getY(3),7);
                  }
                  else if(hit.statusEffect == "death")
                  {
                     hit.damage = 9999999;
                  }
                  else
                  {
                     this.debuff(hit.statusEffect,hit.statusDegree);
                  }
               }
            }
            trace("after defence applied: " + hit.damage + " element: " + hit.element + " status: " + hit.statusEffect + " chance: " + hit.statusChance);
            if(hit.damage < 0)
            {
               this.getHeal(- hit.damage);
            }
            else
            {
               this.HP -= hit.damage;
               if(this.parent.user.getClass() == "Player" and hit.damage != 9999999)
               {
                  this.parent.user.dealt = hit.damage;
                  trace(hit.damage);
                  _root.defs.damageRecord(hit.damage);
                  _root.kongregate.stats.submit("maxDamage",hit.damage);
               }
               if(hit.damage == 9999999)
               {
                  this.showDamage(2,5);
               }
               else if(hit.crit)
               {
                  this.showDamage(hit.damage,2);
               }
               else if(this.getElementalResistance(hit.element) > 1)
               {
                  this.showDamage(hit.damage,17);
               }
               else if(this.getElementalResistance(hit.element) < 1)
               {
                  this.showDamage(hit.damage,16);
               }
               else
               {
                  this.showDamage(hit.damage,0);
               }
               if(this.HP <= 0)
               {
                  this.doDie();
                  this.graphic.gotoAndPlay("die");
                  this.specialHit5(hit);
               }
               else if(!this.specialHit2(hit))
               {
                  if(hit.damage > this.hit2HP * this.maxHP)
                  {
                     this.graphic.gotoAndPlay("hit2");
                  }
                  else
                  {
                     this.graphic.gotoAndPlay("hit");
                  }
               }
            }
         }
      }
      this.parent.updateFoeBars();
   }
   function doDie()
   {
      this.addPool();
      this.HP = 0;
      this.dead = true;
      this.dropItems();
      _root.defs.flags.killCount++;
      _root.kongregate.stats.submit("kills",1);
      this.parent.playerStatus[this.foeNumber] = false;
      this.parent.checkAllDead();
      this.doom = 0;
      this.regen = 0;
      this.poison = 0;
      this.parent.updateFoeBars();
   }
   function addPool()
   {
      this.parent.goldPool += this.gold;
      this.parent.expPool += this.experience;
      this.parent.abilityPool += this.abilityPoints;
   }
   function dispel()
   {
      this.regen = 0;
      if(this.attackBuff > 1)
      {
         this.attackBuff = 1;
      }
      if(this.defenceBuff > 1)
      {
         this.defenceBuff = 1;
      }
      if(this.magicAttackBuff > 1)
      {
         this.magicAttackBuff = 1;
      }
      if(this.magicDefenceBuff > 1)
      {
         this.magicDefenceBuff = 1;
      }
      if(this.evadeBuff > 1)
      {
         this.evadeBuff = 1;
      }
      if(this.accuracyBuff > 1)
      {
         this.accuracyBuff = 1;
      }
   }
   function active(b)
   {
      if(b)
      {
         this.act = true;
      }
      else
      {
         this.act = false;
         this.parent.turnEnd();
      }
   }
   function turnStart()
   {
      this.busy = true;
      this.turnTaken = true;
      this.target = this.parent.randomPlayer();
      this.targetAll = "onePlayer";
      this.getXY(2);
      this.gettingHit = true;
      this.graphic.createEmptyMovieClip("delay",100);
      this.graphic.delay.a = this;
      this.graphic.delay.c = 2;
      this.graphic.delay.onEnterFrame = function()
      {
         if(this.c == 0)
         {
            this.a.gettingHit = false;
            this.removeMovieClip();
         }
         else
         {
            this.c = this.c - 1;
         }
      };
   }
   function round(nn)
   {
      return Math.round(nn * 100) / 100;
   }
   function debuff(stat, ss)
   {
      var _loc2_ = stat.substring(0,stat.length - 4);
      this[_loc2_ + "Buff"] -= ss;
      if(this[_loc2_ + "Buff"] < this.minBuff)
      {
         this[_loc2_ + "Buff"] = this.minBuff;
      }
      this[_loc2_ + "Buff"] = this.round(this[_loc2_ + "Buff"]);
      this.graphic.idle.stats.update();
      this.graphic.stats.update();
   }
   function buff(stat, ss)
   {
      var _loc2_ = stat.substring(0,stat.length - 2);
      this[_loc2_ + "Buff"] += ss;
      if(this[_loc2_ + "Buff"] > this.maxBuff)
      {
         this[_loc2_ + "Buff"] = this.maxBuff;
      }
      this[_loc2_ + "Buff"] = this.round(this[_loc2_ + "Buff"]);
      this.graphic.idle.stats.update();
      this.graphic.stats.update();
   }
   function showDamage(damage, style)
   {
      this.parent.showDamage(damage,this.getX(3),this.getY(3),style);
   }
   function getHeal(damage)
   {
      if(!this.dead)
      {
         damage = Math.round(damage);
         this.HP += damage;
         if(this.HP > this.maxHP)
         {
            this.HP = this.maxHP;
         }
         this.graphic.gotoAndPlay("heal");
         this.busy = true;
         this.showDamage(damage,1);
         this.parent.updateFoeBars();
      }
   }
   function healStatus()
   {
   }
   function castSpell(spell)
   {
      this.parent.magicGraphics.user = this;
      this.parent.magicGraphics.targetAll = this.targetAll;
      this.parent.magicGraphics.target = this.target;
      this.parent.magicGraphics.gotoAndPlay(spell);
      this.parent.magicGraphics.busy = true;
   }
   function getElementalResistance(el)
   {
      var _loc2_ = 0;
      while(_loc2_ < this.elementalResistance.length)
      {
         if(this.elementalResistance[_loc2_] == el)
         {
            return this.elementalResistance[_loc2_ + 1];
         }
         _loc2_ += 2;
      }
   }
   function getStatusResistance(el)
   {
      var _loc2_ = 0;
      while(_loc2_ < this.statusResistance.length)
      {
         if(this.statusResistance[_loc2_] == el)
         {
            trace(el + " resistance " + this.statusResistance[_loc2_ + 1]);
            return this.statusResistance[_loc2_ + 1];
         }
         _loc2_ += 2;
      }
   }
   function sortResistance(arr)
   {
      var _loc5_ = [];
      var _loc6_ = 0;
      var _loc8_;
      var _loc7_ = 0;
      var _loc4_;
      var _loc2_;
      while(_loc7_ < arr.length)
      {
         _loc4_ = -5;
         _loc2_ = 0;
         while(_loc2_ < arr.length)
         {
            if(arr[_loc2_ + 1] >= _loc4_ and this.notIn(_loc5_,arr[_loc2_]))
            {
               _loc4_ = arr[_loc2_ + 1];
               _loc8_ = arr[_loc2_];
            }
            _loc2_ += 2;
         }
         _loc5_[_loc6_] = _loc8_;
         _loc6_ = _loc6_ + 1;
         _loc5_[_loc6_] = _loc4_;
         _loc6_ = _loc6_ + 1;
         _loc7_ += 2;
      }
      return _loc5_;
   }
   function notIn(arr, item)
   {
      var _loc1_ = 0;
      while(_loc1_ < arr.length)
      {
         if(arr[_loc1_] == item)
         {
            return false;
         }
         _loc1_ = _loc1_ + 1;
      }
      return true;
   }
   function getWeakness(arr)
   {
      arr = this.sortResistance(arr);
      var _loc5_ = [];
      var _loc2_ = 0;
      var _loc4_ = 0;
      while(arr[_loc2_ + 1] >= 1.3)
      {
         _loc5_[_loc4_] = " " + arr[_loc2_];
         _loc2_ += 2;
         _loc4_ = _loc4_ + 1;
      }
      return _loc5_;
   }
   function getResistance(arr)
   {
      arr = this.sortResistance(arr);
      var _loc5_ = [];
      var _loc2_ = arr.length;
      var _loc4_ = 0;
      while(arr[_loc2_ - 1] <= 0.7)
      {
         _loc5_[_loc4_] = " " + arr[_loc2_ - 2];
         _loc2_ -= 2;
         _loc4_ = _loc4_ + 1;
      }
      return _loc5_;
   }
   function levelUp(m)
   {
      var _loc4_;
      var _loc5_;
      if(_root.defs.difficulty == "easy")
      {
         _loc4_ = 0.7;
         _loc5_ = 0.7;
      }
      if(_root.defs.difficulty == "normal")
      {
         _loc4_ = 1;
         _loc5_ = 1;
      }
      if(_root.defs.difficulty == "hard")
      {
         _loc4_ = 1.3;
         _loc5_ = 1;
      }
      if(_root.defs.difficulty == "epic")
      {
         _loc4_ = 1.6;
         _loc5_ = 1;
      }
      this.level = m;
      this.maxHP = Math.floor(this.maxHP * Math.pow(1.18,m) * _loc5_);
      this.HP = this.maxHP;
      this.attack = this.attack * Math.pow(1.28,m) * _loc4_;
      this.magicAttack = this.magicAttack * Math.pow(1.28,m) * _loc4_;
      this.defence = Math.floor(this.defence + 0.2 * this.defence * (m / 5));
      this.magicDefence = Math.floor(this.magicDefence + 0.2 * this.magicDefence * (m / 5));
      this.evade = Math.floor(this.evade + 0.2 * this.evade * (m / 5));
      this.accuracy = Math.floor(this.accuracy + 0.2 * this.accuracy * (m / 5));
      this.gold = Math.floor(this.gold * Math.pow(1.2,m));
      this.experience = Math.floor(this.experience * Math.pow(1.21,m));
      this.abilityPoints = Math.floor(this.abilityPoints * Math.pow(1.21,m));
   }
   function getXY(a)
   {
      this.graphic.X = (this.getX(a) - this.target.getX(2)) / 12;
      this.graphic.Y = (this.getY(a) - this.target.getY(2)) / 12;
   }
   function getX(a)
   {
      return this.graphic.getPoint(a)._x * this.graphic._xscale / 100 + this.graphic._x;
   }
   function getY(a)
   {
      return this.graphic.getPoint(a)._y * this.graphic._yscale / 100 + this.graphic._y;
   }
   function reposition(point)
   {
      this.graphic._x = point._x - this.graphic.point1._x * this.scaleGraphic / 100;
      this.graphic._y = point._y - this.graphic.point1._y * this.scaleGraphic / 100;
      this.graphic._xscale = this.graphic._yscale = this.scaleGraphic;
   }
   function printStats()
   {
      trace("\nName: " + this.foeName + "\nType: " + this.foeType + "\nHP: " + this.HP + "/" + this.maxHP + "\n" + "Elem Weakness: " + this.getWeakness(this.elementalResistance) + "\nElem Resistance: " + this.getResistance(this.elementalResistance) + "\nStat Weakness: " + this.getWeakness(this.statusResistance) + "\nStat Resistance: " + this.getResistance(this.statusResistance) + "\n" + this.foeDescription + "\n");
   }
   function printStats2()
   {
      return "Name: " + this.foeName + "\nLevel: " + this.level + "\nType: " + this.foeType + "\nHP: " + this.HP + "/" + this.maxHP + "\n\n" + "Defence: " + this.defence + "\nMagic Def: " + this.magicDefence + "\nEvade: " + this.evade + "\n\n" + this.foeDescription;
   }
   function printStats3()
   {
      return "Elemental Weakness: \n" + this.getWeakness(this.elementalResistance) + "\n\nElemental Resistance: \n" + this.getResistance(this.elementalResistance) + "\n\nStat Weakness: \n" + this.getWeakness(this.statusResistance) + "\n\nStat Resistance: \n" + this.getResistance(this.statusResistance);
   }
   function printStats4()
   {
      return "" + this.foeDescription + "\n" + this.printStats3();
   }
   function setHP(h)
   {
      this.HP = h;
      this.maxHP = h;
   }
   function makeMove()
   {
      var _loc2_ = random(4);
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
         this.graphic.gotoAndPlay("special");
      }
      if(_loc2_ == 2)
      {
         this.graphic.gotoAndPlay("magic");
      }
   }
   function fadeBuffs()
   {
      var _loc3_ = ["attack","magicAttack","defence","magicDefence","evade","accuracy"];
      var _loc2_ = 0;
      while(_loc2_ < _loc3_.length)
      {
         if(this[_loc3_[_loc2_] + "Buff"] > 1)
         {
            this[_loc3_[_loc2_] + "Buff"] -= 0.05;
         }
         if(this[_loc3_[_loc2_] + "Buff"] < 1)
         {
            this[_loc3_[_loc2_] + "Buff"] += 0.05;
         }
         this[_loc3_[_loc2_] + "Buff"] *= 100;
         this[_loc3_[_loc2_] + "Buff"] = Math.round(this[_loc3_[_loc2_] + "Buff"]) / 100;
         _loc2_ = _loc2_ + 1;
      }
      this.graphic.idle.stats.update();
      this.graphic.stats.update();
   }
   function fadeStatus()
   {
      if(this.stun > 0)
      {
         this.stun = this.stun - 1;
      }
      if(this.syphon > 0)
      {
         this.syphon = this.syphon - 1;
      }
      if(this.berserk > 0)
      {
         this.berserk = this.berserk - 1;
      }
      if(this.regen > 0)
      {
         this.regen = this.regen - 1;
      }
      if(this.autolife > 0)
      {
         this.autolife = this.autolife - 1;
      }
      this.graphic.idle.stats.update();
      this.graphic.stats.update();
   }
   function poisonDamage()
   {
      if(this.poison != 0)
      {
         this.getHit(FoeBrickers.makeDamageObject("magic",7 * this.level * (this.level / 5) * this.poison * this.magicDefence + 5,0.1,"poison",1,"null",0,0,999,0));
      }
   }
   function regenDamage()
   {
      if(this.regen != 0 and !this.dead)
      {
         this.getHeal(this.level * this.level * this.level / 6,0.1);
      }
   }
}
