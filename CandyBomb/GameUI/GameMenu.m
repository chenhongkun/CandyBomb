//
//  GameMenu.m
//  CandyBomb
//
//  Created by Mingle Chang on 13-11-27.
//  Copyright 2013年 Mingle. All rights reserved.
//

#import "GameMenu.h"


@implementation GameMenu
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	GameMenu *layer = [GameMenu node];
	[scene addChild: layer];
	return scene;
}
@end
