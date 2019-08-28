%模拟退火算法
clear;clc;
蒙特卡洛方法，温度降低之前多次实验
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
];                %%31个省会坐标
n=31; %%自己修改的地方
D=zeros(n,n);%D表示完全图的赋权邻接矩阵
for i=1:n
    for j=1:n
        if i~=j
            D(i,j)=((C(i,1)-C(j,1))^2+(C(i,2)-C(j,2))^2)^0.5;
        else
            D(i,j)=0;      %i=j时不计算，应该为0，但后面的启发因子要取倒数，用eps（浮点相对精度）表示
        end
        D(j,i)=D(i,j);   %对称矩阵
    end
end


dis = D;   %城市距离矩阵


temperature = 1000;                 % 初始温度
cooling_rate = 0.94;                % 冷却率
iterations = 1;                     % Initialize the iteration number. 迭代数目（等温步长）

% Initialize random number generator with "seed". 
rand('seed',0);                    

% 随机选出初始解
route = randperm(31);
% 初始解的总距离
previous_distance = totaldistance(route,dis);

% 这是用于在100次迭代后冷却当前温度的标志
temperature_iterations = 1;


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
        iterations = iterations + 1;
    end
    
    % 每迭代100次降温
    if temperature_iterations >= 100
       temperature = cooling_rate*temperature;
       temperature_iterations = 0;
    end

end

route
previous_distance
current_distance

