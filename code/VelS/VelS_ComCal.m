function comm_velmod = VelS_ComCal(comm,pre_cr)
% This function is used to modify the motion command based on the judgement
% of velocity shortage.
%% Shortage flag & initialization
flag = 0;
j = comm(4);
%% Calculate the critical feedrate
f_cr = zeros(1,2);
f_cr(1) = pre_cr(2) + (comm(3)^2-pre_cr(3)^2)/(2*comm(4)) - (comm(3)^2)/(2*(-comm(4)));
f_cr(2) = (comm(3)^2)/(2*comm(4)) - (comm(3)^2)/(2*(-comm(4)));

%% The acceleration phase
if comm(1)*f_cr(1)>=0 && abs(comm(1))<abs(f_cr(1))
    flag = 1;
    a_posm = (-2*j*j*(comm(2)-pre_cr(2)) - j*pre_cr(3)^2) / (-j - j);
    a_posm = sqrt(a_posm);
    if comm(3) < 0
        a_posm = -a_posm;
    end
end

%% The deceleration phase
if comm(1)*f_cr(1)>=0 && abs(comm(1)) < abs(f_cr(2))
    flag = 1;
    a_negm = (-2*j*j*comm(2)) / (-j - j);
    a_negm = sqrt(a_negm);
    if comm(3) < 0
        a_negm = -a_negm;
    end
end

%% Command process
if ~flag
    comm_velmod = comm;
elseif a_posm == a_negm
    comm_velmod = comm;
    comm_velmod(3) = a_posm;
else
    comm_velmod = zeros(1,5);
    comm_velmod(1:2) = comm(1:2);
    comm_velmod(3:4) = [a_posm, a_negm];
    comm_velmod(5) = comm(4);
end