function [T] = RHS_Vec(Pressure_Field, mx, my, alpha, phi_m, h)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Construting the right hand size vector whose size is
% [(height-2)*(width-2),1]
%
% 05.10.2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[height, width] = size(Pressure_Field);
T = zeros((height-2)*(width-2), 1);
A = mx.^2 + alpha;
B = mx.*my;
C = my.^2 + alpha;
for j = 1:1:(height-2)
    for i = 1:1:(width-2)
        if((i==1) && (j==1))
            T((i-1)*(height-2)+j) = 0.5*B(j,i)*Pressure_Field(j,i) + A(j,i)*h^(-2)*Pressure_Field(j+1,i) - 0.5*B(j,i)*Pressure_Field(j+2, i) + C(j,i)*h^(-2)*Pressure_Field(j, i+1) - 0.5*B(j,i)*Pressure_Field(j, i+2) - 0.5/h*mx(j,i)*(phi_m(j+1,i+2)-phi_m(j+1,i)) - 0.5/h*my(j,i)*(phi_m(j+2,i+1)-phi_m(j,i+1));
        else
            if(i==(width-2) && j==(height-2))
                T((i-1)*(height-2)+j) = -0.5*B(j,i)*Pressure_Field(j,i+2) + A(j,i)*h^(-2)*Pressure_Field(j+1,i+2) + 0.5*B(j,i)*Pressure_Field(j+2, i+2) + C(j,i)*h^(-2)*Pressure_Field(j+2, i+1) - 0.5*B(j,i)*Pressure_Field(j+2, i) - 0.5/h*mx(j,i)*(phi_m(j+1,i+2)-phi_m(j+1,i)) - 0.5/h*my(j,i)*(phi_m(j+2,i+1)-phi_m(j,i+1));
            else
                if(i==1 && j==(height-2))
                    T((i-1)*(height-2)+j) = 0.5*B(j,i)*Pressure_Field(j,i) + A(j,i)*h^(-2)*Pressure_Field(j+1,i) - 0.5*B(j,i)*Pressure_Field(j+2, i) + C(j,i)*h^(-2)*Pressure_Field(j+2, i+1) + 0.5*B(j,i)*Pressure_Field(j+2, i+2) - 0.5/h*mx(j,i)*(phi_m(j+1,i+2)-phi_m(j+1,i)) - 0.5/h*my(j,i)*(phi_m(j+2,i+1)-phi_m(j,i+1));
                else
                    if(i==(width-2) && j==1)
                        T((i-1)*(height-2)+j) = 0.5*B(j,i)*Pressure_Field(j,i) + C(j,i)*h^(-2)*Pressure_Field(j,i+1) - 0.5*B(j,i)*Pressure_Field(j, i+2) + A(j,i)*h^(-2)*Pressure_Field(j+1, i+2) + 0.5*B(j,i)*Pressure_Field(j+2, i+2) - 0.5/h*mx(j,i)*(phi_m(j+1,i+2)-phi_m(j+1,i)) - 0.5/h*my(j,i)*(phi_m(j+2,i+1)-phi_m(j,i+1));
                    else
                        if(i==1 && j>1 && j<(height-2))
                            T((i-1)*(height-2)+j) = 0.5*B(j,i)*Pressure_Field(j,i) + A(j,i)*h^(-2)*Pressure_Field(j+1,i) - 0.5*B(j,i)*Pressure_Field(j+2, i) - 0.5/h*mx(j,i)*(phi_m(j+1,i+2)-phi_m(j+1,i)) - 0.5/h*my(j,i)*(phi_m(j+2,i+1)-phi_m(j,i+1));
                        else
                            if(i==(width-2) && j>1 && j<(height-2))
                                T((i-1)*(height-2)+j) = -0.5*B(j,i)*Pressure_Field(j,i+2) + A(j,i)*h^(-2)*Pressure_Field(j+1,i+2) + 0.5*B(j,i)*Pressure_Field(j+2, i+2) - 0.5/h*mx(j,i)*(phi_m(j+1,i+2)-phi_m(j+1,i)) - 0.5/h*my(j,i)*(phi_m(j+2,i+1)-phi_m(j,i+1));
                            else
                                if(j==1 && i>1 && i<(width-2))
                                    T((i-1)*(height-2)+j) = 0.5*B(j,i)*Pressure_Field(j,i) + C(j,i)*h^(-2)*Pressure_Field(j,i+1) - 0.5*B(j,i)*Pressure_Field(j, i+2) - 0.5/h*mx(j,i)*(phi_m(j+1,i+2)-phi_m(j+1,i)) - 0.5/h*my(j,i)*(phi_m(j+2,i+1)-phi_m(j,i+1));
                                else
                                    if(j==(height-2) && i>1 && i<(width-2))
                                        T((i-1)*(height-2)+j) = -0.5*B(j,i)*Pressure_Field(j+2,i) + C(j,i)*h^(-2)*Pressure_Field(j+2,i+1) + 0.5*B(j,i)*Pressure_Field(j+2, i+2) - 0.5/h*mx(j,i)*(phi_m(j+1,i+2)-phi_m(j+1,i)) - 0.5/h*my(j,i)*(phi_m(j+2,i+1)-phi_m(j,i+1));
                                    else
                                        T((i-1)*(height-2)+j) = - 0.5/h*mx(j,i)*(phi_m(j+1,i+2)-phi_m(j+1,i)) - 0.5/h*my(j,i)*(phi_m(j+2,i+1)-phi_m(j,i+1));
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end