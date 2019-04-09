function [pd,pv,pa,pj,dcom] = ProfileGeneratorT(pattern,d0,v0,a0,t)
% This function is used to generate profiles of d,v,a and j.
%%  Initialization
accum = zeros(1,3);
accum(1:3) = [d0, v0, a0];            %accum is the accumulation value used in the intermedia phase
qa = zeros(size(pattern,1),2);
qv = zeros(size(pattern,1),3);
qd = zeros(size(pattern,1),4);
tcc = 0;
tcc_temp = 0;
pd = d0;
pv = v0;
pa = a0;
pj = pattern(1,1);

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
    
    tcc = tcc + pattern(i,2);
    if t < tcc
        pd = polyval(qd(i,:), t-tcc_temp);
        pv = polyval(qv(i,:), t-tcc_temp);
        pa = polyval(qa(i,:), t-tcc_temp);
        pj = p;
        break
    else
        tcc_temp = tcc;
    end
end

