% Chapter 3 - Untyped Arithmetic Expressions
% Small-step evaluation
:- module(arith_small_step, [eval/2]).

% Numeric values
nv(0) :- !.
nv(succ(N)) :- nv(N).

% E-IfTrue
eval(if(true, T2, _T3), T2) :- !.

% E-IfFalse
eval(if(false, _T2, T3), T3) :- !.

% E-If
eval(if(T1, T2, T3), if(T1_, T2, T3)) :-
    eval(T1, T1_).

% E-Succ
eval(succ(T1), succ(T1_)) :-
    eval(T1, T1_).

% E-PredZero
eval(pred(0), 0) :- !.

% E-PredSucc
eval(pred(succ(NV1)), NV1) :-
    nv(NV1),
    !.

% E-Pred
eval(pred(T1), pred(T1_)) :-
    eval(T1, T1_).

% E-IsZeroZero
eval(iszero(0), true) :- !.

% E-IsZeroSucc
eval(iszero(succ(NV1)), false) :-
    nv(NV1),
    !.

% E-IsZero
eval(iszero(T1), iszero(T1_)) :-
    eval(T1, T1_).
