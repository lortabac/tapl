:- begin_tests(arith_small_step).

:- use_module("../arith_small_step").

test(if) :-
    eval(if(true, true, if(false, false, false)), true).

test(pred1) :-
    eval(pred(succ(0)), 0).

test(pred2) :-
    eval(pred(pred(succ(succ(0)))), 0).

test(iszero) :-
    eval(iszero(succ(0)), false).

test(value1) :-
    eval(true, true).

test(value2) :-
    eval(succ(0), succ(0)).

test(stuck1) :-
    eval(pred(true), pred(true)).

test(stuck2) :-
    eval(iszero(false), iszero(false)).
