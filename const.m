%% skrypt inicjalizujące stałe

a = 1;
b = -1.5;
X_start = [3 -0.5;
    2 -2.5;
    0 -2.5;
    0 -0.5];

if ~exist('data', 'dir')
    mkdir data;
end

x_best(1, 1) = a + 1;
x_best(1, 2) = (x_best(1, 1) - a)^2 + b;

f_holder = @(x, y) ((x - 1 - a) ^ 2 + 100 * ((x - a) ^ 2 - y + b)^2);
fun_celu_holder = @(x) fun_celu(x, a, b);
error_holder = @(x, x0) (power(x(1) - x0(1), 2) + power(x(2) - x0(2), 2));

x_min = min(X_start(:, 1)) - 0.5;
x_max = max(X_start(:, 1)) + 0.5;

y_min = min(X_start(:, 2)) - 0.5;
y_max = max(X_start(:, 2)) + 0.5;

X = x_min : 0.01: x_max;
Y = y_min : 0.01: y_max;

Z = zeros(length(Y), length(X));

for i = 1 : length(X)
    for j = 1 : length(Y)
        Z(j, i) = fun_celu_holder([Y(j), X(i)]);
    end
end

dotSize = 40;
density = 800;