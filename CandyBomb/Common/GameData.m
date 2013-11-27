//
//  GameData.m
//  CandyBomb
//
//  Created by Mingle Chang on 13-11-27.
//  Copyright (c) 2013年 Mingle. All rights reserved.
//

#import "GameData.h"
static GameData *singleGameData=nil;
@implementation GameData
+(GameData *)shareGameData{
    @synchronized(self){
        if (singleGameData==nil) {
            singleGameData=[[GameData alloc]init];
        }
    }
    return singleGameData;
}
-(id)init{
    self=[super init];
    if (self) {
    }
    return self;
}
@end
