function cri_val = cri_cal(commi, step, d, v, a)
%% Preprocess
% Deal with the direction.
comm = commi;
if commi(1) < 0
    comm = -abs(comm);
end

%% Deal with the pre-acceleration process
% This pre phase should be dealed with at the first step, as it is fixed.
pre_cr = Pre_Acc(comm, d, v, a);

%% Velocity Shortage Determination
% The difference judgement is used, as the correction need the jerk.
% Compute the modified command.
comm_velmod = VelS_ComCal(comm,pre_cr);

%% 1st Standard Process Calculation
% This is to calculate the critical values for the standard
% process. Based on these values, further determination can be made.
[d_cr, v_cr, a_cr, t_cr] = Std_PRO_cr(comm_velmod, pre_cr);    
    
%% Displacement Shortage Determination
DS_flag = DisS_Judge(d_cr,comm);

if DS_flag
    d_cr(5:8) = d_cr(5:8) - d_cr(5) + d_cr(4);
    [Ind,ds_cr,vs_cr,as_cr,ts_cr] = DisS_CJ(d_cr,v_cr,t_cr,comm_velmod,pre_cr);
    switch Ind
        case 1          %The DS can't be made up
            d_cr = ds_cr;
            v_cr = vs_cr;
            a_cr = as_cr;
            t_cr = ts_cr;
        case 2          %The DS can be made up by modifing the CA step
            [d_cr, v_cr, a_cr, t_cr] = DisS_CAModiCal(d_cr,v_cr,t_cr,comm_velmod,pre_cr);
        case 3          %The DS can be made up by changing the acceleration
            dis_comm = comm_velmod;
            if length(comm_velmod) < 5          % If is not feedrate shortage, then modify it to feedrate shortage case.
                dis_comm(2) = dis_comm(2) - min(v_cr(3)-v_cr(2), v_cr(7)-v_cr(6));
            end
            [d_cr, v_cr, a_cr, t_cr] = DisS_AAModiCal(dis_comm, pre_cr, step);
    end
end

%% Postprocess
cri_val = [d_cr', v_cr', a_cr', t_cr'];
end

