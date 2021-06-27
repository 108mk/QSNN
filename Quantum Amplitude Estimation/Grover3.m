%�ú����Ĺ���ʵ��һ��Grover����
%����ȷ�����ǣ�oracle�Ǳ�Ǹ�������Ϊ1������״̬
%���ֻ��Ҫ�����Ʊ���̬������A
%3��ʾ������һ��3qubit��Grover����
function G = Grover3(A)
Z = [1,0;0,-1];
I = eye(2);
X = [0,1;1,0];

%oracle
%��anc=1��״̬ȫ�����
O = kron3(Z,I,I);
%I_0
%ֻ��ȫ0̬��һ����ת��λ
I_0 = kron3(I,I,X) * CnU(1,3,Z) * kron3(I,I,X);

G = -A * I_0 * A^(-1) * O;
end