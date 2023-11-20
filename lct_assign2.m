% PID Controlled Voltage Regulator with Custom Feedback Transfer Function

% Plant transfer function (representing the voltage regulator system)
numerator = 10;     % adjust coefficients based on your system
denominator = [0.04 0.54 1.5 1]; % adjust coefficients based on your system
plant = tf(numerator, denominator);

% Feedback transfer function
feedback_numerator = 1;     % adjust coefficients based on your feedback system
feedback_denominator = [0.05 1]; % adjust coefficients based on your feedback system
feedback_tf = tf(feedback_numerator, feedback_denominator);

% Desired voltage reference
V_ref = 1.0;

% Create a PID controller
Kp = 1;    % Proportional gain
Ki = 0.25;  % Integral gain
Kd = 0.20; % Derivative gain
pidController = pid(Kp, Ki, Kd);

% Connect the plant, PID controller, and feedback transfer function
openLoopSystem = series(pidController, plant);
openLoopSystemWithFeedback = series(openLoopSystem, feedback_tf);

% Create a closed-loop system
closedLoopSystem = feedback(openLoopSystemWithFeedback, 1);

% Time vector
t = 0:0.01:30;

% Input step signal
r = V_ref * ones(size(t));

% Simulate the closed-loop system
[y, t, x] = lsim(closedLoopSystem, r, t);

% Plot the results
figure;
subplot(2,1,1);
plot(t, r, 'r--', t, y, 'b-', 'LineWidth', 1.5);
title('Voltage Regulator with PID Control and Custom Feedback');
xlabel('Time (s)');
ylabel('Voltage');
legend('Reference', 'Output');

% Plot the controller output
subplot(2,1,2);
plot(t, y, 'm-', 'LineWidth', 1.5);
title('PID Controller Output');
xlabel('Time (s)');
ylabel('Controller Output');
