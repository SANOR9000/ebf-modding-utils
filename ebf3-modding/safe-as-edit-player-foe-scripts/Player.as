class Player extends Target
{
   var HP;
   var MP;
   var X;
   var Y;
   var _parent;
   var _x;
   var _y;
   var a;
   var accuracy;
   var armor;
   var attack;
   var baseHP;
   var baseMP;
   var currentSkill;
   var dead;
   var defence;
   var depth;
   var evade;
   var gotoAndPlay;
   var graphic;
   var hat;
   var hitBy;
   var magicAttack;
   var magicDefence;
   var maxHP;
   var maxMP;
   var parent;
   var playerData;
   var playerName;
   var playerNumber;
   var removeMovieClip;
   var skills3;
   var speed;
   var target;
   var targetAll;
   var weapon;
   var level = 0;
   var busy = true;
   var turnTaken = false;
   var defending = false;
   var abilityPoints = 0;
   var exp = 0;
   var exp2 = 50;
   var limit = 0;
   var maxLimit = 100;
   var hit2HP = 0.5;
   var counter = false;
   var maxHPBonus = 0;
   var maxMPBonus = 0;
   var attackBonus = 0;
   var defenceBonus = 0;
   var magicAttackBonus = 0;
   var magicDefenceBonus = 0;
   var accuracyBonus = 0;
   var evadeBonus = 0;
   var noStat = false;
   var attackBuff = 1;
   var defenceBuff = 1;
   var magicAttackBuff = 1;
   var magicDefenceBuff = 1;
   var evadeBuff = 1;
   var accuracyBuff = 1;
   var scaleGraphic = 67.7;
   var stun = 0;
   var poison = 0;
   var syphon = 0;
   var berserk = 0;
   var regen = 0;
   var doom = 0;
   var autolife = 0;
   var freeze = 0;
   var elementalResistance = ["fire",1,"water",1,"ice",1,"thunder",1,"wind",1,"poison",1,"earth",1,"dark",1,"holy",1,"bomb",1];
   var statusResistance = ["poison",1,"stun",1,"syphon",1,"blind",1,"death",1,"berserk",1,"dispel",1,"doom",1,"attackDown",1,"defenceDown",1,"magicAttackDown",1,"magicDefenceDown",1,"accuracyDown",1,"evadeDown",1];
   var isItem = false;
   var currentItem = null;
   var act = false;
   var maxBuff = 1.7;
   var minBuff = 0.5;
   var gettingHit = false;
   var levelCap = true;
   function Player(n, na, p, point)
   {
      super();
      this.playerName = na;
      this.playerNumber = n;
   }
   function cheer()
   {
      if(!this.dead)
      {
         trace("cheer");
         this.graphic.gotoAndPlay("cheer");
      }
   }
   function getLimitPercent()
   {
      return Math.round(this.limit / this.maxLimit * 100);
   }
   function getClass()
   {
      return "Player";
   }
   function setStats(hp, mp, atk, def, matk, mdef, acc, eva, spe)
   {
      this.setHP(hp);
      this.setMP(mp);
      this.adjustHPMP();
      this.HP = this.maxHP;
      this.MP = this.maxMP;
      this.attack = atk;
      this.defence = def;
      this.magicAttack = matk;
      this.magicDefence = mdef;
      this.accuracy = acc;
      this.evade = eva;
      this.speed = spe;
   }
   function unbusy()
   {
      this.busy = false;
      this.parent.checkBusy();
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
   function resetStatus()
   {
      this.regen = 0;
      this.freeze = 0;
      this.doom = 0;
      this.counter = false;
      this.defending = false;
      this.autolife = 0;
      this.attackBuff = 1;
      this.defenceBuff = 1;
      this.magicAttackBuff = 1;
      this.magicDefenceBuff = 1;
      this.evadeBuff = 1;
      this.accuracyBuff = 1;
      this.healStatus();
   }
   function autoRevive()
   {
      if(this.autolife > 0)
      {
         this.revive(33,0);
         this.autolife = 0;
         this.parent.showStatus(this.getX(3),this.getY(3),15);
      }
      else
      {
         this.graphic.stop();
         this.unbusy();
      }
   }
   function canMove()
   {
      return !this.dead and !this.stun and !this.freeze;
   }
   function setItem(i)
   {
      this.currentItem = i;
      this.isItem = true;
      this.graphic.currentItem = i;
   }
   function useItem()
   {
      this.turnTaken = true;
      this.busy = true;
      this.parent.takingTurn = false;
      this.graphic.foodLike(this.currentItem.name);
      this.currentItem.quantity -= 1;
      if(this.currentItem.type == "Food")
      {
         if(this.currentItem.targets == "onePlayer" and this.target == this)
         {
            this.graphic.gotoAndPlay("itemeat");
         }
         else
         {
            this.graphic.gotoAndPlay("itempass");
         }
      }
      if(this.currentItem.type == "Misc")
      {
         this.graphic.gotoAndPlay("item2");
      }
   }
   function attackItem()
   {
      this.noStat = true;
      this.parent.magicGraphics.user = this;
      this.parent.magicGraphics.target = this.target;
      this.parent.magicGraphics.targetAll = this.targetAll;
      this.parent.magicGraphics.busy = true;
      this.parent.magicGraphics.gotoAndPlay(this.currentItem.effect);
   }
   function throwItem()
   {
      var _loc2_ = 0;
      while(_loc2_ < 3)
      {
         this.parent.players[_loc2_].currentItem = this.currentItem;
         this.parent.players[_loc2_].graphic.currentItem = this.currentItem;
         _loc2_ = _loc2_ + 1;
      }
      if(this.currentItem.targets == "onePlayer")
      {
         this.target.busy = true;
         this.target.graphic.gotoAndPlay("itemcatch");
         this.graphic.k();
         this.target.graphic.foodLike(this.currentItem.name);
      }
      else if(this.currentItem.targets == "deadPlayer")
      {
         this.target.revive(50,1);
         this.graphic.k();
      }
      else
      {
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            if(!this.parent.players[_loc2_].dead)
            {
               this.parent.players[_loc2_].graphic.foodLike(this.currentItem.name);
               this.parent.players[_loc2_].graphic.gotoAndPlay("itemcatch");
            }
            _loc2_ = _loc2_ + 1;
         }
      }
   }
   function eatItem()
   {
      if(this.currentItem.effect == "HP" or this.currentItem.effect == "MP" or this.currentItem.effect == "HPMP")
      {
         if(this.currentItem.effect == "HP" or this.currentItem.effect == "HPMP")
         {
            this.getHeal(this.currentItem.power * this.casual(),0);
         }
         if(this.currentItem.effect == "MP" or this.currentItem.effect == "HPMP")
         {
            this.MpHeal(this.currentItem.power * this.casual(),0);
         }
      }
      else if(this.currentItem.effect == "status")
      {
         this.healDefects();
         this.graphic.k();
      }
      else
      {
         this.buff(this.currentItem.effect,this.currentItem.power);
         this.graphic.k();
      }
   }
   function effectiveHP()
   {
      return this.maxHP;
   }
   function effectiveMP()
   {
      return this.maxMP;
   }
   function casual()
   {
      if(this.parent.user.armor.name == "Casual Shirt")
      {
         return 2;
      }
      return 1;
   }
   function healDefects()
   {
      this.stun = 0;
      this.poison = 0;
      this.syphon = 0;
      this.berserk = 0;
      this.doom = 0;
      this.parent.updatePlayerBars();
   }
   function getHpPercent()
   {
      return Math.round(this.HP / this.maxHP * 100) + 1;
   }
   function getExpPercent()
   {
      return Math.round(this.exp / this.exp2 * 100) + 1;
   }
   function getHp()
   {
      return "" + this.HP + "/" + this.maxHP;
   }
   function getExp()
   {
      return "" + this.exp + "/" + this.exp2;
   }
   function getMpPercent()
   {
      return Math.round(this.MP / this.maxMP * 100) + 1;
   }
   function getMp()
   {
      return "" + this.MP + "/" + this.maxMP;
   }
   function getEquipStats(s)
   {
      var _loc5_ = this.weapon[s][this.weapon.level - 1];
      if(_loc5_ == undefined)
      {
         _loc5_ = this.weapon[s][0];
      }
      var _loc4_ = this.hat[s][this.hat.level - 1];
      if(_loc4_ == undefined)
      {
         _loc4_ = this.hat[s][0];
      }
      var _loc3_ = this.armor[s][this.armor.level - 1];
      if(_loc3_ == undefined)
      {
         _loc3_ = this.armor[s][0];
      }
      return (_loc5_ + _loc4_ + _loc3_) / 100;
   }
   function equip(h, a, w)
   {
      this.hideArrow();
      trace("Equipping " + h.name + ", " + a.name + ", " + w.name);
      this.hat = h;
      this.armor = a;
      this.weapon = w;
      this.adjustHPMP();
      this.graphic.gotoAndPlay("equip");
      this.turnTaken = true;
      this.busy = true;
      this.parent.takingTurn = false;
   }
   function adjustHPMP()
   {
      this.maxHP = Math.round((this.baseHP + this.maxHPBonus) * (this.getEquipStats("HP") + 1));
      this.maxMP = Math.round((this.baseMP + this.maxMPBonus) * (this.getEquipStats("MP") + 1));
      if(this.HP > this.maxHP)
      {
         this.HP = this.maxHP;
      }
      if(this.MP > this.maxMP)
      {
         this.MP = this.maxMP;
      }
      this.parent.updatePlayerBars();
   }
   function equipWeapon(e)
   {
      this.weapon = e;
      this.updatePlayerGraphics(this.playerNumber,e.graphic,0);
   }
   function equipArmor(e)
   {
      this.armor = e;
      this.updatePlayerGraphics(this.playerNumber,e.graphic,2);
   }
   function equipHat(e)
   {
      this.hat = e;
      this.updatePlayerGraphics(this.playerNumber,e.graphic,1);
   }
   function getEquipElementalResistance(s)
   {
      if(this.weapon.resistance[s][this.weapon.level - 1] == undefined)
      {
         this.weapon.resistance[s][this.weapon.level - 1] = this.weapon.resistance[s][0];
      }
      if(this.hat.resistance[s][this.hat.level - 1] == undefined)
      {
         this.hat.resistance[s][this.hat.level - 1] = this.hat.resistance[s][0];
      }
      if(this.armor.resistance[s][this.armor.level - 1] == undefined)
      {
         this.armor.resistance[s][this.armor.level - 1] = this.armor.resistance[s][0];
      }
      if(this.weapon.resistance[s][this.weapon.level - 1] == undefined)
      {
         this.weapon.resistance[s] = [0,0,0,0,0];
      }
      if(this.hat.resistance[s][this.hat.level - 1] == undefined)
      {
         this.hat.resistance[s] = [0,0,0,0,0];
      }
      if(this.armor.resistance[s][this.armor.level - 1] == undefined)
      {
         this.armor.resistance[s] = [0,0,0,0,0];
      }
      return (this.weapon.resistance[s][this.weapon.level - 1] + this.hat.resistance[s][this.hat.level - 1] + this.armor.resistance[s][this.armor.level - 1]) / 100 + 1;
   }
   function getEquipStatusResistance(s)
   {
      return this.weapon.getStatusResistance(s) + this.armor.getStatusResistance(s) + this.hat.getStatusResistance(s) - 3;
   }
   function defend()
   {
      this.hideArrow();
      this.defending = true;
   }
   function hideArrow()
   {
      this.parent.playerArrow._x = -1000;
   }
   function useSkill()
   {
      this.noStat = false;
      this.hideArrow();
      this.turnTaken = true;
      if(this.isItem)
      {
         this.useItem();
      }
      else
      {
         trace("using " + this.currentSkill.name);
         this.graphic.gotoAndPlay(this.currentSkill.effect);
         this.graphic.skill = this.currentSkill;
         this.graphic.user = this;
         this.graphic.target = this.target;
         this.parent.magicGraphics.skill = this.currentSkill;
         this.parent.magicGraphics.user = this;
         this.parent.magicGraphics.target = this.target;
         this.MP -= this.currentSkill.mp[this.currentSkill.level - 1];
         this.parent.updatePlayerBars();
         this.busy = true;
         this.parent.takingTurn = false;
      }
   }
   function drawSpell()
   {
      this.parent.magicGraphics.targetAll = this.targetAll;
      this.parent.magicGraphics.gotoAndPlay(this.currentSkill.name);
      this.parent.magicGraphics.busy = true;
   }
   function sendHeal(pow, ran)
   {
      var _loc3_ = pow * this.magicAttack * this.magicAttackBuff * (this.getEquipStats("magicAttack") + 1);
      trace("healing for " + _loc3_);
      var _loc2_;
      if(this.targetAll == "allPlayers")
      {
         _loc2_ = 0;
         while(_loc2_ < this.parent.players.length)
         {
            if(!this.parent.players[_loc2_].dead)
            {
               this.parent.players[_loc2_].getHeal(_loc3_,ran);
            }
            _loc2_ = _loc2_ + 1;
         }
      }
      if(this.targetAll == "onePlayer")
      {
         this.target.getHeal(_loc3_,ran);
      }
   }
   function autoBuff()
   {
      var _loc2_;
      if(this.armor.level > 3)
      {
         if(this.armor.specials[3] == "attackUp" or this.armor.specials[3] == "defenceUp" or this.armor.specials[3] == "magicDefenceUp" or this.armor.specials[3] == "magicAttackUp" or this.armor.specials[3] == "evadeUp")
         {
            if(this.armor.level == 5)
            {
               _loc2_ = 0.2;
            }
            else
            {
               _loc2_ = 0.15;
            }
            this.buff(this.armor.specials[3],_loc2_);
         }
      }
   }
   function getHeal(damage, ran)
   {
      this.busy = true;
      damage = this.randomize(damage,ran);
      damage = Math.round(damage);
      this.HP += damage;
      if(this.HP > this.maxHP)
      {
         this.HP = this.maxHP;
      }
      this.graphic.gotoAndPlay("heal");
      this.showDamage(damage,1);
      this.parent.updatePlayerBars();
   }
   function revive(damage, ran)
   {
      this.busy = true;
      damage = this.randomize(damage,ran) * (this.maxHP / 100);
      damage = Math.round(damage);
      this.HP += damage;
      if(this.HP > this.maxHP)
      {
         this.HP = this.maxHP;
      }
      this.dead = false;
      this.graphic.gotoAndPlay("revive");
      this.showDamage(damage,1);
      this.parent.updatePlayerBars();
   }
   function MpHeal(damage, ran)
   {
      damage = this.randomize(damage,ran);
      damage = Math.round(damage);
      this.MP += damage;
      if(this.MP > this.maxMP)
      {
         this.MP = this.maxMP;
      }
      this.graphic.gotoAndPlay("heal");
      this.showDamage(damage,4);
      this.parent.updatePlayerBars();
   }
   function MpHeal2(damage, ran)
   {
      damage = this.randomize(damage,ran);
      damage = Math.round(damage);
      this.MP += damage;
      if(this.MP > this.maxMP)
      {
         this.MP = this.maxMP;
      }
      this.showDamage(damage,4);
   }
   function sendHit(type, power, randomness, element, e, stat, s, ss, acc, critP)
   {
      var _loc4_;
      if(this.currentSkill.extra == "noStats")
      {
         trace("special meow meow stat get");
         acc *= this.accuracy + this.accuracyBonus;
         _loc4_ = power * this.level * 5;
      }
      else if(this.noStat)
      {
         acc *= this.accuracy + this.accuracyBonus;
         _loc4_ = power * this.level * 3;
         trace("No stat formula used.");
      }
      else if(type == "attack")
      {
         acc = acc * (this.accuracy + this.accuracyBonus) * this.accuracyBuff * (this.getEquipStats("accuracy") + 1);
         _loc4_ = power * (this.attack + this.attackBonus) * this.attackBuff * (this.getEquipStats("attack") + 1);
      }
      else if(type == "magic")
      {
         acc = acc * (this.accuracy + this.accuracyBonus) * this.accuracyBuff * (this.getEquipStats("accuracy") + 1);
         _loc4_ = power * (this.magicAttack + this.magicAttackBonus) * this.magicAttackBuff * (this.getEquipStats("magicAttack") + 1);
      }
      if(this.berserk)
      {
         _loc4_ *= 2.4;
      }
      trace("mag: " + this.magicAttack + " magBonus: " + this.magicAttackBonus + " magBuff: " + this.magicAttackBuff + " magEquip: " + (this.getEquipStats("magicAttack") + 1) + " skillPower: " + power);
      if(this.targetAll == "oneFoe")
      {
         this.target.getHit(PlayerBrickers.makeDamageObject(type,_loc4_,randomness,element,e,stat,s,ss,acc,critP));
      }
      var _loc2_;
      if(this.targetAll == "allFoes")
      {
         _loc2_ = 0;
         while(_loc2_ < this.parent.foes.length)
         {
            this.parent.foes[_loc2_].getHit(PlayerBrickers.makeDamageObject(type,_loc4_,randomness,element,e,stat,s,ss,acc,critP));
            _loc2_ = _loc2_ + 1;
         }
      }
      if(this.targetAll == "allPlayers")
      {
         _loc2_ = 0;
         while(_loc2_ < this.parent.players.length)
         {
            if(!this.parent.players[_loc2_].dead)
            {
               this.parent.players[_loc2_].getHit(PlayerBrickers.makeDamageObject(type,_loc4_,randomness,element,e,stat,s,ss,acc,critP));
            }
            _loc2_ = _loc2_ + 1;
         }
      }
      if(this.targetAll == "allButOneFoe")
      {
         _loc2_ = 0;
         while(_loc2_ < this.parent.foes.length)
         {
            if(this.parent.foes[_loc2_] != this.target)
            {
               this.parent.foes[_loc2_].getHit(PlayerBrickers.makeDamageObject(type,_loc4_,randomness,element,e,stat,s,ss,acc,critP));
            }
            _loc2_ = _loc2_ + 1;
         }
      }
      if(this.targetAll == "deadPlayer")
      {
         this.target.revive(PlayerBrickers.makeDamageObject());
      }
   }
   function swapLayer(b)
   {
      if(b)
      {
         this.graphic.swapDepths(this.target.getGraphicDepth() - 1);
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
   function getHit(hit)
   {
      var _loc6_ = this.HP * 33;
      var _loc5_;
      var _loc4_;
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
         if(this.defending and this.playerName == "Lance")
         {
            _loc5_ = 1.3;
         }
         else
         {
            _loc5_ = 1;
         }
         trace("Accuracy: " + hit.accuracy + " Evade: " + this.evade * (this.getEquipStats("evade") + 1));
         if(Math.random() > hit.accuracy / ((this.evade + this.evadeBonus) * (this.getEquipStats("evade") + 1) * _loc5_ * this.evadeBuff) and !this.stun and !this.freeze)
         {
            this.graphic.gotoAndPlay("evade");
            this.showDamage(0,3);
         }
         else
         {
            this.hitBy = this.parent.user;
            if(this.defending)
            {
               hit.damage /= 2;
            }
            if(this.freeze == 2)
            {
               hit.damage *= 2;
               this.freeze = 1;
            }
            if(hit.t == "attack")
            {
               if(this.defending and this.playerName == "Matt")
               {
                  hit.damage /= 2;
               }
               hit.damage /= (this.defence + this.defenceBonus) * this.defenceBuff * (this.getEquipStats("defence") + 1);
            }
            if(hit.t == "magic")
            {
               hit.damage /= (this.magicDefence + this.magicDefenceBonus) * this.magicDefenceBuff * (this.getEquipStats("magicDefence") + 1);
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
               _loc4_ = 2 - this.getEquipElementalResistance(hit.element);
               trace("Elem multiplier: " + _loc4_);
               hit.damage = hit.damage * hit.elementDegree * _loc4_ + hit.damage * (1 - hit.elementDegree);
            }
            hit.damage = this.randomize(hit.damage,hit.randomness);
            hit.damage = Math.round(hit.damage);
            if(hit.statusEffect != "null")
            {
               if(Math.random() < hit.statusChance * (2 - this.getEquipElementalResistance(hit.statusEffect)))
               {
                  trace("inflicted with " + hit.statusEffect);
                  if(hit.statusEffect == "stun")
                  {
                     this.stun += hit.statusDegree;
                     this.parent.showStatus(this.getX(3),this.getY(3),8);
                  }
                  else if(hit.statusEffect == "poison")
                  {
                     this.poison += hit.statusDegree;
                     this.parent.showStatus(this.getX(3),this.getY(3),11);
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
                  else if(hit.statusEffect == "freeze" and !this.berserk)
                  {
                     this.freeze = 2;
                     this.defending = false;
                     this.parent.showStatus(this.getX(3),this.getY(3),12);
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
            if(hit.damage < 0)
            {
               this.getHeal(- hit.damage,0);
            }
            else
            {
               this.HP -= hit.damage;
               this.getCounter(0.25);
               if(this.defending and this.playerName == "Natalie" and hit.t == "magic")
               {
                  this.MpHeal2(hit.damage / 10,0.1);
               }
               if(this.skills3[1].level != 0 or this.skills3[2].level != 0 or this.skills3[3].level != 0)
               {
                  if(hit.damage != 9999999)
                  {
                     this.limit += hit.damage / this.maxHP * 133 / ((this.level + 1) / 5);
                  }
                  else
                  {
                     this.limit += 50;
                  }
               }
               if(hit.damage == 9999999)
               {
                  this.showDamage(2,5);
               }
               else if(hit.crit)
               {
                  this.showDamage(hit.damage,2);
               }
               else if(this.getEquipElementalResistance(hit.element) < 1)
               {
                  this.showDamage(hit.damage,17);
               }
               else if(this.getEquipElementalResistance(hit.element) > 1)
               {
                  this.showDamage(hit.damage,16);
               }
               else
               {
                  this.showDamage(hit.damage,0);
               }
               if(this.HP <= 0)
               {
                  this.HP = 0;
                  this.graphic.gotoAndPlay("die");
                  this.dead = true;
                  _root.defs.flags.deathCount++;
                  _root.kongregate.stats.submit("deaths",1);
                  this.parent.playerStatus[this.playerNumber] = false;
                  if(!this.autolife)
                  {
                     this.resetStatus();
                  }
               }
               else if(this.freeze == 2)
               {
                  this.graphic.gotoAndPlay("freeze");
               }
               else if(this.defending)
               {
                  this.graphic.gotoAndPlay("defhit");
               }
               else if(hit.damage > this.hit2HP * this.maxHP)
               {
                  this.graphic.gotoAndPlay("hit2");
                  this.getCounter(1);
                  this.autoBuff();
               }
               else
               {
                  this.graphic.gotoAndPlay("hit");
               }
            }
         }
      }
      this.parent.updatePlayerBars();
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
   function getCounter(e)
   {
      trace(this.parent.user.getClass());
      if(Math.random() <= e and this.parent.user.getClass() == "Foe")
      {
         this.counter = true;
      }
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
   }
   function buff(stat, ss)
   {
      trace("buffing " + stat + " by " + ss);
      var _loc2_ = stat.substring(0,stat.length - 2);
      this[_loc2_ + "Buff"] += ss;
      if(this[_loc2_ + "Buff"] > this.maxBuff)
      {
         this[_loc2_ + "Buff"] = this.maxBuff;
      }
      this[_loc2_ + "Buff"] = this.round(this[_loc2_ + "Buff"]);
      this.graphic.idle.stats.update();
   }
   function showDamage(damage, style)
   {
      this.parent.showDamage(damage,this.getX(3),this.getY(3),style);
   }
   function healStatus()
   {
      this.poison = 0;
      this.doom = 0;
      this.stun = 0;
      this.berserk = 0;
      this.syphon = 0;
      this.graphic.idle.stats.update();
   }
   function doomed()
   {
      if(this.doom > 0)
      {
         this.doom = this.doom - 1;
         if(this.doom == 0)
         {
            this.busy = true;
            this.getHit(PlayerBrickers.makeDamageObject("magic",this.maxHP * this.hit2HP * this.magicDefence,0.1,"null",1,"death",3,1,999,0));
         }
      }
      this.graphic.idle.stats.update();
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
         _loc5_[_loc4_] = arr[_loc2_];
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
         _loc5_[_loc4_] = arr[_loc2_ - 2];
         _loc2_ -= 2;
         _loc4_ = _loc4_ + 1;
      }
      return _loc5_;
   }
   function updatePlayerGraphics(num, gra, ind)
   {
      if(num == 1)
      {
         _root.P1equips[ind] = gra;
      }
      if(num == 2)
      {
         _root.P2equips[ind] = gra;
      }
      if(num == 3)
      {
         _root.P3equips[ind] = gra;
      }
   }
   function levelUp()
   {
      this.exp -= this.exp2;
      var _loc4_ = this.HP;
      var _loc3_ = this.MP;
      this.level = this.level + 1;
      _root.kongregate.stats.submit("level",this.level);
      if(this.level >= 30)
      {
         _root.defs.medals.medalGet("level3");
      }
      else if(this.level >= 20)
      {
         _root.defs.medals.medalGet("level2");
      }
      else if(this.level >= 10)
      {
         _root.defs.medals.medalGet("level1");
      }
      _root.defs.getBaseStats(this.playerNumber);
      this.baseHP = Math.floor(this.baseHP * Math.pow(1.15,this.level));
      this.baseMP = Math.floor(this.baseMP * Math.pow(1.1,this.level));
      this.adjustHPMP();
      this.attack = Math.floor(this.attack * Math.pow(1.13,this.level));
      this.magicAttack = Math.floor(this.magicAttack * Math.pow(1.13,this.level));
      this.defence = Math.floor(this.defence * Math.pow(1.11,this.level));
      this.magicDefence = Math.floor(this.magicDefence * Math.pow(1.11,this.level));
      this.evade = Math.floor(this.evade + 0.2 * this.evade * (this.level / 7));
      this.accuracy = Math.floor(this.accuracy + 0.2 * this.accuracy * (this.level / 7));
      this.MP = _loc3_;
      this.HP = _loc4_;
      this.adjustHPMP();
      this.nextExp();
      if(this.level == 30 and this.levelCap)
      {
         this.exp2 = Infinity;
      }
      if(this.exp >= this.exp2)
      {
         this.levelUp();
      }
   }
   function nextExp()
   {
      this.exp2 = Math.floor(50 * Math.pow(1.39,this.level));
   }
   function createGraphics(p, point)
   {
      _root.kongregate.stats.submit("level",this.level);
      this.turnTaken = false;
      this.defending = false;
      this.dead = false;
      this.resetStatus();
      PlayerBrickers.handleGraphicData(this,p,point);
   }
   function getXY(a)
   {
      this.graphic.X = (this.getX(a) - this.target.getX(2) + 50) / 12;
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
      trace("\nName: " + this.playerName + "\nHP: " + this.HP + "/" + this.maxHP + "\n" + "Elem Weakness: " + this.getWeakness(this.elementalResistance) + "\nElem Resistance: " + this.getResistance(this.elementalResistance) + "\nStat Weakness: " + this.getWeakness(this.statusResistance) + "\nStat Resistance: " + this.getResistance(this.statusResistance) + "\n");
   }
   function setHP(h)
   {
      this.HP = h;
      this.baseHP = h;
      this.adjustHPMP();
   }
   function setMP(h)
   {
      this.MP = h;
      this.baseMP = h;
      this.adjustHPMP();
   }
   function fadeBuffs()
   {
      this.defending = false;
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
   }
   function fadeStatus()
   {
      this.turnTaken = true;
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
      if(this.hat.name == "Viking Helmet")
      {
         this.berserk = 1;
         this.parent.showStatus(this.getX(3),this.getY(3),13);
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
   }
   function poisonDamage()
   {
      if(this.poison != 0)
      {
         this.getHit(PlayerBrickers.makeDamageObject("magic",3 * this.level * (this.level / 5) * this.poison * this.magicDefence + 5,0.1,"poison",1,"null",0,0,999,0));
      }
   }
   function regenDamage()
   {
      if(this.regen != 0)
      {
         if(_root.defs.regen.level)
         {
            this.getHeal(_root.defs.player2.magicAttack * _root.defs.regen.power[_root.defs.regen.level - 1] / 2,0.1);
         }
      }
   }
}
