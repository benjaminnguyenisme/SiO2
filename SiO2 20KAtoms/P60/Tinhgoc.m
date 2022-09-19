function goc=Tinhgoc(a0, a1, a2)

global x y z lx ly lz lx2 ly2 lz2 

    a=KC_rij(a0, a1);   b=KC_rij(a0, a2);  c=KC_rij(a1, a2);            
    goc=(a*a+b*b-c*c)/2/a/b;
        if(goc<-1.0)
            goc=-0.99999;
        end
        if(goc>1.0)
            goc=0.99999;
        end
        
    goc=180*acos(goc)/pi;  

end