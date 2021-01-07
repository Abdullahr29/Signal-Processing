function edge = detect_edges_vectorised(img)
    edge = zeros(size(img, 2));
    edge1 = zeros(size(img, 2));
    edge2 = zeros(size(img, 2));
    v = [1:1:128];
    m = repmat(v,128,1);
    m = img;
    
    
end