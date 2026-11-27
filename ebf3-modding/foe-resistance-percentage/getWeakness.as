function getWeakness(arr)
{
   arr = this.sortResistance(arr);
   var _loc3_ = [];
   var _loc4_ = 0;
   var _loc5_ = 0;
   zwnbs = "0 width no-break space";
   zwnbs = String.fromCharCode(65279);
   while(arr[_loc4_ + 1] > 1)
   {
      degree = (1 - arr[_loc4_ + 1]) * -100;
      degree = "-" + zwnbs + degree;
      separator = "";
      if(_loc4_ > 0)
      {
         separator = " ";
      }
      _loc3_[_loc5_] = separator + degree + "%" + zwnbs + " " + zwnbs + arr[_loc4_];
      _loc4_ += 2;
      _loc5_ += 1;
   }
   return _loc3_;
}
