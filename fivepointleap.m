function next = fivepointleap(middle, left, right, up, down, last, exeption)
    if exeption == 0
        next = -2*middle + left + right + up + down - last;
        %2u - u+ - u- = 2nabla
        %u+ = 2u - 2nabla - u-
    end
    if exeption == 1
        next = -middle + right + 1/2*(up + down);
    end
    if exeption == 2
        next = -middle + left + 1/2*(up + down);
    end
    
end

%TODO:
%-----------------
%Make similar functions for other boundary equations
%Allow for different step lengths in the formulas