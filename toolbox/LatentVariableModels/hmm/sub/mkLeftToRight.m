function A = mkLeftToRight(A)
%% Make the only possible transitions left to right
%
% A         -- stochastic transition matrix

%%

for i=1:size(A, 1)
    A(i, 1:i-1) = 0;
end

A = normalize(A, 2);

end