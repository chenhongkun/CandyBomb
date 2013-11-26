//
//  CandySprite.h
//  CandyBomb
//
//  Created by Mingle Chang on 13-11-26.
//  Copyright 2013年 Mingle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
typedef enum tileColor{
    kRed=1,
    kYellow,
    kGreen,
    kBlue,
    kPurple,
    kBrown
}tileColor;
@interface CandySprite : CCSprite {
    
}
@property(nonatomic,assign)NSInteger number;
@property(nonatomic,assign)CGPoint coord;
+(CandySprite *)spriteWithNumber:(NSInteger)number;
@end
