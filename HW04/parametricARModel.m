function [b,a] = parametricARModel(r,p)
    N = length(r) + 1;
    B = [];
    for i = [1:p]
        B = [B; [r(N/2 - (i-1):N/2 + p-1 - (i-1))]];
    end
    v = -1*[r(N/2+1:N/2+p)]';
    B_ = inv(B);
    a = B_*v; a = [1, a'];
    b = sum(a.*[r(N/2:N/2+p)]);
end