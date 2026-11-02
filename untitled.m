% Domain
x = linspace(0,10,200);
y = linspace(0,10,200);
[X,Y] = meshgrid(x,y);

% Velocity field
U = X.^2 .* Y;
V = -X .* Y.^2;

% Stream function
psi = 0.5 * X.^2 .* Y.^2;

% Plot stream function (streamlines)
figure;
contour(X,Y,psi,300);      % 30 contour levels
hold on;
quiver(X,Y,U,V,'k');      % velocity vectors
hold off;

xlabel('Horizontal distance');
ylabel('Vertical distance');
title('Stream Function and Velocity Field');
axis equal;
grid on;
