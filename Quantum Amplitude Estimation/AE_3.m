clear 
close
clc
%���Ʊ�����Ϊ3
%Grover������Ƶı�����Ϊ3

%�������һ��1024ά�ȵ��������ұ�֤������ƽ����Ϊ1
dim = 2;
[x,mul1] = rand_vec(dim);
[y,mul2] = rand_vec(dim);
N = 500;
for j=1:N
    x = [cos((j)/N*pi/4); sin((j)/N*pi/4)];
    y = [sin((j)/N*pi/4);cos((j)/N*pi/4)];
    res(j) = x'*y;


%ʹ��ʩ������������������������Ͼ���
C = diag(ones(dim,1));
C(:,1) = x;
Ux = Schmidt_orthogonalization(C);
Ux = Ux';
D = diag(ones(dim,1));
D(:,1) = y;
Uy = Schmidt_orthogonalization(D);
Uy = Uy';

H = 1/sqrt(2) * [1,1;1,-1];
X = [0,1;1,0];
I = eye(2);

%��̬
%Ŀ��Ĵ���3��qubit�����ƼĴ���3��qubit
psi = zeros(2^6,1);
psi(1) = 1;

%U1 = kron3(H, Ry(2*pi/3), Ry(2*pi/12));
U1 = kron3(H, Ux, Uy);%������ɵ�Ux��Uy
U2 = Cswap(3,2,3);
U3 = kron3(H,I,I);

%����ִ��Grover���ӵ�Ŀ��Ĵ������ǵĳ�̬Ϊ��
%���Ƿ��־���һ��swap-test��·��ĳ�̬�У���һ�����Ϊ���ģ��Ⲣ��Ӱ�����
%��Ϊ��ʹ��Grover�㷨�����뱣֤ÿ������ǷǸ���
%�����Զ��ڳ�̬�Ӿ���ֵ�����ǿ��ǵ�Grover�㷨�л�Ҫʹ���Ʊ���̬������
%��ˣ�����ʹ��CCZ�ţ���֤ÿ������Ǹ�
%���Ƕ����ձ��������˵�������ĸ�����Ǹ��Ļ���Ҫ��̽��
Z = [1,0;0,-1];
U4 = CnU(3,3,Z);


%������̬
A = U3 * U2 * U1;
%A = U4 * U3 * U2 * U1;
B = kron(u1(-pi/2),eye(4)) * kron3(H,H,H);
W1 = kron(kron3(H,H,H), A);
%W1 = kron(kron3(H,H,H), B);
psi = W1 * psi;
%�ܿ�G��
G = Grover3(A);
W2 = kron3(I, I, CnU(2, 4, G));
W3 = kron(I, CnU([3,4], 5, G^2));
W4= CnU([5,6,7,8], 6, G^4);

psi = W4 * W3 * W2 * psi;

%IQFT
Q = IQFT(3);
swap = CnX([3,4],3) * XnC([2,4],3) * CnX([3,4],3);

psi = kron(swap * Q,eye(8)) * psi;

for i = 1:8
    measure(i) = sum(abs(psi(8*(i-1)+ 1 : 8*(i-1)+ 8)).^2);
end

es(j) = find(measure(1:4) == max(measure(1:4)))-1;
es(j) = es(j) / 8 * pi;
es_res(j) = sqrt(1-2*sin(es(j))^2);
end
plot(1:N,res,1:N,es_res)
hold on
