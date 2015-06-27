//
//  main.m
//  TodoList
//
//  Created by Michael Kavouras on 6/25/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>


//*************************** listItem class *********************************//
@interface ListManager : NSObject
-(void)run;
@end

@implementation ListManager

-(void)run {
    BOOL programIsRunning = YES;
    while (programIsRunning) {
        printf("Welcome to the Elbo-Yucatan To-Do List Manager. Please select an option. \n 0) Exit program \n 1) Show my active to-do lists \n 2) Create a new to-do list \n 3) Edit a to-do list");
        int input;
        scanf("%d%*c", &input);
        switch (input) {
            case 0:
                programIsRunning = NO;
                break;
            case 1:
                // show your lists
                break;
            case 2:
                //create to-do list
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

-(NSMutableArray *)listArray {
    return _listArray;
}

@end
//****************************** end List class ******************************//


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
        
        List *list = [[List alloc] init];
        [list addListItem:item1];
        [list addListItem:item2];
        [list addListItem:item3];
        
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
        [myListManager run];

    }
    return 0;
}
