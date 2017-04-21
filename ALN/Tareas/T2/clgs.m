function [Q,R] = clgs(A) % Gram-Schmidt Clasico
  n=length(A);
  for j=1:n,
     vj= A(:,j);
    sum = 0;
    for i=1:j-1,
        R(i,j) = Q (:,i)'*A(:,j);
        sum= sum + R(i,j)*Q(:,i);
    end
    vj  = vj - sum;
    R(j,j) = norm(vj);
    Q(:,j) = vj/R(j,j); 	
  end
end
