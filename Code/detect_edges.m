 function edge = detect_edges(img)
    edge = zeros(size(img, 2));
    edge1 = zeros(size(img, 2));
    edge2 = zeros(size(img, 2));
    b = size(img, 2);
    for i = 1:b-1
        for j = 1:b
            edge1(i,j)=abs(img(i,j)-img(i+1,j));
        end
    end
    for i = 1:b
        for j = 1:b-1
            edge2(i,j)=abs(img(i,j)-img(i,j+1));
        end
    end
    for i = 1:b
        for j = 1:b
            edge(i,j)=(edge1(i,j)+edge2(i,j))/2;
        end
    end
end 