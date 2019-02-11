function [p_CA, v_CA, t_CA] = Std_CA_cr(p0_CA, v0_CA, vt_CA, a_max_CA)
% This funciton is used to calculate the critical values of standard CA (Constant Accelerate)
% process
v_CA = vt_CA;
t_CA = (vt_CA - v0_CA) / (a_max_CA);
p_CA = 1/2*a_max_CA*t_CA^2 + v0_CA*t_CA + p0_CA;
end