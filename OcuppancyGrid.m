function [Cgrid] =OcuppancyGrid(itheta,PlotThis,CB,theta,obs)
%% part C
layer_sol=itheta;
Cgrid=zeros(32,32);
if PlotThis
figure
% plot 
[X,Y]=meshgrid(0:32);% Generate Grid mesh
plot(X,Y,'b')
hold on
plot(Y,X,'b') ;
% title(append('Part C - Layer Num is  ', string(layer_sol)))
title(['part C, layer number ', num2str(itheta),...
           ' (theta = ',num2str(theta(itheta)),...
           '^0)']) 
xlabel('X');ylabel('Y');
  
    axis equal

end
%% Solve
imax=32;jmax=32;% initialization
for i=1:imax
    for j=1:jmax
       % Ceate Cell Polygon
       Cell_X=[i-1,i,i,i-1];
       Cell_Y=[j-1 j-1 j j];
       CellPoly=polyshape(Cell_X,Cell_Y);
       for iObs=1:11
           CBi=polyshape(CB{layer_sol,iObs}(1,:),CB{layer_sol,iObs}(2,:));
           polyout = intersect(CellPoly,CBi);
           if polyout.NumRegions
               Cgrid(i,j)=1;
               if PlotThis
               fill(Cell_X,Cell_Y,'c')
               text(i-0.6,j-0.5,'1')
               end
               break;
           end
       end  
         % plot obstacles 
    if PlotThis
      if Cgrid(i,j)==0
       text(i-0.6,j-0.5,'0')
      end
    end
    end
end
if PlotThis
for iobs = 1:length(obs)
        Bx = obs{iobs}(1,:); By = obs{iobs}(2,:);
        plot( [Bx, Bx(1)], [By, By(1)],...
              'linewidth',2,'color','r')
        hold on
    end
% hold off
end
end
