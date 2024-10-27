function plot_room_and_CB(obs, CB, grid_size, lim_flag)

    % plot grid
    for ix = 0:grid_size(1)-1
        for iy = 0:grid_size(2)-1
            plot( [ix,ix+1,ix+1,ix], [iy,iy,iy+1,iy+1],'k')
            hold on
        end
    end
    xticks(0:1:grid_size(1)); yticks(0:1:grid_size(2));
    if lim_flag == 1; xlim([0 grid_size(1)]);   ylim([0 grid_size(2)]); end
    
    % plot CB
    for itheta = 1:size(CB,1)
        for iobs = 1:size(CB,2)
            CBx = CB{itheta, iobs}(1,:); CBy = CB{itheta, iobs}(2,:);
            fill(CBx,CBy,[0.75 0.75 0.75])
            hold on
        end
    end
    
    % plot borders of CB
    color_map = get_color_map(obs); 
    for itheta = 1:size(CB,1)
        for iobs = 1:size(CB,2)
            CBx = CB{itheta, iobs}(1,:); CBy = CB{itheta, iobs}(2,:);
            plot( [CBx CBx(1)], [CBy CBy(1)],...
                  'linewidth',2,'color',color_map(iobs,:))
            hold on
        end
    end
    
    % plot obstacles 
    for iobs = 1:length(obs)
        Bx = obs{iobs}(1,:); By = obs{iobs}(2,:);
        fill( Bx, By, [1 1 0.6])
        if any( 1:7 == iobs); name_of_obs = ['B',num2str(iobs)]; end
        if any( 8:11 == iobs); name_of_obs = ['B0',num2str(iobs-7)]; end
        text( sum(Bx)/length(Bx)-0.5, sum(By)/length(By),...
              name_of_obs, 'fontweight', 'bold')
        hold on
    end
    
    % plot borders of obstacles
    for iobs = 1:length(obs)
        Bx = obs{iobs}(1,:); By = obs{iobs}(2,:);
        plot( [Bx, Bx(1)], [By, By(1)],...
              'linewidth',2,'color',color_map(iobs,:))
        hold on
    end
 
end

function color_map = get_color_map(obs)
    color_map = zeros(length(obs),3);
    if length(obs) == 11
        color_map(1:2,1) = color_map(1:2,1) + [0.5;1];
        color_map(3:4,2) = color_map(3:4,2) + [0.5;1];
        color_map(5:6,3) = color_map(5:6,3) + [0.5;1];
        color_map(7:11,:) = color_map(1:5,:);
        color_map(7:10,3) = color_map(7:10,3) + [0.5;1;0.5;1];
        color_map(11,1) = color_map(11,1) + 1;
    else
        color_map = [1 0 0];
    end
end
