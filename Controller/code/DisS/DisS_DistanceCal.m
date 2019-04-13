function [d_cr, v_cr, a_cr, t_cr] = DisS_DistanceCal(comm, pre_cr)
% This function is used to calculate the distance for each group of
% parameters.
comm_vel = VelS_ComCal(comm,pre_cr);
[d_cr, v_cr, a_cr, t_cr] = Std_PRO_cr(comm_vel, pre_cr);
dir = abs(comm(1))/comm(1);
if dir*d_cr(5) < dir*d_cr(4)
    d_cr(5:8) = d_cr(5:8) - d_cr(5) + d_cr(4);
end