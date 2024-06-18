clc
close all
clear

tic

N_B = 512*512;

stopCriterionSelection = 3;
% 1: I(X,\hat{Y}) = H(X)
% 2: max region number
% 3: desired value of I(X,\hat{Y})

Nreg_thr = 4;
scal_f = 0.7;

HumanFolder = 'ImageDatabase\Human\';
AIfolder = 'ImageDatabase\AI\';

dirNameH = strcat(HumanFolder,'*.jpg');
imageStructH = dir(dirNameH); %load the images of the desired folder on a struct variable
imageStructH = natsortfiles(imageStructH);


dirNameAI = strcat(AIfolder,'*.jpeg');
imageStructAI = dir(dirNameAI); %load the images of the desired folder on a struct variable
imageStructAI = natsortfiles(imageStructAI);

for i=1:size(imageStructH,1)
    currentfilenameH = strcat(HumanFolder, imageStructH(i).name);
    currentfilenameAI = strcat(AIfolder, imageStructAI(i).name);

    AIstruct.title{i} = currentfilenameAI;
    Hstruct.title{i} = currentfilenameH;

    imgH = imread(currentfilenameH);
    imgAI = imread(currentfilenameAI);

    N_H = numel(imgH)/3;
    N_AI = numel(imgAI)/3;

    Rr= N_AI/N_B;
    imgAI = imresize(imgAI,1/sqrt(Rr));

    Rr = N_H/N_B;
    imgH = imresize(imgH,1/sqrt(Rr));

    AIimg_L = (0.2126.*imgAI(:,:,1))+(0.7152.*imgAI(:,:,2))+(0.0722.*imgAI(:,:,3));
    Himg_L = (0.2126.*imgH(:,:,1))+(0.7152.*imgH(:,:,2))+(0.0722.*imgH(:,:,3));


    [Ixy_AI,N_regAI,reg_featuresAI,HpAI] = PartitionAlg_L(AIimg_L,stopCriterionSelection,Nreg_thr,scal_f);
    [Ixy_H,N_regH,reg_featuresH,HpH] = PartitionAlg_L(Himg_L,stopCriterionSelection,Nreg_thr,scal_f);

    Ixy_AI_vec(i) =  Ixy_AI(end)/HpAI;
    Ixy_H_vec(i) = Ixy_H(end)/HpH;

    Nreg_AI_vec(i) = N_regAI;
    Nreg_H_vec(i) = N_regH;
    
    Hp_AI_vec(i) = HpAI;
    Hp_H_vec(i) = HpH;
end




x = linspace(1,size(imageStructAI,1),size(imageStructAI,1));

switch stopCriterionSelection
    case 1

        graphTitle = strcat('AI vs. Human $$I(X,\hat{Y}$$ = H_p');
        figure
        bar(x,[Nreg_AI_vec;Nreg_H_vec]);

        title(graphTitle);
        xlabel('Painting label');
        ylabel('Nreg');
        legend('AI','Human');

    case 2
        graphTitle = strcat('AI vs. Human Nreg',{' '},num2str(Nreg_thr));
        figure
        bar(x,[Ixy_AI_vec;Ixy_H_vec]);

        ylim([0 1]);
        title(graphTitle);
        xlabel('Painting label');
        ylabel('$$I(X,\hat{Y}$$)', 'Interpreter', 'latex');
        legend('AI','Human');

    case 3
        graphTitle = strcat('AI vs. Human',{' '},num2str(scal_f),{' '},'H_p');
        figure
        bar(x,[Nreg_AI_vec;Nreg_H_vec]);

        title(graphTitle);
        xlabel('Painting label');
        ylabel('Nreg');
        legend('AI','Human');
end




toc