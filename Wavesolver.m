%script for å løse bølgelikningen u_tt - u_xx - u_yy = 0 ved å utvikle
%tidsframes u1,u2,u3... med en leapfrogrutine

%Fixing stepsizes and such INPUT HERE:
n = 20; %x steps (vertical j)
m = 20; %y steps (horizontal i)
T = 7;

%Vi kjører periodic boundaries i y = 0 = 1. Dvs j = 0 er boundarien og vi
%gjør m litt større
m = m+1;
%Vi kjører u_x = u_t i x = 0, og u_x = -u_t i x = 1. (1. ordens
%aproksimasjon av venstre og høyre halvsirkel av bølgelikningens
%løsningsområde)

%Set opp initial og immediate next step values INPUT HERE:.
U_0 = zeros(m,n);
U_1 = zeros(m,n);

for i = 1:m
    for j = 1:n
        U_0(i,j) = sin(2*pi*i/m);
        U_1(i,j) = sin(2*pi*(i-1)/m);
    end
end

%Bygge opp u
u = zeros(T,n*m);
u(1,:) = reshape(U_0, [1,n*m]);
u(2,:) = reshape(U_1, [1,n*m]);

for t = 2:T-1
    %---------------------------------------------------------------------
    %cases on x-boundary
    j = 1;
    %    cases for the y-boundary
    u(t+1,j) = fivepointleap( u(t,j), 0, u(t,j+1), u(t,(m-1)*n+j), u(t,j+n), u(t-1,j), 1);
    u(t+1,(m-1)*n+j) = fivepointleap( u(t,(m-1)*n+j), 0, u(t,(m-1)*n+j+1), u(t,(m-2)*n+j), u(t,j), u(t-1,(m-1)*n+j), 1);
    %    Cases in the y interior
    for i = 2:m-2
        u(t+1, i*n + j) = fivepointleap( u(t,i*n+j), 0, u(t,i*n+j+1), u(t,i*n+j-n), u(t,i*n+j+n), u(t-1,i*n+j), 1);
    end
    
    j = n
    %    cases for the y-boundary
    u(t+1,j) = fivepointleap( u(t,j), u(t,j-1), 0, u(t,(m-1)*n+j), u(t,j+n), u(t-1,j), 2);
    u(t+1,(m-1)*n+j) = fivepointleap( u(t,(m-1)*n+j), u(t,(m-1)*n+j-1), 0, u(t,(m-2)*n+j), u(t,j), u(t-1,(m-1)*n+j), 2);
    %   Cases in the y interior
    for i = 2:m-2
        u(t+1, i*n + j) = fivepointleap( u(t,i*n+j), u(t,i*n+j-1), 0, u(t,i*n+j-n), u(t,i*n+j+n), u(t-1,i*n+j), 2);
    end        
    
    %--------------------------------------------------------------------------
    %Cases in the x-interior
    for j = 2:n-1
        %Cases on the y boundary
        u(t+1,j) = fivepointleap( u(t,j), u(t,j-1), u(t,j+1), u(t,(m-1)*n+j), u(t,j+n), u(t-1,j), 0);
        u(t+1,(m-1)*n+j) = fivepointleap( u(t,(m-1)*n+j), u(t,(m-1)*n+j-1), u(t,(m-1)*n+j+1), u(t,(m-2)*n+j), u(t,j), u(t-1,(m-1)*n+j), 0);
    end
        %Cases in the y interior
    for i = 2:m-2
        for j = 2:n-1
                u(t+1, i*n + j) = fivepointleap( u(t,i*n+j), u(t,i*n+j-1), u(t,i*n+j+1), u(t,i*n+j-n), u(t,i*n+j+n), u(t-1,i*n+j), 0);
        end
    end
end

showtime = ;
picture = extracttimeframe(u,showtime,n,m)
surf(picture)
    
%TODO:
%-----------------------------
%- Test with initial conditions
% -make a visual plot somehow