class sen { 
  float a, b, c;
  ten suiten = null;
  boolean borntobefree = true;

  //ax + by = c

  sen(float _a, float _b, float _c) {
    a = _a;
    b = _b;
    c = _c;
  }

  sen(ten _a, ten _b) {
    a = _a.x-_b.x;
    b = _a.y-_b.y;
    c = (
      +_a.x*_a.x+_a.y*_a.y
      -_b.x*_b.x-_b.y*_b.y
      )/2;
    suiten = new ten(
      (_a.x+_b.x)/2, (_a.y+_b.y)/2
      );
      borntobefree = false;
  }

  void display() {
    if (a != 0) {
      float x1 = (c - b * 0)/a;
      float x2 = (c - b * height)/a;
      line(x1, 0, x2, height);
    } else if (b != 0) {
      float y1 = c/b;
      float y2 = y1;
      line(0, y1, width, y2);
    }
  }
}