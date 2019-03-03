function [d, v, a, t] = DisS_CAModiCal(d_cr,v_cr,t_cr,comm,pre_cr)
% This function is used to calculate the critical values for case 2.
%% Calculate the new critical value for v_cr(3)
dd = comm(1) - d_cr(8);
b = 2*comm(3)*t_cr(4);
c = comm(3)*dd - 2*comm(3)*v_cr(3)*t_cr(4)+v_cr(3)^2;
delta = b^2-4*c;
v_n(1) = 0.5 * (-b + sqrt(delta));
v_n(2) = 0.5 * (-b - sqrt(delta));

%% Determine the new critical value
dis = v_cr(3) - v_n;
if comm(1) >= 0
    if length(find(dis<0)) > 1
        V = max(v_n);
    else
        V = v_n(dis<0);
    end
else
    if length(find(dis>0)) > 1
        V = min(v_n);
    else
        V = v_n(dis>0);
    end
end

%% Postprocess
comm(2) = comm(2) - v_cr(2) + V;
[d,v,a,t] = DisS_DistanceCal(comm,pre_cr);

