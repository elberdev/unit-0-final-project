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
-(void)setItemPriority:(int)priority;
-(int)itemPriority;
-(void)setDoneStatus:(BOOL)doneStatus;
-(BOOL)doneStatus;

@end

@implementation ListItem {
    NSString *_itemDescription;
    int _itemPriority;
    BOOL _doneStatus;
//    NSDate *_dueDate;
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

-(void)setName:(NSString*)name;
-(NSString*)name;
-(NSMutableArray *)listArray;
-(void)addListItem:(ListItem *)listItem;
-(void)removeListItem:(int)index;
-(void)editListItemDescription:(int)index withString:(NSString *)string;
-(void)editListPriority:(int)index withPriority:(int)priority;
-(void)editListDoneStatus:(int)index withDoneStatus:(BOOL)doneStatus;

@end

@implementation List {
    NSString *_name;
    NSMutableArray *_listArray;
}

-(id)init {
    if (self = [super init]) {
        _listArray = [[NSMutableArray alloc] init];
        _name = [[NSString alloc] init];
    }
    return self;
}

-(void)setName:(NSString*)name {
    _name = name;
}

-(NSString*)name {
    return _name;
}

-(void)addListItem:(ListItem *)listItem {
    [self.listArray addObject:listItem];
}

-(void)removeListItem:(int)index {
    if (index < [self.listArray count]) {
        [self.listArray removeObjectAtIndex:index];
    } else {
        printf("\n  The list item you input does not exist\n");
    }
}

-(void)editListItemDescription:(int)index withString:(NSString *)string {
    if (index < [self.listArray count]) {
        [[self.listArray objectAtIndex:index] setItemDescription:string];
    } else {
        printf("\n  The list item you input does not exist\n");
    }
}

-(void)editListPriority:(int)index withPriority:(int)priority {
    if (index < [self.listArray count]) {
        [[self.listArray objectAtIndex:index] setItemPriority:priority];
    } else {
        printf("\n  The list item you input does not exist\n");
    }
}

-(void)editListDoneStatus:(int)index withDoneStatus:(BOOL)doneStatus {
    if (index < [self.listArray count]) {
        [[self.listArray objectAtIndex:index] setDoneStatus:doneStatus];
        
    } else {
        printf("\n  The list item you input does not exist\n");
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
    BOOL _ascending;
    NSString *_sortDescriptorKey;
}

-(id)init {
    if (self = [super init]) {
        _listDatabase = [[NSMutableArray alloc] init];
        _sortDescriptorKey = [[NSString alloc] init];
    }
    return self;
}

-(void)addList:(List *)list {
    [_listDatabase addObject:list];
}

-(void)removeList:(NSString *)name {
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
    
    BOOL found = NO;
    List *list = [[List alloc]init];
    
    for (int i = 0; i < [_listDatabase count]; i++) {
        if ([listname isEqualToString:[_listDatabase[i] name]]) {
            found = YES;
            list = _listDatabase[i];
        }
    }
    
    if (found == NO) {
        printf("\n  There are no lists by that name\n\n");
        return nil;
    }

    return list;
}

-(void)newList:(NSString *)newListName {
    List *list = [[List alloc] init];
    
    [list setName:newListName];
    [self addList:list];
    printf("\n\n  A NEW LIST HAS BEEN CREATED:\n");
    printf("\n      %s\n\n", [newListName UTF8String]);
}

-(void)deleteList:(NSString *)listName {
    if ([self getListByName:listName] == nil) {
        return;
    }
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
}

-(void)renameList:(NSString *)listName {
    if ([self getListByName:listName] == nil) {
        return;
    }
    printf("\n\n  PLEASE ENTER NEW NAME FOR LIST %s\n", [listName UTF8String]);
    NSString *newName = [self parse];
    [[self getListByName:listName] setName:newName];
    printf("\n    List %s has been renamed %s\n\n", [listName UTF8String],
           [newName UTF8String]);
}

-(void)displayList:(NSString *)listName {
    if ([_listDatabase count] == 0) {
        printf("\n\n  NO TO-DO LISTS TO DISPLAY\n");
    } else if ([listName isEqualToString:@"summary"]) {
        printf("\n\n  DISPLAYING LIST SUMMARY\n");
        for (int i = 0; i < [_listDatabase count]; i++) {
            printf("\n    %s: %lu items\n", [[_listDatabase[i] name] UTF8String],
                   (unsigned long)[_listDatabase[i] showNumberOfItems]);
        }
    } else {
        [self prioritySort:listName];
    }
    printf("\n");
}

-(void)newItem:(NSString *)listName {
    if ([self getListByName:listName] == nil) {
        return;
    }
    ListItem *newItem = [[ListItem alloc]init];
    
    printf("\n\n  CREATING NEW ITEM IN LIST %s\n", [listName UTF8String]);
    printf("\n    Input to do item description: \n");
    NSString *description = [self parse];
    [newItem setItemDescription:description];
    
    int priority;
    while (true) {
        printf("\n    Input item priority from 1 (most pressing) to 4 (least pressing)\n\n    ");
        scanf("%d%*c", &priority);
        fpurge(stdin);
        if (0 < priority && priority < 5) {
            [newItem setItemPriority:priority];
            break;
        } else {
            printf("\n    INVALID INPUT\n");
        }
    }
    [[[self getListByName:listName] listArray] addObject:newItem];
    printf("\n  TO DO ITEM CREATED SUCCESSFULLY\n\n");
}

-(int)displayItems:(NSString *)listName {
    List *list = [self getListByName:listName];
    if (list == nil) {
        return 0;
    }
    printf("\n\n  DISPLAYING LIST %s\n", [listName UTF8String]);
    NSMutableArray *array = [list listArray];
    [self formatItems:array];
    return (int)[array count];
}

-(void)displayItems:(NSString *)listName withSort:(NSString *)sortDescriptor {
    List *list = [self getListByName:listName];
    if (list == nil) {
        return;
    }
    printf("\n\n  DISPLAYING LIST %s,%s\n", [listName UTF8String],
           [sortDescriptor UTF8String]);
    NSMutableArray *array = [list listArray];
    NSArray *sortedArray = [self sortItems:array];
    [self formatItems:[NSMutableArray arrayWithArray:sortedArray]];
}

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
    printf("\n     |  %*s  %-*s  priority  done\n", biggestNumPadding,
           [[NSString stringWithFormat:@" "] UTF8String], longestLength,
           [description UTF8String]);
    
    for (int i = 0; i < [array count]; i++) {
        printf("     |\n     |  %*s) %-*s      %d       %s\n",
               biggestNumPadding,
               [(num = [NSString stringWithFormat:@"%d", i]) UTF8String],
               longestLength, [[array[i] itemDescription] UTF8String],
               (int)[array[i] itemPriority],
               [[array[i] doneStatus] ? @"Y" : @"N" UTF8String]);
    }
    printf("\n");
}

-(void)deleteItemPrompt:(NSString*)listname {
    printf("\n    Do you want to delete more items? y/n\n");
    NSString *prompt = [self parse];
    if ([prompt isEqualToString:@"y"]) {
        [self deleteItems:listname];
    } else if ([prompt isEqualToString:@"n"]) {
        printf("\n    EXITING DELETION\n\n");
        [self commandTree:[self parse]];
    } else {
        printf("\n    INVALID INPUT\n");
        [self deleteItemPrompt:listname];
    }
}

-(void)deleteItems:(NSString *)listName {
    if ([self getListByName:listName] == nil) {
        return;
    }
    printf("\n\n  DELETING ITEMS IN LIST %s\n", [listName UTF8String]);
    
    int itemIndex;
    int count;
    while (true) {
        count = [self displayItems:listName];
        printf("    Please select an item to be deleted:\n\n");
        printf("\n      ");
        scanf("%d%*c", &itemIndex);
        fpurge(stdin);
        if(0 <= itemIndex && itemIndex < count) {
            break;
        } else {
            printf("\n  INVALID INPUT");
        }
    }
    [[self getListByName:listName] removeListItem:itemIndex];
    printf("\n    Item has been deleted\n");
    [self deleteItemPrompt:listName];
}

-(NSArray *)sortItems:(NSMutableArray *)array {
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] init];
    sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:_sortDescriptorKey
                                                   ascending:_ascending];
    //                                              selector:@selector(localizedStandardCompare:)];
    // Don't forget to use this last parameter ^^^^^^^^^^^^^^^^^^^^ if you want to
    // compare strings instead of numbers
    
    return [array sortedArrayUsingDescriptors:@[sortDescriptor]];
}

