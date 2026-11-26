class FoeBrickers
{
   static var handleGraphicData;
   static var makeDamageObject;
   function FoeBrickers()
   {
   }
   static function handleGraphicData(foe, n, p, point)
   {
      foe.parent = p;
      foe.foeNumber = n;
      var graphicData = {foeData:foe,monster:foe.subGraphic,k:function()
      {
         if(this.foeData.graphic == undefined)
         {
            this.foeData.graphic = this;
            this.foeData.reposition(point);
            trace("FOE GRAPHIC WAS UNDEFINED, FOE FIXED IT");
         }
         if(!this.foeData.gettingHit)
         {
            this.gotoAndPlay("stand");
            this.foeData.unbusy();
            this.swapLayer(false);
         }
      },run:function(X, Y)
      {
         this._x -= this.X;
         this._y -= this.Y;
      },getPoint:function(a)
      {
         return eval("this.point" + a);
      },shake:function(a)
      {
         this._parent.shake.gotoAndPlay(a);
      }};
      foe.parent.attachMovie(foe.mainGraphic,"foe" + foe.foeNumber + "Graphic",50 + n * 5,graphicData);
      foe.graphic = eval("p.foe" + foe.foeNumber + "Graphic");
      foe.reposition(point);
      foe.depth = 50 + n * 5;
      trace("Foe graphic at depth: ");
      trace(foe.graphic.getDepth());
   }
   static function makeDamageObject(type, power, randomness, element, e, stat, s, ss, acc, critP)
   {
      return new DamageObject(type,power,randomness,element,e,stat,s,ss,acc,critP);
   }
}
