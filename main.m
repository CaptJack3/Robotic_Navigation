%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Almog Elbaum  - 313269839 %%%
%%% Yakov Vaksman - 316153261 %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Clean Start
close all; clear ; clc;
tic
%% input
run([pwd,'\obstacles'])
run([pwd,'\robot_in_orientations'])
% start = robot{1} + [4 4 4 4; 24 24 24 24];
% goal  = robot{1} + [4 4 4 4; 8 8 8 8];
PlotAnB=1; %% Plot clauses (a) and (b) 
%% culc CB for all obs and robot's orientations
CB = cell(length(robot),length(obs));
for itheta = 1:length(robot)
    for iobs = 1:length(obs)
        CB{itheta, iobs} = Calc_CB(robot{itheta}, obs{iobs});
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% part a
layers2print = [1,8,16,32]; obs2print = 1; grid_size = [32,32];
if PlotAnB
ifiga = 1;
for ilayer = 1:length(layers2print)
    figure(ifiga)
    plot_room_and_CB(obs(obs2print), CB(layers2print(ilayer), obs2print),...
                     grid_size, 0)
    title(['part a, layer number ', num2str(layers2print(ilayer)),...
           ' (theta = ',num2str(theta(layers2print(ilayer))),...
           '^0), with spill outs'])        
    ifiga = ifiga + 1;
    
    figure(ifiga)
    plot_room_and_CB(obs(obs2print), CB(layers2print(ilayer), obs2print),...
                     grid_size, 1)
    title(['part a, layer number ', num2str(layers2print(ilayer)),...
           ' (theta = ',num2str(theta(layers2print(ilayer))),...
           '^0), without spill outs']) 
    ifiga = ifiga + 1;
end

% close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% part b
layers2print = [1,8,16,32]; obs2print = 1:length(obs); grid_size = [32,32];
ifigb = ifiga; 
for ilayer = 1:length(layers2print)
    figure(ifigb)
    plot_room_and_CB(obs(obs2print), CB(layers2print(ilayer), obs2print),...
                     grid_size, 0)
    title(['part b, layer number ', num2str(layers2print(ilayer)),...
           ' (theta = ',num2str(theta(layers2print(ilayer))),...
           '^0), with spill outs']) 
    ifigb = ifigb + 1;

    figure(ifigb)
    plot_room_and_CB(obs(obs2print), CB(layers2print(ilayer), obs2print),...
                     grid_size, 1)
    title(['part b, layer number ', num2str(layers2print(ilayer)),...
           ' (theta = ',num2str(theta(layers2print(ilayer))),...
           '^0), without spill outs'])  
    ifigb = ifigb + 1;
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  part C
% close all
layers2print =[1,8,16,32];
for layer=1:32 %1:32
    PlotThis=any(layers2print==layer);
Cgrid{layer} =OcuppancyGrid(layer,PlotThis,CB,theta,obs);
end
toc
