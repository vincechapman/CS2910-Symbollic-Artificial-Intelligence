/*

    CS2910 Introduction to Prolog

    File: family.pl

*/

child_of( emmeline, frank ). 
child_of( amelia, frank ).
child_of( harold, frank ).
child_of( chris, amelia ).
child_of( chris, john ).
child_of( emlyn, chris ).
child_of( emlyn, elizabeth ).
child_of( brendon, chris ).
child_of( brendon, elizabeth ). 
child_of( irene, maurice ).
child_of( les, maurice ).
child_of( elizabeth, irene ).
child_of( elizabeth, george ).
child_of( margaret, irene ).
child_of( margaret, george ).
child_of( rebecca, margaret ).
child_of( louise, margaret ).   
child_of( nick, margaret ).
child_of( rebecca, peter ).
child_of( louise, peter ).
child_of( nick, peter ).

male( frank ).   
male( harold ).
male( chris ).
male( john ).
male( emlyn ).
male( brendon ).
male( maurice ).
male( les ).
male( nick ).
male( peter ).
male( george ).

female( emmeline ).
female( amelia ).
female( elizabeth ).
female( irene ).
female( margaret ).
female( rebecca ).
female( louise ).

mother_of( M, X ) :- child_of( X, M ), female( M ).
grandparent_of( Gp, X ) :- child_of( Y, Gp ), child_of( X, Y ).
daughter_of( D, X ) :- child_of( D, X ), female( D ).
uncle_of( Unc, X ) :- male( Unc ), child_of( Unc, Gp ), child_of( X, P ), child_of( P, Gp ).
niece_of( N, X ) :- female( N ), child_of( N, P ), child_of( P, Gp ), child_of( X, Gp ).
great_grandfather_of( Gfx, X ) :- child_of( X, P ), child_of( P, Gp ), child_of( Gp, Gfx ).
ancestor_of( Anc, X ) :-
    child_of( X, Anc ).
ancestor_of( Anc, X ) :-
    child_of( P, Anc ),
    ancestor_of( P, X ).

% end of data
