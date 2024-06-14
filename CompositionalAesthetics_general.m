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

[M_jH] = M_jCalculation(image_structH,Hfolder_RES,resol_level);
[M_jAI] = M_jCalculation(image_structAI,AIfolder_RES,resol_level);

[M_KH] = M_KCalculation(image_structH,Hfolder_RES,resol_level);
[M_KAI] = M_KCalculation(image_structAI,AIfolder_RES,resol_level);

x = linspace(1,size(image_structAI,1),size(image_structAI,1));

figure

plot(x,M_jH,'r:.',...
    'LineWidth',1,...
    'MarkerSize',20)
hold on
plot(x,M_jAI,'b:.',...
    'LineWidth',1,...
    'MarkerSize',20)
title('AI vs. Human Jensen-Shannon order M_j')
xlabel('Painting label')
ylabel('M_j') 

legend('Human','AI')
hold off


figure

plot(x,M_KH,'r:.',...
    'LineWidth',1,...
    'MarkerSize',20)
hold on
plot(x,M_KAI,'b:.',...
    'LineWidth',1,...
    'MarkerSize',20)
title('AI vs. Human NCD analysis M_K')
xlabel('Painting label')
ylabel('M_K') 

legend('Human','AI')
hold off








