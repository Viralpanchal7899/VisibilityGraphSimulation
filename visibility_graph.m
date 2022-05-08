close all
clear all
clc

% Making Rectangular arena first of 10*10

arena = polyshape([0 10 10 0],[0 0 10 10]);
plot(arena,'Facecolor','white');

% Making Obstacles within the arena
x1 = [1.5 3.5 3.5 1.5];
y1 = [2 2 4 4];
x2 = [3 5 5 3];
y2 = [6.5 6.5 8.5 8.5];
x3 = [6 8 8 6];
y3 = [3 3 5 5];
obstacles = [1.5 2 3.5 2 3.5 4 1.5 4;
             3 6.5 5 6.5 5 8.5 3 8.5;
             6 3 8 3 8 5 6 5];
         
num_obstacles = size(obstacles,1);
for i_obs = 1:num_obstacles
    obs_x = [obstacles(i_obs,1) obstacles(i_obs,3) obstacles(i_obs,5) obstacles(i_obs,7)];
    obs_y = [obstacles(i_obs,2) obstacles(i_obs,4) obstacles(i_obs,6) obstacles(i_obs,8)];
    patch(obs_x,obs_y,'black');
end
hold on

% Declare the starting point and goal point
x_s = 1;
y_s = 8;
x_g = 9;
y_g = 0.5;
hold on 
plot(x_s,y_s,'*');
plot(x_g,y_g,'d');

% checking if the start-point and goal-point have direct euclidien path 
for i = 1:num_obstacles
    if collision_check_segment(x_s,y_s,x_g,y_g,obstacles) == 0
        hold on 
        plot ([x_s x_g], [y_s y_g], 'b','LineWidth',2);
        dist = sqrt((x_g - x_s)^2 + (y_g - y_s)^2);
    end
    pause(.1)
end

path_index = 1; 
% making edges from start-point to neigbouring vertices
for i = 1:num_obstacles
    for m = 1:2:7
        if collision_check_segment(x_s,y_s,obstacles(i,m),obstacles(i,m+1),obstacles) == 0
            child_l1{1,path_index} = [x_s y_s;obstacles(i,m) obstacles(i,m+1)];
            path_index = path_index + 1;
            hold on 
            plot ([x_s obstacles(i,m)], [y_s obstacles(i,m+1)], 'b');
        end
        pause(.1)
    end
end

for i = 1:size(child_l1,2)
    temp_tree = child_l1{1,i};
    
end

% Connecting all the vertices
for i = 1:length(x1)
    for m = 1:length(x2)
        p1_x = [x1(1,i) x2(1,m)];
        p1_y = [y1(1,i) y2(1,m)];
        if collision_check_segment(x1(1,i),y1(1,i),x2(1,m),y2(1,m),obstacles) == 0
            hold on
            plot(p1_x,p1_y,'r');
        end
        pause(.1)
    end
    for n = 1:length(x3)
        p2_x = [x1(1,i) x3(1,n)];
        p2_y = [y1(1,i) y3(1,n)];
        if collision_check_segment(x1(1,i),y1(1,i),x3(1,n),y3(1,n),obstacles) == 0
            hold on 
            plot(p2_x,p2_y,'r');
        end
        pause(.1)
    end
end 
for i = 1:length(x2)
    for m = 1:length(x3)
        p3_x = [x2(1,i) x3(1,m)];
        p3_y = [y2(1,i) y3(1,m)];
        if collision_check_segment(x2(1,i),y2(1,i),x3(1,m),y3(1,m),obstacles) == 0
            hold on
            plot(p3_x,p3_y,'r');
        end
        pause(.1)
    end
end

% making edges from goal-point to neigbouring vertices 
for i = 1:num_obstacles
    for m = 1:2:7
        if collision_check_segment(x_g,y_g,obstacles(i,m),obstacles(i,m+1),obstacles) == 0
            hold on 
            plot ([x_g obstacles(i,m)], [y_g obstacles(i,m+1)], 'g');
        end
        pause(.1)
    end
end

cl = zeros();
cl(1,1) = x_s;
cl(1,2) = y_s;
cl_index = 1;
ol_index = 1;
open_list = zeros();
while cl(size(cl,1),1)~= x_g && cl(size(cl,1),2) ~= y_g
    open_list = zeros();
    weight = zeros();
%     clear open_list;
%     clear weight;
    if collision_check_segment(cl(cl_index,1),cl(cl_index,2),x_g,y_g,obstacles) == 0
                cl(cl_index+1,1) = x_g;
                cl(cl_index+1,2) = y_g;
                break;
    end
    for j = 1:num_obstacles
        for k = 1:2:7
            if collision_check_segment(cl(cl_index,1),cl(cl_index,2),obstacles(j,k),obstacles(j,k+1),obstacles) == 0
                open_list(ol_index,1) = obstacles(j,k);
                open_list(ol_index,2) = obstacles(j,k+1);
                weight(ol_index,1) = sqrt((obstacles(j,k) - cl(cl_index,1))^2 + ((obstacles(j,k+1)) - cl(cl_index,2))^2);
                ol_index = ol_index + 1;
            end
        end
    end
    [min_dist,min_dist_idx] = min(weight);
    cl_index = cl_index + 1;
    cl(cl_index,1) = open_list(min_dist_idx,1);
    cl(cl_index,2) = open_list(min_dist_idx,2);
end

hold on
plot(cl(:,1),cl(:,2),'k','LineWidth',3);


        