function H = lpfilterTF(type, P, Q, param)

switch type
    case 'ideal'
        D0 = param;
        H = ones(P, Q);
        for u = 1:P
            for v = 1:Q
                D = sqrt((u - P/2).^2 + (v - Q/2).^2);
                if (D <= D0)
                    H(u, v) = 1;
                else
                    H(u,v) = 0;
                end
            end
        end
    case 'gaussian'
        D0 = param;
        H = ones(P, Q);
        for u = 1:P
            for v = 1:Q
                D = sqrt((u - P/2).^2 + (v - Q/2).^2);
                H(u,v) = exp(-(D.^2)/(2.*(D0.^2)));
            end
        end
    case 'butterworth'
        D0 = param(1, 1);
        n = param(1, 2);
        H = ones(P, Q);
        for u = 1:P
            for v = 1:Q
                D = sqrt((u - P/2).^2 + (v - Q/2).^2);
                H(u,v) = 1/(1 + (D/D0).^(2*n));        
            end
        end
    otherwise
        disp('Not a supported function. Please use "ideal", "gaussian", or "butterworth"')
        H = zeros(P, Q);
        return;
end