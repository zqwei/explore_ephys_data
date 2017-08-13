function [orth,along] = func_orthrog_vectors(v1,v2)
% fucntion to  make v2 orthogonal to v1 

        along = (v2'*v1)/(v1'*v1)*v1;
        orth  = v2-(v2'*v1)/(v1'*v1)*v1;


end

