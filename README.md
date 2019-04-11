import io.rbricks.itemized.annotation.enum
# Thesis
##  Selection of a stopping criterion for Anisotropic Diffusion filtering in ultrasound images
Javier Enrique Guillen Ibarra - *Student of mechanical and mechatronic engineering*

This repository contains the codes and algorithm of the implementation of an Anisotropic diffusion filter for Ultrasound images using a stopping criterion.
This stopping criterion is based on the evolution of the relative variance between the estimated denoised image and the original one, and the minimium improvment in *signal-to-noise* ratio (SNR). This algorithm is effective on noise removal without blurring the edges, different quality metrics were evaluated in 25 test images.

The code was implemented for real ultrasound images (DICOM) and simulated images (.jpg/.BMP). Below is a description of each code present here:

@enum trait Codes for real ultrasound images: {
  object diffusion_DICOM.m
  object Examples.m
}

@enum trait Codes for simulated images: {
  object diffusion_SIM.m
  object Examples_SIM.m
}

@enum trait Other functions: {
  object Metrics.m
  object Normalization.m
  object UQI.m
}


Future work includes the validation of the proposed method with a larger database of images, the use of other metrics to evaluate the quality of edges during the process, and the use of the filtering algorithm previous to segmentation of structures to observe how it can improve the results of this task.
