/** does not compile stand alone. preprocessing compiler directives included in the .xp files **/

#include "epix.h"
#include "stdio.h"


using namespace ePiX;


int main() {

  bounding_box(P(-0.0,-0.2), P(1.3,1.3));
  picture(2,2);
  unitlength("100pt");

  begin();

  arrow(P(0.0,0.0), P(xaxislength,0));
  arrow(P(0.0,0.0), P(0.0,1.0));
 
  label(P(0.0,1.0), P(-10,0), "$x_{i+1}$",tl);
  label(P(xaxislength,0), P(0,0), "$x_i$",br);
 

  double x=xinit;
  double x1=x;
  double x12;

  char buffer[8];
  dashed();
  line(P(x,0.),P(x,x));

  sprintf(buffer, "$x_{%i}$", 0);
  label (P(x,0), P(0,-5), buffer, b);

  for (int j=1; j<firstiter; j++){
    x1=f(x);
    x12=x+arrowshift*(x1-x);
    solid();
    arrow(P(x, x), P(x,x12));
    line(P(x, x12), P(x,x1));
    arrow(P(x,x1), P(x12,x1));
    line(P(x12,x1), P(x1,x1));
    dashed();
    line(P(x1,x1), P(x1,0));
    x=x1;
    sprintf(buffer, "$x_{%i}$", j);
    label (P(x,0), P(0,-5), buffer, b);
}

  for (int j=firstiter; j<8; j++){
    x1=f(x);
    x12=x+0.75*(x1-x);
    solid();
    line(P(x, x), P(x,x1));
    line(P(x,x1), P(x1,x1));
    dashed();
    line(P(x1,x1), P(x1,0));
    x=x1;
}



    label (P(x,0), P(0,-5), "$x_n$", b);

  
  bbold();
  solid();
  plot(f,0.,1.,15);
  solid();
  dashed();
  line(P(0,0), P(1,1));
  tikz_format();
  end();
}
