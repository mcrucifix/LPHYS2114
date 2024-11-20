#include "epix.h"
#include "stdio.h"
using namespace ePiX;


double mod1 (double x) { return (fmod(x, 1. ));}

void preparePlot (){
  h_axis(P(0.0,0.0), P(1.0, 0.0), 10);
  h_axis_labels(P(0.,0.), P(1.0, 0.0), 5,  P(0,-5), b); 
  v_axis(P(0.0,0.0), P(0.0, 1.0), 10);
  v_axis_labels(P(0.,0.), P(0.,1.0), 5,  P(-5,0), l); 
  
  label(P(1,0), P(4,0), "$\\theta_n$", r);
  plain(Black(1.0));
  line(P(0.,0.), P(1.,1.));
  
}


double itenerary(double x, double omega){
  dashed();
  plain(Red(-0.2));
  P p1 = P(x,x);
  double x2 = mod1(x+ omega);
  P p2 = P(x, x2);
  P p3 = P(x2, x2);
  line(p1,p2);
  line(p2,p3);
  solid();
  return(x2);
}


double itenerarysin(double x, double omega, double K){
  dashed();
  plain(Red(-0.2));
  P p1 = P(x,x);
  double x2 = mod1(x+ omega - K/(2.*M_PI)*sin(2*M_PI*x));
  P p2 = P(x, x2);
  P p3 = P(x2, x2);
  line(p1,p2);
  line(p2,p3);
  solid();
  return(x2);
}





void sinmap (double OMEGA, double K, int n, int order, double init = 0.3 ) {
  plain(Blue(1.0));
  bold();
  int wind = 0;
  int pathnum = 0;
  path curve[6];
  path currentpath = curve[wind];
  double x=0;
  double y;
  do{
     y = x ;
     for (int i= 0; i < order ; i++) {
     y = y + OMEGA - K/(2.*M_PI)*sin(2*M_PI*y) ;
     }
     y = y - double(wind);
     if ( y > 1){
       currentpath.draw();
       currentpath = curve[pathnum];
       wind++;
       pathnum++;
       y = y - 1. ;
     }
     if ( y < 0){
       currentpath.draw();
       currentpath = curve[pathnum];
       wind--;
       pathnum++;
       y = y + 1;
     }
 
     currentpath.pt(P(x,y));
     x = x + 0.01;
  } while (x < 1);

  currentpath.draw();
//  delete[] curve;

  plain(Black(1.0));
  double x0=init;
  char buffer[50];
  for (int i=0; i<n; i++) {
    sprintf(buffer, "$x_%d$", i);
    label(P(x0,x0), P(0,6), buffer,t);
    x0 = itenerarysin(x0, OMEGA, K); 
  }
  
  sprintf(buffer, "$K=%.2f \\quad \\Omega=%.2f$", K, OMEGA) ;
  label (P(0.5, 1.1), P(0,2), buffer, c);


  sprintf(buffer, "$\\theta_{n+%d}$", order) ;
  label(P(0,1), P(0,4), buffer, t);

}
 

void simpleomega (double OMEGA, int n ) {
  plain(Blue(1.0));
  bold();
  line(P(0.,OMEGA), P(1.-OMEGA, 1));
  line(P(1.-OMEGA, 0.), P(1, OMEGA));
  plain(Black(1.0));
  double x0=0.3;
  char buffer[50];
  for (int i=0; i<n; i++) {
    sprintf(buffer, "$x_{%d}$", i);
    label(P(x0,x0), P(0,6), buffer,t);
    x0 = itenerary(x0, OMEGA); 
  }


  sprintf(buffer, "$\\Omega=%.2f$", OMEGA) ;
  label (P(0.5, 1.1), P(0,2),  buffer, c);

  sprintf(buffer, "$\\theta_{n+%d}$", 1) ;
  label(P(0,1), P(0,4), buffer, t);
}
 



