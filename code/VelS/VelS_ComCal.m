function comm_velmod = VelS_ComCal(f_cr,comm,jerk_AC,jerk_CD)
%% Shortage flag
flag = 0;
%% The acceleration phase
if abs(comm(1)) < abs(f_cr(1))
    flag = 1;
    a_posm = (2*jerk_AC(1)*jerk_CD(1)*(comm(2) - v) + jerk_CD(1)*a^2) / (jerk_CD(1) - jerk_AC(1));
    a_posm = sqrt(a_posm);
    if comm(3) < 0
        a_posm = -a_posm;
    end
end

%% The deceleration phase
if abs(comm(1)) < abs(f_cr(2))
    flag = 1;
    a_negm = (2*jerk_AC(2)*jerk_CD(2)*comm(2)) / (jerk_AC(2) - jerk_CD(2));
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