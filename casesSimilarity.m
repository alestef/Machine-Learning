function [ similarity ] = casesSimilarity( a, b, measure )

if( measure.STRCMP('length') ) %euclidean distance(L2-norm)
   vector1 = zeros(1,45);
   vector2 = zeros(1,45);
   
   for i=1:length(a.problem)
    vector1(a.problem(i)) = 1;
   end
   
   for i=1:length(b.problem)
    vector2(b.problem(i)) = 1;
   end
   
   sum = 0;
    
   for i=1:45
    sum = sum + ( vector1(i)-vector2(i) )^2;
   end
   
   similarity = sqrt(sum);  
   
elseif( measure.STRCMP('matchAU') )
    % matching_AUs / avg_vec_length
    similarity = intersect(a.problem,b.problem).length / ( (a.problem.length + b.problem.length) / 2)
else %City-block(Manhattan) distance(L1-norm)
   vector1 = zeros(1,45);
   vector2 = zeros(1,45);

   for i=1:length(a.problem)
    vector1(a.problem(i)) = 1;
   end
   
   for i=1:length(b.problem)
    vector2(b.problem(i)) = 1;
   end

   sum = 0;
    
   for i=1:45
    sum = sum + abs(vector1(i)-vector2(i));
   end
   
   similarity = sum;  
end