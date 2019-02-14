function [p_CA, v_CA, t_CA, a_CA] = Std_CA_cr(p0_CA, f0, v0_CA, a_max_CA, j_max_DA)
% This funciton is used to calculate the critical values of standard CA (Constant Accelerate)
% process
v_CA = f0 + a_max_CA^2/(2*j_max_DA);
t_CA = (v_CA - v0_CA) / a_max_CA;
p_CA = 1/2*a_max_CA*t_CA^2 + v0_CA*t_CA + p0_CA;
a_CA = a_max_CA;
end