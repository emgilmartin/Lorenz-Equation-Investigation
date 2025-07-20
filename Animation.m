%%
clf; clc; clear; % Clear current figure
% divergence of trajectory depending on p
sig = 10;
b = 8/3;
count = 1;
T = [ "p = 0.1";  "p = 1"; "p = 10"; "p = 99.96"];
for i = 1:4
    p = [0.1 1 10 99.96];
% First trajectory setup
p = p(i);
f = @(t, c) [sig * (c(2) - c(1)); c(1) * (p - c(3)) - c(2); c(1) * c(2) - b * c(3)];
y0_1 = [1; 1; 1];  % Initial conditions for the first trajectory
[tvals1, yvals1] = rk4(f, y0_1, 0, 100, 0.01);  % Run the RK4 method
x1 = yvals1(1, :); 
y1 = yvals1(2, :); 
z1 = yvals1(3, :); 

% Second trajectory setup
y0_2 = [0; 1; 0];  % Initial conditions for the second trajectory
[tvals2, yvals2] = rk4(f, y0_2, 0, 100, 0.01);  % Run the RK4 method
x2 = yvals2(1, :); 
y2 = yvals2(2, :); 
z2 = yvals2(3, :);

d = sqrt(x1.^2+y1.^2+z1.^2)-sqrt(x2.^2+y2.^2+z2.^2);
figure(1)
subplot(2,2,count)
plot(tvals1,d,'k')
title(T(count))
xlabel('t')
ylabel('distance')
hold on
sgtitle('Effects of p on trajectories')
count = count+1;
end

%dependence on initial condition
p = 10;

% First trajectory setup
f = @(t, c) [sig * (c(2) - c(1)); c(1) * (p - c(3)) - c(2); c(1) * c(2) - b * c(3)];
y0_1 = [1; 1; 1];  % Initial conditions for the first trajectory
[tvals1, yvals1] = rk4(f, y0_1, 0, 100, 0.01);  % Run the RK4 method
x1 = yvals1(1, :); 
y1 = yvals1(2, :); 
z1 = yvals1(3, :); 

% Second trajectory setup
y0_2 = [0; 1; 0];  % Initial conditions for the second trajectory
[tvals2, yvals2] = rk4(f, y0_2, 0, 100, 0.01);  % Run the RK4 method
x2 = yvals2(1, :); 
y2 = yvals2(2, :); 
z2 = yvals2(3, :);

y0_3 = [10; 1; 28];  % Initial conditions for the first trajectory
[tvals3, yvals3] = rk4(f, y0_3, 0, 100, 0.01);  % Run the RK4 method
x3 = yvals3(1, :); 
y3 = yvals3(2, :); 
z3 = yvals3(3, :); 

d1 = sqrt(x1.^2+y1.^2+z1.^2)-sqrt(x2.^2+y2.^2+z2.^2);
d2 = sqrt(x1.^2+y1.^2+z1.^2)-sqrt(x3.^2+y3.^2+z2.^3);
figure(2)
subplot(1,2,1)
plot(tvals1,d1)
xlim([0 30])
subplot(1,2,2)
plot(tvals1,d2)
xlim([0 30])


%% animation
% First trajectory setup
p = 28;
sig = 10;
b = 8/3;
f = @(t, c) [sig * (c(2) - c(1)); c(1) * (p - c(3)) - c(2); c(1) * c(2) - b * c(3)];
y0_1 = [1; 1; 1];  % Initial conditions for the first trajectory
[tvals1, yvals1] = rk4(f, y0_1, 0, 100, 0.01);  % Run the RK4 method
x1 = yvals1(1, :); 
y1 = yvals1(2, :); 
z1 = yvals1(3, :); 

% Second trajectory setup
y0_2 = [13; 25; 2];  % Initial conditions for the second trajectory
[tvals2, yvals2] = rk4(f, y0_2, 0, 100, 0.01);  % Run the RK4 method
x2 = yvals2(1, :); 
y2 = yvals2(2, :); 
z2 = yvals2(3, :);


% Create a figure and hold the plot for multiple lines
if 1==1
grid on;
xlabel('x(t)');
ylabel('y(t)');
zlabel('z(t)');
title('3D Animation - Lorenz Attractor');
hold on;

% Set axis limits after computing both trajectories
axis([min([x1, x2]) max([x1, x2]) min([y1, y2]) max([y1, y2]) min([z1, z2]) max([z1, z2])]);

% Initialize the animated lines
animatedLine1 = animatedline('Color', 'r', 'LineWidth', 0.5);
animatedLine2 = animatedline('Color', 'b', 'LineWidth', 0.5);

% Set up 3D view angle
view(3);

% Animation loop
time1 = tic;  % Start the timer
for i = 1:length(tvals1)
    time2 = toc(time1);  % Calculate elapsed time
    if time2 > 30  % Stop after 30 seconds
        break;
    end
    
    % Add new points to the animated lines for both trajectories
    addpoints(animatedLine1, x1(i), y1(i), z1(i));  % Add point to the red line
    addpoints(animatedLine2, x2(i), y2(i), z2(i));  % Add point to the blue line
    
    % Refresh the plot to update the animation
    drawnow;
end
end