%v��ʾ�ܿر��ش��ڵ�v��״̬ʱ������X�š�v��ȡֵ��Χ��[1,2^(n_qubit-1)]
%�ڳ������ܿر��غ�Ŀ�����֮��������0,1��ִ��X�ţ���ʱvӦ����һ�����飬
%��ʾ�ܿر��ش��ڵ�v()��״̬ʱ������X�š�
%2^n_qubit��ʾ���ӱ����ŵ�ά�ȣ�����n_qubit-1λ�ܿر���������1��Ŀ�����
%��λ���Ƹ�λ
function U = XnC(v, n_qubit)
U = sparse(2^n_qubit,2^n_qubit);
X = [0,1;1,0];
%����ִֻ��I�ź�ִֻ��X�ŵ����У�����v������ִֻ��X�ŵ�����
%�Ȳ�����
w = [1:2^(n_qubit-log2(length(X)))];

%�޳�v�а�����ֵ
for i =1:2^(n_qubit-1)
    for j =1:length(v)
        if w(i) == v(j)
            %�ظ���Ԫ�ظ�ֵΪ0
            w(i) = 0;
        end
    end
end
%w��ɾ��Ϊ0��Ԫ��
w(w==0) = [];

%��ִֻ��I�ļ�����
for i =1:length(w)
     p_i = sparse(2^(n_qubit-1),1);
     p_i(w(i)) = 1;
     U = U + kron(eye(2),p_i*p_i');
end

%��ִֻ��X�ļ�����
for i =1:length(v)
     p_i = sparse(2^(n_qubit-1),1);
     p_i(v(i)) = 1;
     U = U + kron(X,p_i*p_i');
end
end