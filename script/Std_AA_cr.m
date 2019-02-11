function [pAA, vAA, t_AA] = Std_AA_cr(p0_AA, v0_AA, a0_AA, a_max_AA, j_max_AA)
% This function is used to calculate the critical values of the standard
% AA(Accelerated Accelerate) process.
vAA = (a_max_AA^2 - a0_AA^2) / (2*j_max_AA) + v0_AA;
t_AA = (a_max_AA - a0_AA) / j_max_AA;
pAA = 1/6*j_max_AA*t_AA^3 + 1/2*a0_AA*t_AA^2 + v0_AA*t_AA + p0_AA;
end