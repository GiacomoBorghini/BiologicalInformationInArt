function resize_save(folderINpath,folderOUTpath,dirName,N_B)

image_struct = dir(dirName);

for i=1:size(image_struct,1)

     currentfilename = strcat(folderINpath, image_struct(i).name);
     img = imread(currentfilename);

     N_A = size(img,1)*size(img,2);
     Rr = N_A/N_B;
     img = imresize(img,1/sqrt(Rr));

     imwrite(img,strcat(folderOUTpath,image_struct(i).name));
   
     

end



end