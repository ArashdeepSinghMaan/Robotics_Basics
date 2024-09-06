clc; clear all;
a1=1;a2=1;a3=0.5;
x=0.80;y=0.60;
phi=(120*pi)/180;
%parameters for circle
centre=[1 1];
radius=0.5;
[thetha1 thetha2 thetha3 wx wy]=IKin(x,y)
for i=[1 2];
    X=[0 a1*cos(thetha1(i))  wx  x];
    Y=[0 a1*sin(thetha1(i))  wy   y];
  
   
    axis([-3 3 -3 3])
end

The1_conf1=[];
The1_conf2=[];
The2_conf1=[];
The2_conf2=[];
The3_conf1=[];
The3_conf2=[],
X1=[];
Y1=[]
ang=linspace(0,2*pi,100);
for i=1:length(ang)
    x1=centre(1)+radius*cos(ang(i));
    y1=centre(2)+radius*sin(ang(i));
    X1=[X1 x1];
    Y1=[Y1 y1];
    [thetha1 ,thetha2, thetha3 ,wx ,wy]=IKin(x1,y1);
    
    X=[ 0,a1*cos(thetha1(1)),wx,x1];
    Y=[ 0,a1*sin(thetha1(1)),wy,y1];
    X2=[0,a1*cos(thetha1(2)),wx,x1];
    Y2=[0,a1*sin(thetha1(2)),wy,y1];
    
   
    
   
    plot(X2,Y2,X,Y,X1(1:i),Y1(1:i))
    axis([-3 3 -3 3])
    pause(.01)
    axis equal
    
    % The1_conf1=[The1_conf1,thetha1(1)];
    % The1_conf2=[The1_conf2,thetha1(2)];
    % The2_conf1=[The2_conf1,thetha2(1)];
    % The2_conf2=[The2_conf2,thetha2(2)];
    % The3_conf1=[The3_conf1,thetha3(1)];
    % The3_conf2=[The3_conf2,thetha3(2)];
    % 
    
  
    
end
% 
% figure(5)
% hold on
% plot([1:length(ang)],The1_conf1*(180/pi),'m')
% plot([1:length(ang)],The1_conf2*(180/pi),'r')
% grid on
% xlabel("X")
% ylabel("Y(angle)")
% axis([1 length(ang) -300,300])
% 
% figure(6)
% hold on
% plot([1:length(ang)],The2_conf1*(180/pi),'m')
% plot([1:length(ang)],The2_conf2*(180/pi),'r')
% grid on
% xlabel("X")
% ylabel("Y(angle)")
% axis([1 length(ang) -300,300])
% 
% 
% 
% 
% figure(7)
% hold on
% plot([1:length(ang)],The3_conf1*(180/pi),'m')
% plot([1:length(ang)],The3_conf2*(180/pi),'r')
% grid on
% xlabel("X")
% ylabel("Y(angle)")
% axis([1 length(ang) -450,450 ])




