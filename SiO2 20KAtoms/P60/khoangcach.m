function kc=khoangcach(x1, y1, z1, x2, y2, z2, lx, ly, lz)
rx=abs(x1-x2);if(rx>lx/2)rx=rx-lx;end
ry=abs(y1-y2);if(ry>ly/2)ry=ry-ly;end
rz=abs(z1-z2);if(rz>lz/2)rz=rz-lz;end
kc=sqrt(rx^2+ry^2+rz^2);
end