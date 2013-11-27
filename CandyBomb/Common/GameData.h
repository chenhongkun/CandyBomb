//
//  GameData.h
//  CandyBomb
//
//  Created by Mingle Chang on 13-11-27.
//  Copyright (c) 2013年 Mingle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameData : NSObject
@property(nonatomic,assign)int hintLevel;//提示技能等级
@property(nonatomic,assign)int timeLevel;//时间技能等级
@property(nonatomic,assign)int bombLevel;//炸弹技能等级
@property(nonatomic,assign)int diamondLevel;//钻石技能等级
@property(nonatomic,assign)int superLevel;//超能技能等级
@property(nonatomic,assign)int connectLevel;//连击技能等级
@property(nonatomic,assign)int luckyLevel;//幸运技能等级
@property(nonatomic,assign)int coinsLevel;//金币技能等级
+(GameData *)shareGameData;
@end
