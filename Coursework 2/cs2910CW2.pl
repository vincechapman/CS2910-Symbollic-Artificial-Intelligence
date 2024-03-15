% Initial house layout facts and rules (without cost).

leads_to(outside, porch_1).
leads_to(porch_1, kitchen).
leads_to(kitchen, living_room).
leads_to(porch_2, living_room).
leads_to(outside, porch_2).
leads_to(corridor, living_room).
leads_to(bedroom, corridor).
leads_to(corridor, wc).
leads_to(corridor, master_bedroom).

% Allows path-finding to work bi-directionally.
adjacent_to(R1, R2) :- leads_to(R1, R2); leads_to(R2, R1).




% 3.1: Find a path
% ---------------------------------------------------------

find_paths(Goal, Goal, _) :-
    write("\nStart and goal location are the same!"), !.

find_paths(Start, _, _) :-
    \+ adjacent_to(Start, _), !,
    write("\nInvalid start room given for first argument.").

find_paths(_, Goal, _) :-
    \+ adjacent_to(Goal, _), !,
    write("\nInvalid goal room given for second argument.").

find_paths(_, _, Solution) :-
    \+ var(Solution), !,
    write("\nThird predicate argument must be a variable.").

find_paths(Start, Goal, Solution) :-
    df_search(Goal, [], Start, X),
    reverse(X, [], Solution).


% Depth-first search algorithm

df_search(Goal, Visited, Current, [Current | Visited]) :-
    =(Goal, Current).

df_search(Goal, Visited, Current, Solution) :-
    adjacent_to(Current, Next),
    \+ member(Next, Visited),
    df_search(Goal, [Current | Visited], Next, Solution).


% Reverse list order algorithm

reverse([], X, X). % Base case, if original list empty

reverse([Head | Tail], Acc, X) :-
    reverse(Tail, [Head | Acc], X).




% 3.2 Paths ending at a common destination
% ---------------------------------------------------------

len([], 0).
len([_|Tail], Len) :- len(Tail, X), Len is X+1.

find_shortest_paths(Start, Goal, Solution) :-
    find_paths(Start, Goal, Solution),
    \+ (
        find_paths(Start, Goal, Shorter),
        len(Shorter, Len1),
        len(Solution, Len2),
        Len1 < Len2
    ).

find_combined_path(O1, O2, D, Solution) :-
    find_paths(O1, D, P1),
    find_paths(O2, D, P2),
    reverse(P2, [], P2rev),
    combine_paths(P1, P2rev, Solution).
    % append(P1, P2rev, X),
    % list_to_set(X, Solution).

% combine_paths([], [], []) :-
%     write("base case"), !.

% combine_paths([O1|Path1], [O2|Path2], [O1|CombinedPath]) :-
%     write(CombinedPath),
%     combine_paths(Path1, Path2, CombinedPath),
%     O1 = O2.

% combine_paths(A, B, C) :-
%     append(A1, Common, A),
%     append(Common, More, B),
%     append(A1, More, C).

combine_paths([], [], [], 0).

% Combine paths from O1 to D and O2 to D with total cost
combine_paths([O1|Path1], [O2|Path2], [O1|CombinedPath]) :-
    combine_paths(Path1, Path2, CombinedPath),
    O1 = O2, % Meeting point at D    

% Query example: combine paths from Outside to WC and Kitchen to WC
% Usage: combine_paths(Path1, Path2, CombinedPath).
% Example query: combine_paths([outside, porch1, kitchen], [kitchen, living_room, corridor, wc], CombinedPath).





% 3.3 Paths with costs
% ---------------------------------------------------------

leads_to_with_cost(outside, porch_1, 1).
leads_to_with_cost(porch_1, kitchen, 1).
leads_to_with_cost(kitchen, living_room, 3).
leads_to_with_cost(porch_2, living_room, 5).
leads_to_with_cost(outside, porch_2, 1).
leads_to_with_cost(corridor, living_room, 1).
leads_to_with_cost(bedroom, corridor, 2).
leads_to_with_cost(corridor, wc, 2).
leads_to_with_cost(corridor, master_bedroom, 2).

adjacent_to_with_cost(R1, R2, C) :- leads_to_with_cost(R1, R2, C); leads_to_with_cost(R2, R1, C).