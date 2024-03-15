% Declaring house layout through the following facts and rules:

leads_to(outside, porch_1).
leads_to(outside, porch_2).
leads_to(porch_1, kitchen).
leads_to(porch_2, living_room).
leads_to(kitchen, living_room).
leads_to(corridor, wc).
leads_to(corridor, bedroom).
leads_to(corridor, master_bedroom).
leads_to(corridor, living_room).

adjacent_to(R1, R2) :- leads_to(R1, R2); leads_to(R2, R1).


% 3.1 Find a path

find_paths(Start, Goal, Solution) :-
    df_search(Goal, [], Start, X),
    reverse(X, Solution, []).

df_search(Goal, Visited, Current, [Current | Visited]) :-
    =(Goal, Current).
df_search(Goal, Visited, Current, Solution) :-
    adjacent_to(Current, Next),
    \+ member(Next, Visited),
    df_search(Goal, [Current | Visited], Next, Solution).

reverse([],Z,Z).
reverse([H|T],Z,Acc) :-
    reverse(T,Z,[H|Acc]).