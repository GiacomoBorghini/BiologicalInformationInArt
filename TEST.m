% img_array = ["./pictures/AI/AI daVinci 1.jpeg"... 
%             "./pictures/AI/AI daVinci 2.jpeg"...
%             "./pictures/AI/AI Mondrian 1.jpeg"... 
%             "./pictures/AI/AI Mondrian 2.jpeg"... %LOOPING (1,3,6)
%             "./pictures/AI/AI Mondrian 3.jpeg"... %LOOPING (1,6)
%             "./pictures/AI/AI Picasso 1.jpeg"...
%             "./pictures/AI/AI Picasso 2.jpeg"...  
%             "./pictures/AI/AI Rothko 1.jpeg"...   %LOOPING (1,2,3,4,5,6,7)
%             "./pictures/AI/AI Rothko 2.jpeg"...   %LOOPING (1,2,3,4,5,6,7)
%             "./pictures/AI/AI VanGogh 1.jpeg"...  
%             "./pictures/AI/AI VanGogh 2.jpeg"...  
%             "./pictures/Human/daVinci 1.jpg"...
%             "./pictures/Human/daVinci 2.jpg"...
%             "./pictures/Human/Mondrian 1.jpg"...
%             "./pictures/Human/Mondrian 2.jpg"...  
%             "./pictures/Human/Mondrian 3.jpg"...
%             "./pictures/Human/Picasso 1.jpg"...   
%             "./pictures/Human/Picasso 2.jpg"...
%             "./pictures/Human/Rothko 1.jpg"...
%             "./pictures/Human/Rothko 2.jpg"...
%             "./pictures/Human/vanGogh 1.jpg"...
%             "./pictures/Human/vanGogh 2.jpg"];

% img_array = ["./pictures/AI/1.jpeg"];
% img_array = ["./pictures/AI/1.jpeg",
%              "./pictures/AI/2.jpeg",
%              "./pictures/AI/3.jpeg",
%              "./pictures/AI/4.jpeg",
%              "./pictures/AI/5.jpeg",
%              "./pictures/AI/6.jpeg",
%              "./pictures/AI/7.jpeg",
%              "./pictures/AI/8.jpeg",
%              "./pictures/AI/9.jpeg",
%              "./pictures/AI/10.jpeg",
%              "./pictures/AI/11.jpeg",
 img_array = ["./pictures/Human/1.jpg",
             "./pictures/Human/2.jpg", %LOOPED (DB LH, DB HL, SYM3 HL, COIF1 HL, DMEY HH, DMEY HL)
             "./pictures/Human/3.jpg",
             "./pictures/Human/4.jpg",
             "./pictures/Human/5.jpg",
             "./pictures/Human/6.jpg",
             "./pictures/Human/7.jpg",
%              "./pictures/Human/8.jpg", %LOOPED (DMEY LH)
%              "./pictures/Human/9.jpg", %LOOPED (DMEY LH)
%              "./pictures/Human/10.jpg", %LOOPED (DMEY LH)
%              "./pictures/Human/11.jpg",
    ];

% disp("NEW TEST: CHANGED ES(NODE,:,:,:) TO ES(:,NODE,:,;)")

dict_array = zeros(size(img_array,2), 2);

for index=1:length(img_array)
    imgpath = img_array(index);
    img = cropImage(imread(imgpath));

    wavelet_array = ["haar", "db2", "sym3", "coif1", "bior1.3", "rbio1.3", "dmey"];
    % wavelet_array = ["sym3", "coif1", "dmey"];

    entropy_array = zeros(1,size(wavelet_array, 2));

    img = img(:,:,1);

    for x=1:length(wavelet_array)

        coefs = -1;
        if wavelet_array(x) == "daubechies"
            coefs = daubcqf(4);
        else
            coefs = wfilters(wavelet_array(x));
        end

        [y] = hdenoise_adjusted(img, coefs);

        % disp(upper(wavelet_array(x)))
        % disp(y)

        entropy_array(x) = y;
    end

    dict = dictionary(wavelet_array, entropy_array);

    disp(imgpath);
    disp(dict);

end

% for i=1:length(img_array)
%     disp(img_array(i))
%     disp(dict_array(i))
% end


function [cropped_img] = cropImage(img)
    smaller_dim = 0;
    if size(img,1) < size(img,2)
        smaller_dim = size(img,1);
    else
        smaller_dim = size(img,2);
    end

    square_size = 2^floor(log2(smaller_dim));

    %KEEPING ALL IMAGES AT 1024x1024 OR LOWER
    if square_size > 1024
        square_size = 1024;
    end

    target_size = [square_size square_size];

    crop_window = centerCropWindow2d(size(img), target_size);

    cropped_img = imcrop(img, crop_window);

end