# BiologicalInformationInArt
In this repository is reported the Matlab code used to obtain the results of the paper 
presented to NanoCom 2024 conference, titled "Detection of Biological Information in Art: An Information Theoretic Perspective to Measure Creativity". The paper refers to two methods: Informational Aesthetics and Wavelet domain Hidden Markov Trees (WHMT). Here are explained how to run the Matlab code which is provided as well in this repository. 


# Informational Aesthetics
## Global Aesthetics Measures
The main code to run to get the results is contained in **Global_Aesthetics_general.m** . This is main function and provides the graphics of the comparison, between AI and human paintings, of the M_H and M_K metrics. To run this code is necessary to have in the same folder the functions:
* **resize_save.m**
* **M_H_K.m**
* **natsort.m**
* **natsortfiles.m**

The last two scripts has been taken from the File Exchange section of Matlab website (link: https://it.mathworks.com/matlabcentral/fileexchange/47434-natural-order-filename-sort).
To run the Global_Aesthetics_general.m function is important to set properly the variables that contains the path of the folders where the human and AI paintings to which we want to apply the methods are saved. 
To run the code without modifying the _Hfolder_ and _AIfolder_ variables is sufficient to create a folder called "ImageDatabase" containing two sub-folders called "Human" (where human paintings should be saved) and "AI" (where AI paintings should be saved) in the same Matlab workspace where the scripts are placed. 

## Compositional Aesthetics Measures
The main code to run to get the results is contained in **Compositional_Aesthetics_general.m** 
## Mutual-Information-based Partitioning


# Wavelet domain Hidden Markov Trees


