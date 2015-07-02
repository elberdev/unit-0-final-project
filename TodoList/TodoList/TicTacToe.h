//
//  TicTacToe.h
//  TodoList
//
//  Created by Elber Carneiro on 7/2/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

// Kaira and Christella
// Tic Tac Toe Project

//HI HELLO

/////// TIC TAC TOE DECLATRATION ///////

@interface TicTacToe : NSObject

- (void)printIntroduction;
- (int)introMessage;
- (void)printBoard;
- (void)playerOne;
- (void)playerTwo;
- (NSMutableArray *)board;
- (NSString *)returnCoin:(char)headsTails;
- (NSArray *)coinFaces;
- (NSString *)playerSelection;
- (BOOL)correctCheck;
- (BOOL)oneVoneGameState:(int)num;
- (BOOL)onePlayerGameState:(int)num;
- (void)computerEasy;
- (void)printWinnerX;
- (void)printWinnerO;
- (void)coinCalculating:(NSArray *)coins;
- (char)headsOrtails;
- (BOOL)draw;
- (void)run;

@end

