Result1 = zeros(1,2);
Result2 = zeros(1,2);
Result3 = zeros(1,2);
Result4 = zeros(1,2);

for i = 1:43347
    EDA = sqrt(sum((d(i,:)-MeanA(1,:)).^2));
    EDN = sqrt(sum((d(i,:)-MeanN(1,:)).^2));
    if EDA <= EDN
        Result1(1,1) = Result1(1,1) + 1;    % Active compounds.
    else
        Result1(1,2) = Result1(1,2) + 1;    % Non-Active compounds.
    end
end

for i = 1:43347
    MDA = sqrt(sum(((d(i,:)-MeanA(1,:))./StdevA(1,:)).^2));
    MDN = sqrt(sum(((d(i,:)-MeanN(1,:))./StdevN(1,:)).^2));
    if MDA <= MDN
        Result2(1,1) = Result2(1,1) + 1;    % Active compounds.
    else
        Result2(1,2) = Result2(1,2) + 1;    % Non-Active compounds.
    end
end

for i = 1:43347
    Active = 0;
    NonActive = 0;
    for j = 1:16 
        P3 = sqrt((d(i,j)-MeanA(1,j)).^2);
        Q3 = sqrt((d(i,j)-MeanN(1,j)).^2);
        if P3 <= Q3
            Active = Active + 1;
        else
            NonActive = NonActive + 1;
        end
    end
    if Active >= NonActive
        Result3(1,1) = Result3(1,1) + 1;    % Active compounds.
    else
        Result3(1,2) = Result3(1,2) + 1;    % Non-Active compounds.
    end
end

for i = 1:43347
    Active = 0;
    NonActive = 0;
    for j = 1:16 
        P4 = sqrt(((d(i,j)-MeanA(1,j))./StdevA).^2);
        Q4 = sqrt(((d(i,j)-MeanN(1,j))./StdevA).^2);
        if P4 <= Q4
            Active = Active + 1;
        else
            NonActive = NonActive + 1;
        end
    end
    if Active >= NonActive
        Result4(1,1) = Result4(1,1) + 1;    % Active compounds.
    else
        Result4(1,2) = Result4(1,2) + 1;    % Non-Active compounds.
    end
end
