//
//  main.m
//  TodoList
//
//  Created by Elber Carneiro and Jackie Meggesto on 6/25/15.
//  Copyright (c) 2015 Jackie Meggesto and Elber Carneiro. All rights reserved.
//

#import <Foundation/Foundation.h>


//*************************** listItem class *********************************//
@interface ListItem : NSObject

-(void)setItemDescription:(NSString *)itemDescription;
-(NSString *)itemDescription;
-(void)setItemPriority:(int)itemPriority;
-(int)itemPriority;
-(void)setDoneStatus:(BOOL)doneStatus;
-(BOOL)doneStatus;

@end

@implementation ListItem {
    NSString *_itemDescription;
    int _itemPriority;
    BOOL _doneStatus;
    NSDate *_dueDate;
}

-(id)init {
    if(self = [super init]) {
        _itemPriority = 1;
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

-(void)setItemPriority:(int)priority {
    _itemPriority = priority;
}

-(int)itemPriority {
    return _itemPriority;
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

-(id)init {
    if (self = [super init]) {
        _listArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)setName:(NSString*)name {
    _name = name;
}

-(NSString*)name {
    if (_name == nil) {
        _name = [[NSString alloc] init];
    }
    return _name;
}

-(void)addListItem:(ListItem *)listItem {
    [self.listArray addObject:listItem];
}

-(void)removeListItem:(int)index {
    
    if (index < [self.listArray count]) {
        [self.listArray removeObjectAtIndex:index];
    } else {
        printf("The list item you input does not exist\n");
    }
}

-(void)editListItem:(int)index withString:(NSString *)string {
    
    if (index < [self.listArray count]) {
        [[self.listArray objectAtIndex:index] setItemDescription:string];

    } else {
        NSLog(@"\n  The list item you input does not exist");
    }
}

-(NSUInteger)showNumberOfItems {
    
    return [self.listArray count];
}

-(NSMutableArray *)listArray {
    if (_listArray == nil) {
        _listArray = [[NSMutableArray alloc] init];
    }
    return _listArray;
}

@end
//****************************** end List class ******************************//


//*************************** ListManager class *******************************//
@interface ListManager : NSObject

-(void)run;

@end

@implementation ListManager {
    NSMutableArray *_listDatabase;
}

-(id)init {
    if (self = [super init]) {
        _listDatabase = [[NSMutableArray alloc] init];
    }
    return self;
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
        if ([[_listDatabase[i] name] isEqualToString:name]) {
            [_listDatabase removeObjectAtIndex:i];
            found = YES;
        }
    }
    
    if (found == NO) {
        printf("\nThere are no lists matching that name");
    }
    
}

-(List*)getListByName:(NSString*)listname {
    if (_listDatabase == nil) {
        _listDatabase = [[NSMutableArray alloc] init];
    }
    
    for (int i = 0; i < [_listDatabase count]; i++) {
        if ([listname isEqualToString:[_listDatabase[i] name]]) {
            return _listDatabase[i];
        }
    }
    printf("\n  There are no lists by that name.\n\n");
    [self commandTree:[self parse]];
    return nil;
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

-(void)newList:(NSString *)newListName {
    List *list = [[List alloc] init];
    
    [list setName:newListName];
    [self addList:list];
    printf("\n\n  A NEW LIST HAS BEEN CREATED:\n");
    printf("\n      %s\n\n", [newListName UTF8String]);
    
    [self commandTree:[self parse]];
}

-(void)deleteList:(NSString *)listName {
    [self getListByName:listName];
    
    NSString *confirm;
    
    while (true) {
        printf("\n\n  ARE YOU SURE YOU WANT TO DELETE LIST %s?\n",
               [listName UTF8String]);
        printf("\n    RE-ENTER THE LIST NAME TO CONFIRM or type 'cancel' to abort\n");
        confirm = [self parse];
        if ([confirm isEqualToString:listName]) {
            [self removeList:listName];
            printf("\n    LIST %s HAS BEEN DELETED.\n", [listName UTF8String]);
            break;
        } else if ([confirm isEqualToString:@"cancel"]) {
            printf("\n    ABORTING DELETION.\n");
            break;
        } else {
            printf("\n    list name mismatch.\n");
        }
    }
    printf("\n");
    
    [self commandTree:[self parse]];
    
}

-(void)renameList:(NSString *)listName {
    
    [self getListByName:listName];
    printf("\n\n  PLEASE ENTER NEW NAME FOR LIST %s\n", [listName UTF8String]);
    NSString *newName = [self parse];
    [[self getListByName:listName] setName:newName];
    printf("\n    List %s has been renamed %s\n\n", [listName UTF8String],
           [newName UTF8String]);
    [self commandTree:[self parse]];
}

-(void)displayList:(NSString *)listName {
    
    if ([_listDatabase count] == 0) {
            printf("\n\n  NO TO-DO LISTS TO DISPLAY\n");
    } else if ([listName isEqualToString:@"all"]) {
        printf("\n\n  DISPLAYING ALL TO-DO LISTS\n");
        for (int i = 0; i < [_listDatabase count]; i++) {
            printf("\n    %s: %lu items\n", [[_listDatabase[i] name] UTF8String],
                   (unsigned long)[_listDatabase[i] showNumberOfItems]);
        }
    } else {
        printf("\n\n  DISPLAYING LIST %s\n", [listName UTF8String]);
        [self displayItems:listName withPrompt:NO];
    }
    printf("\n");
    
    [self commandTree:[self parse]];
}

-(void)newItem:(NSString *)listName {
    [self getListByName:listName];
    ListItem *newItem = [[ListItem alloc]init];
    
    printf("\n\n  CREATING NEW ITEM IN LIST %s\n", [listName UTF8String]);
    printf("\n    Input to do item description: \n");
    NSString *description = [self parse];
    [newItem setItemDescription:description];
    printf("\n    Input item priority from 1 (most pressing) to 4 (least pressing)\n\n    ");
    int priority;
    scanf("%d%*c", &priority);
    fpurge(stdin);
    [newItem setItemPriority:priority];
    [[[self getListByName:listName] listArray] addObject:newItem];
    
    printf("\n    to do item created successfully\n\n");
    [self commandTree:[self parse]];
}

-(void)displayItems:(NSString *)listName withPrompt:(BOOL)prompt{
    if (prompt == YES) {
        printf("\n\n  DISPLAYING ITEMS IN LIST %s\n\n", [listName UTF8String]);
    }
    
    List *list = [self getListByName:listName];
    NSMutableArray *array = [list listArray];
    
    [self formatItems:array];
    
    if (prompt == YES) {
       [self commandTree:[self parse]];
    }
    
}

//////////// call this in displayItems //////////////////////////////////////////////////////
-(NSArray *)sortItems:(NSMutableArray *)array
                          by:(NSString *)descriptor
                   ascending:(BOOL)ascending {
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] init];
    
    if ([descriptor isEqualToString:@"itemPriority"]) {
        sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:descriptor
                                                       ascending:ascending];
    } else {
        sortDescriptor = [NSSortDescriptor
                          sortDescriptorWithKey:descriptor
                                      ascending:ascending
                                       selector:@selector(localizedStandardCompare:)];
    }

    return [array sortedArrayUsingDescriptors:@[sortDescriptor]];
 
}
/////////////////////////////////////////////////////////////////////////////////////////////


-(void)formatItems:(NSMutableArray *)array {
    
    if ([array count] == 0) {
        printf("\n      No items to display\n\n");
        return;
    }
    
    // figure out if i have to add any padding before any of the numbers by
    // seeing how long the array is
    int biggestNumPadding = 0;
    NSString *arrayCount = [NSString stringWithFormat:@"%lu", [array count]];
    biggestNumPadding = (int) [arrayCount length];
    NSString* num = [[NSString alloc] init];
    
    // figure out which item description is the longest so you can use its
    // length as the standard for formatting
    NSString *description = [NSString stringWithFormat:@"description"];
    int longestLength = (int) [description length];
    for (int i = 0; i < [array count]; i++) {
        if ([[array[i] itemDescription] length] > longestLength) {
            longestLength = (int) [[array[i] itemDescription] length];
        }
    }
    
    // crazy c formatting I have to use to make everything pretty
    printf("\n     |  %*s  %-*s  priority  completed\n", biggestNumPadding,
           [[NSString stringWithFormat:@" "] UTF8String], longestLength,
           [description UTF8String]);
    
    for (int i = 0; i < [array count]; i++) {
        printf("     |\n     |  %*s) %-*s      %d         %s    \n",
               biggestNumPadding,
               [(num = [NSString stringWithFormat:@"%d", i]) UTF8String],
               longestLength, [[array[i] itemDescription] UTF8String],
               (int)[array[i] itemPriority],
               [[array[i] doneStatus] ? @"Y" : @"N" UTF8String]);
    }
    printf("\n");
}

-(void)deleteItems:(NSString *)listName {
    [self getListByName:listName];
    while (true) {
        printf("\n\n  DELETING ITEMS IN LIST %s\n", [listName UTF8String]);
        [self displayItems:listName withPrompt:NO];
        printf("    Please select an item to be deleted:\n\n    ");
        int input;
        scanf("%d%*c", &input);
        fpurge(stdin);
        [[self getListByName:listName] removeListItem:input];
        printf("\n    Item has been deleted.\n");
        printf("\n    Do you want to delete more items? y/n\n");
        NSString *deletion = [self parse];
        if ([deletion isEqualToString:@"y"]) {
            printf("\n\n  RETURNING TO NORMAL PROMPT\n");
            continue;
        } else if ([deletion isEqualToString:@"n"]) {
            break;
        } else {
            printf("\n    Invalid command.\n");
        }
        
        
    }
    [self commandTree:[self parse]];
}

-(void)displayAllItems:(NSString *)order {
    
    NSMutableArray *combinedList = [[NSMutableArray alloc] init];
    for (int i = 0; i < [_listDatabase count]; i++) {
        for (int j = 0; j < [[_listDatabase[i] listArray] count]; j++) {
            [combinedList addObject:[[_listDatabase[i] listArray] objectAtIndex:j]];
        }
    }
    
    [self formatItems:combinedList];
    
//    if([order isEqualTo:@"urgent first"]) {
//        for (int i = 1; i <= 4; i++) {
//            for (int j = 0; j < [combinedList count]; j++) {
//                
//            }
//        }
//    }
    
    [self commandTree:[self parse]];
    
}

-(NSString *)snip:(NSString *)toDelete fromCommand:(NSString *)command {
    command = [command stringByReplacingOccurrencesOfString:toDelete
                                                 withString:@""];
    
    return command;
}

-(void)commandTree:(NSString *)command {
    if ([command isEqualToString:@"help"]) {
        [self help];
    } else if ([command containsString:@"new list "]) {
        [self newList:[self snip:@"new list " fromCommand:command]];
    } else if ([command containsString:@"delete list "]) {
        [self deleteList:[self snip:@"delete list " fromCommand:command]];
    } else if ([command containsString:@"rename list "]) {
        [self renameList:[self snip:@"rename list " fromCommand:command]];
    } else if ([command containsString:@"display list "]) {
        [self displayList:[self snip:@"display list " fromCommand:command]];
    } else if ([command containsString:@"new item in "]) {
        [self newItem:[self snip:@"new item in " fromCommand:command]];
    } else if ([command containsString:@"display items in "]) {
        [self displayItems:[self snip:@"display items in " fromCommand:command]
                withPrompt:YES];
    } else if ([command containsString:@"delete items in "]) {
        [self deleteItems:[self snip:@"delete items in " fromCommand:command]];
    } else if ([command containsString:@"display all items "]) {
        [self displayAllItems:[self snip:@"display all items " fromCommand:command]];
    } else if ([command isEqualToString:@"exit"]) {
        exit(0);
    } else {
        printf("\n  NOT A RECOGNIZED COMMAND\n");
        printf("\n    Type 'help' for available commands\n\n");
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
    printf("\n      delete list <list name>\n");
    printf("\n      rename list <list name>\n");
    printf("\n      display list <list name / all>\n");
    printf("\n      new item in <list name>\n");
    printf("\n      display items in <list name>\n");
    printf("\n      delete items in <list name>\n");
    printf("\n      display all items <sort selector> first\n");
    printf("\n            sort selectors:\n\n");
    printf("               high priority\n");
    printf("               low priority\n");
    printf("               closest due date\n");
    printf("               farthest due date\n");
    printf("               completed\n");
    printf("               not completed\n");
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
        [item1 setItemPriority:3];
        ListItem *item2 = [[ListItem alloc] init];
        [item2 setItemDescription:@"kill bad guys"];
        [item2 setItemPriority:2];
        ListItem *item3 = [[ListItem alloc] init];
        [item3 setItemDescription:@"call Robin"];
        [item3 setItemPriority:4];
        ListItem *item4 = [[ListItem alloc] init];
        [item4 setItemDescription:@"polish bat-mobile"];
        ListItem *item5 = [[ListItem alloc] init];
        [item5 setItemDescription:@"grab a beer with Joker"];
        [item5 setItemPriority:3];
        ListItem *item6 = [[ListItem alloc] init];
        [item6 setItemDescription:@"look mysterious"];
        ListItem *item7 = [[ListItem alloc] init];
        [item7 setItemDescription:@"get haircut"];
        [item7 setItemPriority:1];
        ListItem *item8 = [[ListItem alloc] init];
        [item8 setItemDescription:@"buy flowers for catwoman"];
        [item8 setItemPriority:3];
        ListItem *item9 = [[ListItem alloc] init];
        [item9 setItemDescription:@"fire alfred"];
        [item9 setItemPriority:2];
        ListItem *item10 = [[ListItem alloc] init];
        [item10 setItemDescription:@"march at pride"];
        [item10 setItemPriority:4];
        ListItem *item11 = [[ListItem alloc] init];
        [item11 setItemDescription:@"get wonder woman to teach me how to use a lasso"];
        [item11 setItemPriority:2];
        
        List *list = [[List alloc] init];
        [list addListItem:item1];
        [list addListItem:item2];
        [list addListItem:item3];
        [list addListItem:item4];
        [list addListItem:item5];
        [list addListItem:item6];
        [list setName:@"urgent"];
        
        List *list2 = [[List alloc] init];
        [list2 addListItem:item7];
        [list2 addListItem:item8];
        [list2 addListItem:item9];
        [list2 addListItem:item9];
        [list2 addListItem:item10];
        [list2 addListItem:item11];
        [list2 setName:@"more urgentest"];
        
        [list editListItem:0 withString:@"hit Bernie Sanders with a batarang"];
        
        ListManager *myListManager = [[ListManager alloc]init];
        [myListManager addList:list];
        [myListManager addList:list2];

        [myListManager run];
        /// yo yo yo 

    }
    return 0;
}
