clc; clear; close all;

%% -------- PARAMETERS --------
U = 1;      % free stream velocity
R = 1;      % cylinder radius

%% -------- GRID --------
xv = linspace(-4,4,400);
yv = linspace(-4,4,400);
[X,Y] = meshgrid(xv,yv);

R2 = X.^2 + Y.^2;
R2(R2==0) = 1e-6;

%% -------- STREAM FUNCTION (UNIFORM + DOUBLET COMBINED) --------
psi = U*Y .* (1 - (R^2 ./ R2));

%% -------- VELOCITY FROM STREAM FUNCTION --------
% u = dψ/dy , v = -dψ/dx

dx = xv(2)-xv(1);
dy = yv(2)-yv(1);

[psi_y, psi_x] = gradient(psi, dy, dx);

u = psi_y;
v = -psi_x;

Vmag = sqrt(u.^2 + v.^2);

%% -------- FIGURE 1: FLOW OVER CYLINDER --------
figure;
contour(X,Y,psi,8400); hold on;

% cylinder surface = psi = 0
contour(X,Y,psi,[0 0],'k','LineWidth',3);

axis equal;
xlabel('x'); ylabel('y');
title('Potential Flow over Circular Cylinder');
grid on;

%% -------- FIGURE 2: VELOCITY FIELD --------
figure;
contourf(X,Y,Vmag,60); colorbar; hold on;

% cylinder again
contour(X,Y,psi,[0 0],'k','LineWidth',3);

quiver(X(1:12:end,1:12:end),Y(1:12:end,1:12:end), ...
       u(1:12:end,1:12:end),v(1:12:end,1:12:end),'k');

axis equal;
xlabel('x'); ylabel('y');
title('Velocity Field over Cylinder');
grid on;
