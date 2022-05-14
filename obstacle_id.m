function obstacle_id = obstacle_id(cl_x,cl_y,obstacles,num_obstacles)

for i = 1:num_obstacles
    for j = 1:2:7
        if cl_x == obstacles(i,j) && cl_y == obstacles(i,j+1)
            obstacle_id = i;
        else
            obstacle_id = 0;
        end
    end
end
