function[time,thd2,dthd2,ddthd2,tau2] =quantic(to,qo,vo,aco,tf,qf,vf,acf)
%Practical 1: Force Analysis
clc; clear all;
%Inputs
m=1; l=1;lc=0.5;Izz=(1/3)*m*l*l;g=9.81;
%Motion Parameters
tho=0;thT=(2*pi)/3; step=0.01; i=1;d2r=pi/180;
to=0,tf=3,
qo=0;
vo=0;
aco=0;
qf=(2*pi)/3;
vf=0;
acf=0;
A=[1,to,to^2,to^3,to^4,to^5;
    0,1,2*to,3*to^2,4*to^3,5*to^4;
    0,0,2,6*to,12*to^2,20*to^3;
    1,tf,tf^2,tf^3,tf^4,tf^5;
    0,1,2*tf,3*tf^2,4*tf^3,5*tf^4;
    0,0,2,6*tf,12*tf^2,20*tf^3];

C= [qo;
    vo;
    aco;
    qf;
    vf;
    acf]
B= inv(A)*C
a0=B(1);
a1=B(2);
a2=B(3);
a3=B(4);
a4=B(5);
a5=B(6)
%for loop starts
for t=0:step:tf
    time(i)=t;
  
   thd2(i)=a0+a1*t+a2*t*t+a3*t*t*t;  %q
   dthd2(i)=a1+2*a2*t+3*a3*t*t;  %dq
   ddthd2(i)=  2*a2+6*a3*t;%ddq
   tau2(i)=Izz*ddthd2(i)+m*g*lc*cos(thd2(i));
%    %End effector position, velocity and acceleration
%    x0=0;y0=0; xe(i)=x0+l*cos(thd(i));ye(i)=y0+l*sin(thd(i));
%   
%  
%    dxe(i)=-l*sin(thd(i))*dthd(i);dye(i)=l*cos(thd(i))*dthd(i);
%    ddxe(i)=-l*cos(thd(i))*dthd(i)-l*sin(thd(i))*ddthd(i);
%    ddye(i)=-l*sin(thd(i)*dthd(i))+l*cos(thd(i))*ddthd(i);
%    %ANimation
%    xx=[x0;xe(i)]; yy=[y0;ye(i)];
%    
%    figure(2)
%    plot(xx,yy,xe(1:i),ye(1:i))
%    xmin=-1.5*l; xmax=1.5*l; ymin=-1.5*l; ymax=1.5*l;
%    axis([xmin xmax ymin ymax])
%    xlabel('X(m)');ylabel('Y(m)')
%    axis equal;
%    pause(0.01)
   i=i+1;
end 
% figure(1)
% plot(time,thd/d2r,time,dthd/d2r,time,ddthd/d2r,time,tau)
% xlabel('time(s)');ylabel('Motion and torque')
% legend('Joint angle(deg)','Joint rate(deg/s)','Joint acc(deg/s)','torque(Nm)')
% figure(3)
% plot(time,dxe,time,dye,time,ddxe,time,ddye)
% legend('dxe(m/s)','dye(m/s)','ddxe(m/s)','ddye(m/s)');
end