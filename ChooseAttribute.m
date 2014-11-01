
    function best_attribute = ChooseAttribute(examples, attributes, targets)

        p = sum(targets);
        n = numel(targets) - p;

        current_best_igain = igain(attributes(1),p,n,examples,targets);
        current_best_attribute = attributes(1);

        for idx = 2:numel(attributes)
            current_igain = igain(attributes(idx),p,n,examples,targets);

            if current_best_igain < current_igain
                current_best_attribute = attributes(idx);
            end
        end

        best_attribute = current_best_attribute;
    end
    
    
    function ig = information_gain(p,n)
       ig = - (p/(p+n)) * log2(p/(p+n)) - (n/(p+n)) * log2(n/(p+n));
    end

    function rem = remainder(attribute,p,n,examples,targets)

       p0 = 0;
       n0 = 0;
       p1 = 0;
       n1 = 0;
       
       for idx = 1:numel(targets)
           if targets(idx) == 1
               if examples(idx,attribute) == 0
                   %Example positive, attribute is 0
                   p0 = p0 + 1;
               else
                   %Example positive, attribute is 1
                   p1 = p1 +1;
               end
           else
               if examples(idx,attribute) == 0
                   %Example negative, attribute is 0
                   n0 = n0 + 1;
               else
                   %Example negative, attribute is 1
                   n1 = n1 +1;
               end
           end
       end
       
       rem = ((p0+n0)/(p+n))* information_gain(p0,n0) + ((p1+n1)/(p+n))* information_gain(p1,n1);
       
    end

    function gain = igain(attribute,p,n,examples,targets)
        gain = information_gain(p,n) - remainder(attribute,p,n,examples,targets);
    end

    
        
    