% Parameters
sigma = 10;
beta = 8 / 3;
rho_range = 0:0.1:100;  % Finer range of rho (bifurcation parameter)
x_eq = [];              % Array to store equilibria

% ODE solver options for accuracy
options = odeset('RelTol', 1e-8, 'AbsTol', 1e-8);

for rho = rho_range
    % Define the Lorenz system
    lorenz_eq = @(t, state) [
        sigma * (state(2) - state(1));
        state(1) * (rho - state(3)) - state(2);
        state(1) * state(2) - beta * state(3)
    ];
    
    % Initial conditions
    initial_conditions = [1, 1, 1];
    
    % Integrate the system
    [~, states] = ode45(lorenz_eq, [0 100], initial_conditions, options);
    
    % Remove transient data
    steady_state = states(ceil(end / 2):end, :); % Keep second half
    
    % Collect long-term x-values
    x_eq = [x_eq; rho * ones(size(steady_state, 1), 1), steady_state(:, 1)];
end

% Plot the bifurcation diagram
figure;
scatter(x_eq(:, 1), x_eq(:, 2), 1, 'k', 'filled'); % Small points for clarity
xlabel('\rho');
ylabel('x');
title('Bifurcation Diagram of the Lorenz System');
