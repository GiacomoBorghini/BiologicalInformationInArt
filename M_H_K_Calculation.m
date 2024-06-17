function [M_b,M_k,H_p] = M_b_kCalculation(imageStrMb,folder)

Nb_rgb = 256^3; %number of bins of the insensity histogram of an rgb image
Hmax_rgb = log2(Nb_rgb);

for i=1:size(imageStrMb,1)
    currentfilename = strcat(folder, imageStrMb(i).name);

    image_raw = imread(currentfilename);

    image = cast(image_raw,'uint32');
    Xrgb = bitshift(image(:,:,1),16) + bitshift(image(:,:,2),8) + image(:,:,3);

    %math steps to compute the image entropy
    [A,ia,ic] = unique(sort(Xrgb(:)));
    ia = [ia;length(Xrgb(:))+1];
    n_pixel = ia(2:end) - ia(1:end-1);
    p_x = n_pixel/sum(n_pixel);

    size_jpg = imageStrMb(i).bytes;
    size_raw = numel(image_raw);


    H_p(i) = -sum(p_x.*log2(p_x));

    M_b(i) = (Hmax_rgb-H_p(i))/Hmax_rgb; %relative redundancy M_b
    M_k(i) = (size_raw-size_jpg)/size_raw;
    ia=0;

end



end