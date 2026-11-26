function getWeakness(arr)
{
  arr = this.sortResistance(arr);
  var _loc3_ = [];
  var _loc4_ = 0;
  var _loc5_ = 0;
  nbs = "non-breaking space";
  nbs = String.fromCharCode(160);
  zwnbs = "0 width no-break space";
  zwnbs = String.fromCharCode(65279);
  while(arr[_loc4_ + 1] > 1)
  {
	 _loc69_ = (1 - arr[_loc4_ + 1]) * -100;
	 _loc69_ = "-" + zwnbs + _loc69_;
	 if(_loc4_ > 0)
	 {
		_loc3_[_loc5_] = " " + _loc69_ + "%" + nbs + arr[_loc4_];
	 }
	 else
	 {
		_loc3_[_loc5_] = "" + _loc69_ + "%" + nbs + arr[_loc4_];
	 }
	 _loc4_ += 2;
	 _loc5_ += 1;
  }
  return _loc3_;
}
