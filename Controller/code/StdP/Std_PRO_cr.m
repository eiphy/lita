function [d_cr,v_cr,a_cr,t_cr] = Std_PRO_cr(comm, v0, a0)
%This function is used to calculate the critical value of standard
%acceleration process. The initial displacement is assumed to be zero.
%Instead of using the jerk value determined in the velocity shortage
%judement, the jerk is independently judged in this function to deal with
%general case and the later displacement determination.
%% Initialization
d_cr = zeors(1,8);
v_cr = zeros(1,8);
a_cr = zeros(1,8);
t_cr = zeros(1,8);
d_cr(1) = pre_cr(1);
v_cr(1) = pre_cr(2);
a_cr(1) = pre_cr(3);
t_cr(1) = pre_cr(4);

%% Acceleration phase
% AA step
[d_cr(2), v_cr(2), t_cr(2), a_cr(2)] = Std_AA_cr(d_cr(1), v_cr(1), a_cr(1), comm(3), comm(end));

% CA step
[d_cr(3), v_cr(3), t_cr(3), a_cr(3)] = Std_CA_cr(d_cr(2), comm(2), v_cr(2), comm(3), -comm(end));

% DA step
[d_cr(4), v_cr(4), t_cr(4), a_cr(4)] = Std_CA_cr(d_cr(3), comm(2), v_cr(3), comm(3), -comm(end));

%% Deceleration phase
% The decceleration phase is calculated to get the critical displacement
% value that can be used to do the calculation for Constant Navigation
% Phase(CC).
% AA step
[d_cr(6), v_cr(6), t_cr(6), a_cr(6)] = Std_AA_cr(0, comm(2), 0, -comm(end-1), -comm(end));

% CA step
[d_cr(7), v_cr(7), t_cr(7), a_cr(7)] = Std_CA_cr(d_cr(6), 0, v_cr(6), -comm(end-1), comm(end));

% DA step
[d_cr(8), v_cr(8), t_cr(8), a_cr(8)] = Std_CA_cr(d_cr(7), 0, v_cr(7), -comm(end-1), comm(end));

%% CC phase and modify the deceleration phase
t_cr(5) = Std_CC_cr(d_cr(4), comm(1)-d_cr(8), comm(2));
d_cr(5) = comm(1) - dcr(8);
v_cr(5) = comm(2);
a_cr(5) = 0;

% Process d_cr for decceleration phase
d_cr(6:8) = d_cr(6:8) + d_cr(5);
end