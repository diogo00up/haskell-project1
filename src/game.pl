
% each cell will either be empty or contain a stack which would endicate Color and how many pieces are stacked together

% player(Player1, Orange).
% player(Player2, Blue ).
% stack(Color, Height).


play :-
    display_menu,
    game_mode(GameMode),
    choose_difficulty(GameMode, Difficulty),
    start_game(GameMode, Difficulty).

display_menu :-
    write('1. Play Human vs Human'), nl,
    write('2. Play Human vs Computer'), nl,
    write('3. Play Computer vs Human'), nl,
    write('4. Play Computer vs Computer'), nl,
    write('Choose an option (1-4): ').


game_mode(GameMode) :-
    read(Input),
    game_mode(Input, GameMode).

game_mode(1, hh).     % Human vs Human
game_mode(2, hc).     % Human vs Computer
game_mode(3, ch).     % Computer vs Human
game_mode(4, cc).     % Computer vs Computer


choose_difficulty(hh, none):-
    write('No difficulty level selection for player vs player: '), nl.

choose_difficulty(hc, Difficulty):-
    write('Choose difficulty level (easy, medium, hard): '), nl,
    read(Difficulty),
    (   difficulty_level(Difficulty)
    ->  true
    ;   write('Invalid difficulty. Setting dificulty to "easy".'), nl,
        Difficulty = easy).

choose_difficulty(ch, Difficulty):-
    write('Choose difficulty level (easy, medium, hard): '), nl,
    read(Difficulty),
    (   difficulty_level(Difficulty)
    ->  true
    ;   write('Invalid difficulty. Setting dificulty to "easy".'), nl,
        Difficulty = easy).

choose_difficulty(cc, Difficulty ):-
    write('Choose difficulty level (easy, medium, hard): '), nl,
    read(Difficulty),
    (   difficulty_level(Difficulty)
    ->  true
    ;   write('Invalid difficulty. Setting dificulty to "easy".'), nl,
        Difficulty = easy).


difficulty_level(easy).
difficulty_level(medium).
difficulty_level(hard).

choose_player(hh, players(Player1,Player2)):-
    Player1 = player(orange, human),  
    Player2 = player(blue, human).
    
choose_player(hc, players(Player1,Player2)):-
    Player1 = player(orange, human),  
    Player2 = player(blue, computer).
    
choose_player(ch, players(Player1,Player2)):-
    Player1 = player(orange, computer),  
    Player2 = player(blue, human).
    
choose_player(cc, players(Player1,Player2)):-
    Player1 = player(orange, computer),  
    Player2 = player(blue, computer).
    

start_game(GameMode, Difficulty) :-
    write('Game initialized with:'),
    choose_player(GameMode,players(Player1,Player2)),
    nl, write('GameMode: ') ,write(GameMode),write(', '),write('Difficulty: '),  write(Difficulty), nl,
    initial_state(game_config(GameMode, Player1, Player2, Difficulty), GameState),
    game_loop(GameState, Difficulty).


play(player(Colour, human),GameState,_):-
    write('HUMAN PLAYING').

play(player(Colour, computer),GameState,easy):-
    write('COMPUTER PLAYING'),nl,
    write('Dificulty: '), write(easy).
    
play(player(Colour, computer),GameState,medium):-
    write('COMPUTER PLAYING'),nl,
    write('Dificulty: '), write(medium).
    
play(player(Colour, computer),GameState,hard):-
    write('COMPUTER PLAYING'),nl,
    write('Dificulty: '), write(hard).
    

game_loop(game_state(Board, CurrentPlayer, NextPlayer, CapturedPieces, RemainingPieces), Difficulty):-
    display_game(game_state(Board, CurrentPlayer, NextPlayer, CapturedPieces, RemainingPieces)),
    play(CurrentPlayer,GameState,Difficulty).



% game_config(GameMode, Player1, Player2, Difficulty)
% game_state(Board, CurrentPlayer, CapturedPieces, RemainingPieces)

initial_state(game_config(GameMode, Player1, Player2, Difficulty), game_state(Board, CurrentPlayer, NextPlayer, CapturedPieces, RemainingPieces)) :-
    board(Board),  
    CurrentPlayer = Player1,
    NextPlayer = Player2,
    CapturedPieces = [],
    RemainingPieces = [].
    

:- use_module(library(lists)).
board(Board) :-
    length(Board, 7),           % Create a list with 7 elements for the rows
    maplist(create_row, Board). 

create_row(Row) :-
    length(Row, 7),            
    maplist(=(empty), Row).    

display_board([]).
display_board([H|T]):-
    write(H),nl,
    display_board(T).

display_game(game_state(Board, CurrentPlayer, NextPlayer, CapturedPieces, RemainingPieces)):-
    write('CURRENT GAME STATE:'),nl,
    write('Current player: '),  write(CurrentPlayer), write(', '),
    write('Next player: '),  write(NextPlayer), write(', '),
    write('Captured peices: '),  write(CapturedPieces), write(', '),
    write('Remaining peices: '),  write(RemainingPieces), write(', '),nl,
    display_board(Board).
