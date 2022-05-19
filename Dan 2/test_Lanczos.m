% Dio nastavnog materijala na  
% PMF-Matematicki odsjek, Sveuciliste u Zagrebu
% Diplomski kolegij Numericka analiza 1 (© Zlatko Drmac)
%
% Cilj je prouciti elemente Lanczosevog algoritma, posebno s obzirom na 
% numericku ortogonalnost matrice Q koja daje ortonormiranu bazu za 
% odgovarajuci Krilovljev potprostor.
% Diskusija tokom prezentacije na vjezbama.

clear   % pocisti workspace 
% nasumicno odabrane dimenzije i matrica A 
n = 1000  ; % dimenzija matrice A 
m = 30   ; % potencija od A u zadnjem Krilovljevom vektoru (A^m * b) 
A = randn(n,n) ; 
A = A + A' ; % simetrizacija jer Lanczosev algoritam radi na simetricnim m.

% odabir vektora b
case_b = menu('Izbor vektora b','slucajni (jednostavan genericki slucaj)', ...
               'razapet odabranim svojstvenim vektorima')
if ( case_b == 1 )
    b = randn(n,1) ; 
else
  p = 10 ;   
  [VA,EA] = eigs(A,p) ; % p svojstvenih vrijednosti i vektora
  b = VA(:,1:p)*randn(p,1); % lin. kombinacija p sv. vektora
end

%
% Slijedi Arnoldijev algoritam 
%

tol = eps ; 
[ Q, T, alpha, beta, ell ] = Lanczos( A, m, b, tol ) ;
%
% testiramo izracunate Q i H 
%
% 1. Provjera ortogonalnosti matrice Q 

testQ = Q(:,1:m)'*Q(:,1:m) ; 
figure(1)
imagesc( log10(abs(testQ)) ), colorbar
title('odstupanje od ortog. matrice Q u Lanczosevom alg.')
% vizualizacija odstupanja od ortogonalnosti - log10 od apsolutnih
% vrijednosti: nula ili blizu nule znaci da je u abs(testQ) element blizu
% jedinice i to bi trebalo vrijediti samo za dijagonalne elemente. Za 
% izvandijagonalne elemente bi log10(abs(.)) trebali biti priblizno cijeli 
% brojevi oko -16, -15, -14. 
max_testQ = max(max(abs(testQ-eye(m)))) % ovo treba (idealno) biti <= n*eps

% 2. Provjera relacije A * Q(:,1:m) = Q(:,1:m+1) * T(1:m+1,1:m) 
%    Gornju relaciju mozemo pisati i kao
%    A * Q(:,1:m) = Q(:,1:m) * T(1:m,1:m) + Q(:,m+1) * T(m+1,m)  
%    pa je 
%    Q(:,1:m)' * A * Q(:,1:m) = Q(:,1:m)' * Q(:,1:m) *T(1:m,1:m) + 
%                             + Q(:,1:m)' * Q(:,m+1) * T(m+1,m) = 
%                             = T(1:m,1:m) jer je Q ortonormalna.
%
AQm = A * Q(:,1:m) ; 
R = AQm - Q(:,1:m+1) * T(1:m+1,1:m) ; 
%   [ * * 0 0 ]
%   [ * * * 0 ]   T(1:m,1:m) ] [*]_{4 x 4}
%   [ 0 * * * ]   Q(:,1:m+1) * T(1:m+1,1:m) = Q(:,1:m) * T(1:m,1:m) +   
%   [ 0 0 * * ]                             + Q(:,m+1) * T(m+1,m)
%   [ 0 0 0 x ]   x = T(m+1,m)                           ~~~~~~~~
%                                                        sto ako je ovo
%                                                        malo po |.| ?
rezidual = norm(R,'fro') / norm(AQm,'fro' )
figure(2)
imagesc(log10(abs(R./AQm))), colorbar
title('rel. rezidual A*Q(:,1:m) - Q(:,1:m+1) * T(1:m+1,1:m)')

% 3. Vizualna inspekcija Hessenbergove matrice H

figure(3)
subplot(1,2,1), imagesc(log10(abs(T(1:ell+1,1:ell)))), colorbar
title('log10(abs(T(1:ell+1,1:ell)))')
subplot(1,2,2), semilogy(abs(diag(T(1:ell+1,1:ell),-1)),'x-')
title('|T(i+1,i)|, i=1,..,m')
subplot

% 4. Test Rayleighijevog kvocijenta 

RQ = Q(:,1:m)' * A * Q(:,1:m) ; % Rayleighijev kvocijent,
                                % teorijski jednak H(1:m,1:m)
                                
rezidual_RQ = norm( RQ - T(1:m,1:m), 'fro') / norm(T(1:m,1:m),'fro') 

% 5. Matrica T je uvedena radi citljivosti i u jednoj pravoj implementaciji je
% ne koristimo. Informacija o T je zapisana u vektorima alpha i beta.

T_alpha_beta = diag(alpha(1:ell)) + diag(beta(1:ell-1),1) + ...
               diag(beta(1:ell-1),-1) ; 
testT = norm(T(1:ell,1:ell)-T_alpha_beta,'fro')
testlast = T(ell+1,ell) - beta(ell) 


