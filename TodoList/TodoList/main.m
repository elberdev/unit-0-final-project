//
//  main.m
//  TodoList
//
//  Created by Michael Kavouras on 6/25/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>


//*************************** listItem class *********************************//
@interface ListItem : NSObject

-(void)setItemDescription:(NSString *)itemDescription;
-(NSString *)itemDescription;
-(void)setPriority:(int)priority;
-(int)priority;
-(void)setDoneStatus:(BOOL)doneStatus;
-(BOOL)doneStatus;

@end

@implementation ListItem {
    NSString *_itemDescription;
    int _priority;
    BOOL _doneStatus;
}

-(id)init {
    if(self = [super init]) {
        _priority = 1;
        _doneStatus = NO;
    }
    return self;
}

-(void)setItemDescription:(NSString *)itemDescription {
    _itemDescription = itemDescription;
}

-(NSString *)itemDescription {
    return _itemDescription;
}

-(void)setPriority:(int)priority {
    _priority = priority;
}

-(int)priority {
    return _priority;
}

-(void)setDoneStatus:(BOOL)doneStatus {
    _doneStatus = doneStatus;
}

-(BOOL)doneStatus {
    return _doneStatus;
}

@end
//**************************** end listItem class ****************************//


//******************************** List class ********************************//
@interface List : NSObject

-(void)addListItem:(ListItem *)listItem;
-(NSMutableArray *)listArray;
-(void)removeListItem:(int)index;
-(void)editListItem:(int)index withString:(NSString *)string;
-(void)setName:(NSString*)name;
-(NSString*)name;

@end

@implementation List {
    NSString *_name;
    NSMutableArray *_listArray;
}

-(void)setName:(NSString*)name {
    _name = name;
}

-(NSString*)name {
    return _name;
}

-(void)addListItem:(ListItem *)listItem {
    if (_listArray == nil) {
        _listArray = [[NSMutableArray alloc] init];
    }
    [_listArray addObject:listItem];
}

-(void)removeListItem:(int)index {
    if (_listArray == nil) {
        _listArray = [[NSMutableArray alloc] init];
    }
    
    if (index < [_listArray count]) {
        [_listArray removeObjectAtIndex:index];
    } else {
        NSLog(@"The list item you input does not exist");
    }
}

-(void)editListItem:(int)index withString:(NSString *)string {
    if (_listArray == nil) {
        _listArray = [[NSMutableArray alloc] init];
    }
    
    if (index < [_listArray count]) {
        [[_listArray objectAtIndex:index] setItemDescription:string];

    } else {
        NSLog(@"The list item you input does not exist");
    }
}

-(NSUInteger)showNumberOfItems {
    if (_listArray == nil) {
        _listArray = [[NSMutableArray alloc] init];
    }
    return [_listArray count];
}

-(NSMutableArray *)listArray {
    return _listArray;
}

@end
//****************************** end List class ******************************//


//*************************** ListManager class *******************************//
@interface ListManager : NSObject

-(void)editList;
-(void)run;
-(void)showLists;
-(void)addList:(List *)list;
-(List*)getListByName:(NSString*)listname;
-(void)removeList:(NSString *)name;

@end

@implementation ListManager {
    NSMutableArray *_listDatabase;
}

-(void)editList {
    printf("Name of list to edit:");
    char nameC[256];
    scanf("%255s[^\n]%*c", nameC);
    fpurge(stdin);
    NSString *name = [NSString stringWithCString:nameC
                                        encoding:NSUTF8StringEncoding];
    int input;
    List *tempList = [[List alloc]init];

    printf("What would you like to do? \n 1) Edit list name \n 2) Delete list \n 3) Add an item to list \n 4) Delete an item from list");
    scanf("%d", &input);
    switch (input) {
            
        case 1:
             tempList = [self getListByName:name];
            if (tempList != nil) {
                [tempList setName:@"hello"];
            }
            break;
            
        default:
            printf("placeholder");
            
            
            
    }
    
}

-(void)addList:(List *)list {
    if (_listDatabase == nil) {
        _listDatabase = [[NSMutableArray alloc] init];
    }
    
    [_listDatabase addObject:list];
}

-(void)removeList:(NSString *)name {
    if (_listDatabase == nil) {
        _listDatabase = [[NSMutableArray alloc] init];
    }
    
    BOOL found = NO;
    
    for (int i = 0; i < [_listDatabase count]; i++) {
        if ([_listDatabase[i] name] == name) {
            [_listDatabase removeObjectAtIndex:i];
            found = YES;
        }
    }
    
    if (found == NO) {
        printf("\nThere are no lists matching that name");
    }
    
}
-(List*)getListByName:(NSString*)listname {
    for (int i = 0; i < [_listDatabase count]; i++) {
        if ([listname isEqualToString:[_listDatabase[i] name]]) {
            return _listDatabase[i];
        }
    }
    printf("There are no lists by that name.");
    return nil;
}

-(void)showLists {
    for (int i = 0; i < [_listDatabase count]; i++) {
        printf("%s: %lu items\n", [[_listDatabase[i] name] UTF8String],
               (unsigned long)[_listDatabase[i] showNumberOfItems]);
    }
}

