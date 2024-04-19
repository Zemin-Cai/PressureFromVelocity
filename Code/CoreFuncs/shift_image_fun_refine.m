function [Im1_shift,uxI,uyI]=shift_image_fun_refine(ux,uy,Im1,Im2,cut_value)

% ux and uy are the initial velocity fields in pixels/unit time in coarse image
% Im1 and Im2 are finer images at the times 1 and 2
% uxI and uyI are the interpolated velocity fields in pixels/unit time in finer image
% cut_vaule is the value of displacement between uses of the direct shift
% method and optical flow shift method (such as 5 pixels) 
% Im1_shite is the shifted image from Im1 based on uxI and uyI


[m0,n0]=size(ux);
% normalized size of coarse image
x0_normalized=[1:n0]/n0;
y0_normalized=[1:m0]/m0;
[X,Y] = meshgrid(x0_normalized,y0_normalized);

[m1,n1]=size(Im1);
% normalized size of finer image
x1_normalized=[1:n1]/n1;
y1_normalized=[1:m1]/m1;

% obtain interpolated velocity field in the finer image
[XI,YI] = meshgrid(x1_normalized,y1_normalized);
uxI = (n1/n0)*interp2(X,Y,ux,XI,YI); % pixels/unit time in finer image
uyI = (m1/m0)*interp2(X,Y,uy,XI,YI); % pixels/unit time in finer image

% generate a shifted image from Im1 based on the velocity field that is rounded
dx=1;
dy=1;

Im1_shift0=Im2;
for i=1:m1
    for j=1:n1
        i_shift=i+round(uyI(i,j));
        j_shift=j+round(uxI(i,j));
        u_mag=(uxI(i,j)^2+uyI(i,j)^2)^0.5;
        if (i_shift<=m1) && (i_shift >=1) && (j_shift<=n1) && (j_shift>=1) && (u_mag>cut_value)
            Im1_shift0(i_shift,j_shift)=Im1(i,j);
        elseif (u_mag<=cut_value) && (i<(m1-2) && (j<(n1-2)))
          ii=i+1;
          jj=j+1;   
          term1=uxI(ii,jj)*(Im1(ii,jj+dx)-Im1(ii,jj))/dx+uyI(ii,jj)*(Im1(ii+dy,jj)-Im1(ii,jj))/dy;
          term2=Im1(ii,jj)*(uxI(ii,jj+dx)-uxI(ii,jj))/dx+Im1(ii,jj)*(uyI(ii+dy,jj)-uyI(ii,jj))/dy;   
          Im1_shift0(ii,jj)=Im1(ii,jj)-term1-term2;             
        else
            Im1_shift0(i,j)=Im1(i,j);
        end
    end
end

Im1_shift=uint8(Im1_shift0);





