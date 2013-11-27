//
//  MainMenu.m
//  CandyBomb
//
//  Created by Mingle Chang on 13-11-26.
//  Copyright 2013年 Mingle. All rights reserved.
//

#import "MainMenu.h"
#import "GameScene.h"

@implementation MainMenu
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	MainMenu *layer = [MainMenu node];
	[scene addChild: layer];
	return scene;
}
-(id)init{
    self=[super init];
    if (self) {
        [CCMenuItemFont setFontSize:28];
        CCMenuItemFont *lStartItemFont=[CCMenuItemFont itemWithString:@"Play" target:self selector:@selector(playGame:)];
        CCMenu *lMenu=[CCMenu menuWithItems:lStartItemFont, nil];
        lMenu.position=ccp(kWinSize.width/2, kWinSize.height/2);
        [self addChild:lMenu];
    }
    return self;
}
-(void)playGame:(CCMenuItem *)sender{
    CCScene *lGameScene=[GameScene scene];
    CCTransitionScene *lTransition=[CCTransitionFade transitionWithDuration:0.5 scene:lGameScene];
    [[CCDirector sharedDirector]replaceScene:lTransition];
}
@end
