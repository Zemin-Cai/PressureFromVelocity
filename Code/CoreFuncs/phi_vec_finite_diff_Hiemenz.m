function [phi_x,phi_y]=phi_vec_finite_diff_Hiemenz(ux,uy,a,C_rot,factor_x,factor_y)


% [omega]=vorticity(ux, uy);
% % [ux_x,ux_y]=gradient(ux);
% % omega=ux_y;
% omega=omega*factor_x;

% factor_x=1000/1; %% pixels/unit-length
% factor_y=1000/1; %% pixels/unit-length


[ux_x,ux_y]=gradient(ux);
[uy_x,uy_y]=gradient(uy);

mask_size=20;
std=mask_size*0.62;
H1=fspecial('gaussian',mask_size,std);
ux_x=imfilter(ux_x,H1);
ux_y=imfilter(ux_y,H1);
uy_x=imfilter(uy_x,H1);
uy_y=imfilter(uy_y,H1);

[ux_xx,ux_xy]=gradient(ux_x);
[ux_yx,ux_yy]=gradient(ux_y);

[uy_xx,uy_xy]=gradient(uy_x);
[uy_yx,uy_yy]=gradient(uy_y);

del2_ux=ux_xx+ux_yy;
del2_uy=uy_xx+uy_yy;

% del2_ux=del2_ux*factor_x^2;
% del2_uy=del2_uy*factor_y^2;

del2_ux=del2(ux)*factor_x^2;
del2_uy=del2(uy)*factor_y^2;


omega=uy_x*factor_x-ux_y*factor_y;


phi_x=del2_ux+a^(-2)*omega.*uy*C_rot;
phi_y=del2_uy-a^(-2)*omega.*ux*C_rot;
























