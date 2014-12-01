function [ solved_case ] = Reuse( calculated_case, novel_case )
    novel_case.solution = calculated_case.solution;
    solved_case = novel_case;
end

