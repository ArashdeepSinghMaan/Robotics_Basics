%FORWARD KINEMATICS OF N link ROBOT MANIPULATOR%

clc;
clear all;

%Defining symbolic varaiables%
syms a alpha d theta
syms  a2 d2 d4 c 
%Input will be DH Parameters and position of End effector%
c=pi/180;a2=0.5;d2=0.5;d4=1;d6=1;

a66=1;

%First Defining DH Parameters as matrix
%Convention order for parameters will be a alpha d theta



DHTABLE= [ 0,0,0,0;
           1,0,0,0;
           ]
    
           
       
        
     
       %DEFININING HOMOGENOUS TRANSFORMATION MATRIX
        
        TDH=[cos(theta),-sin(theta),0,a;
            sin(theta)*cos(alpha),cos(theta)*cos(alpha),-sin(alpha),-d*sin(alpha);
            sin(theta)*sin(alpha),cos(theta)*sin(alpha),cos(alpha),d*cos(alpha);
            0,0,0,1]
        %N is the number of liinks
        %There will be different values of N as per the case
        %For RR Manipulator
        N=2;
        A=cell(1,N);x=zeros(3,N+1);
        for i=1:N
            a=DHTABLE(i,1);
            alpha=DHTABLE(i,2);
            d=DHTABLE(i,3);
            theta=DHTABLE(i,4);
            A{i}=subs(TDH);
        end
        T=eye(4);
        for i=1:N
            T=T*A{i};
            T=simplify(T);
            x(:,i)=T(1:3,4)
        end
        T01=A{1};
        T12=A{2};
        
        TO2=T
        R02=T(1:3,1:3)
        O02=T(1:3,4)
        z=[1,0,0,1]';
        P02=T*z
        x(:,N+1)=P02(1:3)
        fig(x)