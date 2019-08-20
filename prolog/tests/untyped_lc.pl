:- begin_tests(untyped_lc).

:- use_module("../untyped_lc").

test(id) :-
    Id = abs(var(0)),
    C0 = abs(abs(var(0))),
    eval(app(Id, C0), C0).

test(bool) :-
    Tru = abs(abs(var(1))),
    Fls = abs(abs(var(0))),
    C0 = abs(abs(var(0))),
    C1 = abs(abs(app(var(1), var(0)))),
    Test = abs(abs(abs(app(app(var(2), var(1)), var(0))))),
    eval(app(app(app(Test, Tru), C0), C1), C0),
    eval(app(app(app(Test, Fls), C0), C1), C1).

test(value) :-
    eval(abs(var(0)), abs(var(0))).
