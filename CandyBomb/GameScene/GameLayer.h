//
//  GameLayer.h
//  CandyBomb
//
//  Created by Mingle Chang on 13-11-26.
//  Copyright 2013年 Mingle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameLayer : CCLayer {
    NSMutableArray *_tiles;
    NSMutableArray *_selectedTiles;
    NSMutableArray *_removeTiles;
    CCSprite *_selectedSprite;
}

@end
