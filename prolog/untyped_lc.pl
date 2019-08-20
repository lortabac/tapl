% Chapters 5-6
% The Untyped Lambda-Calculus
:- module(untyped_lc, [eval/2]).

% Shifting
shift(D, T, R) :-
    shift_(D, 0, T, R).

shift_(D, C, var(X), R) :-
    X >= C,
    R0 is X + D,
    R = var(R0).

shift_(_D, C, var(X), var(X)) :-
    not(X >= C).

shift_(D, C, abs(T1), R) :-
    C1 is C + 1,
    shift_(D, C1, T1, R0),
    R = abs(R0).

shift_(D, C, app(T1, T2), R) :-
    shift_(D, C, T1, R1),
    shift_(D, C, T2, R2),
    R = app(R1, R2).

% Substitution
subst(J, S, T, R) :-
    subst_(J, S, 0, T, R).

subst_(J, S, C, var(X), R) :-
    X is J + C,
    shift(C, S, R).

subst_(J, _S, C, var(X), var(X)) :-
    not(X is J + C).

subst_(J, S, C, abs(T1), R) :-
    C1 is C + 1,
    subst_(J, S, C1, T1, R0),
    R = abs(R0).

subst_(J, S, C, app(T1, T2), R) :-
    subst_(J, S, C, T1, R1),
    subst_(J, S, C, T2, R2),
    R = app(R1, R2).

subst_top(S, T, R) :-
    shift(1, S, S_),
    subst(0, S_, T, R0),
    shift(-1, R0, R).

% Values
v(abs(_)).

% E-App1
eval1(app(T1, T2), app(T1_, T2)) :-
    eval1(T1, T1_).

% E-App2
eval1(app(V1, T2), app(V1, T2_)) :-
    v(V1),
    eval1(T2, T2_).

% E-AppAbs
eval1(app(abs(T12), V2), S12) :-
    v(V2),
    subst_top(V2, T12, S12).

% Call eval1 as long as the term can be reduced
eval(T, T_) :-
    eval1(T, T1),
    eval(T1, T_),
    !.

% Return the term if no rule applies
eval(T, T) :- !.