-(void)createList {
    List *list = [[List alloc] init];
    
    printf("\n Please enter a name for your list: ");
    char nameC[256];
    scanf("%255s[^\n]%*c", nameC);
    fpurge(stdin);
    NSString *name = [NSString stringWithCString:nameC
                                         encoding:NSUTF8StringEncoding];
    
    [list setName:name];
    [self addList: list];
    
}
-(void)newItem:(NSString *)listName {
    printf("\n\n  CREATING NEW ITEM IN LIST %s\n", [listName UTF8String]);
    printf("\n    Input to do item description: \n");
    NSString *description = [self parse];
    printf("\n    Input item priority from 1 (most pressing) to 4 (least pressing)\n");
    NSString *priority = [self parse];
    printf("\n    to do item created successfully\n\n");
    [self commandTree:[self parse]];
}
-(NSString *)snip:(NSString *)toDelete fromCommand:(NSString *)command {
    command = [command stringByReplacingOccurrencesOfString:toDelete
                                                 withString:@""];
    
    return command;
}
-(void)newList:(NSString *)listName {
    printf("\n\n  A NEW LIST HAS BEEN CREATED:\n");
    printf("\n      %s\n\n", [listName UTF8String]);
    [self commandTree:[self parse]];
}
-(void)commandTree:(NSString *)command {
    if ([command isEqualToString:@"help"]) {
        [self help];
    } else if ([command containsString:@"new list "]) {
        [self newList:[self snip:@"new list " fromCommand:command]];
    } else if ([command containsString:@"new item in "]) {
        [self newItem:[self snip:@"new item in " fromCommand:command]];
    } else if ([command isEqualToString:@"exit"]) {
        exit(0);
    } else {
        printf("\n  NOT A RECOGNIZED COMMAND\n");
        printf("    Type 'help' for available commands");
        [self commandTree:[self parse]];
    }
}
-(NSString *)parse {
    
    printf("\n    ");
    
    /* Allocate memory and check if okay. */
    char *commandC = malloc (256);
    if (commandC == NULL) {
        printf ("No memory\n");
    }
    
    // fgets is a function analogous to scanf but with better protection against
    // buffer overflow
    fgets (commandC, 256, stdin);
    
    /* Remove trailing newline, if there. */
    if ((strlen(commandC) > 0) && (commandC[strlen (commandC) - 1] == '\n')) {
        commandC[strlen(commandC) - 1] = '\0';
    }
    
    // change C string to NSString
    NSString *command = [NSString stringWithCString:commandC
                                           encoding:NSUTF8StringEncoding];
    
    return command;
}
-(void)help {
    printf("\n\n  AVAILABLE COMMANDS:\n");
    printf("\n      new list <list name>\n");
    printf("\n      new item in <list name>\n");
    printf("\n      delete list <list name / all>\n");
    printf("\n      edit list <list name>\n");
    printf("\n      display list <list name / all>\n\n");
    printf("\n      exit \n\n");
    [self commandTree:[self parse]];
}
-(void)run {
    printf("\n  Welcome to the Elbo-Yucatan To-Do List Management System. \n");
    printf("\n    Type a command (or type 'help' for instructions)\n\n");
    [self commandTree:[self parse]];
}
@end
//************************** end ListManager class ***************************//


int main(int argc, const char * argv[]) {
    @autoreleasepool {

        // insert code here...
//        char string[256];
//        scanf("%255s", &string);
//        NSString *firstName = [NSString stringWithCString:string encoding:1];
//        NSLog(@"%@", firstName);
        
        ListItem *item1 = [[ListItem alloc] init];
        [item1 setItemDescription:@"do laundry"];
        ListItem *item2 = [[ListItem alloc] init];
        [item2 setItemDescription:@"kill bad guys"];
        ListItem *item3 = [[ListItem alloc] init];
        [item3 setItemDescription:@"call Robin"];
        ListItem *item4 = [[ListItem alloc] init];
        [item1 setItemDescription:@"polish bat-mobile"];
        ListItem *item5 = [[ListItem alloc] init];
        [item2 setItemDescription:@"grab a beer with Joker"];
        ListItem *item6 = [[ListItem alloc] init];
        [item3 setItemDescription:@"look mysterious"];
        
        List *list = [[List alloc] init];
        [list addListItem:item1];
        [list addListItem:item2];
        [list addListItem:item3];
        [list setName:@"urgent"];
        
        List *list2 = [[List alloc] init];
        [list2 addListItem:item4];
        [list2 addListItem:item5];
        [list2 addListItem:item6];
        [list2 setName:@"monty python"];
        
        NSMutableArray *arrayList = [list listArray];
        
        for(int i = 0; i < [arrayList count]; i++) {
            NSLog(@"%@", [arrayList[i] itemDescription]);
        }
        
        [list removeListItem:2];
        
        for(int i = 0; i < [arrayList count]; i++) {
            NSLog(@"%@", [arrayList[i] itemDescription]);
        }
        
        [list editListItem:0 withString:@"elect Bernie Sanders president"];
        
        for(int i = 0; i < [arrayList count]; i++) {
            NSLog(@"%@", [arrayList[i] itemDescription]);
        }
        ListManager *myListManager = [[ListManager alloc]init];
        [myListManager addList:list];
        [myListManager addList:list2];
        //[myListManager showLists];
        [myListManager run];

    }
    return 0;
}
