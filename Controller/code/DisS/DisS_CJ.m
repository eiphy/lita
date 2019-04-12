function [In,d,v,a,t] = DisS_CJ(d_cr,comm,pre_cr)
% This function is used to determine whitch case the current DS belongs to.
%% Calculate the minimum displacement that can be achieved.
comm_min = comm;
comm_min(2) = 0;
[d,v,a,t] = DisS_DistanceCal(comm_min,pre_cr);

%% Determine which case.
if (comm(1)>=0&&d(1)>=comm(1)) || (comm(1)<0&&d(1)<=comm(1))
    In = 1;         % Case 1: The DS can't be made up.
else
    d_CA = min(d_cr(3)-d_cr(2),d_cr(7)-d_cr(6));
    d_temp = d_cr(8) - 2*d_CA;
    if (comm(1)>=0&&d_temp<=comm(1)) || (comm(1)<0&&d_temp>comm(1))
        In = 2;     % Case 2: The DS can be made up by modifying the CA steps.
    else
        In = 3;     % Case 3: The DS can be made up by modifying the AA & DA steps.
    end
end