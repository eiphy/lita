function [p_DA, v0_DA, v_DA, t_DA] = Std_DA_cr(p0_DA, f0_DA, a0_DA, a_max_DA, j_max_DA)
v_DA = f0_DA;
v0_DA = f0_DA + a_max_DA^2/(2*j_max_DA);
t_DA = (0 - a_max_DA) / (j_max_DA);
p_DA = 1/6*j_max_DA*t_DA^3 + 1/2*a0_DA*t_DA^2 + v0_DA*t_DA + p0_DA;
end
