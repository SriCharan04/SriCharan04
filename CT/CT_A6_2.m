%assn6b

%using roots method to solve the equation p
parray = [1 0 0 -1];
rootsofp = roots(parray);

%using fzero and fsolve to solve the equation
%without options
[x f ex op] = fzero(@p,0);
it_fzero = 8; 
Solution3.xfinal = x;
Solution3.ffinal = f;
Solution3.exitflag = ex;
Solution3.iter = it_fzero;

[x f ex op jac] = fsolve(@p,0);
it_fsolve = 1;
Solution4.xfinal = x;
Solution4.ffinal = f;
Solution4.exitflag = ex;
Solution4.iter = it_fsolve;

%with options
options = optimset('TolFun',1e-2,'TolX',1e-2);
%fzero
[x f ex op] = fzero(@p,0,options);
it_fzero = 4;  %found through the options

[x f ex op jac] = fsolve(@p,0,options);
it_fsolve = 1;

%saving in the structure array
Solution1.xfinal = x;
Solution1.ffinal = f;
Solution1.exitflag = ex;
Solution1.iter = it_fzero;

function y = p(x)
    y = x^3-1;
end

