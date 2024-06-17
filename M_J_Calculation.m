function [M_j] = M_jCalculation(imageStrMj,folder,resol_level)

for n=1:size(imageStrMj,1)

    currentfilename = strcat(folder, imageStrMj(n).name);
    image_raw = imread(currentfilename);

    %computes the luma Y709
    image_L = (0.2126.*image_raw(:,:,1))+(0.7152.*image_raw(:,:,2))+(0.0722.*image_raw(:,:,3));

    blockSizeH = ceil(size(image_L,1)/resol_level);
    blockSizeL = ceil(size(image_L,2)/resol_level);

    startH = 1;
    startL = 1;
    regCell = cell(resol_level,resol_level);

    %image regions are saved inside a cell variable
    for i=1:resol_level
        for j=1:resol_level

            reg = image_L(startH:startH+blockSizeH-1,startL:startL+blockSizeL-1);
            startL = startL+blockSizeL-1;
            regCell{i,j} = reg;

        end
        startH = startH+blockSizeH-1;
        startL = 1;
    end

    %find whole image entropy
    [A,ia,ic] = unique(sort(image_L(:)));
    ia = [ia;length(image_L(:))+1];
    n_pixel = ia(2:end) - ia(1:end-1);
    p_x = n_pixel/sum(n_pixel);

    Hp = -sum(p_x.*log2(p_x)); %entropy of the image

    %find the entropy of the located image regions.
    for m=1:size(regCell,1)
        for j=1:size(regCell,2)
            imgReg = cell2mat(regCell(m,j)); %takes one image region at a time
            regSizes(m,j) = size(imgReg,1)*size(imgReg,2)/numel(image_L);
            [A,ia,ic] = unique(sort(imgReg(:)));
            ia = [ia;length(imgReg(:))+1];
            n_pixel = ia(2:end) - ia(1:end-1);
            p_x = n_pixel/sum(n_pixel);
            h_p(m,j) = -sum(p_x.*log2(p_x));
        end
    end

    M_j(n) = sum(regSizes.*h_p,"all")/Hp;




end





end