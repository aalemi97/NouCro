//
//  GameEngine.cpp
//  NouCro
//
//  Created by AliReza on 2024-10-18.
//

#include "GameEngine.h"

GameEngine::GameEngine(int playersNumber, int gridSize) {
    players = playersNumber;
    n = gridSize;
    resetBoard();
}

int GameEngine::addMove(vector<int> move) {
    if (moves.size() == n * n)
        return turn;
    
    moves.push_back(move);
    setStateForMove(move, 1);
    int r = move[0];
    int c = move[1];
    if (rows[turn][r] == n || cols[turn][c] == n || diag[turn][0] == n || diag[turn][1] == n)
        winner = turn;
    
    if (moves.size() == n * n && winner < 0)
        winner = -1;
    
    if (turn < players - 1)
        turn += 1;
    else
        turn = 0;
    return turn;
}

int GameEngine::undo() {
    if (moves.size() < 1)
        return turn;
    if (turn > 0)
        turn -= 1;
    else
        turn = players - 1;
    unsigned long index = moves.size() - 1;
    vector<int> move = moves[index];
    moves.pop_back();
    setStateForMove(move, -1);
    return turn;
}

void GameEngine::setStateForMove(vector<int> move, int unit) {
    int r = move[0];
    int c = move[1];
    rows[turn][r] += unit;
    cols[turn][c] += unit;
    if (r == c)
        diag[turn][0] += unit;
    if (r + c == n - 1)
        diag[turn][1] += unit;
    return;
}

int GameEngine::getWinner() {
    return winner;
}

void GameEngine::resetBoard() {
    turn = 0;
    rows = {};
    cols = {};
    diag = {};
    moves = {};
    winner = -2;
    for (int i = 0; i < players; i++) {
        vector<int> temp = {};
        for (int j = 0; j < n; j++) {
            temp.push_back(0);
        }
        rows.push_back(temp);
        cols.push_back(temp);
        diag.push_back({0, 0});
    }
}
