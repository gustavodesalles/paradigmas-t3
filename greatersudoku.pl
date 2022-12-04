:- use_module(library(clpfd)).

greatersudoku(Rows, Horizontals, Verticals) :-
        length(Rows, 9), maplist(same_length(Rows), Rows),
        append(Rows, Vs),
        Vs ins 1..9,
        length(Horizontals, 9), maplist(same_length([0,1,2,3,4,5]), Horizontals),
        append(Horizontals, Ws),
        Ws ins 0..1,
        length(Verticals, 9), maplist(same_length([0,1,2,3,4,5]), Verticals),
        append(Verticals, Ws),
        maplist(all_distinct, Rows),
        transpose(Rows, Columns),
        maplist(all_distinct, Columns),
        Rows = [As,Bs,Cs,Ds,Es,Fs,Gs,Hs,Is],
        Horizontals = [H1,H2,H3,H4,H5,H6,H7,H8,H9],
        Horizontals = [V1,V2,V3,V4,V5,V6,V7,V8,V9],
        blocks(As, Bs, Cs, [H1,H2,H3], [V1,V2,V3]),
        blocks(Ds, Es, Fs, [H4,H5,H6], [V4,V5,V6]),
        blocks(Gs, Hs, Is, [H7,H8,H9], [V7,V8,V9]).

blocks([], [], [], _, _).
blocks([N1,N2,N3|Ns1], [N4,N5,N6|Ns2], [N7,N8,N9|Ns3], [Ha|HOR], [Va|VER]) :-
        all_distinct([N1,N2,N3,N4,N5,N6,N7,N8,N9]),
        Ha = [C1,C2,C3,C4,C5,C6],
        Va = [D1,D2,D3,D4,D5,D6],
        comp(N1,C1,N2), comp(N2,C2,N3), comp(N4,C3,N5), comp(N5,C4,N6), comp(N7,C5,N8), comp(N8,C6,N9),
        comp(N1,D1,N4), comp(N4,D2,N7), comp(N2,D3,N5), comp(N5,D4,N8), comp(N3,D5,N6), comp(N6,D6,N9),
        blocks(Ns1, Ns2, Ns3, HOR, VER).

comp(X,0,Y) :- X #< Y.
comp(X,1,Y) :- comp(Y,0,X).
