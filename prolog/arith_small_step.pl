% Chapter 3 - Untyped Arithmetic Expressions
% Small-step evaluation
:- module(arith_small_step, [eval/2]).

% Numeric values
nv(0) :- !.
nv(succ(N)) :- nv(N).

% E-IfTrue
eval1(if(true, T2, _T3), T2) :- !.

% E-IfFalse
eval1(if(false, _T2, T3), T3) :- !.

% E-If
eval1(if(T1, T2, T3), if(T1_, T2, T3)) :-
    eval1(T1, T1_).

% E-Succ
eval1(succ(T1), succ(T1_)) :-
    eval1(T1, T1_).

% E-PredZero
eval1(pred(0), 0) :- !.

% E-PredSucc
eval1(pred(succ(NV1)), NV1) :-
    nv(NV1),
    !.

% E-Pred
eval1(pred(T1), pred(T1_)) :-
    eval1(T1, T1_).

% E-IsZeroZero
eval1(iszero(0), true) :- !.

% E-IsZeroSucc
eval1(iszero(succ(NV1)), false) :-
    nv(NV1),
    !.

% E-IsZero
eval1(iszero(T1), iszero(T1_)) :-
    eval1(T1, T1_).

% Call eval1 as long as the term can be reduced
eval(T, T_) :-
    eval1(T, T1),
    eval(T1, T_),
    !.

% Return the term if no rule applies
eval(T, T) :- !.
