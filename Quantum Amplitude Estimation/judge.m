%ȷ��|xy>-|yx>�������ŵ�λ��
clc
close
clear

r = rand(4,2);%���������������
r = sort(r,2);
res = kron(r(:,1),r(:,2)) - kron(r(:,2),r(:,1));
