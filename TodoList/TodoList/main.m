//
//  main.m
//  TodoList
//
//  Created by Michael Kavouras on 6/25/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        char string[256];
        scanf("%255s", &string);
        NSString *firstName = [NSString stringWithCString:string encoding:1];
        NSLog(@"%@", firstName);
    }
    return 0;
}
