% Declare a random variable with values from -10 to 10 to graph g1 and g2
v = -10:0.1:10;     % increment of 0.1 for graphing smoothness
plot(v, g1_fun(v), 'b');
hold on
plot(v, g2_fun(v), 'r');
% From the graphs, we know the minimum of the g1 is around -2, and
    % g2 is 0, and we can make our first guess around those values to 
    % ensure convergence
    
% figure(#)
x1 = -6;
x2 = 1;
maxiter = 50;
step_size = 0.1;

[g1, u1] = graddect(x1, step_size, maxiter);
[g2, u2] = graddect2(x2, step_size, maxiter);

plot(u1,g1,'g-o');
plot(u2,g2,'m-*');
legend({'g_{1}','g_{2}', 'gd_{1}', 'gd_{2}'}, 'FontSize',12)
hold off

figure(2)
inc1 = 0:49;
plot(inc1, u1, 'b', inc1, u2, 'r')
hold on
yline(0,'--', 'x = 0')
yline(-2, '--', 'x = -2')
legend({'conv_{1}','conv_{2}'}, 'FontSize',12, 'Location', 'south')

T = table(g1, u1, g2, u2);
writetable(T, 'convergance.xlsx')
T


function g1 = g1_fun(u)
    g1 = 1/2 * (u+3).^2 + abs(u);
end

function g2 = g2_fun(u)
    g2 = 1/2 * (u.^2) + abs(u);
end

function [g, u] = graddect(u0, t, maxiter)
    u=zeros(maxiter, 1);        % storing u values after each step
    g=zeros(maxiter, 1);        % storing g values after each step from g(x)
    u(1)=u0;                    % first element of u is the assumed u0
    g(1)=gradient1(u0);         % first element of orig func
    for i=2:maxiter
       % i = 1 is already declared in line 4 and 5
       u(i) = u(i-1) - (t * gradient1(u(i-1)));
       g(i) = g1_fun(u(i));
    end
end

function [g, u] = graddect2(u0, t, maxiter)
    u=zeros(maxiter, 1);        % storing u values after each step
    g=zeros(maxiter, 1);        % storing g values after each step from g(x)
    u(1)=u0;                    % first element of u is the assumed u0
    g(1)=gradient2(u0);
    for i=2:maxiter
       % i = 1 is already declared in line 4 and 5
       u(i) = u(i-1) - (t * gradient2(u(i-1)));
       f(i) = g2_fun(u(i));
    end
end

function gg1 = gradient1(u)
    if u<0
        gg1 = u + 2;
    else
        gg1 = u + 4;
    end
end

function gg2 = gradient2(u)
    if u<0
        gg2 = u - 1;
    else
        gg2 = u + 1;
    end
end