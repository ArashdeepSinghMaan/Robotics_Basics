


clear all;
clc;


eps = 0.05; 
zeta_2 = 100;
alp = 0.01;
neta_2 = 1000; 
roho = 0.1; 

m_2 = 1.5;
l_2 = 1.5;

%Starting Configuration
q_1s = 0 * (pi/180); % Initial starting angle % change this
q_2s = 0.9; % Initial starting distance of link % change this

%Final Configuration
q_1f = 120 * (pi/180); % Final starting angle
q_2f = 1.3; % Final starting distance of link

% Obstacle Position
b = [0.7 ; -0.7]; % change this

%Initial and Final Position of o2(q)
o_2 = [q_2s*sin(q_1s); -q_2s*cos(q_1s)];
o_2f = [q_2f*sin(q_1f); -q_2f*cos(q_1f)];

%Initialising q1 and q2
q_1(1) = q_1s; %q1 for angle
q_2(1) = q_2s; %q2 for distance
i = 1;


frep_2_plot2 = ([]);
%gradient descent
while(norm([q_1(i);q_2(i)] - [q_1f;q_2f]) > eps) 
    
    th1 = q_1(i); 
    d2 = q_2(i); 
    o2 = [d2*sin(th1); -d2*cos(th1)];

    % Attractive force define
    fatt_2 = -zeta_2*(o_2 - o_2f);
    %F = fatt_2;
    %Avoiding Obstacle and defining Repulsive force
    if norm(o2-b) > roho
        frep_2 = [0;0];
    else
        frep_2 = neta_2*((1/norm(o2-b))-(1/rho_0))*((1/norm(o2-b))^2)*((o2-b)/norm(o2-b));
    end
    
    %Finding overall torque
    J_o2 = [d2*cos(th1), sin(th1) ; d2*sin(th1), -cos(th1)]; %Jacobian of general o2 matrix 
    tau = (J_o2)'*fatt_2 + (J_o2)'*frep_2 ;
    
    %Incrementing the angle/distance
    q_1(i+1) = q_1(i) + alp *(tau(1,1)/norm(tau));
    q_2(i+1) = q_2(i) + alp *(tau(2,1)/norm(tau));
    
    %length of the link should not go beyond certain limit
    if q_2(i+1) > l_2
        q_2(i+1) = l_2;
    elseif q_2(i+1) <= 0 
        q_2(i+1) = 0.1; %0.1 is randomly initiated
    else 
        q_2(i+1) = q_2(i+1); 
    end
    
    %Animating
    x0 = 0; 
    y0 = 0;

    %End effector position
    xe = x0 + d2*cos(th1 - (pi/2));
    ye = y0 + d2*sin(th1 - (pi/2));
    
    %Plotting remaining link
    x1 = -(l_2 - d2)*cos(th1 - (pi/2));
    y1 = -(l_2 - d2)*sin(th1 - (pi/2));

    %Storing end effector values for tracing path
    xx(i) = xe;
    yy(i) = ye;

    figure(1)
    plot([x1 xe],[y1 ye], 'b','linewidth', 2); % Plot the robot link 
    hold on;
    plot(xx(1:i),yy(1:i), 'r', 'LineWidth', 1); % Tracing the path
    hold on;
    plot(b(1,1),b(2,1),".", 'MarkerSize',20);
    axis equal;
    axis([-2 2 -2 2]);
    grid on;
    %Making x axis and y axis
    %xline(0, 'k--', LineWidth=0.7);
   % yline(0, 'k--', LineWidth=0.7);
   
    frep_2_plot1(i) = frep_2(1,1);
    frep_2_plot2(i) = frep_2(2,1);
    fatt_2_plot1(i) = fatt_2(1,1);
    fatt_2_plot2(i) = fatt_2(2,1);
    tau1_plot(i) = tau(1,1);
    tau2_plot(i) = tau(2,1);
    i_plot(i) = i;
    
    pause(0.001);
    i = i+1;
    hold off;
end
figure(2)
plot( i_plot,frep_2_plot1, i_plot, frep_2_plot2 )
title("Repulsive Forces")
grid on
axis equal
% 
% figure(3)
% plot(i_plot, frep_2_plot2 )
% title("Repulsive Force 2")
% grid on
% axis equal
%    
figure(4)
plot(i_plot, fatt_2_plot1,i_plot, fatt_2_plot2 )
title("Attractive Forces")
grid on
axis equal

   
% figure(5)
% plot(i_plot, fatt_2_plot2 )
% title("Attractive Force2")
% grid on
% axis equal
   
figure(6)
plot(i_plot, tau1_plot,i_plot, tau2_plot )
title("Tau 1,Tau2")
grid on
axis equal

% figure(7)
% plot(i_plot, tau2_plot)
% title("Tau 2")
% grid on
% axis equal

