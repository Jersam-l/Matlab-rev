clc; clear; close all;

% Domain
x = linspace(-5,5,300);
y = linspace(-5,5,300);
[X,Y] = meshgrid(x,y);

% Strength of source (L > 0 source, L < 0 sink)
L = 5;

% Stream function for source/sink
psi = (L/(2*pi)) * atan2(Y, X);

% Velocity from stream function
dx = x(2) - x(1);
dy = y(2) - y(1);
[psi_y, psi_x] = gradient(psi, dy, dx);

U = psi_y;        % u = dψ/dy
V = -psi_x;       % v = -dψ/dx

% Plot streamlines
figure;
contour(X, Y, psi, 50);
hold on;
quiver(X, Y, U, V, 'k');
hold off;

xlabel('x-position (m)');
ylabel('y-position (m)');
title('Source / Sink Flow: Stream Function and Velocity Field');
axis equal;
grid on;
