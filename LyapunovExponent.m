%https://mds.marshall.edu/cgi/viewcontent.cgi?referer=&httpsredir=1&article=1105&context=etd
clear all; clc;  % Clear workspace
format long;  % Display decimals with default precision

% Parameters
sigma = 10;
beta = 8/3;
rho = 28;
t0 = 0;
dt = 0.001;
tEnd = 1000;
t1 = 30;  % Time after which to start computing Lyapunov exponent so we can exclude points that don't provide the best data
T = t0:dt:tEnd;
num_It = 10;  % Number of iterations for averaging Lyapunov exponent
LLE_vector = zeros(1, num_It);  % Initialize vector for storing Lyapunov exponents

% Run the simulation for num_It iterations
for col = 1:num_It
    % Random initial conditions
    x0 = rand;
    y0 = rand;
    z0 = rand;
    d0 = 10^(-8);  % Initial perturbation size
    v = zeros(3, length(T));  % Orbit 1 (main)
    w = zeros(3, length(T));  % Orbit 2 (perturbed)
    v(:, 1) = [x0; y0; z0];
    w(:, 1) = [x0; y0; z0];
    w(1, 1) = w(1, 1) + d0;  % Perturb the initial condition of the second orbit
    k = 1;
    n = 0;  % Counter for number of valid L1 values
    L2 = 0;  % Cumulative sum for L2

    t = t0;
    while t < tEnd
        % Define the Lorenz system as a function handle
        f = @(x,t) [sigma*(x(2) - x(1));
                  x(1)*(rho - x(3)) - x(2);
                  x(1)*x(2) - beta*x(3)];

        % Use Runge-Kutta integration to update orbits
        v(:, k+1) = rk(v(:, k), t, dt, f);
        w(:, k+1) = rk(w(:, k), t, dt, f);

        % Calculate the distance between the two orbits
        d1 = norm(v(:, k+1) - w(:, k+1)); 

        % start calculating Lyapunov exponent after period
        if t > t1
            L1 = log(abs(d1 / d0));  % Natural logarithm of the relative separation
            L2 = L2 + L1;  % Accumulate the logarithms
            n = n + 1;  % Increment the count
        end

        % Re-adjust the second orbit to maintain the perturbation size
        diff = w(:, k+1) - v(:, k+1);
        if d1 > 0  % Avoid division by zero
            w(:, k+1) = v(:, k+1) + (d0 / d1) * diff;  % Normalize the perturbation
        end

        % Increment time and step index
        t = t + dt;
        k = k + 1;
    end

    % Calculate the Lyapunov exponent for this iteration
    L3 = (L2 / n) / dt;  % Average value of the logarithm sum
    LLE_vector(col) = L3;  % Store the Lyapunov exponent for this iteration
plot(n,L3,'k-')
hold on
end

% Average Lyapunov exponent over all iterations
L4 = mean(LLE_vector);  % Average LLE value across all iterations
disp('Average Lyapunov Exponent:');
disp(L4);
