Result1a = zeros(16,2);
Result2a = zeros(16,2);
Result3a = zeros(16,2);
Result4a = zeros(16,2);

Result1b = zeros(16,2);
Result2b = zeros(16,2);
Result3b = zeros(16,2);
Result4b = zeros(16,2);

Ratio1 = zeros(16,1);
Ratio2 = zeros(16,1);
Ratio3 = zeros(16,1);
Ratio4 = zeros(16,1);

for int=1:16
    tmpactive = active;
    tmpNonActive = NonActive;
    tmpMeanA = MeanA;
    tmpMeanN = MeanN;
    tmpStdevA = StdevA;
    tmpStdevN = StdevN;
    
    tmpactive(:,int) = []; % Removes one column from each to see which column is a problem
    tmpNonActive(:,int) = [];
    tmpMeanA(:,int) = [];
    tmpMeanN(:,int) = [];
    tmpStdevA(:,int) = [];
    tmpStdevN(:,int) = [];
    
    for i = 1:1347
        EDA = sqrt(sum((tmpactive(i,:)-tmpMeanA(1,:)).^2));
        EDN = sqrt(sum((tmpactive(i,:)-tmpMeanN(1,:)).^2));
        if EDA <= EDN
            Result1a(int,1) = Result1a(int,1) + 1;    % Active compounds.
        else
            Result1a(int,2) = Result1a(int,2) + 1;    % Non-Active compounds.
        end
    end

    for i = 1:1347
        MDA = sqrt(sum(((tmpactive(i,:)-tmpMeanA(1,:))./tmpStdevA(1,:)).^2));
        MDN = sqrt(sum(((tmpactive(i,:)-tmpMeanN(1,:))./tmpStdevN(1,:)).^2));
        if MDA <= MDN
            Result2a(int,1) = Result2a(int,1) + 1;    % Active compounds.
        else
            Result2a(int,2) = Result2a(int,2) + 1;    % Non-Active compounds.
        end
    end

    for i = 1:1347
        Active3 = 0;
        NonActive3 = 0;
        for j = 1:15 
            P3 = sqrt((tmpactive(i,j)-tmpMeanA(1,j))^2);
            Q3 = sqrt((tmpactive(i,j)-tmpMeanN(1,j))^2);
            if P3 <= Q3
                Active3 = Active3 + 1;
            else
                NonActive3 = NonActive3 + 1;
            end
        end
        if Active3 >= NonActive3
            Result3a(int,1) = Result3a(int,1) + 1;    % Active compounds.
        else
            Result3a(int,2) = Result3a(int,2) + 1;    % Non-Active compounds.
        end
    end

    for i = 1:1347
        Active4 = 0;
        NonActive4 = 0;
        for j = 1:15 
            P4 = sqrt(((tmpactive(i,j)-tmpMeanA(1,j))/tmpStdevA(1,j))^2);
            Q4 = sqrt(((tmpactive(i,j)-tmpMeanN(1,j))/tmpStdevN(1,j))^2);
            if P4 <= Q4
                Active4 = Active4 + 1;
            else
                NonActive4 = NonActive4 + 1;
            end
        end
        if Active4 >= NonActive4
            Result4a(int,1) = Result4a(int,1) + 1;    % Active compounds.
        else
            Result4a(int,2) = Result4a(int,2) + 1;    % Non-Active compounds.
        end
    end

    %% Non-Active Set

    for i = 1:42000
        EDA = sqrt(sum((tmpNonActive(i,:)-tmpMeanA(1,:)).^2));
        EDN = sqrt(sum((tmpNonActive(i,:)-tmpMeanN(1,:)).^2));
        if EDA <= EDN
            Result1b(int,1) = Result1b(int,1) + 1;    % Active compounds.
        else
            Result1b(int,2) = Result1b(int,2) + 1;    % Non-Active compounds.
        end
    end

    for i = 1:42000
        MDA = sqrt(sum(((tmpNonActive(i,:)-tmpMeanA(1,:))./tmpStdevA(1,:)).^2));
        MDN = sqrt(sum(((tmpNonActive(i,:)-tmpMeanN(1,:))./tmpStdevN(1,:)).^2));
        if MDA <= MDN
            Result2b(int,1) = Result2b(int,1) + 1;    % Active compounds.
        else
            Result2b(int,2) = Result2b(int,2) + 1;    % Non-Active compounds.
        end
    end

    for i = 1:42000
        Active3 = 0;
        NonActive3 = 0;
        for j = 1:15 
            P3 = sqrt((tmpNonActive(i,j)-tmpMeanA(1,j))^2);
            Q3 = sqrt((tmpNonActive(i,j)-tmpMeanN(1,j))^2);
            if P3 <= Q3
                Active3 = Active3 + 1;
            else
                NonActive3 = NonActive3 + 1;
            end
        end
        if Active3 >= NonActive3
            Result3b(int,1) = Result3b(int,1) + 1;    % Active compounds.
        else
            Result3b(int,2) = Result3b(int,2) + 1;    % Non-Active compounds.
        end
    end

    for i = 1:42000
        Active4 = 0;
        NonActive4 = 0;
        for j = 1:15 
            P4 = sqrt(((tmpNonActive(i,j)-tmpMeanA(1,j))/tmpStdevA(1,j))^2);
            Q4 = sqrt(((tmpNonActive(i,j)-tmpMeanN(1,j))/tmpStdevN(1,j))^2);
            if P4 <= Q4
                Active4 = Active4 + 1;
            else
                NonActive4 = NonActive4 + 1;
            end
        end
        if Active4 >= NonActive4
            Result4b(int,1) = Result4b(int,1) + 1;    % Active compounds.
        else
            Result4b(int,2) = Result4b(int,2) + 1;    % Non-Active compounds.
        end
    end
    
    %% Ratios
    
    Ratio1(int) = Result1a(int,1)/Result1b(int,1);
    Ratio2(int) = Result2a(int,1)/Result2b(int,1);
    Ratio3(int) = Result3a(int,1)/Result3b(int,1);
    Ratio4(int) = Result4a(int,1)/Result4b(int,1);
end

A = zeros(5,2);
B = zeros(5,2);
C = zeros(5,2);
D = zeros(5,2);

Ratioa = Ratio1;
Ratiob = Ratio2;
Ratioc = Ratio3;
Ratiod = Ratio4;

for i = 1:5
    [Ma,Ia] = min(Ratioa);
    Ratioa(Ia) = max(Ratioa);
    A(i,1) = Ia;
    A(i,2) = Ma;
    
    [Mb,Ib] = min(Ratiob);
    Ratiob(Ib) = max(Ratiob);
    B(i,1) = Ib;
    B(i,2) = Mb;
    
    [Mc,Ic] = min(Ratioc);
    Ratioc(Ic) = max(Ratioc);
    C(i,1) = Ic;
    C(i,2) = Mc;
    
    [Md,Id] = min(Ratiod);
    Ratiod(Id) = max(Ratiod);
    D(i,1) = Id;
    D(i,2) = Md;
end

%[16,15,12,7,5];