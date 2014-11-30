function [ solvedcase ] = reuse( case_struct, newcase )
    newcase.solution = case_struct.solution;
    solvedcase = newcase;
end

