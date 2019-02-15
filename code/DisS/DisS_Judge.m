function DS_flag = DisS_Judge(d_cr,comm)
%This function is used to judge if the displacement shortage happened.
DS_flag = 0;
if comm(1) > 0
    if d_cr(5) < d_cr(4)
        DS_flag = 1;
    end
else
    if d_cr(5) > d_cr(4)
        DS_flag = 1;
    end
end
    