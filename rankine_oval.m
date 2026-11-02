clc; clear; close all;

% -------- Parameters --------
U = 1;              % Uniform flow velocity
m = 5;              % Source strength

% -------- Grid --------
x = linspace(-5, 5, 300);
y = linspace(-5, 5, 300);
[X, Y] = meshgrid(x, y);

% -------- Avoid singularity at origin --------
R2 = X.^2 + Y.^2;
R2(R2 == 0) = 1e-6;

% -------- Velocity components --------
u = U + (m/(2*pi)) .* (X ./ R2);
v =      (m/(2*pi)) .* (Y ./ R2);

% -------- Stream function (for body shape) --------
psi = U.*Y + (m/(2*pi))*atan2(Y, X);

% -------- Plot streamlines --------
figure;
contour(X, Y, psi, 60);
hold on;
quiver(X, Y, u, v, 'k');
axis equal;
xlabel('x'); ylabel('y');
title('Half Rankine Body: Uniform Flow + Source');
grid on;
               
