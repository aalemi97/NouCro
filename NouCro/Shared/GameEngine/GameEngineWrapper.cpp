//
//  GameEngineWrapper.cpp
//  NouCro
//
//  Created by AliReza on 2024-10-19.
//

#include "GameEngine.h"
#include "GameEngineWrapper.h"

struct GameEngineWrapper {
    GameEngine* gameEngine;
};

GameEngineWrapper* GameEngineWrapper_init(int playersNumber, int gridSize) {
    GameEngineWrapper* wrapper = new GameEngineWrapper();
    wrapper->gameEngine = new GameEngine(playersNumber, gridSize);
    return wrapper;
};

int GameEngine_addMove(GameEngineWrapper* wrapper, int move[2]) {
    int turn = wrapper->gameEngine->addMove({move[0], move[1]});
    return turn;
};

int GameEngine_undo(GameEngineWrapper* wrapper) {
    int turn = wrapper->gameEngine->undo();
    return turn;
};

int GameEngine_getWinner(GameEngineWrapper* wrapper) {
    int winner = wrapper->gameEngine->getWinner();
    return winner;
};

void GameEngine_resetBoard(GameEngineWrapper* wrapper) {
    wrapper->gameEngine->resetBoard();
};

void GameEngine_deinit(GameEngineWrapper* wrapper) {
    delete wrapper->gameEngine;
    delete wrapper;
};

