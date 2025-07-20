%% Numerical Project
clc; clear; clf;

%dx/dt = sig(y-x)
%dy/dt = x(p-z)-y
%dz/dt = xy-bz
sig = 10;
b = 8/3;
p = 28;
%let x = c(1);
%let y = c(2);
%let z = c(3);
f = @(t,c) [sig.*(c(2)-c(1)); c(1).*(p-c(3))-c(2); c(1).*c(2)-b.*c(3)];
y0 = [1; 1; 1]; %[y1(0) y2(0)]
[tvals,yvals] = rk4(f,y0,0,100,0.01);
x = yvals(1,:);
y = yvals(2,:);
z = yvals(3,:);

%plot results
figure(1);
subplot(2,2,1)
plot (tvals, x, 'b', 'LineWidth',0.1);
xlabel('t'); ylabel('x(t)');
title('x vs. t - Lorenz Eqation');
xlim([0 50])
subplot(2,2,2)
plot (tvals, y, 'b', 'LineWidth',0.1);
xlabel('t'); ylabel('y(t)');
xlim([0 50])
title('y vs. t - Lorenz Eqation');
subplot(2,2,3)
plot (tvals, z, 'b' , 'LineWidth',0.1);
xlim([0 50])
xlabel('t'); ylabel('z(t)');
title('z vs. t - Lorenz Eqation');
subplot(2,2,4)
grid on;
plot3(x, y, z, 'r-','LineWidth',0.1)
xlabel('x(t)');
ylabel('y(t)');
zlabel('z(t)');
title('Runge-Kutta Method');
sgtitle("Vizualization of Trajectory vs Time")

%investigate dependance on p
count = 1;
T = [ "p = 0.1"; "p = 0.8"; "p = 1"; "p = 14"; "p = 30"; "p = 99.96"];
for p = [0.1 0.8 1 14 30 99.96]
    f = @(t,c) [sig.*(c(2)-c(1)); c(1).*(p-c(3))-c(2); c(1).*c(2)-b.*c(3)];
    y0 = [1; 1; 1]; %[y1(0) y2(0)]
    [tvals,yvals] = rk4(f,y0,0,100,0.05);
    x = yvals(1,:);
    y = yvals(2,:);
    z = yvals(3,:);
    figure(2); %plots 3-d visual
    subplot(3,2,count)
    plot3(x, y, z)
    xlabel('x(t)')
    ylabel('y(t)')
    zlabel('z(t)')
    title(T(count))
    hold on
    sgtitle("Vizualization of Dependence on p (3-d)")
    figure(3); %plots x-y view
    subplot(3,2,count)
    plot(x,y)
    hold on
    xlabel('x')
    ylabel('y')
    title(T(count))
    sgtitle("Vizualization of Dependence on p (2-d)")
    count = count+1;
end




