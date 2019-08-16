:- begin_tests(arith_small_step).

:- use_module("../arith_small_step").

test(if) :-
    eval(if(true, true, if(false, false, false)), true).

test(pred) :-
    eval(pred(succ(0)), 0).

test(iszero) :-
    eval(iszero(succ(0)), false).

test(stuck1) :-
    \+ eval(pred(true), _).

test(stuck2) :-
    \+ eval(iszero(false), _).
