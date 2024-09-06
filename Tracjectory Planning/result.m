clc;
clear all;
d2r=pi/180;
%Trying to supe[angle, velocity, acceleration,torque] =cycloidal(x1,x2,x3,x4)rimpose result of different trajectories using functions
to=0,tf=3,
qo=0;
vo=0;
aco=0;
qf=(2*pi)/3;
vf=0;
acf=0;
V=1.5*(qf-qo)/tf;
(qf-qo)/tf < V && V <= 2*(qf-qo)/tf ;
ts = tf/2;
alpha = V/ts;
step=0.01

[time,thd1,dthd1,ddthd1,tau1] =cubic(to,qo,vo,tf,qf,vf);
[time,thd2,dthd2,ddthd2,tau2] =quantic(to,qo,vo,aco,tf,qf,vf,acf);
[time,thd,dthd,ddthd,tau] =cycloidal(to,qo,tf,qf);
[time,thd4,dthd4,ddthd4,tau4] =parabolic_blend(to,qo,tf,qf,V);
[time,thd5,dthd5,ddthd5,tau5] =min_time(to,qo,qf,alpha);
 figure(1)
 plot(time,thd1/d2r,time,thd2/d2r,time,thd/d2r,time,thd4/d2r,time,thd5/d2r)
   xlabel("time(s)");
    ylabel("position(deg)");
    legend( 'Cubic', 'Quantic','Cycloidal', 'LSPB', 'Min Time');
 figure(2)
  plot(time,dthd1/d2r,time,dthd2/d2r,time,dthd/d2r,time,dthd4/d2r,time,dthd5/d2r)
   xlabel("time(s)");
    ylabel("velocity(deg/s)");
    legend( 'Cubic', 'Quantic','Cycloidal', 'LSPB', 'Min Time');
  figure(3)
   plot(time,ddthd1/d2r,time,ddthd2/d2r,time,ddthd/d2r,time,ddthd4/d2r,time,ddthd5/d2r)
    xlabel("time(s)");
    ylabel("Acceleration(deg/s^2)");
    legend( 'Cubic', 'Quantic','Cycloidal', 'LSPB', 'Min Time');
   figure(4)
   plot(time,tau1,time,tau2,time,tau,time,tau4,time,tau5)
    xlabel("time(s)");
    ylabel("torque");
    legend( 'Cubic', 'Quantic','Cycloidal', 'LSPB', 'Min Time');