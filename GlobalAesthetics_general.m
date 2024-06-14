clear
close all
clc

N_B = 512*512;
resol_level = 4;

Hfolder = 'ImageDatabase/Human/';
AIfolder ='ImageDatabase/AI/';

Hfolder_RES = 'ImageDatabase/InUse_H/';
AIfolder_RES = 'ImageDatabase/InUse_AI/';

delete(strcat(Hfolder_RES,'/*'));
delete(strcat(AIfolder_RES,'/*'));


dirNameH = strcat(Hfolder,'*jpg');
dirNameAI = strcat(AIfolder,'*jpeg');
 
resize_save(Hfolder,Hfolder_RES,dirNameH,N_B);
resize_save(AIfolder,AIfolder_RES,dirNameAI,N_B);

dirNameH = strcat(Hfolder_RES,'*jpg');
dirNameAI = strcat(AIfolder_RES,'*jpeg');

image_structH = dir(dirNameH);
image_structAI = dir(dirNameAI);
image_structH = natsortfiles(image_structH);
image_structAI = natsortfiles(image_structAI);



[M_bH,M_kH,Hp_H] = M_b_kCalculation(image_structH,Hfolder_RES);
[M_bAI,M_kAI,Hp_AI] = M_b_kCalculation(image_structAI,AIfolder_RES);


x = linspace(1,size(image_structAI,1),size(image_structAI,1));

figure

plot(x,M_bH,'r:.',...
    'LineWidth',1,...
    'MarkerSize',20)
hold on
plot(x,M_bAI,'b:.',...
    'LineWidth',1,...
    'MarkerSize',20)
title('AI vs. Human Relative Redundancy M_B')
xlabel('Painting label')
ylabel('M_B') 

legend('Human','AI')
hold off


figure

plot(x,M_kH,'r:.',...
    'LineWidth',1,...
    'MarkerSize',20)
hold on
plot(x,M_kAI,'b:.',...
    'LineWidth',1,...
    'MarkerSize',20)
title('AI vs. Human Kolmogorov Complexity M_k')
xlabel('Painting label')
ylabel('M_K') 

legend('Human','AI')
hold off



