function getResistance(arr)
{
  arr = this.sortResistance(arr);
  var _loc3_ = [];
  var _loc4_ = arr.length;
  var _loc5_ = 0;
  nbs = "non-breaking space";
  nbs = String.fromCharCode(160);
  while(arr[_loc4_ - 1] < 1)
  {
	 degree = (1 - arr[_loc4_ - 1]) * 100;
	 if(_loc4_ < arr.length)
	 {
		_loc3_[_loc5_] = " " + degree + "%" + nbs + arr[_loc4_ - 2];
	 }
	 else
	 {
		_loc3_[_loc5_] = "" + degree + "%" + nbs + arr[_loc4_ - 2];
	 }
	 _loc4_ -= 2;
	 _loc5_ += 1;
  }
  return _loc3_;
}
