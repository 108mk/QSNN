clc
close
clear

%���Ʊ�����Ϊ4
%Grover������Ƶı�����Ϊ3

H = 1/sqrt(2) * [1,1;1,-1];
X = [0,1;1,0];
H4 = kron(kron3(H,H,H),H);
I = eye(2);
%�������һ��1024ά�ȵ��������ұ�֤������ƽ����Ϊ1
dim = 2;
% [x,mul1] = rand_vec(dim);
% [y,mul2] = rand_vec(dim);
N = 1000;
res = zeros(N,1);
pro = zeros(N,1);
es_res = zeros(N,1);

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

%��̬
%Ŀ��Ĵ���3��qubit�����ƼĴ���3��qubit
    psi = zeros(2^11,1);
    psi(1) = 1;

    U1 = kron3(H, Ux, Uy);
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

    W1 = kron3(H4,H4, A);

    %�ܿ�G��
    G = Grover3(A);
    W2 = kron(eye(2^7), CnU(2, 4, G));
    W3 = kron(eye(2^6), CnU([3,4], 5, G^2));
    W4 = kron(eye(2^5),CnU([5,6,7,8], 6, G^4));
    W5 = kron(eye(2^4),CnU([9:16], 7, G^8));
    W6 = kron(eye(2^3),CnU([17:32], 8, G^16));
    W7 = kron(eye(2^2),CnU([33:64], 9, G^32));
    W8 = kron(eye(2^1),CnU([65:128], 10, G^64));
    W9 = CnU([129:256],11, G^128);
    psi = W9 * W8 * W7 * W6 * W5 * W4 * W3 * W2 * W1 * psi;

    %IQFT
    Q = IQFT(8);
    swap1 = CnX([65:128], 8) * XnC([2:2:128], 8) * CnX([65:128], 8);
    swap2 = CnX([17:32], 6) * XnC([2:2:32], 6) * CnX([17:32], 6);
    swap3 = CnX([5,6,7,8],4) * XnC([2,4,6,8],4) * CnX([5,6,7,8],4);
    swap4 = CnX([1],2) * XnC([1],2) * CnX([1],2);
    swap = swap1 * kron3(I,swap2,I) * kron3(eye(2^2),swap3,eye(2^2)) * kron3(eye(2^3), swap4, eye(2^3));

    psi = kron(swap * Q,eye(8)) * psi;

    for i = 1:2^8
        measure(i) = sum(abs(psi(8*(i-1)+ 1 : 8*(i-1)+ 8)).^2);
    end
    
     M(1) = measure(1);
    for k = 2:2^8/2
        M(k) = measure(k) + measure(2^8+2-k);
    end
    
    %�����ڻ�
    es(j) = find(M == max(M))-1;
    es(j) = es(j) / 2^8 * pi;
    es_res(j) = sqrt(1-2*sin(es(j))^2);
    
    %����ɹ���
    pro(j) = max(M);
    
%     %����ɹ���
%     inner = 2^8/pi * asin(sqrt(1/2-1/2*res(j)^2)) + 1
%     if floor(inner) ~=1
%         r(j) = (measure(ceil(inner)) + measure(floor(inner))) * 2;
%     else
%         r(j) = measure(ceil(inner))* 2 + measure(floor(inner));
%     end
end
figure(1)
plot(1:N,res,1:N,es_res)
figure(2)
plot(1:N,pro)
