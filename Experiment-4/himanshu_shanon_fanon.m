% Created on 17/02/25
% Created by Himanshu Joshi, BT22ECE108
% Practical 4: Shanon Fanon code.
function [codes, codewords] = Experiment_4()
    clc;
    clear;
    close all;
    
    symbols = ['A', 'B', 'C', 'D', 'E'];
    probabilities = [0.2, 0.05, 0.5, 0.2, 0.05];
    
    if sum(probabilities) ~= 1
        probabilities = probabilities / sum(probabilities);
    end
    
    n = length(symbols);
    elements = cell(n, 2);
    for i = 1:n
        elements{i, 1} = symbols(i);
        elements{i, 2} = probabilities(i);
    end
    
    elements = sortrows(elements, -2);

    [codes, codewords] = create_codes(elements, '');
    
    fprintf('Shannon-Fano Codes:\n');
    for i = 1:length(codes)
        fprintf('Symbol: %s, Code: %s\n', codes{i}, codewords{i});
    end
end

function [symbols, encodings] = create_codes(elements, current_code)
    
    num_elements = size(elements, 1);
    
    if num_elements == 1
        symbols = {elements{1, 1}};
        encodings = {current_code};
        return;
    end
    
    cumulative_distribution = cumsum([elements{:, 2}]);
    split_point = find(cumulative_distribution >= cumulative_distribution(end) / 2, 1);
    
    left_part = elements(1:split_point, :);
    right_part = elements(split_point+1:end, :);
    
    [left_symbols, left_encodings] = create_codes(left_part, [current_code '0']);
    [right_symbols, right_encodings] = create_codes(right_part, [current_code '1']);
    
    symbols = [left_symbols, right_symbols];
    encodings = [left_encodings, right_encodings];
end
