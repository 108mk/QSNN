%v��ʾ�ܿر��ش��ڵ�v��״̬ʱ������Mat�š�v��ȡֵ��Χ��[1,2^(n_qubit-log2(length(Mat)))]
%�ڳ������ܿر��غ�Ŀ�����֮��������0,1��ִ��Mat�ţ���ʱvӦ����һ�����飬
%��ʾ�ܿر��ش��ڵ�v()��״̬ʱ������Mat�š�
%��λ���Ƶ�λ
function U = CnU(v, n_qubit,Mat)
U = sparse(2^n_qubit,2^n_qubit);

%����ִֻ��I�ź�ִֻ��Mat�ŵ����У�����v������ִֻ��Mat�ŵ�����
%�Ȳ�����
w = [1:2^(n_qubit-log2(length(Mat)))];

%�޳�v�а�����ֵ
for i =1:2^(n_qubit-log2(length(Mat)))
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
     p_i = sparse(2^(n_qubit-log2(length(Mat))),1);
     p_i(w(i)) = 1;
     U = U + kron(p_i*p_i',sparse(eye(length(Mat))));
end

%��ִֻ��X�ļ�����
for i =1:length(v)
     p_i = sparse(2^(n_qubit-log2(length(Mat))),1);
     p_i(v(i)) = 1;
     U = U + kron(p_i*p_i',Mat);
end

end