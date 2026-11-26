class PlayerBrickers
{
   static var handleGraphicData;
   static var makeDamageObject;
   function PlayerBrickers()
   {
   }
   static function handleGraphicData(player, p, point)
   {
      player.parent = p;
      player.graphic = eval("p.player" + player.playerNumber + "Graphic");
      player.graphic.playerData = player;
      player.graphic._xscale = 67.7;
      player.graphic._yscale = 67.7;
      player.graphic.k = function()
      {
         if(!this.playerData.gettingHit)
         {
            this.gotoAndPlay("stand");
         }
      };
      player.graphic.run = function(X, Y)
      {
         this._x -= this.X;
         this._y -= this.Y;
      };
      player.graphic.getPoint = function(a)
      {
         return eval("this.point" + a);
      };
      player.graphic.shake = function(a)
      {
         this._parent.shake.gotoAndPlay(a);
      };
      player.depth = player.graphic.getDepth();
      player.reposition(point);
      trace(player.graphic);
   }
   static function makeDamageObject(type, power, randomness, element, e, stat, s, ss, acc, critP)
   {
      return new DamageObject(type,power,randomness,element,e,stat,s,ss,acc,critP);
   }
}
