# Junken
# play unlimited times
# summary if player quit

choice <- c("r", "p", "s")
print("r for Rock, p for Paper, s for Scissors or press q to quit")

game <- 1
win_game <- 0
lose_game <- 0
draw_game <- 0

while (game > 0) {
    bot <- sample(choice, size = 1)
    get_rps <- readline("Rock Paper Scissors ? ")
    win <- (get_rps == "r" && bot == "s") ||
           (get_rps == "p" && bot == "r") ||
           (get_rps == "s" && bot == "p")
    lose <- (get_rps == "r" && bot == "p") ||
            (get_rps == "p" && bot == "s") ||
            (get_rps == "s" && bot == "r")

    if (get_rps == "q") {
        print(paste("You played ", game - 1, " games"))
        print(paste("Win ", win_game))
        print(paste("Lose ", lose_game))
        print(paste("Draw ", draw_game))
        break
    } else if (win) {
        print("Won")
        win_game <- win_game + 1
    } else if (lose) {
        print("Lose")
        lose_game <- lose_game + 1
    } else if (get_rps == bot) {
        print("Draw")
        draw_game <- draw_game + 1
    } else {
        print("Try again")
        game <- game - 1
    }
    game <- game + 1
}