-(void)prioritySort:(NSString *)command {
    
    NSString *sortDescriptor = [[NSString alloc] init];
    BOOL sorting = NO;
    
    if ([command containsString:@" high priority first"]) {
        sortDescriptor = @" high priority first";
        sorting = YES;
        _ascending = YES;
        _sortDescriptorKey = [NSString stringWithFormat:@"itemPriority"];
        command = [self snip:@" high priority first" fromCommand:command];
    } else if ([command containsString:@" low priority first"]) {
        sortDescriptor = @" low priority first";
        sorting = YES;
        _ascending = NO;
        _sortDescriptorKey = [NSString stringWithFormat:@"itemPriority"];
        command = [self snip:@" low priority first" fromCommand:command];
    } else if ([command containsString:@" not done first"]) {
        sortDescriptor = @" not done first";
        sorting = YES;
        _ascending = YES;
        _sortDescriptorKey = [NSString stringWithFormat:@"doneStatus"];
        command = [self snip:@" not done first" fromCommand:command];
    } else if ([command containsString:@" done first"]) {
        sortDescriptor = @" done first";
        sorting = YES;
        _ascending = NO;
        _sortDescriptorKey = [NSString stringWithFormat:@"doneStatus"];
        command = [self snip:@" done first" fromCommand:command];
    } else {
        sorting = NO;
    }
    
    // executes only when displaying an individual sorted list
    if (sorting == YES) {
        [self displayItems:command withSort:sortDescriptor];
    } else {
        [self displayItems:command];
    }

}

