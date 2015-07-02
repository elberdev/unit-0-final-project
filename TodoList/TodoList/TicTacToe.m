//
//  TicTacToe.m
//  TodoList
//
//  Created by Elber Carneiro on 7/2/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "TicTacToe.h"

/////// TIC TAC TOE DEFINITION ///////
@implementation TicTacToe {
    NSMutableArray * _board;
    NSArray * _coinFaces;
    NSString * _playerSelection;
    char _headsTails;
}



- (NSArray *)coinFaces{
    
    _coinFaces = @[@"h",@"t"];
    
    return _coinFaces;
    
}
- (NSString *)playerSelection {
    
    return _playerSelection;
}

- (char)headsOrtails {
    
    do
    {
        printf("\nChoose heads(h) or tails(t): ");
        scanf("%c", &_headsTails);
        fpurge(stdin);
        if(_headsTails == 'h') {
            printf("\nYou chose Heads\n");
        } else if (_headsTails == 't'){
            printf("You chose Tails\n");
        }
        
    } while (_headsTails != 'h' && _headsTails != 't');
    return _headsTails;
    
}
- (NSString *)returnCoin:(char)coin {
    
    _playerSelection = [NSString stringWithFormat:@"%c", _headsTails];
    
    return _playerSelection;
    
    
}

- (void)coinCalculating:(NSArray *)coins {
    
    NSUInteger randomNumber = arc4random_uniform((int)[_coinFaces count]);
    
    NSString *result = [_coinFaces objectAtIndex:randomNumber];
    
    if ([result isEqualToString:[_coinFaces firstObject]]) {
        printf("\nCoin is on Heads\n\n");
    } else if ([result isEqualToString:[_coinFaces lastObject]]) {
        printf("\nCoin is on Tails\n\n");
    }
    
    
    if([result isEqualToString: _playerSelection]) {
        printf("Nice! you are Player 1. You get to go first. :D\n\n");
    } else {
        printf("Bummer, Looks like you are Player 2\n\n");
    }
    
    const char *c = [_playerSelection UTF8String];
    const char *results = [result UTF8String];
    
    printf("PLAYER INPUT: %s\n", c);
    
    printf("RANDOM TOSS: %s\n", results);
}

- (void)printWinnerX {
    
    
    printf(" `8.`8888.      ,8'          `8.`888b                 ,8' 8 8888 b.             8    d888888o.\n");
    printf("  `8.`8888.    ,8'            `8.`888b               ,8'  8 8888 888o.          8  .`8888:' `88.\n");
    printf("   `8.`8888.  ,8'              `8.`888b             ,8'   8 8888 Y88888o.       8  8.`8888.   Y8\n");
    printf("    `8.`8888.,8'                `8.`888b     .b    ,8'    8 8888 .`Y888888o.    8  `8.`8888.\n");
    printf("     `8.`88888'                  `8.`888b    88b  ,8'     8 8888 8o. `Y888888o. 8   `8.`8888.\n");
    printf("     .88.`8888.                   `8.`888b .`888b,8'      8 8888 8`Y8o. `Y88888o8    `8.`8888.\n");
    printf("    .8'`8.`8888.                   `8.`888b8.`8888'       8 8888 8   `Y8o. `Y8888     `8.`8888.\n");
    printf("   .8'  `8.`8888.                   `8.`888`8.`88'        8 8888 8      `Y8o. `Y8 8b   `8.`8888.\n");
    printf("  .8'    `8.`8888.                   `8.`8' `8,`'         8 8888 8         `Y8o.` `8b.  ;8.`8888\n");
    printf(" .8'      `8.`8888.                   `8.`   `8'          8 8888 8            `Yo  `Y8888P ,88P'\n");
}

- (void)printWinnerO {
    
    
    printf("     ,o888888o.              `8.`888b                 ,8' 8 8888 b.             8    d888888o.\n");
    printf("  . 8888     `88.             `8.`888b               ,8'  8 8888 888o.          8  .`8888:' `88.\n");
    printf(" ,8 8888       `8b             `8.`888b             ,8'   8 8888 Y88888o.       8  8.`8888.   Y8\n");
    printf(" 88 8888        `8b             `8.`888b     .b    ,8'    8 8888 .`Y888888o.    8  `8.`8888.\n");
    printf(" 88 8888         88              `8.`888b    88b  ,8'     8 8888 8o. `Y888888o. 8   `8.`8888.\n");
    printf(" 88 8888         88               `8.`888b .`888b,8'      8 8888 8`Y8o. `Y88888o8    `8.`8888.\n");
    printf(" 88 8888        ,8P                `8.`888b8.`8888'       8 8888 8   `Y8o. `Y8888     `8.`8888.\n");
    printf(" `8 8888       ,8P                  `8.`888`8.`88'        8 8888 8      `Y8o. `Y8 8b   `8.`8888.\n");
    printf("  ` 8888     ,88'                    `8.`8' `8,`'         8 8888 8         `Y8o.` `8b.  ;8.`8888\n");
    printf("     `8888888P'                       `8.`   `8'          8 8888 8            `Yo  `Y8888P ,88P'\n");
    
    
}

