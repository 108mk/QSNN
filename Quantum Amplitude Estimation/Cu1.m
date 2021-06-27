%v = 0��ʾ���Ʊ���Ϊ0ʱִ��X��
%v = 1��ʾ���Ʊ���Ϊ1ʱִ��X��
function U = Cu1(v,lambda)
p_0 = [1;0];
p_1 = [0;1];
u1 = [1,0;0,exp(1i*lambda)];
if v == 1
    U = kron(p_0*p_0',eye(2)) + kron(p_1*p_1',u1);
else
    U = kron(p_0*p_0',u1) + kron(p_1*p_1',eye(2));
end

end