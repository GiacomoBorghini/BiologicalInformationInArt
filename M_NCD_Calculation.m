function [M_K] = M_KCalculation(imageStrMk,folder,resol_level)

folderOUT = "tmpComp\";


for n=1:size(imageStrMk,1)
    delete("tmpComp\*");
    currentfilename = strcat(folder, imageStrMk(n).name);
    image_raw = imread(currentfilename);

    image_L = (0.2126.*image_raw(:,:,1))+(0.7152.*image_raw(:,:,2))+(0.0722.*image_raw(:,:,3));
    imageZeroL = image_L;
    imageZeroL(:,:) = 0;

    blockSizeH = ceil(size(image_L,1)/resol_level);
    blockSizeL = ceil(size(image_L,2)/resol_level);

    startH = 1;
    startL = 1;
    regCell = cell(resol_level,resol_level);

    C = zeros(resol_level,resol_level);
    dirNameIN = strcat(folderOUT,'*.jpg');

    %Save the size in bytes of the desired number of regions
    for i=1:resol_level
        for j=1:resol_level
            %In imageZeroL only the current region has a luminance different
            %from zero
            Ii = image_L(startH:startH+blockSizeH-1,startL:startL+blockSizeL-1);
            imageZeroL(startH:startH+blockSizeH-1,startL:startL+blockSizeL-1)=Ii;



            %imgReg = cell2mat(regCell(i,j));
            imwrite(imageZeroL,strcat(folderOUT,"tmpReg.jpg"),'quality',100);
            imageStr = dir(dirNameIN);
            regSize = imageStr(1).bytes;
            C(i,j) = regSize;
            regCell{i,j} = imageZeroL;
            startL = startL+blockSizeL-1;

            imageZeroL(:,:) = 0;

        end
        startH = startH+blockSizeH-1;
        startL = 1;
    end


    k = 1;

    for i=1:(resol_level^2-1)
        for j=i+1:resol_level^2

            x = cell2mat(regCell(floor((i-1)/resol_level+1),mod(i-1,resol_level)+1));
            y = cell2mat(regCell(floor((j-1)/resol_level+1),mod(j-1,resol_level)+1));
            xy = x+y;

            imwrite(xy,strcat(folderOUT,"tmpReg.jpg"),'quality',100);
            imageStr = dir(dirNameIN);
            regSize = imageStr(1).bytes;
            C_xy = regSize;

            C_x = C(floor((i-1)/resol_level+1),mod(i-1,resol_level)+1);
            C_y = C(floor((j-1)/resol_level+1),mod(j-1,resol_level)+1);


            NCD(k) = ((C_xy)-min(C_x,C_y))/max(C_x,C_y);
            if NCD(k)>1
                NCD(k) = 1;
            end
            k = k+1;

        end
    end

    avgNCD = mean(NCD);
    M_K(n) = 1-avgNCD;



end
end