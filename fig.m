function fig(x)
%a,b=size(x)
%for i=1:n.
x1=x(1,:);
y1=x(2,:);
z1=x(3,:);
figure;
plot3(x1,y1,z1,'Linewidth',2);
xlabel('Xaxis')
ylabel('Yaxis')
zlabel('Zaxis')

grid on

axis equal
end