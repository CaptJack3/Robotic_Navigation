layers   = 32;
theta    = 0 : 360/layers : 360 - 360/layers;
robot    = cell(1,length(theta)); 
robot{1} = [0 8 8 0;
            0 0 1 1];
      
for i = 2:length(theta)
    R = [cosd(theta(i)) -sind(theta(i));
         sind(theta(i))  cosd(theta(i)) ];
    robot{i} = R * robot{1};  
end

