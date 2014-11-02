function metrics = ClassificationMetrics(cmatrix)

metrics = cell(6,1);

for n = 1:6
    metrics{n} = struct('label',[],'precision',[],'recall',[],'F1',[]);
    metrics{n}.label = n;
    
    tp = cmatrix(n,n);
    fn = sum(cmatrix(n,:)) - tp;
    fp = sum(cmatrix(:,n)) - tp;
    %tn = sum(cmatrix) - (tp+fn+fp);
    
    metrics{n}.recall = RecallRate(tp, fn);
    metrics{n}.precision = PrecisionRate(tp, fp);
    metrics{n}.F1 = F1(metrics{n}.precision, metrics{n}.recall);
    
end

end

function recall = RecallRate(tp, fn)

recall = (tp/(tp+fn+eps))*100;

end

function precision = PrecisionRate(tp, fp)

precision = (tp/(tp+fp+eps))*100;

end

function f1 = F1(precision, recall)

f1 = 2*(precision*recall)/(precision+recall+eps);

end