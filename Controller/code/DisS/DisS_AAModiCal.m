function [d,v,a,t] = DisS_AAModiCal(comm,pre_cr,t)
% This function use the golden radio method to get a desirable feedrate.
%% Initialize.
if comm(1) < 0              % Take care of the direction.
    comm = -comm;
    pre_cr = -pre_cr;
end
% Initialize data.
R = 0.618;
vl = 0;
vu = comm(2);
v1 = vl + R*(vu-vl);
v2 = vu - R*(vu-vl);
[d1,d2] = DisS_AAModiCompCal(comm,pre_cr,v1,v2);
%% Interation
while abs(v2-v1) > t
    if d1<comm(1) && d2<comm(1) || d1<comm(1) && d2>comm(2)
        vl = v2;
        v2 = v1;
        v1 = v2 + R*(vu-vl);
        [d1,d2] = DisS_AAModiCompCal(comm,pre_cr,v1,v2);
    elseif d1>comm(1) && d2>comm(1)
        vu = v1;
        v1 = v2;
        v2 = v1 - R*(vu-vl);
        [d1,d2] = DisS_AAModiCompCal(comm,pre_cr,v1,v2);
    elseif d1>comm(1) && d2<comm(2)
        vu = v1;
        vl = v2;
        v1 = vl + R*(vu-vl);
        v2 = vu - R*(vu-vl);
        [d1,d2] = DisS_AAModiCompCal(comm,pre_cr,v1,v2);
    elseif d1==comm(1)
        v2 = v1;
    elseif d2==comm(2)
        v1 = v2;
    end
end
comm(2) = (v1+v2)/2;
[d,v,a,t] = DisS_DistanceCal(comm,pre_cr);