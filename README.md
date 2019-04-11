# Thesis
##  Selection of a stopping criterion for Anisotropic Diffusion filtering in ultrasound images
Javier Enrique Guillen Ibarra - *Student of mechanical and mechatronic engineering*

This repository contains the codes and algorithm of the implementation of an Anisotropic diffusion filter for Ultrasound images using a stopping criterion.
This stopping criterion is based on the evolution of the relative variance between the estimated denoised image and the original one, and the minimium improvment in *signal-to-noise* ratio (SNR). This algorithm is effective on noise removal without blurring the edges, different quality metrics were evaluated in 25 test images.

The algorithm has several versions, where you can use two different templates, one of 4 neighboring pixels and one of 12 pixels. In the same way you can choose the number of iterations you want to process, the default filter uses its automated version.

The code was implemented for real ultrasound images (DICOM) and simulated images (.jpg/.BMP). Below is a description of each code present here:

## Codes for real ultrasound images:
* diffusion_DICOM.m: Main function 
* Examples.m: Code with different test of the algorithm

## Codes for real ultrasound images:
* diffusion_SIM.m: Main function
* Examples_SIM.m: Code with different tests of the algorithm 

## Other functions:
* Metrics.m: Function to calculate the quality merics
* Normalization.m: Function to normalize the image
* UQI.m: Function for calculating the universal quality index

Future work includes the validation of the proposed method with a larger database of images, the use of other metrics to evaluate the quality of edges during the process, and the use of the filtering algorithm previous to segmentation of structures to observe how it can improve the results of this task.
