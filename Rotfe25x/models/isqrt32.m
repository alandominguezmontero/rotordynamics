function [n,ni]=isqrt32(R2) 
%
    %if (0 =%= R2),
    n=int16(0),
    %return ; %  // Avoid zero divide
    %end
    
      n = (  R2 / 2) + 1;       %// Initial estimate, never low
      ni(1)=n;
      n1 = (n + (  R2 / n)) / 2;
      p=1;
    while (n1 < n) 
        p=p+1;
        n = n1;
        ni(p)=n;
        n1 = (n + (  R2 / n)) / 2;
    end             %// end while
  n = int16(n);