- (void)printIntroduction{
    
    printf( "\n\n\tTic Tac Toe\n\n");
    printf( "Player 1 (X)  -  Player 2 (O) \n \n");
    printf("\n");
    printf( "     |     |     \n" );
    printf( " [1] | [2] | [3] \n");
    printf( "_____|_____|_____\n") ;
    printf( "     |     |     \n") ;
    printf( " [4  | [5] | [6] \n");
    printf( "_____|_____|_____\n") ;
    printf( "     |     |     \n") ;
    printf( " [7] | [8] | [9] \n");
    printf( "     |     |     \n \n") ;
    
}

- (int)introMessage {
    printf(" \n\n");
    printf("///////////////////////////////////////////////////////////////////////////////// \n\n");
    printf("######## ####  ######     ########    ###     ######  ########  #######  ########\n");
    printf("   ##     ##  ##    ##       ##      ## ##   ##    ##    ##    ##     ## ##\n");
    printf("   ##     ##  ##             ##     ##   ##  ##          ##    ##     ## ##\n");
    printf("   ##     ##  ##             ##    ##     ## ##          ##    ##     ## ######\n");
    printf("   ##     ##  ##             ##    ######### ##          ##    ##     ## ##\n");
    printf("   ##     ##  ##    ##       ##    ##     ## ##    ##    ##    ##     ## ##\n");
    printf("   ##    ####  ######        ##    ##     ##  ######     ##     #######  ########\n");
    printf(" \n\n");
    printf("///////////////////////////////////////////////////////////////////////////////// \n");
    printf("////                                                                         //// \n");
    printf("////                        PRESS 1 for ONE PLAYER MODE                      //// \n");
    printf("////                                                                         //// \n");
    printf("////                        PRESS 2 for TWO PLAYER MODE                      //// \n");
    printf("////                                                                         //// \n");
    printf("////                                                                         //// \n");
    printf("////                                                                         //// \n");
    printf("///////////////////////////////////////////////////////////////////////////////// \n\n");
    
    int playerMode;
    printf("ENTER: ");
    scanf("%d", &playerMode);
    fpurge(stdin);
    
    
    int mode;
    
    if (playerMode == 1){
        
        mode = 1;
        
    } else if (playerMode == 2) {
        
        mode = 2;
        
    } else {
        
        mode = 0;
    }
    
    return mode;
}

- (NSMutableArray *)board{
    
    _board = [NSMutableArray arrayWithObjects: @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    
    return _board;
}


- (void)playerOne{
    
    printf("PLAYER ONE MOVE:  ");
    int x;
    scanf("%d", &x);
    printf("\n");
    BOOL wrongMove = false;
    
    do {
        if (!(x < 10)){
            printf("Please pick a valid number: ");
            scanf("%d", &x);
            printf("\n");
            wrongMove = true;
        }
        
        if (x < 10){
            if (![[_board objectAtIndex:x - 1] isEqualToString:@"o"] && ![[_board objectAtIndex:x - 1] isEqualToString:@"x"]) {
                // valid input
                _board[x - 1] = @"x";
                break;
            }
            else {
                // already taken
                printf("Please pick a valid number: ");
                scanf("%d", &x);
                printf("\n");
                wrongMove = true;
            }
        }
        
    } while (wrongMove);
    
}

- (void)playerTwo {
    
    printf("PLAYER TWO MOVE:  ");
    int o;
    scanf("%d", &o);
    printf("\n");
    BOOL wrongMove = false;
    
    do {
        if (!(o < 10)){
            printf("Please pick a valid number: ");
            scanf("%d", &o);
            printf("\n");
            wrongMove = true;
        }
        if (o < 10){
            if (![[_board objectAtIndex:o - 1] isEqualToString:@"o"] && ![[_board objectAtIndex:o - 1] isEqualToString:@"x"]) {
                // valid input
                _board[o - 1] = @"o";
                break;
            }
            else {
                // already taken
                printf("Please pick a valid number: ");
                scanf("%d", &o);
                printf("\n");
                wrongMove = true;
            }
        }
        
    } while (wrongMove);
    
}

- (void)computerEasy {
    printf("COMPUTER MOVE:  ");
    
    NSMutableArray *emptySpaces = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < [_board count]; i++){
        NSString *currentVal = [_board objectAtIndex:i];
        
        if (![currentVal isEqualToString:@"x"] && ![currentVal isEqualToString:@"o"]){
            
            [emptySpaces addObject:@(i)];
        }
    }
    
    int fromNumber = 1;
    int toNumber = (int)[emptySpaces count];
    int randomNumber = (arc4random()%(toNumber-fromNumber))+fromNumber;
    
    int computerSelection = [[emptySpaces objectAtIndex:randomNumber] integerValue];
    _board[computerSelection] = @"o";
    
}


