function [d_cr, v_cr, a_cr, t_cr] = DisS_DistanceCal(comm, pre_cr)
comm_vel = VelS_ComCal(comm,pre_cr);
[d_cr, v_cr, a_cr, t_cr] = Std_PRO_cr(comm_vel, pre_cr);
end