function [d,v,a,j,i,instr] = instrGen(step,dir,i0,instr0,cri_val,comm,commabs,temp1,temp2)
%% Reset the motion value to ideal ones
i = i0;
instr = instr0;

d = cri_val(i+1,1);
v = cri_val(i+1,2);
a = cri_val(i+1,3);


%% Ready to check next step.
i = i + 1;

%% Iteratively check if proper step should be excuted
while 1
    switch i
        case 1
            if temp1>a || a>temp2  %If should go to step 1
                instr = 2;
                if a > cri_val(2,3)
                    j = -commabs(4);
                else
                    j = commabs(4);
                end
                break
            else
                i = i + 1;
            end
        case 2
            temp = v + 0.5*comm(4)*step^2 + cri_val(3,3)*step;
            if dir * temp < dir * cri_val(3,2) %If should go to step 2
                j = 0;
                instr = 3;
                break
            else
                i = i + 1;
            end
        case 3
            temp = a - comm(4) * step;
            if dir * temp > 0              % If should go to step 3
                j = -comm(4);
                instr = 4;
                break
            else
                i = i + 1;
            end
        case 4
            temp = d + cri_val(5,2)*step;   % If should go to step 4
            if dir * temp < dir * cri_val(5,1)
                j = 0;
                instr = 1;
                break
            else
                i = i + 1;
            end
        case 5
            temp = a - comm(4) * step;
            if dir * temp > dir * cri_val(6,3)
                j = - comm(4);
                instr = 2;
                break
            else
                i = i + 1;
            end
        case 6
            temp = v - 0.5*comm(4)*step^2 + cri_val(7,3)*step;
            if dir * temp > cri_val(7,2)
                j = 0;
                instr = 3;
                break
            else
                i = i + 1;
            end
        case 7
            temp = a + comm(4) * step;
            if dir * temp < 0
                j = comm(4);
                instr = 4;
                break
            else
                i = i + 1;
            end
        otherwise
            i = 8;
            j = 0;
            instr = 1;
            break
    end
end