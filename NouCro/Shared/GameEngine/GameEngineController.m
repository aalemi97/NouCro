//
//  GameEngineController.m
//  NouCro
//
//  Created by AliReza on 2024-10-19.
//

#import "GameEngineController.h"
#import "GameEngineWrapper.h"

@interface GameEngineController()

@property (atomic) GameEngineWrapper* wrapper;

@end

@implementation GameEngineController

- (nonnull instancetype)initWithPlayersNumber:(int)playersNumber gridSize:(int)gridSize {
    self = [super init];
    if (self) {
        self.wrapper = GameEngineWrapper_init(playersNumber, gridSize);
    }
    return self;
}

- (NSInteger)addMove:(NSArray<NSNumber *> * _Nonnull)move {
    @autoreleasepool {
        int newMove[2];
        newMove[0] = [move[0] intValue];
        newMove[1] = [move[1] intValue];
        int turn = GameEngine_addMove(self.wrapper, newMove);
        return turn;
    }
}

- (NSInteger)getWinner {
    int winner = GameEngine_getWinner(self.wrapper);
    return winner;
}

- (NSInteger)undo { 
    int turn = GameEngine_undo(self.wrapper);
    return turn;
}

- (void)dealloc {
    GameEngine_deinit(self.wrapper);
}

@end
