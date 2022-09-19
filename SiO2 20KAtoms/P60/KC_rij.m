function  rij=KC_rij(i, j)
global x y z lx ly lz lx2 ly2 lz2
	rx=abs(x(i)-x(j));if(rx>lx2)rx=rx-lx;end
	ry=abs(y(i)-y(j));if(ry>ly2)ry=ry-ly;end
	rz=abs(z(i)-z(j));if(rz>lz2)rz=rz-lz; end
	rij= sqrt(rx*rx+ry*ry+rz*rz);
end
