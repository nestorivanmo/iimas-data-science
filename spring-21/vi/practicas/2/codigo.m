%%
%
%   Ejercicio 1: Funciones
%
a = 5;
b = 2;
c = 4;
x = (0:0.1:10);
y1 = exp(x);
y2 = sin(x);
y3 = a.*(x.*x) + b.*x + c;
y4 = sqrt(x);

t = tiledlayout(2,2);
t.TileSpacing = 'normal';

title_lab = title(t, 'Funciones');
set(title_lab, 'Interpreter', 'latex');
xlab = xlabel(t, '$x$');
set(xlab, 'Interpreter', 'latex');
set(xlab, 'FontSize', 14);
ylab = ylabel(t, '$y$');
set(ylab, 'Interpreter', 'latex');
set(ylab, 'FontSize', 14);

nexttile;
plot(x,y1, 'linewidth', 1.7);%, 'MarkerIndices',1:10:length(y));
title('$e^x$', 'Interpreter', 'latex', 'FontSize', 14);
axis([-0.3,10.3,-1000,23000]);

nexttile
plot(x,y2, 'linewidth', 1.7);
title('$\sin(x)$', 'Interpreter', 'latex', 'FontSize', 14);
axis([-0.2,10.3,-1.2,1.2]);

nexttile;
plot(x,y3, 'linewidth', 1.7);
title('$5x^2 + 2x + 4$', 'Interpreter', 'latex', 'FontSize', 14);
axis([-0.5,10.5,-30,550]);

nexttile;
plot(x,y4,'linewidth',1.7);
title('$\sqrt{x}$', 'Interpreter', 'latex', 'FontSize', 14);
axis([-1,11,-0.3,3.4]);
%% 

%
%   Ejercicio 2: Funciones senoidales
%

x = linspace(-pi, pi);
y1 = sin(x);
y2 = sin(2.*x);
y3 = sin(3.*x);

figure
plot(x,y1,x,y2,'--',x,y3,':', 'linewidth', 1.7);
title_lab = title('Funciones senoidales para $x\in[-\pi, \pi]$', 'Interpreter', 'latex');
set(title_lab, 'FontSize', 14);
xlab = xlabel('x$\in [-\pi, \pi]$', 'Interpreter', 'latex');
set(xlab, 'FontSize', 14);
ylab = ylabel('y$\in [-1,1]$', 'Interpreter', 'latex');
set(ylab, 'FontSize', 13);
leg = legend('$\sin(x)$', '$\sin(2x)$', '$\sin(3x)$');
set(leg, 'Interpreter', 'latex');
set(leg, 'FontSize', 12);
axis([-pi,pi,-1.2,1.7]);
%% 

%
%   Ejercicio 3: Proyectil
%

% Inciso a)

v0 = 100; % velocidad inicial
theta = 60; % ángulo de lanzamiento
time = linspace(0,20);
h0 = 0;
h = h0 + (v0*cos(theta*pi/180)).*time;
y0 = 0;
g = 9.78;
y = y0 + (v0*sin(theta*pi/180)).*time -(0.5*g).*(time.^2);

syms t;
solt = solve(-0.5*g*t^2 + v0*sin(theta*pi/180)*t +y0 == 0, t);
time_zero = double(vpa(solt(2)));

figure;
p(1) = plot(time, h, '-o', 'linewidth', 1.7);
p(1).MarkerIndices = 1:10:length(time);
p(1).MarkerEdgeColor = 'red';
p(1).MarkerFaceColor = [1 .6 .6];
p(1).MarkerSize = 6;
p(2) = xline(time_zero);
p(2).Color = 'r';
title('Distancia horizontal vs. tiempo', 'Interpreter', 'latex', 'FontSize', 14);
xlabel('Tiempo $t [s]$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('Distancia horizontal $h [m]$', 'Interpreter', 'latex', 'FontSize', 14);
l = legend(p(2), '$t=17.701$', 'Location', 'northwest');
set(l, 'Interpreter', 'latex');
set(l, 'FontSize', 12);

figure;
p = plot(time, y, '-o', 'linewidth', 1.7);
p.MarkerIndices = 1:10:length(time);
p.MarkerEdgeColor = 'red';
p.MarkerFaceColor = [1 .6 .6];
p.MarkerSize = 6;
title('Distancia vertical vs. tiempo', 'Interpreter', 'latex', 'FontSize', 14);
xlabel('Tiempo $t [s]$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('Distancia vertical $y [m]$', 'Interpreter', 'latex', 'FontSize', 14);
vline = xline(time_zero);
vline.Color = 'r';
hline = refline(0);
l = legend(vline, '$t=17.701$', 'Location', 'northwest');
set(l, 'Interpreter', 'latex');
set(l, 'FontSize', 12);
axis([0,20,-300,450]);


% Inciso b)

figure;
yyaxis left;
plot(time, y);
yyaxis right;
plot(time, h)
%% 

% Inciso c)

