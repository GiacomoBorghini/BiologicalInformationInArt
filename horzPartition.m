%This function realizes a horizontal partitioning of the input image region.
%The output of the function is the updated array with the row and column index 
% of the new located regions (relative to the image matrix) as well as the mutual information given by the
%partition.
%The criterion used to define which is the best partition for the input
%image region is the minimization of the loss of mutual information given
%by the segmentation.

%startReg_row = row index where the current region starts
%endReg_row = row index where the current region ends

%startReg_col = column index where the current region starts
%endReg_col = column index where the current region ends
%(all the index MUST be referred to the image)

function [reg_features_new] = horzPartition3(img_L,reg_features)

startReg_col = reg_features(1);
endReg_col = startReg_col+reg_features(3)-1;
startReg_row = reg_features(2);
endReg_row = startReg_row+reg_features(4)-1;
k = 0;

for i=startReg_col:(endReg_col-1)
    %locate regions
    k = k+1;
    reg_1 = img_L(startReg_row:endReg_row,startReg_col:i);
    reg_2 = img_L(startReg_row:endReg_row,i+1:endReg_col); %horizontal partitioning

    p_y1 = numel(reg_1)/numel(img_L);
    p_y2 = numel(reg_2)/numel(img_L);

    %compute conditional entropy of region 1
    [A,ia,ic] = unique(sort(reg_1(:)));
    ia = [ia;length(reg_1(:))+1];
    n_pixel = ia(2:end) - ia(1:end-1);
    p_x = n_pixel/sum(n_pixel);
    h_1 = -sum(p_x.*log2(p_x));
    h_c1Array(k) = p_y1*h_1;

    %compute conditional entropy of region 2
    [A,ia,ic] = unique(sort(reg_2(:)));
    ia = [ia;length(reg_2(:))+1];
    n_pixel = ia(2:end) - ia(1:end-1);
    p_x = n_pixel/sum(n_pixel);
    h_2 = -sum(p_x.*log2(p_x));
    h_c2Array(k) = p_y2*h_2;

    %compute conditional entropy of the current segmentetion
    Hc(k) = p_y1*h_1 + p_y2*h_2;
    

   
    


end



    min_Hc = min(Hc);
    min_idx = find(Hc == min_Hc);
    min_idx = min_idx(1);
    
    reg_features_new = [reg_features(1) reg_features(2) min_idx reg_features(4) h_c1Array(min_idx);...
        reg_features(1)+min_idx reg_features(2) reg_features(3)-min_idx reg_features(4) h_c2Array(min_idx) ];


    



end