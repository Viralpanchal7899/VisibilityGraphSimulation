% Visiblity graph Using A*

close all
clear all
clc

% Making Rectangular arena first of 10*10
arena = polyshape([0 10 10 0],[0 0 10 10]);
plot(arena,'Facecolor','white');

% Making Obstacles within the arena
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
x_s = 2;
y_s = 6;
x_g = 9;
y_g = 8;
hold on 
plot(x_s,y_s,'*');
plot(x_g,y_g,'d');

% checking if the start-point and goal-point have direct path 
for i = 1:num_obstacles
    if collision_check(x_s,y_s,x_g,y_g,obstacles) == 0
        hold on 
        plot ([x_s x_g], [y_s y_g], 'b','LineWidth',2);
        dist = sqrt((x_g - x_s)^2 + (y_g - y_s)^2);
    end
    pause(.1)
end

% making edges from start-point to neigbouring vertices
for i = 1:num_obstacles
    for m = 1:2:7
        if collision_check(x_s,y_s,obstacles(i,m),obstacles(i,m+1),obstacles) == 0
            hold on 
            plot ([x_s obstacles(i,m)], [y_s obstacles(i,m+1)], 'b');
        end
        pause(.1)
    end
end

% Connecting all the vertices
for p = 1:num_obstacles
    for q = 1:2:7
        p_x = obstacles(p,q);
        p_y = obstacles(p,q+1);
        for i = 1:num_obstacles
            if p ~= i
                for m = 1:2:7
                    if collision_check(p_x,p_y,obstacles(i,m),obstacles(i,m+1),obstacles) == 0
                        hold on 
                        plot([p_x obstacles(i,m)],[p_y obstacles(i,m+1)],'r');
                    end
                    pause(.1)
                end
            end
        end
    end
end
   
% making edges from goal-point to neigbouring vertices 
for i = 1:num_obstacles
    for m = 1:2:7
        if collision_check(x_g,y_g,obstacles(i,m),obstacles(i,m+1),obstacles) == 0
            hold on 
            plot ([x_g obstacles(i,m)], [y_g obstacles(i,m+1)], 'g');
        end
        pause(.1)
    end
end

cl_list_index = 1;
cl_list(cl_list_index,1) = x_s;
cl_list(cl_list_index,2) = y_s;

while cl_list(size(cl_list,1),1) ~= x_g && cl_list(size(cl_list,1),2) ~= y_g
    op_list_index = 1;
    
    for i = 1:num_obstacles
        for j = 1:2:7
            if cl_list(size(cl_list,1),1) == obstacles(i,j) && cl_list(size(cl_list,1),2) == obstacles(i,j+1)
                obstacle_id = i;
                break;
            else
                obstacle_id = 0;
            end
        end
        if obstacle_id > 0
            break;
        end
    end
    
    if collision_check(cl_list(size(cl_list,1),1),cl_list(size(cl_list,1),2),x_g,y_g,obstacles) == 0
        cl_list_index = cl_list_index + 1;
        cl_list(cl_list_index,1) = x_g;
        cl_list(cl_list_index,2) = y_g;
        break;
    end
    
    for m = 1:num_obstacles
        if obstacle_id ~= m
            for n = 1:2:7
                if collision_check(cl_list(size(cl_list,1),1),cl_list(size(cl_list,1),2),obstacles(m,n),obstacles(m,n+1),obstacles) == 0
                    op_list(op_list_index,1) = obstacles(m,n);
                    op_list(op_list_index,2) = obstacles(m,n+1);
                    weight = sqrt((obstacles(m,n) - cl_list(size(cl_list,1),1))^2 + (obstacles(m,n+1) - cl_list(size(cl_list,1),2))^2);
                    weight_mat (op_list_index,1) = weight; 
                    op_list_index = op_list_index + 1;
                end
            end
        end
    end
    
    if op_list_index ==1
        f = msgbox("No point visible from the last point in closed loop","Insufficient neighbours");
        break;
    end
    
    % update op_list for non repeating steps 
    c = 1;
    for a = 1:size(op_list,1)
        for b = 1:size(cl_list,1)
            if op_list(a,1) ~= cl_list(b,1) && op_list(a,2) ~= cl_list(b,2)
                op_list(c,1) = op_list(a,1);
                op_list(c,2) = op_list(a,2);
                weight_mat(c,1) = weight_mat(a,1);
            end
        end
        c = c + 1;
    end
    
    [min_dist,min_dist_idx] = min(weight_mat);
    cl_list_index = cl_list_index + 1;
    cl_list(cl_list_index,1) = op_list(min_dist_idx,1);
    cl_list(cl_list_index,2) = op_list(min_dist_idx,2);
    
    clear op_list;
    clear weight_mat;
end

hold on
plot(cl_list(:,1),cl_list(:,2),'k','LineWidth',3);
    
                    
    
    

        