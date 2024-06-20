# BiologicalInformationInArt

In this repository is reported the Matlab code used to obtain the results of the paper presented to NanoCom 2024 conference, titled "Detection of Biological Information in Art: An Information Theoretic Perspective to Measure Creativity". The paper refers to two methods: Informational Aesthetics and Wavelet domain Hidden Markov Trees (WHMT) described in literature. Here is explained how to run the Matlab code which is provided as well in this repository. For further information on the theory behind the reported algorithms, please refer to the articles on which they are based. The articles mentioned alongside their DOI are listed below:

- "Informational Aesthetics Measures" (https://doi.org/10.1109/mcg.2008.34)
- "An information theoretic framework for image segmentation" (https://doi.org/10.1109/ICIP.2004.1419518)
- "Quantifying self-organization with optimal wavelets" (https://doi.org/10.1209/0295-5075/102/40004)
- "The Artists who Forged Themselves: Detecting Creativity in Art"(https://doi.org/10.48550/arXiv.1506.04356)




# Informational Aesthetics

To run the code without modifying any variable is sufficient to create a folder called "ImageDatabase" containing two sub-folders called "Human" (where human paintings should be saved) and "AI" (where AI paintings should be saved) in the same Matlab workspace where the scripts are placed. Since this is a code designed to produce a comparison between the values of metrics obtained from couples of images (each composed of an AI and a Human painting) it's **mandatory** to **rename the images with numerical labels** (1,2,3...). Images with same label will be analyzed as a couple. The code can be used as you prefer, but it is designed to compare metrics obatined from images which are somehow related (e.g. they have same subject and artistic style).

## Global Aesthetics Measures
The main code to run to get the results is contained in **Global_Aesthetics_general.m** . This is main function and provides the graphics of the comparison, between AI and human paintings, of the M_H and M_K metrics. To run this code is necessary to have in the same folder where the main script is saved the following functions:
* **resize_save.m**
* **M_H_K_Calculation.m**
* **natsort.m**
* **natsortfiles.m**

The last two scripts has been taken from the File Exchange section of Matlab website (link: https://it.mathworks.com/matlabcentral/fileexchange/47434-natural-order-filename-sort).
To run the Global_Aesthetics_general.m function is important to set properly the variables that contains the path of the folders where the human and AI paintings to which we want to apply the methods are saved. 
To run the code without modifying the _Hfolder_ and _AIfolder_ variables, located at the beginning of Global_Aesthetics_general.m, is sufficient to create a folder called "ImageDatabase" containing two sub-folders called "Human" (where human paintings should be saved) and "AI" (where AI paintings should be saved) in the same Matlab workspace where the scripts are placed. 

## Compositional Aesthetics Measures
The main code to run to get the results is contained in **Compositional_Aesthetics_general.m**. This is the main function and provides the graphics of the comparison, between AI and human paintings, of the M_J and M_NCD metrics. To run this code is necessary to have in the same folder where tha main script is placed the following functions:
* **resize_save.m**
* **M_NCD_Calculation.m**
* **M_J_Calculation.m**
* **natsort.m**
* **natsortfiles.m**

The last two scripts has been taken from the File Exchange section of Matlab website (link: https://it.mathworks.com/matlabcentral/fileexchange/47434-natural-order-filename-sort).
To run the Compositional_Aesthetics_general.m function is important to set properly the variables that contains the path of the folders where the human and AI paintings to which we want to apply the methods are saved. 
## Mutual-Information-based Partitioning
The main code to get results is contained in **Mutual_Information_Partitionig_L.m**. This is the main function and provides the graphis of the comparison, betweem AI and human paintings, of the result obtained by applying the Mutual-Information-based Partitiong algorithm. To run this code is necessary to have in the same folder where tha main script is placed the following functions:
* **PartitionAlg_L.m**
* **horzPartitionL.m**
* **vertPartitionL.m**
* **natsort.m**
* **natsortfiles.m**



# Wavelet domain Hidden Markov Trees


