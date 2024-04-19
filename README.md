# Pressure from Velocity

This repository contains Malab functions for extraction of pressure from velocity data. This method is based on a variational formulation with a smoothness constraint for extraction of pressure from two-dimensional velocity field.  
The Euler–Lagrange equation is obtained to determine a pressure field from velocity data in a domain with suitable boundary conditions.   
Numerical algorithms are developed to solve the Euler–Lagrange equation with suitable boundary conditions.   
The method is evaluated on a simulated two-dimensional oblique Hiemenz flow.   
In an experimental case, pressure fields near a freely flying hawkmoth are estimated from high-resolution velocity fields that are obtained by applying the optical flow method to high-speed Schlieren photography images.

## Quick test
Run Velocity2Pressure in MATLAB.    

## Modifying the code
-- You can edit Velocity2Pressure.m to process your own image sequences which are stored in the ‘Data’ folder in advance.  
-- The 2D velocity filed was calculated using the physics-based optical flow method, which is implemented in OpticalFlowPhysics_fun.m.  
-- The calculated velocity field and pressure from the velocity field are stored in the ‘Results’ folder.  

## Note
If you need the flow files or image sequences of simulation and experiments introduced in Chapter 8 of our book "Inverse Problems in Global Flow Diagnostics", please contact us.  

## Contact
Issues, comments and questions, please contact Tianshu Liu(tianshu.liu@wmich.edu) or Zemin Cai(zmcai@stu.edu.cn)   

Any scientific work that makes use of our code should appropriately mention this in the text and cite our papers in EiF and JCAM (see below).  

@article{Cai2020,  
author = {Cai, Zemin and Liu, Yun and Chen, Tao and Liu, Tianshu},  
year = {2020},  
month = {04},  
pages = {},  
title = {Variational method for determining pressure from velocity in two dimensions},  
volume = {61},  
journal = {Experiments in Fluids},  
doi = {10.1007/s00348-020-02954-2}  
}  
  
@article{WANG201562,  
title = {An analysis of physics-based optical flow},  
journal = {Journal of Computational and Applied Mathematics},  
volume = {276},  
pages = {62-80},  
year = {2015},  
doi = {https://doi.org/10.1016/j.cam.2014.08.020},  
author = {Bo Wang and Zemin Cai and Lixin Shen and Tianshu Liu},  
}  
