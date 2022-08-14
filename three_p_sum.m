function Max_p=three_p_sum(s,T)
format short g
b = 0;
v = [5 5 5
    5 5 10
    5 10 5
    5 10 10
    10 5 5
    10 5 10
    10 10 5
    10 10 10];
% s = [200 300 300];
% alpha = [3000 3000 3000];
alpha=[3000:500:8000];
beta = [0.01 0.01 0.01];
T = [20 30 10];
a = s/100;  


n = length(v); 
s = repmat(s,n,1); 
a = repmat(a,n,1);
alpha = repmat(alpha,n,1);
beta = repmat(beta,n,1);
T = repmat(T,n,1);

p = exp(a.*v-b)./repmat(sum(exp(a.*v-b),2),1,3);

u = p.*(alpha./(1+exp(-beta.*T)) - v.*s);

f = sum(u,2); 

Aeq = [1 1 1 1 1 1 1 1];
beq = 1;
u = u';
A = -[u(1,1)-u(1,5), u(1,2)-u(1,6),u(1,3)-u(1,7),u(1,4)-u(1,8),0,0, 0, 0
     0, 0, 0,0,u(1,5)-u(1,1), u(1,6)-u(1,2),u(1,7)-u(1,3),u(1,8)-u(1,4)
     u(2,1)-u(2,3),u(2,2)-u(2,4),0,0,u(2,5)-u(2,7), u(2,6)-u(2,8),0,0
     0,0,u(2,3)-u(2,1),u(2,4)-u(2,2),0,0,u(2,7)-u(2,5),u(2,8)-u(2,6)
     u(3,1)-u(3,2),0,u(3,3)-u(3,4),0,u(3,5)-u(3,6),0,u(3,7)-u(3,8),0
     0,u(3,2)-u(3,1),0,u(3,3)-u(3,4),0,u(3,6)-u(3,5),0,u(3,8)-u(3,7)
     ];
b = zeros(6,1);
lb = zeros(8,1);

[x,Min_p] = linprog(-f,A,b,Aeq,beq,lb);
Max_p = -Min_p;

end
