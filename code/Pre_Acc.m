function pre_cr = Pre_Acc(comm, d0, v0, a0)
% This function is used to calculate the critical values for the
% pre-acceleration phase.
if a0*comm(3) < 0
    j = -comm(4);
    pre_cr(2) = -(a0^2)/(2*j) + v0;
    pre_cr(3) = 0;
    pre_cr(4) = (0-a0)/j;
    pre_cr(1) = 1/6*j*pre_cr(4)^3 + 2/1*a0*pre_cr(4)^2 + v0*pre_cr(4) + d0;
else
    pre_cr(1) = d0;
    pre_cr(2) = v0;
    pre_cr(3) = a0;
    pre_cr(4) = 0;
end
end
