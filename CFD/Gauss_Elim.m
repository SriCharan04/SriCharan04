%Gausssian Elimination
A = [1 2 3 4;5 6 7 8;9 10 11 12;13 14 15 16]
size(A,2)
count = 1
for i = count:1%size(A,1)-1
    B = scale(A)
    B = row_pivot(B)
    pivot = B(i,i);
    for j = i+1:size(B,1)-1
        row_rep = B(i,j)
        B(i,j) = B(i,j) - (row_rep/pivot)*B(i,1)
    end
    B = B(i+1:end,i+1:end)
    count = count + 1
end

function mat = scale(matrix)
    for i = 1:size(matrix,1)
        scale_factor = max(matrix(i,:));
        mat(i,:) = matrix(i,:)/scale_factor; 
    end
end

function mat = row_pivot(matrix)
    for i = 1:size(matrix,1)
        [matri,I] = max(matrix(i:end,i));
        mat(i,:) = matrix(I,:);
    end
end