function [ case_struct ] = assignCase( x, label  )

% if cbr_system.HasCase(x)
%   case = cbr_system.GetCase(x)
%   case.typicality++
%   return case
% else 
%   case = new Case(x, label)
%   cbr_system.AddCase(case)
%   return case

case_struct.problem = x;
if (label== 0)
    case_struct.typicality = 0; % if there is no label, typicality is zero
end
case_struct.typicality = 1;
case_struct.solution = label;


end

