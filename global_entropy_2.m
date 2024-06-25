% PS = Probability Matrix; ES = Transition Matrix
function [entropy] = global_entropy_2(PS,ES)

    buffer = 0.000001;

    entropy = 0;

    % Implementing SUM_m;
    for i = 1:size(PS,1)
        S1 = squeeze(PS(i,:,:));

        LH_subband = S1(1,2) + buffer;
        HH_subband = S1(2,2) + buffer;
        HL_subband = S1(2,1) + buffer;

        % Implementing Transition Matrix SUMs, starting at scale=2
        next_layer_entropy = recursive_entropy(ES, 2, i, buffer);

        % Implementing p_0^m * (log(p_0^m) + SUMs


        % % % % entropy = entropy + ...
        % % % %          (LH_subband * (log(LH_subband) + next_layer_entropy)...
        % % % %          * HH_subband * (log(HH_subband) + next_layer_entropy)...
        % % % %          * HL_subband * (log(HL_subband) + next_layer_entropy));
        

        % total_value = (LH_subband + HH_subband + HL_subband) /3;
        total_value = LH_subband * HH_subband * HL_subband;

        entropy = entropy + (total_value * (log(total_value) + next_layer_entropy));

    end
    % Implementing -(SUM)
    entropy = entropy * -1;
end

% ES = Transition Matrix; scale = subband level; node = previous SUM's value (if scale=2, node=m)
function [entropy] = recursive_entropy(ES, scale, node, buffer)

    multiplier = 1;

    entropy = 0;

    % Implementing e^m for scale=2
    ES_node_group = squeeze(ES(node,:,:,:));

    % Implementing SUM(e^n) for scale=2
    for i = 1:size(ES_node_group,1)

        % ES_curret = e^mn
        ES_current = squeeze(ES_node_group(i,:,:));

        next_layer_entropy = 0;
        % Recurs until reading frame (2^scale+1)-1 is out of bounds of ES
        if (2^(scale+1) - 1 < size(ES_current,1))
            next_layer_entropy = recursive_entropy(ES,scale+1,i, buffer);
        end

        % Implements e_i, where i is the scale-1 (e_1 for scale=2, e_2 for scale=3, etc.)
        LH_subband = ES_current(1,2^scale) + buffer;
        HH_subband = ES_current(2^scale,2^scale) + buffer;
        HL_subband = ES_current(2^scale,1) + buffer;

        % total_value = (LH_subband + HH_subband + HL_subband) /3;
        total_value = LH_subband * HH_subband * HL_subband;

        % Implements 2*e_i^mn * (log(2*e_i^mn) + SUM_scale+1)
        % Instead of 2, multiplier=4 because there are four children for each hidden node instead of two


        % % % % entropy = entropy + (multiplier * (...
        % % % %         LH_subband * (log(LH_subband) + next_layer_entropy) *...
        % % % %         HH_subband * (log(HH_subband) + next_layer_entropy) *...
        % % % %         HL_subband * (log(HL_subband) + next_layer_entropy) ...
        % % % %         ));

        entropy = entropy + (multiplier * total_value * (log(total_value) + next_layer_entropy));


    end
end