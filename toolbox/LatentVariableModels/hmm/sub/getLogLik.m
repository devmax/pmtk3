function loglik = getLogLik(model, data)
%% Find the LL of obs. data. Code taken from the hmmFitEm.m function.

%%
stackedData = cell2mat(data')';
nobs = numel(data);
loglik = 0;
logB = mkSoftEvidence(model.emission, stackedData');
[logB, scale] = normalizeLogspace(logB');
B = exp(logB');

seqidx = cumsum([1, cellfun(@(seq)size(seq, 2), data')]);

for i=1:nobs
    [~, ~, ~, logp] = hmmFwdBack(model.pi, model.A, B(:, seqidx(i):seqidx(i+1)-1));
    loglik = loglik + logp;
end
loglik = loglik + sum(scale);
loglik = loglik + log(model.A(:)+eps)'*(model.transPrior(:)) + ...
    log(model.pi(:)+eps)'*(model.piPrior(:));

end