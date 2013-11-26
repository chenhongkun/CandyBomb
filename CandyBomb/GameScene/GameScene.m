//
//  GameScene.m
//  CandyBomb
//
//  Created by Mingle Chang on 13-11-26.
//  Copyright 2013年 Mingle. All rights reserved.
//

#import "GameScene.h"
#import "GameLayer.h"

@implementation GameScene
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	GameScene *layer = [GameScene node];
	[scene addChild: layer];
	return scene;
}
-(id)init{
    self=[super init];
    if (self) {
        GameLayer *lGameLayer=[GameLayer node];
        lGameLayer.position=ccp(0, 90);
        [self addChild:lGameLayer];
    }
    return self;
}
@end
