function [ similarity ] = casesSimilarity( a, b, measure )

if( measure.STRCMP('length') )
   similarity = max(a.length,b.length) / min(a.length,b.length)
    
elseif( measure.STRCMP('matchAU') )
    % matching_AUs / avg_vec_length
    
else
    % matching_AUs / total_AUs
end

