clc; clear; close all;

%% -------- SYMBOLIC PART --------
syms x y U m a

% Stream function: uniform + source + sink
psi = U*y + (m/(2*pi))*atan( y/(x + a) ) - (m/(2*pi))*atan( y/(x - a) );

% Velocities from stream function
u_sym = diff(psi, y);       % u = dψ/dy
v_sym = -diff(psi, x);      % v = -dψ/dx

% Convert to numeric functions
u_fun   = matlabFunction(u_sym,  'Vars', [x y U m a]);
v_fun   = matlabFunction(v_sym,  'Vars', [x y U m a]);
psi_fun = matlabFunction(psi,    'Vars', [x y U m a]);

%% -------- PARAMETERS --------
Uval = 1;     % uniform flow velocity
mval = 5;     % source/sink strength
aval = 1;     % half distance between source and sink

%% -------- GRID --------
xv = linspace(-5,5,400);
yv = linspace(-5,5,400);
[X, Y] = meshgrid(xv, yv);

%% -------- FLOW FIELD --------
Ufield = u_fun(X, Y, Uval, mval, aval);
Vfield = v_fun(X, Y, Uval, mval, aval);
PSI    = psi_fun(X, Y, Uval, mval, aval);

Vmag = sqrt(Ufield.^2 + Vfield.^2);

%% -------- FIND STAGNATION POINT --------
xline = linspace(-3,3,4000);
y0 = 0;

u_axis = u_fun(xline, y0, Uval, mval, aval);
[~, idx] = min(abs(u_axis));
xstag = xline(idx);

psistag = psi_fun(xstag, 0, Uval, mval, aval);

fprintf('Stagnation point at x = %.4f , y = 0\n', xstag);

%% -------- FIGURE 1: FLOW + BODY --------
figure;
contour(X, Y, PSI, 80); hold on;

% body surface (stagnation streamline)
contour(X, Y, PSI, [psistag psistag], 'k', 'LineWidth', 3);

axis equal;
xlabel('x'); ylabel('y');
title('Rankine Body: Flow over Object (Black = Body Surface)');
grid on;

%% -------- FIGURE 2: VELOCITY FIELD --------
figure;
contourf(X, Y, Vmag, 60); colorbar; hold on;

% draw body again
contour(X, Y, PSI, [psistag psistag], 'k', 'LineWidth', 3);

quiver(X(1:10:end,1:10:end), Y(1:10:end,1:10:end), ...
       Ufield(1:10:end,1:10:end), Vfield(1:10:end,1:10:end), 'k');

axis equal;
xlabel('x'); ylabel('y');
title('Velocity Field over Rankine Body');
grid on;
