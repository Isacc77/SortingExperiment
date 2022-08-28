% question from https://tjd1234.github.io/cmpt383summer2022/assignments/prolog_asn.html

% Question 1: fill
fill(N, E, Xs) :-
   length(Xs, N),       
   maplist(=(E), Xs).   

% Question 2: numlist
numlist(Lo, Hi, []) :- Lo > Hi.  
numlist(Lo, Hi, [X | Xs]) :-
  X is Lo,
  NextLo is Lo + 1,
  numlist(NextLo, Hi, Xs).       

% Question 3: min and max
minmax(Lst, Min, Max) :- 
      min_list(Lst,Min),
      max_list(Lst,Max).

min(X, Y, X) :- X =< Y.
min(X, Y, Y) :- X > Y.

min_list([X], X).
min_list([X|Xs], Min) :-
   min_list(Xs, Y),
   min(X, Y, Min).

max(X, Y, X) :- X => Y.
max(X, Y, Y) :- X < Y.

max_list([X], X).
max_list([X|Xs], Max) :-
   max_list(Xs, Y),
   max(X, Y, Max).

% Question 4: negpos
negpos(L, Neg, NonNeg):-
   msort(L, SortedLst),
   negpos_helper(SortedLst, Neg, NonNeg).

negpos_helper([], [], []).                 
negpos_helper([X | Xs], A, [X | Bs]) :-
    X >= 0,
    negpos_helper(Xs, A, Bs).             
negpos_helper([X | Xs], [X | As], B) :-
    X < 0,
    negpos_helper(Xs, As, B).              

% Question 5: cryptarithmetic
alpha([T,I,M,B,Y,U],  Tim, Bit, Yumyum) :-
    between(1, 9, T),
    between(0, 9, I), T \= I,
    between(0, 9, M), \+ member(M, [T,I]),        
    between(0, 9, B), \+ member(B, [T,I,M]),
    between(1, 9, Y), \+ member(Y, [T,I,M,B]),
    between(0, 9, U), \+ member(U, [T,I,M,B,Y]),
    Tim  is           T*100 + I*10 + M ,
    Bit  is           B*100 + I*10 + T ,
    Yumyum is Y*100000 + U*10000 + M*1000 + Y*100 + U*10 + M,
    Yumyum is Tim * Bit.

% Question 6: magic square
magic([X1,X2,X3,X4,X5,X6,X7,X8,X9], [A,B,C,D,E,F,G,H,I], N) :-
  permutation([X1,X2,X3,X4,X5,X6,X7,X8,X9], [A,B,C,D,E,F,G,H,I]),
  Row1 is A + B + C,                
  Row2 is D + E + F,
  Row3 is G + H + I,
  Col1 is A + D + G,                
  Col2 is B + E + H,
  Col3 is C + F + I,
  Row1 == Row2,                     
  Row2 == Row3,                    
  Row3 == Col1,                     
  Col1 == Col2,     
  Col2 == Col3,
  N is Row1.