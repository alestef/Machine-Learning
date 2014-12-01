function [ case_struct ] = assignCase( x, label  )
persistent CUR_ID;

if isempty(CUR_ID)
    CUR_ID = 1;
end

case_struct.id = CUR_ID;
case_struct.problem = x;

if (label == 0)
    case_struct.typicality = 0; % if there is no label, typicality is zero
end

case_struct.typicality = 1;
case_struct.solution = label;

CUR_ID = CUR_ID + 1;
end

