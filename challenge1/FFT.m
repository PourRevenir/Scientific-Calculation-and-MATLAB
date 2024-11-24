%% FFT author: Ryan Black
%% optimizes any prime or composite signal
%% define signal
function [Y] = FFT(y,typef)
    N = length(y);                               %signal length
    %% define tree structure
    bl = factor(N);                              %branches/node
    if N <= 3                                    %just do a naive DFT
        Y = DFT(y,N,typef);                      
    elseif length(bl) == 1                       %if prime, use Rader's
        [r,igm,rm,Nz] = ...                      %find indices
            radersdecimation(N,typef);  
        Y = radersroutine(y,N,typef,igm,r,rm,Nz);%perform conv routine
    else
        Y = treeandnodefft(y,N,typef,bl);        %tree FFT struct
    end
    if typef == 1                                %for inverse 
        Y = Y / N;                               %normalize by N
    end
end
%% function calls
function [Y] = treeandnodefft(y,N,typef,bl)
    bl = bl(1:end-1);                            %decimate until Ml is prime
    nl = zeros(1,length(bl));                    %node per level preallocation
    Ml = zeros(1,length(bl));                    %elements per branch
    nl(1) = 1; bl = cat(2,1,bl); Ml(1) = N;      %declare level 0
    for l = 1:length(bl)-1                       %for each tree level
        nl(l+1) = bl(l) * nl(l);                 %find nodes per level
        Ml(l+1) = Ml(l) / bl(l+1);               %find elements per branch @l
    end
    El = bl.*Ml;                                 %elements per node 
    L = l;                                       %define active levels
    %% reindex to prime structure
    INDEX = zeros(length(Ml)-1,N);               %preallocate reindexing levels
    INDEX = cat(1,y,INDEX);                      %load in lvl 0
    for l = 1:L                                  %for active tree levels
        n=1; k=1;                                %reset n,k for new level
        for ni = 1:nl(l+1)                       %for each node per level
            for bi = 1:bl(l+1)                   %for each branch per node
                INDEX(l+1,n:n+Ml(l+1)-1) = ...   %decimate branch
                    INDEX(l,k:bl(l+1):El(l+1)+k-1);
                n = n + Ml(l+1);                 %hop to next solution location
                k = k+1;                         %iterate to adjacent branch
            end
                k=ni*El(l+1)+1;                  %hop to next node in level
        end
    end
    %% compute FFT
    bl = flip(bl); nl = flip(nl); Ml = flip(Ml); %flip tree instructions 
    El = flip(El);
    BUTTER = zeros(length(Ml),N);                %preallocate FFT upsample tree
    if Ml(1) > 4
    [r,igm,rm,Nz] = ...                          %find indices
            radersdecimation(Ml(1),typef);  
    end
    for l = 1:L+1                                %for all active levels
        n = 1; k =1;                             %reset n,k for new level
        if l == 1                                %First level is the DFT level
        for ni = 1:nl(l)                         %for each node per level
            for bi = 1:bl(l)                     %for each branch per node
                if Ml(1) > 4
                Fy = ...                         %perform conv routine
                 radersroutine(INDEX(end,n:n+Ml(1)-1),Ml(1),typef,igm,r,rm,Nz);
                else                             %take DFT
                Fy = DFT(INDEX(end,n:n+Ml(1)-1),Ml(1),typef); 
                end
                BUTTER(1,n:n+Ml(1)-1) = Fy;      %load to main array
                n = n + Ml(1);                   %hop to next solution location
            end
        end
        else                                     %Upsample through lvls > 1
        for ni = 1:nl(l-1)                       %for each node per level
            if bl(l-1) == 2                      %if bl == 2 use conj twiddle
                CONJ = ...                       %twiddle odd level
                    BUTTER(l-1,n+Ml(l-1):n+2*Ml(l-1)-1) .* ...
                    1i.^(typef*2*(0:1/Ml(l-1):1-1/Ml(l-1)));
                BUTTER(l,n:n+El(l-1)-1) = ...    %conj with even lvl
                    [BUTTER(l-1,n:n+Ml(l-1)-1) + CONJ ,...
                    BUTTER(l-1,n:n+Ml(l-1)-1) - CONJ];
            elseif bl(l-1) > 2                   %else use non-conj twiddle
                for bi = 1:bl(l-1)               %for each branch in node
                tempcomp = ...                   %send to non-conj twiddle fct
                NONCONJfct(BUTTER(l-1,k:k+Ml(l-1)-1),bi,Ml(l-1),bl(l-1),typef);
                BUTTER(l,n:n+El(l-1)-1) = tempcomp + ...
                    BUTTER(l,n:n+El(l-1)-1);     %superimpose to main array
                k = k + Ml(l-1);                 %iterate computation location
                end
             end
                n = ni*El(l-1)+1;                %hop to next node in level
                k = n;                           %computations as well
        end
        end
    end
    Y = BUTTER(end,:);                           %extract FD spectrum
