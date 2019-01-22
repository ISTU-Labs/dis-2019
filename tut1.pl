% Comment
% 1 - Набор фактов
% 2 - Набор правил
% 3 - Запрос

% likes(X,Y). <=> X likes Y
% wife(X). wife(socrates).


likes(ann,alex).  % Ann likes Alex
likes(alex,jul).
likes(john,jul).
likes(jul,alex).

% X,Y,Z are in Love treangle of the first kind.

lt1(X,Y,Z):-
    likes(X,Y),
    likes(Y,Z),
    X\=Z.

lt2(X,Y,Z):-
    likes(X,Y),
    likes(Z,Y),
    X\=Z.

lt(X,Y,Z):-lt1(X,Y,Z).
lt(X,Y,Z):-lt2(X,Y,Z).

lt_(X,Y,Z):-lt1(X,Y,Z); lt2(X,Y,Z).

ok(X,Y):-
    likes(X,Y),
    likes(Y,X).


% Functors wife(X).
% +(1,2)  1+2.  person(cherkashin, evgeny, alexandrovich, 1974)

% d(Expression, Vriable, DExpression).

d(X, X, 1):-!.
d(Y, X, 0):-atom(Y), Y\=X,!.
d(U+V, X, DU + DV):-
    d(U,X,DU),
    d(V,X,DV).
d(U-V, X, DU - DV):-
    d(U,X,DU),
    d(V,X,DV).
d(U*V, X, DU*V+DV*U):-
    d(U,X,DU),
    d(V,X,DV).
d(U/V, X, (DU*V-DV*U)/(V*V)):-
    d(U,X,DU),
    d(V,X,DV).
d(E^N, X, N*E^(M)*DE):-  % f'(g(x)) = f'(g(x))*g'(x)
    M is N-1,
    d(E,X,DE).
d(E,X,DE*DArg):-
    E=..[_, Arg],
    df(E, DE),
    d(Arg,X,DArg).

df(ln(E), 1/E).
df(sin(E), cos(E)).
df(cos(E), -sin(E)).


:- dynamic([f/2]).

f(1,1).
f(2,1).

fib(N,M):-f(N,M),!.
fib(N,M):-N>2,
    N1 is N-1,
    N2 is N-2,
    fib(N1,M1),
    fib(N2,M2),
    M is M1+M2,
    assertz(f(N,M)).