-(void)displayAllItems:(NSString *)command withSort:(BOOL)sort {
    
    NSMutableArray *combinedList = [[NSMutableArray alloc] init];
    for (int i = 0; i < [_listDatabase count]; i++) {
        for (int j = 0; j < [[_listDatabase[i] listArray] count]; j++) {
            [combinedList addObject:[[_listDatabase[i] listArray] objectAtIndex:j]];
        }
    }
    
    if ([command isEqualToString:@" high priority first"] ||
        [command isEqualToString:@" low priority first"] ||
        [command isEqualToString:@" done first"] ||
        [command isEqualToString:@" not done first"]) {
        
        [self prioritySort:command];
        combinedList = [NSMutableArray arrayWithArray:[self sortItems:combinedList]];
    } else {
        if (sort == YES) {
            printf("\n    INVALID SORT SELECTOR\n\n");
            return;
        }
    }
    
    printf("\n\n  DISPLAYING ALL ITEMS,%s\n", [command UTF8String]);
    [self formatItems:combinedList];
}

-(void)editItemsInListSelector:(NSString*)listName {
    
    int itemIndex = -1;
    int count;
    while (true) {
        count = [self displayItems:listName];
        printf("    Please select an item to be edited:\n\n");
        printf("\n      ");
        scanf("%d%*c", &itemIndex);
        fpurge(stdin);
        if(0 <= itemIndex && itemIndex < count) {
            break;
        }
            printf("\n  INVALID INPUT");
    }
    
    int editOption = -1;
    while (true) {
        printf("\n    What edit would you like to perform on that item?\n");
        printf("\n      1) Reassign priority\n");
        printf("\n      2) Edit description\n");
        printf("\n      3) Change completion status\n");
        
        printf("\n\n      ");
        scanf("%d%*c", &editOption);
        fpurge(stdin);
        if(0 < editOption && editOption < 4) {
            break;
        } else {
            printf("\n    INVALID INPUT\n");
        }
    }

    if (editOption == 1) {
        int newPriority = -1;
        while (true) {
            printf("\n    Enter a value from 1 (greatest priority) to 4 (least priority)\n");
            printf("\n      ");
            scanf("%d", &newPriority);
            fpurge(stdin);
            if (0 < newPriority && newPriority < 5) {
                [[self getListByName:listName] editListPriority:itemIndex
                                                   withPriority:newPriority];
                break;
            } else {
                printf("\n    INVALID INPUT\n");
            }
        }

    } else if (editOption == 2) {
        printf("\n    Input a new description for this item:\n");
        [[self getListByName:listName] editListItemDescription:itemIndex
                                                    withString:[self parse]];
    } else if (editOption == 3) {
        NSString *myInput = @"z";
        while (true) {
            printf("\n    Please enter 'y' for done, or 'n' for not done \n");
            myInput = [self parse];
            if ([myInput isEqualToString:@"y"]) {
                [[self getListByName:listName] editListDoneStatus:itemIndex
                                                   withDoneStatus:YES];
                break;
            } else if ([myInput isEqualToString:@"n"]) {
                [[self getListByName:listName] editListDoneStatus:itemIndex
                                                   withDoneStatus:NO];
                break;
            } else {
                printf("\n    INVALID INPUT\n");
            }
        }
    }
}

