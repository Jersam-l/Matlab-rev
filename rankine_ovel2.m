clc; clear; close all;

%% -------- SYMBOLIC PART (theory) --------
syms x y U m a

% Stream function: Uniform + Source at (-a,0) + Sink at (+a,0)
psi = U*y + (m/(2*pi))*atan( y/(x + a) ) - (m/(2*pi))*atan( y/(x - a) );

% Velocities from stream function
u_sym = diff(psi, y);      % u = dψ/dy
v_sym = -diff(psi, x);     % v = -dψ/dx

%% -------- CONVERT TO NUMERIC FUNCTIONS --------
u_fun  = matlabFunction(u_sym,  'Vars', [x y U m a]);
v_fun  = matlabFunction(v_sym,  'Vars', [x y U m a]);
psi_fun = matlabFunction(psi,   'Vars', [x y U m a]);

%% -------- PARAMETERS --------
Uval = 1;     % uniform flow velocity
mval = 5;     % source/sink strength
aval = 1;     % half distance between source and sink

%% -------- GRID --------
xv = linspace(-5,5,300);
yv = linspace(-5,5,300);
[X, Y] = meshgrid(xv, yv);

%% -------- EVALUATE FIELDS --------
Ufield = u_fun(X, Y, Uval, mval, aval);
Vfield = v_fun(X, Y, Uval, mval, aval);
PSI    = psi_fun(X, Y, Uval, mval, aval);

Vmag = sqrt(Ufield.^2 + Vfield.^2);

%% -------- GRAPH 1: FLOW OVER OBJECT (STREAMLINES) --------
figure;
contour(X, Y, PSI, 80);
axis equal;
xlabel('x'); ylabel('y');
title('Flow over Rankine Body (Streamlines)');
grid on;

%% -------- GRAPH 2: VELOCITY FIELD --------
figure;
contourf(X, Y, Vmag, 50);
colorbar;
hold on;
quiver(X, Y, Ufield, Vfield, 'k');
axis equal;
xlabel('x'); ylabel('y');
title('Velocity Field over Rankine Body');
grid on;
