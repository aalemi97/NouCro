//
//  GameEngineWrapper.hpp
//  NouCro
//
//  Created by AliReza on 2024-10-19.
//

#ifndef GameEngineWrapper_h
#define GameEngineWrapper_h

#ifdef __cplusplus
extern "C" {
#endif

typedef struct GameEngineWrapper GameEngineWrapper;

GameEngineWrapper* GameEngineWrapper_init(int playersNumber, int gridSize);
int GameEngine_addMove(GameEngineWrapper* wrapper, int move[2]);
int GameEngine_undo(GameEngineWrapper* wrapper);
int GameEngine_getWinner(GameEngineWrapper* wrapper);
int GameEngine_getTurn(GameEngineWrapper* wrapper);
void GameEngine_deinit(GameEngineWrapper* wrapper);

#ifdef __cplusplus
}
#endif

#endif /* GameEngineWrapper_hpp */
