clc; clear all;
m=1.5;
 l=1.5;
 g=9.81;
 q_1_0=0;
 q_1_T=(120/180)*pi;
 q_2_0= 0.5;
 q_2_T=1;
 T=3;step=0.01;i=1;
 for t=0:step:T
     time(i)=t;
 %FIRST JOINT
 q_1(i)= q_1_0 + ((q_1_T-q_1_0)/T)*(t-(T/(2*pi))*sin((2*pi*t)/T));
 q_1d(i)=((q_1_T-q_1_0)/T)*(1-cos((2*pi*t)/T));
 q_1dd(i)=((q_1_T-q_1_0)/T)*(((2*pi)/T)*sin((2*pi*t)/T));
 
 %SECOND JOINT
 q_2(i) = q_2_0 + ((q_2_T-q_2_0)/T)*(t-(T/(2*pi))*sin((2*pi*t)/T));
 q_2d(i)=((q_2_T-q_2_0)/T)*(1-cos((2*pi*t)/T));
 q_2dd(i)=((q_2_T-q_2_0)/T)*(((2*pi)/T)*sin((2*pi*t)/T));
 
 tau_1(i)=m*q_2(i)*q_2(i)*q_1dd(i)+2*m*q_2(i)*q_2d(i)*q_1d(i)+m*q_2(i)*sin(q_1(i))*g;
 f_2(i)=m*q_2dd(i)-m*q_2(i)*q_1d(i)*q_1d(i)-m*cos(q_1(i))*g;
 %Animation
 x0=0;y0=0;
 xe(i)=x0+q_2(i)*cos(q_1(i));
 ye(i)=y0+q_2(i)*sin(q_1(i));
 xx=[x0;xe(i)];yy=[y0;ye(i)];
 figure(1)
 plot(xx,yy,xe(1:i),ye(1:i))
 xlabel('X(m)');ylabel('Y(m)')

 xmin=-1.5*l;xmax=1.5*l;ymin=-1.5*l;ymax=1.5*l;
 axis([xmin xmax ymin ymax]);
 
 pause(0.01)
i=i+1;
 end
 figure(2)
plot(time,q_1,'-',time,q_1d,'+',time,q_1dd,'*')
title('joint 1 position, velocity, acceleration')
figure(3)
plot(time,q_2,'-',time,q_2d,'+',time,q_2dd,'*')
title('joint 2 position, velocity, acceleration')
figure(4)
plot(time,tau_1)
title('torque')
figure(5)
plot(time,f_2)
title('force')
 
 
 