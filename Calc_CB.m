function CB = Calc_CB(A, B)
%%%
% Input:
%   A - Description of a convex polygonal robot in some orientation
%       as a list of it's vertices described in counter-clockwise order.
%       A is a matrix of size NAx2 where NA is the number of vertices.
%   B - Description of a single convex polygonal obstacle 
%       as a list of it's vertices described in counter-clockwise order.
%       B is a matrix of size NBx2 where NB is the number of vertices.
%
% Output:
%   CB - Description of a convex polygonal c-obstacle calculated from (A,B).
%%%
    
    NA = size(A,2); NB = size(B,2);
    circA = [A A(:,1)]; circB = [B B(:,1)];
    Aprop = cell(4,NA); Bprop = cell(4,NB);
    
    % get properties of A. every cell column as
    % 2 points (2x2 mat), edge (2x1 vec), angel value, isrobot flag
    for iA = 1:NA
        Aprop(:,iA) = get_prop(circA(:,iA),circA(:,iA+1),1);
    end
    % get properties of B. every cell column as
    % 2 points (2x2 mat), edge (2x1 vec), angel value, isrobot flag
    for iB = 1:NB
        Bprop(:,iB) = get_prop(circB(:,iB),circB(:,iB+1),0);
    end
    
    % sorting from minimum angle
    [~,inds] = sort([cell2mat(Aprop(3,:)),cell2mat(Bprop(3,:))]);
    ABprop = [Aprop,Bprop]; tmp_ABprop = ABprop(:,inds);
    sort_ABprop = tmp_ABprop;
    
    % find point that connects robot and obs edges and sort from here
    for iAB = 1:size(sort_ABprop,2)-1
        % sort from the first CB point
        if tmp_ABprop{4,iAB} == tmp_ABprop{4,iAB+1} ||...
                sort_ABprop{3,iAB} == sort_ABprop{3,iAB+1}
            sort_ABprop(:,1:end-1) = sort_ABprop(:,2:end); 
            sort_ABprop(:,end) = tmp_ABprop(:,iAB);
            break
        end
    end

    NCB = length(unique(cell2mat(sort_ABprop(3,:))));
    CB = zeros(2,NCB);
    % find the first point of CB
    if sort_ABprop{4,1} == 0
        CB(:,1) = sort_ABprop{1,1}(:,2) - sort_ABprop{1,2}(:,2);
    elseif sort_ABprop{4,1} == 1
        CB(:,1) = sort_ABprop{1,2}(:,1) - sort_ABprop{1,1}(:,1);
    end
    
    % find all CB points
    iAB = 2;
    for iCB = 2:length(unique(cell2mat(sort_ABprop(3,:))))
        CB(:,iCB) = CB(:,iCB-1) + sort_ABprop{2,iAB};
        iAB = iAB + 1;
        % iAB run on sort_ABprop{3,:} so it can't exceeds his size
        if iAB > length(cell2mat(sort_ABprop(3,:))); break; end
        % correction for obs and robot vector aim to he same direction
        if sort_ABprop{3,iAB-1} == sort_ABprop{3,iAB}
            CB(:,iCB) = CB(:,iCB) + sort_ABprop{2,iAB};
            iAB = iAB + 1;
        end
    end

%     % easy plot for self chech
%     figure()
%     plot(B(1,:),B(2,:),'bo')
%     hold on
%     plot(CB(1,:),CB(2,:),'go')
%     hold off
%     grid on
end


function prop = get_prop(p1,p2,isrobot)     
    % get points matrix and edge vector, ccw (aka 0) for obs and cw (aka 1)
    % for robot
    if isrobot == 0
        prop{1,1} = [p1, p2]; prop{2,1} = p2 - p1;
    elseif isrobot == 1
        prop{1,1} = [p2, p1]; prop{2,1} = p1 - p2;
    end    
    % get angle 
    prop{3,1} = atan2d(prop{2,1}(2),prop{2,1}(1));
    % save is robot flag
    prop{4,1} = isrobot;
end