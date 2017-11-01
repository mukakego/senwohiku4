class ten {
  float x, y;
  sen[] parent = {null, null};

  ten(float _x, float _y) {
    x = _x;
    y = _y;
  }

  ten(float _x, float _y, sen _a, sen _b) {
    x = _x;
    y = _y;
    parent[0] = _a;
    parent[1] = _b;
  }

  void display() {
    ellipse(x, y, 5, 5);
  }
}