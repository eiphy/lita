function dCA = Dis_CADis(d_cr,v_cr,t_cr)
%This function is used to get the displacement for CA step
%   the displacement includes the dispacement of CA step and the
%   displacement loss at AA or DA step.
if abs(v_cr(3)-v_cr(2)) > abs(v_cr(7)-v_cr(6))
    dCA = d_cr(7)-d_cr(6) + (v_cr(5)-v_cr(7)+v_cr(6))*t_cr(6);
else
    dCA = d_cr(3)-d_cr(2) + (v_cr(3)-v_cr(2))*t_cr(4);
end

