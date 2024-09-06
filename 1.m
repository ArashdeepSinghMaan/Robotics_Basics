%Practical 1: Force Analysis
clc; clear all;
%Inputs
m=1; l=1;lc=0.5;Izz=(1/3)*m*l*l;g=9.81;
%Motion Parameters
d2r=(pi/180);tho=0*d2r;thT=120*d2r;T=3; step=0.01; i=1;

%for loop starts
for t=0:step:T
    time(i)=t;
   c1=(thT-tho)/T;c2=(2*pi)/T; 
   thd(i)=tho+c1*(t-(1/c2)*sin(c2*t));
   dthd(i)=c1*(1-cos(c2*t));
   ddthd(i)=c1*(c2*sin(c2*t));
   tau(i)=Izz*ddthd(i)+m*g*lc*cos(thd(i));
   %End effector position, velocity and acceleration
   x0=0;y0=0; xe(i)=x0+l*cos(thd(i));ye(i)=y0+l*sin(thd(i));
  
 
   dxe(i)=-l*sin(thd(i))*dthd(i);dye(i)=l*cos(thd(i))*dthd(i);
   ddxe(i)=-l*cos(thd(i))*dthd(i)-l*sin(thd(i))*ddthd(i);
   ddye(i)=-l*sin(thd(i)*dthd(i))+l*cos(thd(i))*ddthd(i);
   %ANimation
   xx=[x0;xe(i)]; yy=[y0;ye(i)];
   
   figure(2)
   plot(xx,yy,xe(1:i),ye(1:i))
   xmin=-1.5*l; xmax=1.5*l; ymin=-1.5*l; ymax=1.5*l;
   axis([xmin xmax ymin ymax])
   xlabel('X(m)');ylabel('Y(m)')
   axis equal;
   pause(0.01)
   i=i+1;
end 
figure(1)
plot(time,thd/d2r,time,dthd/d2r,time,ddthd/d2r,time,tau)
xlabel('time(s)');ylabel('Motion and torque')
legend('Joint angle(deg)','Joint rate(deg/s)','Joint acc(deg/s)','torque(Nm)')
figure(3)
plot(time,dxe,time,dye,time,ddxe,time,ddye)
legend('dxe(m/s)','dye(m/s)','ddxe(m/s)','ddye(m/s)');

