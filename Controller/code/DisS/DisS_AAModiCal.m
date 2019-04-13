function [d,v,a,t] = DisS_AAModiCal(comm,pre_cr,step)
% This function use semi-binary search method to get a desirable feedrate.
%% Initialize.
% Initialize data.
dir = comm(1)/abs(comm(1));
comm_temp = comm;
tolerance = abs(0.5 * comm(4) * step^2);
vu = comm(2);
vl = 0;
vn = comm(2);
e = 2*tolerance;
%% Iteration
while e > tolerance
    vn = (vu+vl)/2;
    comm_temp(2) = vn;
    [dis, ~, ~, ~] = DisS_DistanceCal(comm_temp, pre_cr);
    if dir*dis(5) >= dir*dis(4)
        vl = vn;
    else
        vu = vn;
    end
    e = abs(vu-vl)/2;
end
    
        
        
%     if d1<comm(1) && d2<comm(1) || d1<comm(1) && d2>comm(2)
%         vl = v2;
%         v2 = v1;
%         v1 = v2 + R*(vu-vl);
%         [d1,d2] = DisS_AAModiCompCal(comm,pre_cr,v1,v2);
%     elseif d1>comm(1) && d2>comm(1)
%         vu = v1;
%         v1 = v2;
%         v2 = v1 - R*(vu-vl);
%         [d1,d2] = DisS_AAModiCompCal(comm,pre_cr,v1,v2);
%     elseif d1>comm(1) && d2<comm(2)
%         vu = v1;
%         vl = v2;
%         v1 = vl + R*(vu-vl);
%         v2 = vu - R*(vu-vl);
%         [d1,d2] = DisS_AAModiCompCal(comm,pre_cr,v1,v2);
%     elseif d1==comm(1)
%         v2 = v1;
%     elseif d2==comm(2)
%         v1 = v2;
%     end
comm(2) = vn;
[d,v,a,t] = DisS_DistanceCal(comm,pre_cr);