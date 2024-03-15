
/*

CS2910: Introduction to Prolog

*/


/*
        Model answers for Exercise 2, Part II
*/



%% SWI-Prolog: member/2 append/3 etc are built-in

% --------------------- Question 1 --------------------------------

%   An acyclic directed graph is represented by the following facts:

    arc( a, b ).
    arc( b, c ).
    arc( b, d ).
    arc( c, f ).
    arc( d, f ).
    arc( c, e ).
    arc( f, e ).

% 1.a.  path(?X,?Z)

    path( NodeX, NodeZ ) :-
        arc( NodeX, NodeZ ).
    path( NodeX, NodeZ ) :-
        arc( NodeX, NodeY ),
        path( NodeY, NodeZ ).

% 1.b.

/*
    QUERIES     SOLUTIONS

    ?- path( b, f ).        "yes"
    ?- path( b, Z ).        Z/c, Z/d, Z/f (twice), Z/e (thrice)
    ?- path( X, d ).        X/a, X/b
*/

% 1.c.

/*
     QUERIES
 
     i    ?- path( a, d ), path( d, f ). 
     ii   ?- arc( Z, f ), arc( Y, Z ), arc( X, Y ).
          (more efficient than)
          ?- arc( X, Y ), arc(Y, Z), arc( Z, f ).
     iii  ?- path( X, X ).
*/


% --------------------- Question 2 (Peano numbers) ---------------------


% 2.a.    plus(?X,?Y/Z?)

    plus(0, N, N).
    plus( s(X), Y, s(Z) ) :-
        plus( X, Y, Z ).

% 2.b.   % queries


% 2.c.

% N is odd iff N = 2M + 1 for some M
% N is odd iff N = M + (M + 1) for some M
% So ... 

    odd( N ) :-
        plus( M, s(M), N ).






% --------------------- Question 3 --------------------------------

% ones_zeros( ?X ).

    ones_zeros( [] ).
    ones_zeros( [1 | List] ) :-
        ones_zeros( List ).
    ones_zeros( [0 | List] ) :-
        ones_zeros( List ).

/* 
Alternatives:

    ones_zeros( [] ).
    ones_zeros( [X | List] ) :-
        one_or_zero(X),
        ones_zeros( List ).

    one_or_zero(1).
    one_or_zero(0).

Alternatively:

    ones_zeros( [] ).
    ones_zeros( [X | List] ) :-
        (X=1 ; X=0),     % ';' is 'or' in Prolog
        ones_zeros( List ).

Alternatively:

    ones_zeros( [] ).
    ones_zeros( [X | List] ) :-
        member(X, [1,0]),
        ones_zeros( List ).

*/


% --------------------- Question 4 --------------------------------

% hasdups( ?X ).

    hasdups( [Elem | List] ) :-
        member( Elem, List ).
    hasdups( [_ | List] ) :-
        hasdups( List ).

/* try queries
     ?- hasdups(X).
     ?- hasdups([a|X]).
*/

   
% --------------------- Question 5  prod/2 --------------------


    prod( [N], N ).      % could also test number(N)
    prod( [Num|Nums], Prod ) :-
        prod( Nums, TempProd ),
        Prod is Num * TempProd.
        
% tail recursive version:
% NB question forbids preds other than prod/2 and is/2
% so strictly speaking this is  not a correct answer
% (though it is a better program)

    prod_tr( [N|Rest], Prod ) :- 
       prod_tr( Rest, N, Prod).
       
    prod_tr( [], X, X ).
    prod_tr( [N|Rest], Acc, Result ) :-
       NewAcc is Acc * N,
       prod_tr( Rest, NewAcc, Result).



% --------------------- Question 6 contains/3 -----------------

%%  (Draw a picture)

    contains( List, Sublist, Position ) :-
        append( Sublist, _, Back ),
        append( Front, Back, List ),
        length( [_|Front], Position ).


/*
The following also works, but produces the sublists in a
different order

    contains( List, Sublist, Position ) :-
        append( Prefix, Sublist, Front ),
        append( Front, _Back, List ),
        length( [_|Prefix], Position ).

The following works best when the input List is given

    contains( List, Sublist, Position ) :-
        append( Front, Back, List ),   % List is bound here
        append( Sublist, _, Back ),    % so Back is bound here
        length( [_|Front], Position ).

*/

/* Here is a recursive program that doesn't use append and length

    contains( [X|_], [X], 1 ).
    contains( [Elem|List], [Elem|Sublist], 1 ) :-
        contains( List, Sublist, 1 ).
    contains( [_|List], Sublist, Position ) :-
        contains( List, Sublist, Previous ),
        Position is Previous + 1.

You might prefer the following base case instead

    contains( _, [], 1 ).
*/
