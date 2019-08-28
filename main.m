%ģ���˻��㷨
clear;clc;

load china; % geographic information
plotcities(province, border, city); % ����ͼ

numberofcities = length(city);      % ������Ŀ
% distance matrix: dis(i,j) is the distance between city i and j.
dis = distancematrix(city);   %���о������


temperature = 1000;                 % ��ʼ�¶�
cooling_rate = 0.94;                % ��ȴ��
iterations = 1;                     % Initialize the iteration number. ������Ŀ

% Initialize random number generator with "seed". 
rand('seed',0);                    

% ���ѡ����ʼ��
route = randperm(numberofcities);
% ��ʼ����ܾ���
previous_distance = totaldistance(route,dis);

% ����������100�ε�������ȴ��ǰ�¶ȵı�־�����²�����
temperature_iterations = 1;
% ����һ����־��������200�ε�������Ƶ�ǰ·�ߡ�
plot_iterations = 1;

% plot the current route
plotroute(city, route, previous_distance, temperature);

while 1.0 < temperature
    %����������ڽ������
    temp_route = perturb(route,'reverse');
    % ������ʱ·�ߵ��ܾ���
    current_distance = totaldistance(temp_route, dis);
    %�������仯
    diff = current_distance - previous_distance;
    
    % Metropolis Algorithm
    if (diff < 0) || (rand < exp(-diff/(temperature)))
        route = temp_route;         %�����½�
        previous_distance = current_distance;
        
        % ���µ���
        temperature_iterations = temperature_iterations + 1;
        plot_iterations = plot_iterations + 1;
        iterations = iterations + 1;
    end
    
    % ÿ����100�ν���
    if temperature_iterations >= 100
       temperature = cooling_rate*temperature;
       temperature_iterations = 0;
    end
    
    % ÿ200�ε������Ƶ�ǰ·��
    if plot_iterations >= 200
       plotroute(city, route, previous_distance,temperature);
       plot_iterations = 0;
    end
end

% �������ս������
plotroute(city, route, previous_distance,temperature);