end
function [Fy] = DFT(y,N,typef)               %DFT main function                                 
    Fy=zeros(1,N);                               %preallocate Fy                   
    for Fit=1:1:N                                %test ALL combinations
        Fy(Fit)=sum(y.*1i.^(typef*4*(Fit-1)*(0:1/N:1-1/N))); 
    end  
 end
function [Fyp] = NONCONJfct(Y,bi,Ml,b,typef) %Non-conjugating twiddle fct
    N = Ml*b;                                    %upsample size
    FY = Y;                                      %hold local FD
    for p = 1:b-1                                %periodically extend FD
    FY = cat(2,Y,FY);
    end
    if bi == 1                                   %branch 1 has no twiddle
    Fyp = FY;                    
    else                                         %twiddle remaining branches
    Fyp = FY.*1i.^(4*typef*(bi-1)*(0:1/N:1-1/N));
    end
end
function [Y] = radersroutine(y,N,typef,igm,r,rm,Nz)
    yg = zeros(1,length(y)-1);                        %preallocate yg
    for n = 1:N-1
        yg(n) = y(round(r(n))+1);                     %index to yg
    end
    yg = cat(2,yg(1),zeros(1,Nz-N+1),yg(2:end));      %zero-pad yg
    bl = factor(Nz);                                  %new factorization
    Y1 = treeandnodefft(yg,Nz,typef,bl);              %FFT of yg
    Y2 = treeandnodefft(igm,Nz,typef,bl);             %FFT of igm
    C = Y1.*Y2;                                       %FD pt-wise mult
    Ys = treeandnodefft(C,Nz,-typef,bl)/Nz + y(1);    %iFFT of C + y(1)
    Yn = Yreindex(Ys(1:N-1),rm);                      %reindex Ys(1:N-1)
    Y = cat(2,sum(y),Yn);                             %cat 0-Hz
end
function [r,igm,rm,Nz] = radersdecimation(N,typef)
%find indices
    for g = 1:N-1                                %guess a generator
        rtry = zeros(1,N-1); t=1;                %preallocate index vector
        for q = 1:N-1                            %for all indices
            t = t*g;                             %get new argument
            rtry(q) = mod(t,N);                  %find argument mod
            t = mod(t,N);                        %reduce t
        end
        if length(rtry) - length(unique(rtry)) == 0
            r = rtry;                            %bijective solution reached
            break
        end
    end
    rm = [flip(r(1:end-1)),r(end)];              %m inv index perm
    Nz = 2^(ceil(log2(2*N-2)));                  %find zero-pad length
    ig = 1i.^(typef*4*rm/N);                     %reindex sinusoid
    igm = ig;                                    %hold for comp
    while length(igm) < Nz
        igm = cat(2,ig,igm);                     %extend igm to >Nz
    end
    igm = igm(1:Nz);                             %extract first Nz
end
function [Yn] = Yreindex(Ys,rm)
        %find reindex scheme
        Yn = zeros(1,length(Ys));                    %preallocate Rader Solution
        r = [rm(2:end),rm(1)];                       %create index vector
        for n=1:length(Ys)
        Yn(round(r(n))) = Ys(n);                     %index to Yn
        end
end