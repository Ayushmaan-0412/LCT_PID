% Voltage Regulator without PID Control

% Plant transfer function (representing the voltage regulator system)
numerator = 10;     % adjust coefficients based on your system
denominator = [0.04 0.54 1.5 1]; % adjust coefficients based on your system
plant = tf(numerator, denominator);

% Feedback transfer function
feedback_numerator = 1;     % adjust coefficients based on your feedback system
feedback_denominator = [0.05 1]; % adjust coefficients based on your feedback system
feedback_tf = tf(feedback_numerator, feedback_denominator);

% Connect the plant and feedback transfer function
openLoopSystem = series(plant, feedback_tf);

% Create a closed-loop system
closedLoopSystem = feedback(openLoopSystem, 1);

% Time vector
t = 0:0.01:30;

% Input step signal
V_ref = 1.0;
r = V_ref * ones(size(t));

% Simulate the closed-loop system
[y, t, x] = lsim(closedLoopSystem, r, t);

% Plot all state variables against time
figure;
subplot(2,1,1);
plot(t, r, 'r--', t, y, 'b-', 'LineWidth', 1.5);
title('Voltage Regulator without PID Control');
xlabel('Time (s)');
ylabel('Voltage');
legend('Reference', 'Output');

