
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

choose_difficulty(cc, (Difficulty1 ,Difficulty2)):-
    write('Set difficulty for Computer 1:'), nl,
    write('Choose difficulty level (easy, medium, hard): '), nl,
    read(Difficulty1),
    (   difficulty_level(Difficulty1)
    ->  true
    ;   write('Invalid difficulty. Setting dificulty to "easy".'), nl,
        Difficulty1 = easy),
    write('Set difficulty for Computer 2:'), nl,
        write('Choose difficulty level (easy, medium, hard): '), nl,
    read(Difficulty2),
    (   difficulty_level(Difficulty2)
    ->  true
    ;   write('Invalid difficulty. Setting dificulty to "easy".'), nl,
        Difficulty2 = easy).


difficulty_level(easy).
difficulty_level(medium).
difficulty_level(hard).


start_game(GameMode, Difficulty) :-
    % InitialState
    initialize_game(GameMode, Difficulty).

initialize_game(GameMode, Difficulty) :-
    write('Game initialized with:'),
    nl, write('GameMode: ') ,write(GameMode),write(', '),write('Difficulty: '),  write(Difficulty), nl,
    write('Game loop begining:').

