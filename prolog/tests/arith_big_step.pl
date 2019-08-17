:- begin_tests(arith_big_step).

:- use_module("../arith_big_step").

test(if) :-
    beval(if(true, true, if(false, false, false)), true).

test(pred1) :-
    beval(pred(succ(0)), 0).

test(pred2) :-
    beval(pred(pred(succ(succ(0)))), 0).

test(iszero) :-
    beval(iszero(succ(0)), false).

test(value1) :-
    beval(true, true).

test(value2) :-
    beval(succ(0), succ(0)).

test(stuck1) :-
    beval(pred(true), pred(true)).

test(stuck2) :-
    beval(iszero(false), iszero(false)).
