%模拟退火算法
clear;clc;

load china; % geographic information
plotcities(province, border, city); % 画地图

numberofcities = length(city);      % 城市数目
% distance matrix: dis(i,j) is the distance between city i and j.
dis = distancematrix(city);   %城市距离矩阵


temperature = 1000;                 % 初始温度
cooling_rate = 0.94;                % 冷却率
iterations = 1;                     % Initialize the iteration number. 迭代数目

% Initialize random number generator with "seed". 
rand('seed',0);                    

% 随机选出初始解
route = randperm(numberofcities);
% 初始解的总距离
previous_distance = totaldistance(route,dis);

% 这是用于在100次迭代后冷却当前温度的标志（等温步长）
temperature_iterations = 1;
% 这是一个标志，用于在200次迭代后绘制当前路线。
plot_iterations = 1;

% plot the current route
plotroute(city, route, previous_distance, temperature);

while 1.0 < temperature
    %随机生成相邻解决方案
    temp_route = perturb(route,'reverse');
    % 计算临时路线的总距离
    current_distance = totaldistance(temp_route, dis);
    %计算距离变化
    diff = current_distance - previous_distance;
    
    % Metropolis Algorithm
    if (diff < 0) || (rand < exp(-diff/(temperature)))
        route = temp_route;         %接受新解
        previous_distance = current_distance;
        
        % 更新迭代
        temperature_iterations = temperature_iterations + 1;
        plot_iterations = plot_iterations + 1;
        iterations = iterations + 1;
    end
    
    % 每迭代100次降温
    if temperature_iterations >= 100
       temperature = cooling_rate*temperature;
       temperature_iterations = 0;
    end
    
    % 每200次迭代绘制当前路线
    if plot_iterations >= 200
       plotroute(city, route, previous_distance,temperature);
       plot_iterations = 0;
    end
end

% 绘制最终解决方案
plotroute(city, route, previous_distance,temperature);
