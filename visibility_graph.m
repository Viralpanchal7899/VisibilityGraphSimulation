close all
clear all
clc

% Making Rectangular arena first of 10*10

arena = polyshape([0 10 10 0],[0 0 10 10]);
plot(arena,'Facecolor','white');

% Making Obstacles within the arena
x1 = [1.5 1.5 2.5 2.5 3.5 3.5];
y1 = [1 3 3 5 5 1];
x2 = [2 6 5];
y2 = [6.5 8.5 6.5];
x3 = [6 6 8 8];
y3 = [2 4 4 2];
obstacles = polyshape({x1,x2,x3},{y1,y2,y3});
hold on
plot(obstacles,'Facecolor','black');

% Declare the starting point and goal point
x_s = 1;
y_s = 8;
x_g = 8;
y_g = 1;
hold on 
plot(x_s,y_s,'*');
plot(x_g,y_g,'d');

% Connecting all the vertices
for i = 1:length(x1)
    for m = 1:length(x2)
        p1_x = [x1(1,i) x2(1,m)];
        p1_y = [y1(1,i) y2(1,m)];
        hold on
        plot(p1_x,p1_y,'r');
        pause(.1)
    end
    for n = 1:length(x3)
        p2_x = [x1(1,i) x3(1,n)];
        p2_y = [y1(1,i) y3(1,n)];
        hold on 
        plot(p2_x,p2_y,'r');
        pause(.1)
    end
end 
for i = 1:length(x2)
    for m = 1:length(x3)
        p3_x = [x2(1,i) x3(1,m)];
        p3_y = [y2(1,i) y3(1,m)];
        hold on
        plot(p3_x,p3_y,'r');
        pause(.1)
    end
end

        
    
        