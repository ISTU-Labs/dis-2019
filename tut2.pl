% - comment
% likes(X,Y) <-> X любит Y.
% MP:  A->b, A |- b
% GEN: A(x) | \forall y A(y),  A(y)]x[.
% term - структура, обозначающая некоторое существительное.
% s - Сократ
% f(x) - Жена x-а.
% f(s)
% X - переменная, тоже терм.
% предикаты = "свойство", h(x) - х-человек.

likes(ann, max). % Факт, истинное высказывание.
likes(max, jul).
likes(kate, max).

% lt1 - Love triangle.

% labs@irnok.net

lt1(X,Y,Z):-      % :-  -   <-, If
    likes(X,Y),   % , - AND
    likes(Y,Z),
    X\=Z.

lt2(X,Y,Z):-
    likes(X,Y),
    likes(Z,Y),
    X\=Z.

lt(X,Y,Z):-lt1(X,Y,Z).
lt(X,Y,Z):-lt2(X,Y,Z).

% lt(X,Y,Z):-lt1(X,Y,Z); lt2(X,Y,Z).

% Запросы.
% d(E, X, DE). X - atom.   X=x

d(X, X, 1):-!.
d(Y, X, 0):-atom(Y), Y\=X, !.
d(U+V, X, DU+DV):-!,
    d(U, X, DU),
    d(V, X, DV).
d(U-V, X, DU-DV):-!,
    d(U, X, DU),
    d(V, X, DV).
d(U*V, X, V*DU+DV*U):-!,
    d(U, X, DU),
    d(V, X, DV).
d(U/V, X, (V*DU-DV*U)/(V^2)):-!,
    d(U, X, DU),
    d(V, X, DV).

d(E,X,DF*DArg):-  % f'(g(x)) -> f'(g)*g'(x)
    % E=f(x)
    % six(x) =.. [sin,x].
    E =.. [_, Arg],!,
    df(E, DF),
    d(Arg, X, DArg).

d(E^N, X, N*E^M*DE):-!,
    M is N-1,
    d(E, X, DE).

df(sin(E), cos(E)).
df(cos(E), -sin(E)).
df(ln(E), 1/E).
