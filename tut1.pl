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


% Примеры обработки списков.

% len(L, N) <-> N - это длина списка L.


% Длина пустого списка равна 0.
len([], 0).
% Длина непустого списка на 1 больше длины хваста этого списка.
len([_|T], N):-
    len(T,M),
    N is M+1.

% Если входной список пуст, то его длина равна 0.
% Чтобы найти длину входного списка,
%    надо найти длину его чваоста, затем,
%    прибавить к ней 1 и вернкть в качестве результата.



last([X],X).
last([_|T],Y):-
    T=[_|_],
    last(T, Y).

in(X,[X|_]).
in(X,[_|T]):-
    in(X,T).

del(X,[X|T],T).
del(X,[Y|T],[Y|R]):-
    del(X,T,R).

pert([],[]).
pert([X|T],P):-
    pert(T,PT),
    del(X,P,PT).

% app(L1,L2,L3) <-> L3 = L1 + L2.
app([],L,L).
app([X|T],L2,[X|R]):-
    app(T,L2,R).


% Sorting

qs([],[]):-!.
qs([X|T],S):-
    div(T,X, L,G),
    qs(L,SL),
    qs(G,SG),
    app(SL,[X|SG],S).

div([],   _, [],[]).
div([Y|T],X, [Y|TL],G):-
    Y<X,
    div(T,X,TL,G).
div([Y|T],X, L,[Y|TG]):-
    Y>=X,
    div(T,X,L,TG).

% Bubble sort

bs(I,O):-
    swap(I, Q),!,
    bs(Q,O).
bs(L,L).

swap([X,Y|T],[Y,X|T]):-
    X>Y,!.
swap([X|T],[X|R]):-
    swap(T,R).
