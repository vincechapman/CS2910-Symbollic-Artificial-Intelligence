% Declaring house layout through the following facts:
leads_to(outside, porch_1).
leads_to(outside, porch_2).
leads_to(porch_1, kitchen).
leads_to(porch_2, living_room).
leads_to(kitchen, living_room).
leads_to(corridor, wc).
leads_to(corridor, bedroom).
leads_to(corridor, master_bedroom).
leads_to(corridor, living_room).

% Rule stating if two rooms are adjacent.
adjacent_to(R1, R2) :- leads_to(R1, R2); leads_to(R2, R1).

find_paths(Start, Goal, Solution) :-
    df_search(Goal, [], Start, Solution). 

% Recursive depth-first search
df_search(Goal, Visited, Current, [Current | Visited]) :-
    =(Goal, Current).
df_search(Goal, Visited, Current, Solution) :-
    adjacent_to(Current, Next),
    \+ member(Next, Visited),
    df_search(Goal, [Current | Visited], Next, Solution).

% df_search(_, Goal, _) :-
%     \+ adjacent_to(Goal, _),
%     write("Invalid goal given").
% df_search(_, _, Current) :-
%     \+ adjacent_to(Current, _),
%     write("Invalid start given").
% df_search(Visited, Goal, Current) :-
%     =(Goal, Current),
%     write(Visited),
%     X = [],
%     print_head(Visited, X).
% df_search(Visited, Goal, Current) :-
%     adjacent_to(Current, Adj),
%     \+ member(Adj, Visited),
%     df_search([Adj|Visited], Goal, Adj).