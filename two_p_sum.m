function Max_p=two_p_sum(s,T)
format short g
b = 1;
v = [5 5
    5 10
    10 5
    10 10];
% s = [200 300];  %这里我调小了，一般s越大结果会出现负数
alpha = [3000 3000];  %一般alpha越大结果会越大
beta = [0.01 0.01];
T = [20 30];
a = s/100;
   
% 前面是基本数据输入，只需调前面参数即可

n = length(v);  %矩阵v的行数
s = repmat(s,n,1);  %将s向量复制为6个一样的矩阵，下面5行一样道理。

a = repmat(a,n,1);
alpha = repmat(alpha,n,1);
beta = repmat(beta,n,1);
T = repmat(T,n,1);

p = exp(a.*v-b)./repmat(sum(exp(a.*v-b),2),1,2);   %计算p
u = p.*(alpha./(1+exp(-beta.*T)) - v.*s);          %计算u

f = sum(u,2);  %目标函数四个系数u1,u2,u3,u4

Aeq = [1 1 1 1];  %等式约束：4个pai加起来等式左边系数
beq = 1;          %等式约束：4个pai加起来等式右边系数
u = u';           %对u进行转至
A = -[u(1,1)-u(1,3), u(1,2)-u(1,4), 0, 0
     0, 0, u(1,3)-u(1,1), u(1,4)-u(1,2)
     u(2,1)-u(2,2),0, u(2,3)-u(2,4),0
     0, u(2,2)-u(2,1), 0 ,u(2,4)-u(2,3)];   %不等式约束四个方程矩阵大于0，加个负号小于0
b = zeros(4,1);                             %不等式约束四个方程向量
lb = zeros(4,1);  %四个优化变量大于等于0

[x,Min_p] = linprog(-f,A,b,Aeq,beq,lb);    %线性优化，最小值优化，所以加个负号
%x 
Max_p = -Min_p;
% x代表四个pai
% Min_p代表优化目标函数
end