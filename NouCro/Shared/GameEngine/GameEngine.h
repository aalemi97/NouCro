//
//  GameEngine.h
//  NouCro
//
//  Created by AliReza on 2024-10-18.
//

#ifndef GameEngine_h
#define GameEngine_h

#include <stdio.h>
#include <iostream>
#include <vector>

using namespace std;

class GameEngine {
    
private:
    int players;
    int n;
    int turn;
    int winner;
    vector<vector<int>> rows;
    vector<vector<int>> cols;
    vector<vector<int>> diag;
    vector<vector<int>> moves;
    void setStateForMove(vector<int> move, int unit);
public:
    GameEngine(int playersNumber, int gridSize);
    int addMove(vector<int> move);
    int undo();
    int getWinner();
    void resetBoard();
};

#endif /* GameEngine_hpp */
