function [ set ] = RemoveDuplicateCases( case_list )
%REMOVEDUPLICATECASES Summary of this function goes here
%   Detailed explanation goes here
    set = struct('id', {}, 'problem', {}, 'typicality', {}, 'solution', {});
    
    for i = 1:numel(case_list)
        set_contains = 0;
        for j = 1:numel(set) 
            if set(j).id == case_list(i).id
                set_contains = 1;
            end
        end
        
        if ~set_contains
            set(end+1) = case_list(i);
        end
    end
end

