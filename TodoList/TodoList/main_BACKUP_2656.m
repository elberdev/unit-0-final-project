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
//    char string[256];
//    itemDescription = [NSString stringWithCString:string encoding:1];
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

-(void)run;
-(void)showLists;
-(void)addList:(List *)list;
-(void)removeList:(NSString *)name;

@end

@implementation ListManager {
    NSMutableArray *_listDatabase;
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

-(void)run {
    BOOL programIsRunning = YES;
    while (programIsRunning) {
        printf("Welcome to the Elbo-Yucatan To-Do List Manager. Please select an option. \n 0) Exit program \n 1) Show my active to-do lists \n 2) Create a new to-do list \n 3) Edit a to-do list");
        int input;
        scanf("\n%d%*c", &input);
        switch (input) {
            case 0:
                programIsRunning = NO;
                break;
            case 1:
                [self showLists];
                break;
            case 2:
                [self createList];
                break;
            case 3:
                //edit to-do list
                break;
            default:
                printf("You have selected an invalid option.");
                break;
        }
    }
}

@end
//************************** end ListManager class ***************************//


int main(int argc, const char * argv[]) {
    @autoreleasepool {

        // insert code here...
<<<<<<< HEAD
        listItem *myItem = [[listItem alloc]init];
        
=======
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

>>>>>>> 1cc80cb5748de3147c7e186a387196d343f146bf
    }
    return 0;
}
