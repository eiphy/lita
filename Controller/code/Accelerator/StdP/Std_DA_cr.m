function [p_DA, v_DA, t_DA, a_DA] = Std_DA_cr(p0_DA, f0, v0_DA, a_max_DA, j_max_DA)
v_DA = f0;
t_DA = (0 - a_max_DA) / (j_max_DA);
p_DA = 1/6*j_max_DA*t_DA^3 + 1/2*a_max_DA*t_DA^2 + v0_DA*t_DA + p0_DA;
a_DA = 0;
end
