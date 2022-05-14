% function to see if the point was traversed previously or not.

function traversal_hist = traversal_hist(clx, cly, cl)

for i = 1:size(cl,1)
    if clx == cl(i,1) && cly == cl(i,2)
        traversal_hist = 1;
    else
        traversal_hist = 0;
    end
end
