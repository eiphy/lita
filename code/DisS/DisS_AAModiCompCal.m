function [d1,d2] = DisS_AAModiCompCal(comm,pre_cr,v1,v2)
comm(2) = v1;
[d, ~, ~, ~] = DisS_DistanceCal(comm, pre_cr);
d1 = d(8);
comm(2) = v2;
[d, ~, ~, ~] = DisS_DistanceCal(comm, pre_cr);
d2 = d(8);