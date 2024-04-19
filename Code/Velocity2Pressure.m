%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pressure calculation from velocity fields
%  
% 02/12/2023
% by Zemin Cai
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clc;
clear all;
addpath(GetAbsolutePath('CoreFuncs'));
addpath(GetAbsolutePath('..\Data'));      
addpath(GetAbsolutePath('..\Results'));

%% Velocity data preparing
ux = load('MothBody_Velocity_700_701_u.mat');
uy = load('MothBody_Velocity_700_701_v.mat');
ux = ux.ux;
uy = uy.uy;

% downsmapling to accelarate the processing  
N = 0.2;              % means the downsamping rate is 20%. The downsampling rate
                      % depends on the original size of the velocity
                      % fields. The downsampled size must be smaller than
                      % 100*80
u_x_small = imresize(ux, N);
u_y_small = imresize(uy, N);

%% Pressure calculation
sprintf('\tCalculating pressure field...')
StandardAtmos_p = 1.01e5;
[height, width] = size(ux);
factor_x = width/6;
factor_y = height/6;
a = 1;
P = zeros(height, width);
P(:, 1) = StandardAtmos_p;
P(1, :) = StandardAtmos_p;
P(height, :) = StandardAtmos_p;
P(:, width) = StandardAtmos_p;

C_rot=1;
[height_small, width_small] = size(u_x_small);
factor_x_small = width_small/6;
factor_y_small = height_small/6;               % pixels/unit-length

mx_small = 0.25.*ones(height_small, width_small);
my_small = sqrt(15)/4.*ones(height_small, width_small);
alpha = 128;
A = mx_small.^2 + alpha;
B = mx_small.*my_small;
C = my_small.^2 + alpha;
h = 1;
[phi_x_small, phi_y_small] = phi_vec_finite_diff_Hiemenz(u_x_small,u_y_small,a,C_rot,factor_x_small,factor_y_small);
phi_m_small = mx_small.*phi_x_small + my_small.*phi_y_small;
degree = 90;
gamma=degree*pi/180;
theta=atan(0.5*tan(gamma));
a=(sin(theta))^(1/2);
P_D = zeros(height_small, width_small);
P_D(:, 1) = StandardAtmos_p;
P_D(1, :) = StandardAtmos_p;
P_D(height_small, :) = StandardAtmos_p;
P_D(:, width_small) = StandardAtmos_p;

disp(sprintf('Now, creating the coeffcient matrix'));
E = CoeffMatrix(height_small, width_small, A, B, C, h);
size(E)

disp(sprintf('Now, creating the right hand side vector'));
T = RHS_Vec(P_D, mx_small, my_small, alpha, phi_m_small, h);

disp(sprintf('Now, solving the linear equations system'));
tic
sol = linsolve(E, T);
toc

% merging
for j = 1:1:(height_small-2)
    for i = 1:1:(width_small-2)
        P_D(j+1, i+1)= sol((i-1)*(height_small-2)+j);
    end
end
p_D = P_D - a^(-2)*0.5.*(u_x_small.^2 + u_y_small.^2);
P_D_full = imresize(P_D, [height, width]);
p_D_full = imresize(p_D, [height, width]);

% save results
idx = 700;
filename = sprintf('MothBody_Velocity_Pressure_%d_%d.mat', idx, idx+1);
path = ['../Results/' filename];
save(path, 'p_D_full', 'ux', 'uy');
