ten[] others = new ten[10];
ten center = new ten(0, 0);
sen[] waku;

void setup() {
  size(400, 400);

  for (int i = 0; i < others.length; i++) {
    others[i] = new ten(random(0, width), random(0, height));
  }

  fill(0);

  sen[] _waku = {
    new sen(1, 0, 0), 
    new sen(0, 1, 0), 
    new sen(1, 0, width), 
    new sen(0, 1, height)
  };
  waku = _waku;
}

void draw() {
  ArrayList<ten> allpoint = new ArrayList();
  ArrayList<ten> online = new ArrayList();
  ArrayList<ten> kakutei = new ArrayList();
  ArrayList<sen> proceed = new ArrayList();
  ArrayList<sen> stuck = new ArrayList();

  background(255); 

  center.x = mouseX;
  center.y = mouseY;

  int nagasa = others.length+4;
  sen[] takusan = new sen[nagasa];
  sen nearline;
  {
    float nearestdist = 1145141919;
    int nearestnumb = -1;

    for (int i = 0; i < nagasa; i++) {

      float sans;

      if (i<others.length) {
        takusan[i] = new sen(center, others[i]);
        sans = distsq(center, others[i])/4;
      } else {
        takusan[i] = waku[i-others.length];
        sans = distsq(center, takusan[i]);
      }

      if (sans < nearestdist) {
        nearestdist = sans;
        nearestnumb = i;
      }
    }

    stuck.add(takusan[nearestnumb]);
  }

  for (int i = 0; i < nagasa; i++) {
    for (int j = i + 1; j < nagasa; j++) {
      allpoint.add(cross(takusan[i], takusan[j]));
    }
  }

  while (stuck.size()>0) {
    online.clear();

    int temp = stuck.size()-1;
    nearline = stuck.get(temp);
    proceed.add(nearline);
    stuck.remove(temp);

    for (int i = 0; i<allpoint.size(); i++) {
      ten matsutaka = allpoint.get(i);
      if (matsutaka!=null) {
        if (matsutaka.parent[0] == nearline
          |matsutaka.parent[1] == nearline) {
          online.add(matsutaka);
          allpoint.remove(i);
          i--;
        }
      }
    }

    for (int i = 0; i<allpoint.size(); i++) {
      ten matsutaka = allpoint.get(i);
      if (matsutaka!=null) {
        sen kijun = nearline;
        ten ten3 = matsutaka;
        float 
          hoge = kijun.a * center.x + kijun.b * center.y - kijun.c ;
        float
          fuga = kijun.a * ten3.x + kijun.b * ten3.y - kijun.c ;
        if (fuga<0&hoge>0 | fuga>0&hoge<0) {
          allpoint.remove(i);
          i--;
        }
      }
    }

    if (nearline.borntobefree) {
      sen asgore = new sen(nearline.b, -nearline.a, 
        nearline.b*center.x-nearline.a*center.y);
      nearline.suiten = cross(nearline, asgore);
    }

    ten[] yaju = new ten[2];
    {
      float distplus = 1145141919, distminus = -1145141919;
      int nearplus = -1, nearminus = -1;
      for (int i = 0; i<online.size(); i++) {
        ten matsutaka = online.get(i)
          , justin = nearline.suiten;

        float toriel = 
          matsutaka.x - justin.x + matsutaka.y - justin.y;
        if (toriel > 0) {
          if (toriel < distplus) {
            nearplus = i;
            distplus = toriel;
          }
        } else {
          if (toriel > distminus) {
            nearminus = i;
            distminus = toriel;
          }
        }
      }

      if (nearplus!=-1)yaju[0] = online.get(nearplus);
      if (nearminus!=-1)yaju[1] = online.get(nearminus);
    }

    for (int i = 0; i< 2; i++) if (yaju[i] != null) {
      if (kakutei.indexOf(yaju[i])==-1)kakutei.add(yaju[i]);

      for (int j = 0; j< 2; j++) {
        sen gpa = yaju[i].parent[j];
        if (
          proceed.indexOf(gpa)==-1
          &
          stuck  .indexOf(gpa)==-1
          )stuck.add(gpa);
      }
    }
  }

  fill(0);
  stroke(0);
  center.display();
  for (ten matsutaka : others) {
    matsutaka.display();
  }
  for (int i = 0; i < nagasa; i++) {
    takusan[i].display();
  }
  noStroke();
  fill(255, 0, 0);

  for (int i = 0; i<kakutei.size(); i++) {
    kakutei.get(i).display();
  }

  println(frameRate);
}

ten cross(sen _a, sen _b) {
  float 
    a = _a.a, b = _a.b, c = _a.c, 
    d = _b.a, e = _b.b, f = _b.c, 
    determination = a * e - b * d;
  if (determination == 0) {
    return null;
  } else {
    float x = ( e * c - b * f) / determination;
    float y = (-d * c + a * f) / determination;
    return new ten(x, y, _a, _b);
  }
}

float distsq(ten _a, ten _b) {
  float x=_a.x-_b.x, y=_a.y-_b.y;
  return x*x+y*y;
}

float distsq(ten _a, sen _b) {
  float 
    abs = _b.a * _a.x + _b.b * _a.y - _b.c, 
    a = _b.a, b = _b.b;
  return abs*abs/(a*a+b*b);
}