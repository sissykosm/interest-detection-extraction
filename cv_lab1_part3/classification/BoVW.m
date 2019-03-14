function [BOF_tr,BOF_ts] = BoVW(data_train,data_test)
%inputs: train set, test set
%outputs: bag of features derived from the train and test sets

new_data_train = cat(1,data_train{:});
part = datasample(new_data_train,floor(size(new_data_train,1)/2)); 
[idx,centroids] = kmeans(part,500);

min_train = cell(1,size(data_train,2));
idx_train = cell(1,size(data_train,2));
for i = 1:size(data_train,2)
    [min_train{1,i},idx_train{1,i}] = pdist2(centroids,data_train{1,i},'euclidean','smallest',1);
end    

min_test = cell(1,size(data_test,2));
idx_test = cell(1,size(data_test,2)); 
for i = 1:size(data_test,2)
    [min_test{1,i},idx_test{1,i}] = pdist2(centroids,data_test{1,i},'euclidean','smallest',1);
end    

BOF_tr = zeros(size(data_test,2),size(centroids,1));
for i = 1:size(data_train,2)
    BOF_tr(i,:) = histc(idx_train{1,i},1:size(centroids,1));
end    
BOF_tr = BOF_tr./repmat(sqrt(sum(BOF_tr.^2,2)),1,size(centroids,1));

BOF_ts = zeros(size(data_test,2),size(centroids,1));
for i = 1:size(data_test,2)
    BOF_ts(i,:) = histc(idx_test{1,i},1:size(centroids,1));
end 
BOF_ts = BOF_ts./repmat(sqrt(sum(BOF_ts.^2,2)),1,size(centroids,1));

end