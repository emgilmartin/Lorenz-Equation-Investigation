function [tvals, yvals] = rk4(f,y0,a,b,h)
numsteps = (b-a)/h;
tvals = a:h:b;
yvals = zeros(length(y0), numsteps + 1);  % Preallocate yvals matrix
yvals(:, 1) = y0;         % Initial condition

for i = 1:numsteps
     t = tvals(i);
     y = yvals(:,i);
    S1 = f(t,y);
    S2 = f(t+h/2, y+(h.*S1./2));
    S3 = f(t+h/2, y+(h.*S2./2));
    S4 = f(t+h, y+h.*S3);
yvals(:, i+1) = y + (h/6)*(S1+2.*S2+2.*S3+S4);
end
end