v0 = 100;
h0 = 0;
y0 = 0;
g = 9.78;
time = linspace(0,20);
theta = [80*pi/180, 45*pi/180, 30*pi/180];
h1 = h0 + (v0*cos(theta(1))).*time;
h2 = h0 + (v0*cos(theta(2))).*time;
h3 = h0 + (v0*cos(theta(3))).*time;
y1 = y0 + (v0*sin(theta(1))).*time -(0.5*g).*(time.^2);
y2 = y0 + (v0*sin(theta(2))).*time -(0.5*g).*(time.^2);
y3 = y0 + (v0*sin(theta(3))).*time -(0.5*g).*(time.^2);


% 1)
figure
plot(time, h1, time, h2, time, h3, 'linewidth', 1.7);
title('Distancia horizontal vs. tiempo para diferentes valores de $\theta$', 'Interpreter', 'latex', 'FontSize', 14);
xlabel('Tiempo $t [s]$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('Distancia horizontal $h [m]$', 'Interpreter', 'latex', 'FontSize', 14);
%l = legend('$\theta = 30^\circ$', '$\theta = 45^\circ$', '$\theta = 80^\circ$', 'Location', 'northwest');
%set(l, 'Interpreter', 'latex');
%set(l, 'FontSize', 12);

figure
plot(time, y1, time, y2, time, y3, 'linewidth', 1.7);
title('Distancia vertical vs. tiempo para diferentes valores de $\theta$', 'Interpreter', 'latex', 'FontSize', 14);
xlabel('Tiempo $t [s]$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('Distancia vertical $y [m]$', 'Interpreter', 'latex', 'FontSize', 14);
axis([0,20,-1000,800]);
hline = refline(0);
hline.Color = [.7 .7 .7];
%l = legend('$\theta = 30^\circ$', '$\theta = 45^\circ$', '$\theta = 80^\circ$', 'Location', 'northwest');
%set(l, 'Interpreter', 'latex');
%set(l, 'FontSize', 12);

% 2)
figure
plot(time, h1, time, h2, '--', time, h3,':', 'linewidth', 1.7);
title('Distancia horizontal vs. tiempo para diferentes valores de $\theta$', 'Interpreter', 'latex', 'FontSize', 14);
xlabel('Tiempo $t [s]$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('Distancia horizontal $h [m]$', 'Interpreter', 'latex', 'FontSize', 14);
l = legend('$\theta = 30^\circ$', '$\theta = 45^\circ$', '$\theta = 80^\circ$', 'Location', 'northwest');
set(l, 'Interpreter', 'latex');
set(l, 'FontSize', 12);

figure
plot(time, y1, time, y2, '--', time, y3, ':', 'linewidth', 1.7);
title('Distancia vertical vs. tiempo para diferentes valores de $\theta$', 'Interpreter', 'latex', 'FontSize', 14);
xlabel('Tiempo $t [s]$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('Distancia vertical $y [m]$', 'Interpreter', 'latex', 'FontSize', 14);
axis([0,20,-1000,800]);
hline = refline(0);
hline.Color = [.7 .7 .7];
l = legend('$\theta = 30^\circ$', '$\theta = 45^\circ$', '$\theta = 80^\circ$', 'Location', 'northwest');
set(l, 'Interpreter', 'latex');
set(l, 'FontSize', 12);

























