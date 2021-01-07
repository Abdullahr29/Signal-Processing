function rot = rotate_image(img, theta)
    rot = zeros(size(img, 2));
    b = size(img, 2);
    for i = 1:b
        for j = 1:b
            temp = [cos(-theta), sin(-theta);-sin(-theta), cos(-theta)];
            rota = (inv(temp))*([i;j]-[b/2;b/2])+[b/2;b/2];
            x = int8(rota(1));
            y = int8(rota(2));
            if x>=1&&y>=1&&x<=b&&y<=b
                rot(i,j)=img(x,y);
            end    
        end
    end
    
end 