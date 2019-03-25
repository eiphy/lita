function [plotData, plotTime] = ProfileGenerator(pattern,d0,v0,a0,step)
% This function is used to generate profiles of d,v,a and j.
%%  Initialization
accum = zeros(1,3);
accum(1:3) = [d0, v0, a0];            %accum is the accumulation value used in the intermedia phase
qa = zeros(size(pattern,1),2);
qv = zeros(size(pattern,1),3);
qd = zeros(size(pattern,1),4);
plotData = cell(4,1);
plotTime = [];
t = 0;

%% Integrate the profile w.r.t each section
for i = 1:size(pattern,1)
    p = pattern(i,1);
    
    % get the equations for current section
    qa(i,:) = polyint(p);
    qa(i,end) = accum(3);
    qv(i,:) = polyint(qa(i,:));
    qv(i,end) = accum(2);
    qd(i,:) = polyint(qv(i,:));
    qd(i,end) = accum(1);
    
    % update the acumulated value
    accum(3) = polyval(qa(i,:), pattern(i,2));
    accum(2) = polyval(qv(i,:), pattern(i,2));
    accum(1) = polyval(qd(i,:), pattern(i,2));
    
    % generate the plot data
    tplot = 0:step:(pattern(i,2));
    plotData{1} = [plotData{1}, polyval(qd(i,:), tplot)];
    plotData{2} = [plotData{2}, polyval(qv(i,:), tplot)];
    plotData{3} = [plotData{3}, polyval(qa(i,:), tplot)];
    plotData{4} = [plotData{4}, ones(1,length(tplot)) * pattern(i,1)];
    
    plotTime = [plotTime, t + tplot];
    t = plotTime(end);
end
