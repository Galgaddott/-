%ģ���˻��㷨
clear;clc;
���ؿ��巽�����¶Ƚ���֮ǰ���ʵ��
C=[
1304 2312;
3639 1315;
4177 2244;
3712 1399;
3488 1535;
3326 1556;
3238 1229;
4196 1004;
4312 790;
4386 570;
3007 1970;
2562 1756;
2788 1491;
2381 1676;
1332 695;
3715 1678;
3918 2179;
4061 2370;
3780 2212;
3676 2578;
4029 2838;
4263 2931;
3429 1908;
3507 2367;
3394 2643;
3439 3201;
2935 3240;
3140 3550;
2545 2357;
2778 2826;
2370 2975
];                %%31��ʡ������
n=31; %%�Լ��޸ĵĵط�
D=zeros(n,n);%D��ʾ��ȫͼ�ĸ�Ȩ�ڽӾ���
for i=1:n
    for j=1:n
        if i~=j
            D(i,j)=((C(i,1)-C(j,1))^2+(C(i,2)-C(j,2))^2)^0.5;
        else
            D(i,j)=0;      %i=jʱ�����㣬Ӧ��Ϊ0�����������������Ҫȡ��������eps��������Ծ��ȣ���ʾ
        end
        D(j,i)=D(i,j);   %�Գƾ���
    end
end


dis = D;   %���о������


temperature = 1000;                 % ��ʼ�¶�
cooling_rate = 0.94;                % ��ȴ��
iterations = 1;                     % Initialize the iteration number. ������Ŀ�����²�����

% Initialize random number generator with "seed". 
rand('seed',0);                    

% ���ѡ����ʼ��
route = randperm(31);
% ��ʼ����ܾ���
previous_distance = totaldistance(route,dis);

% ����������100�ε�������ȴ��ǰ�¶ȵı�־
temperature_iterations = 1;


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
        iterations = iterations + 1;
    end
    
    % ÿ����100�ν���
    if temperature_iterations >= 100
       temperature = cooling_rate*temperature;
       temperature_iterations = 0;
    end

end

route
previous_distance
current_distance

