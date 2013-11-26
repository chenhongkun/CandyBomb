//
//  CandySprite.m
//  CandyBomb
//
//  Created by Mingle Chang on 13-11-26.
//  Copyright 2013年 Mingle. All rights reserved.
//

#import "CandySprite.h"


@implementation CandySprite
-(id)initWithNumber:(NSInteger)number{
    self=[super initWithFile:[NSString stringWithFormat:@"candy_%02i.png",number]];
    if (self) {
        self.number=number;
        //        self.anchorPoint=ccp(0, 0);
    }
    return self;
}
+(CandySprite *)spriteWithNumber:(NSInteger)number{
    return [[[CandySprite alloc]initWithNumber:number]autorelease];
}
@end
