% Chapter 3 - Untyped Arithmetic Expressions
% Big-step beval1uation
:- module(arith_big_step, [beval1/2]).

% Numeric values
nv(0) :- !.
nv(succ(N)) :- nv(N).

% Values
v(true) :- !.
v(false) :- !.
v(T) :- nv(T), !.

% B-Value
beval1(T, T) :- v(T), !.

% B-IfTrue
beval1(if(T1, T2, _T3), V2) :-
    beval1(T1, true),
    beval1(T2, V2),
    !.

% B-IfFalse
beval1(if(T1, _T2, T3), V3) :-
    beval1(T1, false),
    beval1(T3, V3),
    !.

% B-Succ
beval1(succ(T1), succ(NV1)) :-
    beval1(T1, NV1),
    !.

% B-PredZero
beval1(pred(T1), 0) :-
    beval1(T1, 0),
    !.

% B-PredSucc
beval1(pred(T1), NV1) :-
    beval1(T1, succ(NV1)),
    !.

% B-IsZeroZero
beval1(iszero(T1), true) :-
    beval1(T1, 0),
    !.

% B-IsZeroSucc
beval1(iszero(T1), false) :-
    beval1(T1, succ(_NV1)),
    !.

% Call beval1 if the term can be reduced
beval(T, T_) :-
    beval1(T, T_),
    !.

% Return the term if no rule applies
beval(T, T) :- !.