-(void)editItemPrompt:(NSString*)listname {
    printf("\n    Do you want to edit more items? y/n\n");
    NSString *prompt = [self parse];
    if ([prompt isEqualToString:@"y"]) {
        [self editItemsInList:listname];
    } else if ([prompt isEqualToString:@"n"]) {
        printf("\n  EXITING ITEM EDITING\n");
        [self commandTree:[self parse]];
    } else {
        printf("\n  INVALID INPUT\n");
        [self editItemPrompt:listname];
    }
}

-(void)editItemsInList:(NSString*)listName {
    if ([self getListByName:listName] == nil) {
        return;
    }
    printf("\n\n  EDITING ITEMS IN LIST %s\n", [listName UTF8String]);
    [self editItemsInListSelector:listName];
    [self editItemPrompt:listName];
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
    } else if ([command containsString:@"delete items in "]) {
        [self deleteItems:[self snip:@"delete items in " fromCommand:command]];
    } else if ([command isEqualToString:@"display all items"]) {
        [self displayAllItems:[self snip:@"display all items" fromCommand:command]
                     withSort:NO];
    } else if ([command containsString:@"display all items"]) {
        [self displayAllItems:[self snip:@"display all items" fromCommand:command]
                     withSort:YES];
    } else if ([command containsString:@"edit items in "]) {
        [self editItemsInList:[self snip:@"edit items in " fromCommand:command]];
    } else if ([command isEqualToString:@"exit"]) {
        exit(0);
    } else {
        printf("\n  NOT A RECOGNIZED COMMAND\n");
        printf("\n    Type 'help' for available commands\n\n");
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
    printf("\n\n  GENERAL COMMANDS:\n");
    printf("\n      display list summary\n");
    printf("      display list <list name>\n");
    printf("      new list <list name>\n");
    printf("      delete list <list name>\n");
    printf("      rename list <list name>\n");
    printf("      display all items\n");
    printf("      new item in <list name>\n");
    printf("      edit items in <list name>\n");
    printf("      delete items in <list name>\n");
    printf("      exit\n");
    printf("\n   SORTING COMMANDS:\n");
    printf("\n      display list <list name> <sort selector> first\n");
    printf("      display all items <sort selector> first\n");
    printf("\n        SORT SELECTORS:\n\n");
    printf("         high priority\n");
    printf("         low priority\n");
    printf("         done\n");
    printf("         not done\n\n");
}

-(void)run {
    printf("\n  Welcome to the Elbo-Yucatan To-Do List Management System. \n");
    printf("\n    Type a command (or type 'help' for instructions)\n\n");
    while (true) {
        [self commandTree:[self parse]];
    }
}
@end
//************************** end ListManager class ***************************//


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        ListItem *item1 = [[ListItem alloc] init];
        [item1 setItemDescription:@"do laundry"];
        [item1 setItemPriority:3];
        ListItem *item2 = [[ListItem alloc] init];
        [item2 setItemDescription:@"kill bad guys"];
        [item2 setItemPriority:2];
        ListItem *item3 = [[ListItem alloc] init];
        [item3 setItemDescription:@"call Robin"];
        [item3 setItemPriority:4];
        [item3 setDoneStatus:YES];
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
        [item8 setDoneStatus:YES];
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
        
        [list editListItemDescription:0 withString:@"hit Bernie Sanders with a batarang"];
        
        ListManager *myListManager = [[ListManager alloc]init];
        [myListManager addList:list];
        [myListManager addList:list2];

        [myListManager run];
        /// yo yo yo 

    }
    return 0;
}
