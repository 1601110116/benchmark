function sw(f, fi)
% This function advances w and applies its boundary conditions
global w w_aux p pe jz
persistent result

% true
%result = f*w_aux(2:end-1, 2:end-1,2:end-1) + fi*w(2:end-1, 2:end-1, 2:end-1) ...
%	+ curv(p+pe) + ddz(jz) - convect(w) + diffuse(w);

% fault
result = f*w_aux(2:end-1, 2:end-1, 2:end-1) + fi*w(2:end-1, 2:end-1, 2:end-1) ...
	+ curv(get_pert(pe)) + ddz(jz) - convect(w) + diffuse(w);
%

if f < 0.6
	w_aux = w;
end
w(2:end-1, 2:end-1, 2:end-1) = result;
% true
%w = xbc_free(w);
%
w = ybc_periodic(w);
w = zbc_periodic_free(w);