- (void)printBoard {
    
    
    printf("\n");
    printf("     |     |     \n" );
    printf(" [%s] | [%s] | [%s] \n", [_board[0] UTF8String], [_board[1] UTF8String], [_board[2]UTF8String]);
    printf("_____|_____|_____\n")  ;
    printf("     |     |     \n") ;
    printf(" [%s] | [%s] | [%s] \n", [_board[3] UTF8String], [_board[4] UTF8String], [_board[5]UTF8String]);
    printf("_____|_____|_____\n") ;
    printf("     |     |     \n") ;
    printf(" [%s] | [%s] | [%s] \n", [_board[6] UTF8String], [_board[7] UTF8String],[_board[8] UTF8String]);
    printf("     |     |     \n \n") ;
    
    
}


- (BOOL)oneVoneGameState:(int)num{
    
    
    [self board]; // array
    
    
    int tries = 0;
    int maxTries = 20;
    while (tries < maxTries){
        
        [self playerOne];
        
        [self printBoard];
        
        if ([self correctCheck]) {
            break;
        }
        
        if ([self draw] == true){
            printf("It's a draw!");
            break;
        }
        
        
        [self playerTwo];
        
        [self printBoard];
        
        if ([self correctCheck]) {
            break;
        }
        
        if ([self draw] == true){
            printf("It's a draw!");
            break;
        }
        
        tries++;
        
        
    }
    
    
    
    
    return true;
}

