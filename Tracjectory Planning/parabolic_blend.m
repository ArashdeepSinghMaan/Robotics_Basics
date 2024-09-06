function[time,thd4,dthd4,ddthd4,tau4] =parabolic_blend(to,qo,tf,qf,V)
%Practical 1: Force Analysis
clc; clear;

%Model Parameters
m=1; l=1; lc=0.5; Izz=(1/3)*m*l*l; g=9.81; step=0.01; i=1; 

%Initial Parameters
rad=(pi/180); q0=0*rad; t0=0;

%Final Parameters
qf=120*rad; tf=3; 

%NOTE
V=1.5*(qf-q0)/tf;
(qf-q0)/tf < V && V <= 2*(qf-q0)/tf ;

%Tb
tb= (q0-qf+V*tf)/V;

%alpha
alpha = V/tb;

%for loop 
for t=0:step:tf
    time(i)=t;
    %syms t
    if t<=tb

        thd4(i)=q0 + (alpha/2)*t^2;
        dthd4(i)= alpha*t;
        ddthd4(i)= alpha;
        tau4(i)=(Izz*ddthd4(i))+(m*g*lc*cos(thd4(i)));
    
    elseif tb <t && t<=tf-tb
        thd4(i)= (qf+q0-V*tf)/2 + V*t;
        dthd4(i)= V;
        ddthd4(i)= 0;
        tau4(i)=(Izz*ddthd4(i))+(m*g*lc*cos(thd4(i)));
    
    elseif tf-tb < t && t<=tf
        thd4(i)= qf-(alpha*tf^2)/2 + alpha*tf*t - (alpha)/2 * t^2;
        dthd4(i)= alpha*tf - alpha*t;
         ddthd4(i)= -alpha;
        tau4(i)=(Izz*ddthd4(i))+(m*g*lc*cos(thd4(i)));
    end

%     %Initialise Origin
%     x0=0; y0=0; 
% 
%     %End effector Position
%     xe(i)=x0+l*cos(qt(i)); 
%     ye(i)=y0+l*sin(qt(i));
%     
%     %End effector Velocity
%     dxe(i)=-l*sin(qt(i))*qt_dot(i); 
%     dye(i)=l*cos(qt(i))*qt_dot(i);
    
%     %End effector Acceleration
%     ddxe(i)=-l*cos(qt(i))*qt_dot(i)-l*sin(qt(i))*qt_ddot(i);
%     ddye(i)=-l*sin(qt(i))*qt_dot(i)+l*cos(qt(i))*qt_ddot(i);
% 
%     %Animation
%     xx=[x0; xe(i)]; yy=[y0; ye(i)];                 
%     xmin=-1.5*l; xmax=1.5*l; ymin=-1.5*l; ymax=1.5*l;
% 
%     figure(2)
%     plot(xx, yy, xe(1:i), ye(1:i), 'LineWidth', 2);
%     axis([xmin xmax ymin ymax]);
%     xlabel("X(m)"); ylabel("Y(m)")
%     axis equal;
%     grid on;
%     %pause(0.01);

    i=i+1;
end

% %Plotting Graphs
% figure(1)
% plot(time,qt, time,qt_dot, time,qt_ddot, time, tau);
% xlabel("time(s)");
% ylabel("Motion and Torque");
% legend('joint angel(deg)', 'joint rate(m/s)', 'joint acceleration(m/s^2', 'Torque(N-m)');
% 
% figure(3)
% plot(time, dxe, time, dye, time, ddxe, time, ddye);
% xlabel("time(s)");
% ylabel("Speed and Acceleration");
% legend("dxe(m/s)", "dye(m/s)", 'ddxe(m/s^2)', "ddye(m/s^2)")
end