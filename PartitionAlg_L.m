function [Ixy,NregTot,reg_features,Hp] = infoTeorSeg3_L(img_L,stopCriterionSelection,Nreg_thr,scal_f)


%Calculate the entropy of the whole image.
[A,ia,ic] = unique(sort(img_L(:)));
ia = [ia;length(img_L(:))+1];
n_pixel = ia(2:end) - ia(1:end-1);
p_x = n_pixel/sum(n_pixel);

Hp = -sum(p_x.*log2(p_x)); %entropy of the image

N = numel(img_L);


reg_features = [1 1 size(img_L,2) size(img_L,1) Hp];


stop_flag = false;
k=0;
while stop_flag == false

    k=k+1;
    reg_features_newH = [zeros(2,4),[inf;inf]];
    reg_features_newV = [zeros(2,4),[inf;inf]];

    if reg_features(1,3) ~= 1
        reg_features_newH = horzPartition(img_L,reg_features(1,:));
    end
    if reg_features(1,4) ~= 1
        reg_features_newV = vertPartition(img_L,reg_features(1,:));
    end

    if sum(reg_features_newH(:,5)) < sum(reg_features_newV(:,5))
        reg_features = [reg_features;reg_features_newH];

    else
        reg_features = [reg_features;reg_features_newV];
    end

    reg_features(1,:) = [];


    [~, sortHc_idx] = sort(reg_features(:,5),'descend');
    reg_features = reg_features(sortHc_idx,:);
    
    Ixy(k) = Hp-sum(reg_features(:,5));

    if stopCriterionSelection == 1
        if sum(reg_features(:,5)) == maxHc
            stop_flag = true;
        end
    elseif stopCriterionSelection == 2
        if size(reg_features,1) == Nreg_thr || sum(reg_features(:,5)) == 0
            stop_flag = true;
        end
    else
        if sum(reg_features(:,5)) <= (1-scal_f)*Hp
            stop_flag = true;
        end
    end

   
end

NregTot = size(reg_features,1);



end