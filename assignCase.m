function [ case_struct ] = assignCase( x, label  )

case_struct.problem = x;

if (label== 0)
    case_struct.typicality = 0; % if there is no label, typicality is zero
end

case_struct.typicality = 1;
case_struct.solution = label;

end

