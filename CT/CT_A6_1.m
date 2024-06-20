%assn6a

%finding the values at the x array x = [0 1 3]
value1 = p1([0 1 3])
value2 = p2([0 1 3])
value3 = p3([0 1 3])

%finding the roots of the polynomials
%p1
parray1 = [4.5 4.5 0 0 0 4];

%p2
parray2 = [6 -12 0 10];

%p3
parray3 = [1 -6 11 -6];

%finding roots using roots method
r1 = roots(parray1)
r2 = roots(parray2)
r3 = roots(parray3)

%function definitions of p1, p2, and p3 following
function y1 = p1(x)
    y1 = (4.5.*x.*x.*x.*x.*x)+(4.5.*x.*x.*x.*x)-4;
end

function y2 = p2(x)
    y2 = (6.*x.*x.*x)-(12.*x.*x)+10;
end

function y1 = p3(x)
    y1 = (x-1).*(x-2).*(x-3);
end
