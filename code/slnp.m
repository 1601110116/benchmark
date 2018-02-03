function slnp(f, fi)
% This function advances lnp, calculates p and applies their boundary conditions
global lnp lnp_aux p vi src_p curv_phi
persistent result

result = f*lnp_aux(2:end-1, 2:end-1, 2:end-1) + fi*lnp(2:end-1, 2:end-1, 2:end-1) ...
	- 5/3*(curv_phi+ddz(vi)) - vi(2:end-1, 2:end-1, 2:end-1).*ddz(lnp) ...
	- convect(lnp) + diffuse(lnp);
if f < 0.6
	lnp_aux = lnp;
end
lnp(2:end-1, 2:end-1, 2:end-1) = result;
p(2:end-1, 2:end-1, 2:end-1) = exp(lnp(2:end-1, 2:end-1, 2:end-1)) + src_p;
p = xbc_free(p);
p = ybc_periodic(p);
p = zbc_periodic_free(p);
lnp = log(p);
