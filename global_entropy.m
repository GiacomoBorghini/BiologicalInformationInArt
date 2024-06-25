function [entropy] = global_entropy(PS,ES)
    S1_entropy = 0;

    for i = 1:size(PS,1)
        S1 = squeeze(PS(i,:,:));

        LH_subband = S1(1,2);
        HH_subband = S1(2,2);
        HL_subband = S1(2,1);

        hidden_value = LH_subband * HH_subband * HL_subband;

        hidden_array = calc_hidden_nodes(ES);

        S1_entropy = S1_entropy + (hidden_value) * (log(hidden_value) + recursive_entropy(hidden_array, 2));


    end
    entropy = S1_entropy * -1;
end

function [final_entropy] = recursive_entropy(hidden_array, scale)
    multiplier = 4;

    eIndex = 2*scale - 1;

    e11 = hidden_array(1, eIndex);
    e12 = hidden_array(1, eIndex+1);
    e21 = hidden_array(2, eIndex);
    e22 = hidden_array(2, eIndex+1);

    if (2*(scale+1) - 1 > size(hidden_array,2))
        entropy11 = (multiplier*e11) * log(e11);
        entropy12 = (multiplier*e12) * log(e12);
        entropy21 = (multiplier*e21) * log(e21);
        entropy22 = (multiplier*e22) * log(e22);

        final_entropy = entropy11 + entropy12 + entropy21 + entropy22;
    else
        next_entropy = recursive_entropy(hidden_array, scale+1);

        entropy11 = (multiplier*e11) * (log(e11) + next_entropy);
        entropy12 = (multiplier*e12) * (log(e12) + next_entropy);
        entropy21 = (multiplier*e21) * (log(e21) + next_entropy);
        entropy22 = (multiplier*e22) * (log(e22) + next_entropy);

        final_entropy = entropy11 + entropy12 + entropy21 + entropy22;
    end
end

function [hidden_array] = calc_hidden_nodes(ES)
    hidden_array = [];
    for i = 1:log2(size(ES,3))

        hidden_block = [];

        for j = 1:size(ES,1)
            ES1 = squeeze(ES(j,:,:,:));

            hidden_layer = [];

            for k = 1:size(ES1,1)
                current_ES = squeeze(ES1(k,:,:));

                hidden_layer = [hidden_layer, calc_node_val(current_ES, i)];
            end

            hidden_block = [hidden_block; hidden_layer];

        end

        hidden_array = [hidden_array, hidden_block];

    end
end

function [node_total] = calc_node_val(current_ES, scale)
    LH = current_ES(1, 2^scale);
    HL = current_ES(2^scale, 1);
    HH = current_ES(2^scale, 2^scale);

    node_total = LH * HL * HH;
end