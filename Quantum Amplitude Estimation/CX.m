%v = 0��ʾ���Ʊ���Ϊ0ʱִ��X��
%v = 1��ʾ���Ʊ���Ϊ1ʱִ��X��
function U = CX(v)
p_0 = [1;0];
p_1 = [0;1];
X = [0,1;1,0];
if v == 1
    U = kron(p_0*p_0',eye(2)) + kron(p_1*p_1',X);
elseif v == 0
    U = kron(p_0*p_0',X) + kron(p_1*p_1',eye(2));
end

end