- (BOOL)correctCheck {
    
    ////// HORIZONTAL CHECK
    
    BOOL win = false;
    
    // FIRST ROW
    
    if([[_board objectAtIndex:0] isEqualToString:@"x"] && [[_board objectAtIndex:1] isEqualToString:@"x"] && [[_board objectAtIndex:2] isEqualToString:@"x"]){
        
        [self printWinnerX];
        win = true;
    }
    
    else if ([[_board objectAtIndex:0] isEqualToString:@"o"] && [[_board objectAtIndex:1] isEqualToString:@"o"] && [[_board objectAtIndex:2] isEqualToString:@"o"]) {
        
        [self printWinnerO];
        win = true;
        
    }
    
    // SECOND ROW
    
    if([[_board objectAtIndex:3] isEqualToString:@"x"] && [[_board objectAtIndex:4] isEqualToString:@"x"] && [[_board objectAtIndex:5] isEqualToString:@"x"]){
        
        [self printWinnerX];
        win = true;
    }
    
    else if ([[_board objectAtIndex:3] isEqualToString:@"o"] && [[_board objectAtIndex:4] isEqualToString:@"o"] && [[_board objectAtIndex:5] isEqualToString:@"o"]) {
        
        [self printWinnerO];
        win = true;
        
    }
    
    // THIRD ROW
    
    if([[_board objectAtIndex:6] isEqualToString:@"x"] && [[_board objectAtIndex:7] isEqualToString:@"x"] && [[_board objectAtIndex:8] isEqualToString:@"x"]){
        
        [self printWinnerX];
        win = true;
    }
    
    else if ([[_board objectAtIndex:6] isEqualToString:@"o"] && [[_board objectAtIndex:7] isEqualToString:@"o"] && [[_board objectAtIndex:8] isEqualToString:@"o"]) {
        
        [self printWinnerO];
        win = true;
        
    }
    
    
    ////// VERTICAL CHECK
    
    // FIRST COLUMN
    
    if([[_board objectAtIndex:0] isEqualToString:@"x"] && [[_board objectAtIndex:3] isEqualToString:@"x"] && [[_board objectAtIndex:6] isEqualToString:@"x"]){
        
        [self printWinnerX];
        win = true;
    }
    
    else if ([[_board objectAtIndex:0] isEqualToString:@"o"] && [[_board objectAtIndex:3] isEqualToString:@"o"] && [[_board objectAtIndex:6] isEqualToString:@"o"]) {
        
        [self printWinnerO];
        win = true;
        
    }
    
    // SECOND COLUMN
    
    if([[_board objectAtIndex:1] isEqualToString:@"x"] && [[_board objectAtIndex:4] isEqualToString:@"x"] && [[_board objectAtIndex:7] isEqualToString:@"x"]){
        
        [self printWinnerX];
        win = true;
    }
    
    else if ([[_board objectAtIndex:1] isEqualToString:@"o"] && [[_board objectAtIndex:4] isEqualToString:@"o"] && [[_board objectAtIndex:7] isEqualToString:@"o"]) {
        
        [self printWinnerO];
        win = true;
        
    }
    
    // THIRD COLUMN
    
    if([[_board objectAtIndex:2] isEqualToString:@"x"] && [[_board objectAtIndex:5] isEqualToString:@"x"] && [[_board objectAtIndex:8] isEqualToString:@"x"]){
        
        [self printWinnerX];
        win = true;
    }
    
    else if ([[_board objectAtIndex:2] isEqualToString:@"o"] && [[_board objectAtIndex:5] isEqualToString:@"o"] && [[_board objectAtIndex:8] isEqualToString:@"o"]) {
        
        [self printWinnerO];
        win = true;
        
    }
    
    
    ////// DIAGONAL CHECK
    
    //     \\\\
    //      \\\\
    //     --------
    //      \ \ \ \
    //        \ \ \
    //          \ \
    //            \
    
    if([[_board objectAtIndex:0] isEqualToString:@"x"] && [[_board objectAtIndex:4] isEqualToString:@"x"] && [[_board objectAtIndex:8] isEqualToString:@"x"]){
        
        [self printWinnerX];
        win = true;
    }
    
    else if ([[_board objectAtIndex:0] isEqualToString:@"o"] && [[_board objectAtIndex:4] isEqualToString:@"o"] && [[_board objectAtIndex:8] isEqualToString:@"o"]) {
        
        [self printWinnerO];
        win = true;
        
    }
    
    //         ////
    //        ////
    //      --------
    //      / / / /
    //      / / /
    //      / /
    //      /
    
    if([[_board objectAtIndex:2] isEqualToString:@"x"] && [[_board objectAtIndex:4] isEqualToString:@"x"] && [[_board objectAtIndex:6] isEqualToString:@"x"]){
        
        [self printWinnerX];
        win = true;
    }
    
    else if ([[_board objectAtIndex:2] isEqualToString:@"o"] && [[_board objectAtIndex:4] isEqualToString:@"o"] && [[_board objectAtIndex:6] isEqualToString:@"o"]) {
        
        [self printWinnerO];
        win = true;
        
    }
    
    return win;
}

- (BOOL)onePlayerGameState:(int)num{
    
    [self board]; // array
    int tries = 0;
    int maxTries = 20;
    while (tries < maxTries){
        
        [self playerOne];
        
        [self printBoard];
        
        if ([self correctCheck]) {
            break;
        }
        
        
        [self computerEasy];
        
        [self printBoard];
        
        if ([self correctCheck]) {
            break;
        }
        
        
        
        tries++;
        
    }
    
    return true;
}

- (BOOL)draw {
    
    BOOL gameDraw = false;
    NSMutableArray *emptySpaces = [[NSMutableArray alloc]init];
    for (int i = 0; i < [_board count]; i++){
        NSString *currentVal = [_board objectAtIndex:i];
        
        if (![currentVal isEqualToString:@"x"] && ![currentVal isEqualToString:@"o"]){
            
            [emptySpaces addObject:@(i)];
            
            
        }
    }
    
    int toNumber = (int)[emptySpaces count];
    
    if (toNumber == 0){
        gameDraw = true;
    }
    
    return gameDraw;
}

-(void)run {
    
    int playAgain;
    do {
        
        int playerChoose = [self introMessage];
        
        if (playerChoose == 2){
            
            char coinSide = [self headsOrtails];
            
            NSArray *cointItself = [self coinFaces];
            
            [self returnCoin:coinSide];
            
            [self coinCalculating: cointItself];
            
            [self printIntroduction];
            
            [self oneVoneGameState:0];}
        
        
        
        else if (playerChoose == 1){
            
            [self printIntroduction];
            
            [self onePlayerGameState:0];
        }
        
        printf("\n\nDo you want to play again?\n\n");
        printf("PRESS 1 for YES or PRESS 2 for NO\n\n");
        printf("ENTER: ");
        scanf("%d", &playAgain);
        fpurge(stdin);
        
        
    } while (playAgain == 1);
    
    return;
}

@end
