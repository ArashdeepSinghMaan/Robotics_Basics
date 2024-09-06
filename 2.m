%Practical2 Motion Analysis(Forward Dynamics) of 1-link robot%
clc;clear all;
%Parameters%
m=1;l=1;lc=0.5;Izz=(1/3)*(m*l^2);g=9.81;
y0 = [0;0];
time = 0:0.02:3;
% use of ode 45 %
%<include>diffeq.m</include>
%<include>tormy.m</include>
  [t,y]=ode45(@diffeq,time,y0);
  torque = tormy(t);
  time = 0:0.01:3;
y0 = [0;0];
the = y(:,1);
dthe = y(:,2);
ddthe = (1/Izz) * (torque - (m*g*lc*cos(the)));
plot(t,the,t,dthe,t,ddthe)
legend('theta','velocity','acceleration')
x = [];
y = [];
for i = 1:length(the)
    figure(2)
    
    
    
    x(i) = l*cos(the(i));
    y(i) = l*sin(the(i));
    
     plot([0 x(i)],[0 y(i)],x(1:i),y(1:i))
  
    axis([-2 2 -2 2])
    grid on
  pause(0.1)
end   
