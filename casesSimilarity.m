function [ similarity ] = casesSimilarity( a, b, measure )

if( measure.STRCMP('length') )
   similarity = max(a.length,b.length) / min(a.length,b.length)
    
elseif( measure.STRCMP('matchAU') )
    % matching_AUs / avg_vec_length
    similarity = intersect(a,b).length / ( (a.length + b.length) / 2)
else
    % matching_AUs / total_AUs
    similarity = intersect(a,b).length / union(a,b).length
end