//
//  GameEngineProvider.h
//  NouCro
//
//  Created by AliReza on 2024-10-20.
//

#import <Foundation/Foundation.h>

#ifndef GameEngineProvider_h
#define GameEngineProvider_h

NS_ASSUME_NONNULL_BEGIN

@protocol GameEngineProvider <NSObject>

- (instancetype)initWithPlayersNumber:(int)playersNumber gridSize:(int)gridSize;

- (NSInteger)addMove:(NSArray<NSNumber *> *)move;

- (NSInteger)undo;

- (NSInteger)getWinner;

- (NSInteger)getTurn;

@end

NS_ASSUME_NONNULL_END


#endif /* GameEngineProvider_h */
