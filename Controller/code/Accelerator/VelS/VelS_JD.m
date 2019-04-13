function [jAC,jDC] = VelS_JD(comm,a0)
% This function is used to determine the jerk in velocity shortage
% determination. Not currently used.
jAC = zeros(2,1);
jDC = zeros(2,1);

if comm(3) < a0
    jAC(1) = -comm(4);
else
    jAC(1) = comm(4);
end

if comm(3) < 0
    jDC(1) = comm(4);
else
    jDC(1) = -comm(4);
end

jAC(2) = jDC(1);
jDC(2) = -jAC(2);