% Define the parameters
p = [0 0.1 0.5 0.8 1 14 20 30 99.96];  % Example p values
n = length(p);
sig = 10;  

% Initialize arrays for stability and behavior (as string arrays)
stability = strings(1, n);  % Use string array to store stability labels
behavior = strings(1, n);   % Use string array to store behavior labels

% Loop over each value of p and analyze stability
for i = 1:n
    % Define the Jacobian matrix at equilibrium (simplified for example)
    fxx = -sig;
    fxy = sig;
    fyx = p(i);
    fyy = -1;
    Jacobi = [fxx, fxy; fyx, fyy];
    
    % Compute the eigenvalues of the Jacobian matrix
    [V, D] = eig(Jacobi);
    evals = [D(1,1), D(2,2)]';  % Eigenvalues
    revals = real(evals);  % Real parts of the eigenvalues
    
    % Check stability and behavior based on the eigenvalues
    if all(revals < 0)  % If all eigenvalues are negative
        stability(i) = "Stable";
        behavior(i) = "Damped Oscillator";
        disp('System is stable and behaves like a damped oscillator');
    elseif any(revals == 0)  % If any eigenvalue is zero
        stability(i) = "Undetermined";
        behavior(i) = "Undamped Oscillator";
        disp('System is undetermined and behaves like an undamped oscillator');
    else  % If eigenvalues are positive
        stability(i) = "Unstable";
        behavior(i) = "Unstable Oscillator";
        disp('System is unstable and behaves like an unstable oscillator');
    end
end

% Convert p to a column vector for the table
P = p';  % Convert to column for table formatting

% Create the table with stability and behavior as string arrays
T = table(P, stability', behavior', 'VariableNames', {'p', 'stability', 'behavior'});

% Display the table
disp(T);
