//
//  GameLayer.m
//  CandyBomb
//
//  Created by Mingle Chang on 13-11-26.
//  Copyright 2013年 Mingle. All rights reserved.
//

#import "GameLayer.h"
#import "CandySprite.h"
#define kSide 44.5
#define kStartPoint ccp(26,26)
#define kOutOfLayerPoint ccp(-100,0)
#define kAnimationDuration 0.2
@implementation GameLayer
-(void)creatMap{
    for (int i=0; i<49; i++) {
        NSMutableArray *lArray=[[NSMutableArray alloc]initWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:3],[NSNumber numberWithInt:4],[NSNumber numberWithInt:5],[NSNumber numberWithInt:6], nil];
        int x=i%7;
        int y=i/7;
        if (x!=0) {
            int value=(x-1)+y*7;
            CandySprite *lCandySprite=[_tiles objectAtIndex:value];
            [lArray removeObject:[NSNumber numberWithInt:lCandySprite.number]];
        }
        if (y!=0) {
            int value=x+(y-1)*7;
            CandySprite *lCandySprite=[_tiles objectAtIndex:value];
            [lArray removeObject:[NSNumber numberWithInt:lCandySprite.number]];
        }
        int randomValue=arc4random()%lArray.count;
        CandySprite *lCandySprite=[CandySprite spriteWithNumber:[[lArray objectAtIndex:randomValue]intValue]];
        lCandySprite.coord=ccp(x, y);
        lCandySprite.position=ccp(kStartPoint.x+x*kSide, kStartPoint.y+y*kSide);
        [_tiles addObject:lCandySprite];
        [self addChild:lCandySprite];
        [lArray release];
    }
    _selectedSprite=[[CCSprite alloc]initWithFile:@"candy_selected.png"];
    _selectedSprite.position=kOutOfLayerPoint;
    [self addChild:_selectedSprite z:99];
}
-(id)init{
    self=[super init];
    if (self) {
        _tiles=[[NSMutableArray alloc]initWithCapacity:49];
        _selectedTiles=[[NSMutableArray alloc]initWithCapacity:2];
        _removeTiles=[[NSMutableArray alloc]init];
        [self setTouchEnabled:YES];
        [self setTouchMode:kCCTouchesOneByOne];
        [self setTouchSwallow:NO];
        [self setContentSize:CGSizeMake(320, 320)];
        
        CCSprite *bgSprite=[CCSprite spriteWithFile:@"chess_default.png"];
        bgSprite.position=ccp(self.contentSize.width/2,self.contentSize.height/2);
        [self addChild:bgSprite];
        [self creatMap];
    }
    return self;
}
-(void)onEnter{
    [super onEnter];
}
-(void)onEnterTransitionDidFinish{
    [super onEnterTransitionDidFinish];
}
-(void)onExitTransitionDidStart{
    [super onExitTransitionDidStart];
}
-(void)onExit{
    [super onExit];
}
-(void)dealloc{
    [_tiles release];
    [_selectedTiles release];
    [_removeTiles release];
    [super dealloc];
}
#pragma mark - Private Mothed
-(BOOL)checkIsAdjacent{//检查所选中的两个CandySprite是否相邻
    if (_selectedTiles.count!=2) {
        return NO;
    }
    CandySprite *lCandySprite1=[_selectedTiles objectAtIndex:0];
    CandySprite *lCandySprite2=[_selectedTiles objectAtIndex:1];
    if (abs(lCandySprite1.coord.x-lCandySprite2.coord.x)+abs(lCandySprite1.coord.y-lCandySprite2.coord.y)==1) {
        return YES;
    }else{
        return NO;
    }
}
-(void)exchangeSelectedCandySprites{//交换选中的两块的CandySprite的位置
    if (_selectedTiles.count!=2) {
        return;
    }
    CandySprite *lCandySprite1=[_selectedTiles objectAtIndex:0];
    CandySprite *lCandySprite2=[_selectedTiles objectAtIndex:1];
    CCMoveTo *lMoveTo1=[CCMoveTo actionWithDuration:kAnimationDuration position:lCandySprite2.position];
    CCMoveTo *lMoveTo2=[CCMoveTo actionWithDuration:kAnimationDuration position:lCandySprite1.position];
    [lCandySprite1 runAction:lMoveTo1];
    [lCandySprite2 runAction:lMoveTo2];
    CGPoint lCoord=lCandySprite1.coord;
    lCandySprite1.coord=lCandySprite2.coord;
    lCandySprite2.coord=lCoord;
    int index1=[_tiles indexOfObject:lCandySprite1];
    int index2=[_tiles indexOfObject:lCandySprite2];
    [_tiles exchangeObjectAtIndex:index1 withObjectAtIndex:index2];
}
-(void)checkOrientationHori:(int)value{//检查横向的CandySprite
    NSMutableArray *lArray=[[NSMutableArray alloc]initWithCapacity:7];
    for (int i=7*value; i<7*value+7; i++) {
        CandySprite *lCandySprite=[_tiles objectAtIndex:i];
        if (lArray.count==0) {
            [lArray addObject:lCandySprite];
        }else if(lArray.count<3){
            CandySprite *tempCandySprite=[lArray objectAtIndex:0];
            if (tempCandySprite.number==lCandySprite.number) {
                [lArray addObject:lCandySprite];
            }else{
                [lArray removeAllObjects];
                [lArray addObject:lCandySprite];
            }
        }else{
            CandySprite *tempCandySprite=[lArray objectAtIndex:0];
            if (tempCandySprite.number==lCandySprite.number) {
                [lArray addObject:lCandySprite];
            }else{
                for (CandySprite *removeCandySprite in lArray) {
                    if (![_removeTiles containsObject:removeCandySprite]) {
                        [_removeTiles addObject:removeCandySprite];
                    }
                }
                [lArray removeAllObjects];
                [lArray addObject:lCandySprite];
            }
        }
    }
    if (lArray.count>=3) {
        for (CandySprite *removeCandySprite in lArray) {
            if (![_removeTiles containsObject:removeCandySprite]) {
                [_removeTiles addObject:removeCandySprite];
            }
        }
    }
    [lArray release];
}
-(void)checkOrientationVert:(int)value{//检查纵向的CandySprite
    NSMutableArray *lArray=[[NSMutableArray alloc]initWithCapacity:7];
    for (int i=value; i<7*7+value; i+=7) {
        CandySprite *lCandySprite=[_tiles objectAtIndex:i];
        if (lArray.count==0) {
            [lArray addObject:lCandySprite];
        }else if(lArray.count<3){
            CandySprite *tempCandySprite=[lArray objectAtIndex:0];
            if (tempCandySprite.number==lCandySprite.number) {
                [lArray addObject:lCandySprite];
            }else{
                [lArray removeAllObjects];
                [lArray addObject:lCandySprite];
            }
        }else{
            CandySprite *tempCandySprite=[lArray objectAtIndex:0];
            if (tempCandySprite.number==lCandySprite.number) {
                [lArray addObject:lCandySprite];
            }else{
                for (CandySprite *removeCandySprite in lArray) {
                    if (![_removeTiles containsObject:removeCandySprite]) {
                        [_removeTiles addObject:removeCandySprite];
                    }
                }
                [lArray removeAllObjects];
                [lArray addObject:lCandySprite];
            }
        }
    }
    if (lArray.count>=3) {
        for (CandySprite *removeCandySprite in lArray) {
            if (![_removeTiles containsObject:removeCandySprite]) {
                [_removeTiles addObject:removeCandySprite];
            }
        }
    }
    [lArray removeAllObjects];
    [lArray release];
}
-(void)checkSelectedCandySprites{//检查选中的CandySprite
    if (_selectedTiles.count!=2) {
        return;
    }
    CandySprite *lCandySprite1=[_selectedTiles objectAtIndex:0];
    CandySprite *lCandySprite2=[_selectedTiles objectAtIndex:1];
    [self checkOrientationVert:lCandySprite1.coord.x];
    [self checkOrientationVert:lCandySprite2.coord.x];
    [self checkOrientationHori:lCandySprite1.coord.y];
    [self checkOrientationHori:lCandySprite2.coord.y];
}
-(void)checkAll{//检查所有的CandySprite
    for (int i=0; i<7; i++) {
        [self checkOrientationHori:i];
        [self checkOrientationVert:i];
    }
}
-(void)check{//检查
    if (_selectedTiles.count==2) {
        [self checkSelectedCandySprites];
    }else{
        [self checkAll];
    }
    if (_removeTiles.count!=0) {
        for (CandySprite *lCandySprite in _removeTiles) {
            [lCandySprite removeFromParentAndCleanup:YES];
        }
        [self getNewCandySprite];
    }else if (_selectedTiles.count==2){
        [self exchangeSelectedCandySprites];
        [_selectedTiles removeAllObjects];
        CCCallFunc *lCallFunc=[CCCallFunc actionWithTarget:self selector:@selector(setTouchEnableYES)];
        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:kAnimationDuration],lCallFunc, nil]];
    }else{
        [self setTouchEnabled:YES];
    }
}
-(void)getNewCandySprite{//添加新的CandySprite
    for (CandySprite *lCandySprite in _removeTiles) {
        for (int i=lCandySprite.coord.x+lCandySprite.coord.y*7; i<49; i+=7) {
            int index=i + 7;
            if (index>=_tiles.count) {
                CandySprite *lNewCandySprite=[CandySprite spriteWithNumber:arc4random()%6+1];
                CandySprite *lOldCandySprite=[_tiles objectAtIndex:i];
                lNewCandySprite.coord=ccp(i%7, i/7);
                lNewCandySprite.position=ccpAdd(lOldCandySprite.position, ccp(0, kSide));
                [self addChild:lNewCandySprite];
                [_tiles replaceObjectAtIndex:i withObject:lNewCandySprite];
            }else{
                CandySprite *lOldCandySprite=[_tiles objectAtIndex:index];
                lOldCandySprite.coord=ccp(i%7, i/7);
                [_tiles replaceObjectAtIndex:i withObject:lOldCandySprite];
            }
        }
    }
    [self resetAllCandySpritePostion];
}
-(void)resetAllCandySpritePostion{//重新设置所有CandySprite的位置
    for (CandySprite *lCandySprite in _tiles) {
        CCMoveTo *lMoveTo=[CCMoveTo actionWithDuration:kAnimationDuration position:ccp(kStartPoint.x+lCandySprite.coord.x*kSide, kStartPoint.y+lCandySprite.coord.y*kSide)];
        [lCandySprite runAction:lMoveTo];
    }
    [_selectedTiles removeAllObjects];
    [_removeTiles removeAllObjects];
    CCCallFunc *lCallFunc=[CCCallFunc actionWithTarget:self selector:@selector(check)];
    [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:kAnimationDuration+0.1],lCallFunc, nil]];
}
-(void)setTouchEnableYES{
    [self setTouchEnabled:YES];
}
-(void)settouchEnableNO{
    [self setTouchEnabled:NO];
}
#pragma mark - Touch Event
-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint lPoint=[self convertTouchToNodeSpace:touch];
    for (CandySprite *lCandySprite in _tiles) {
        if (CGRectContainsPoint(lCandySprite.boundingBox, lPoint)) {
            if (_selectedTiles.count==0) {//如果之前未选中任何CandySprite，则将点击的CandySprite设置为选中
                _selectedSprite.position=lCandySprite.position;
                [_selectedTiles addObject:lCandySprite];
                return YES;
            }else{
                if (CGPointEqualToPoint(_selectedSprite.position, lCandySprite.position)) {//如果点击的CandySprite是已选中的，则将其取消选中
                    _selectedSprite.position=kOutOfLayerPoint;
                    [_selectedTiles removeAllObjects];
                }else{
                    [_selectedTiles addObject:lCandySprite];//如果点击的CandySprite是未选中的，则将其选中
                    if ([self checkIsAdjacent]) {//如果选中的两个CandySprite是相邻的，则交换位置
                        [self setTouchEnabled:NO];
                        _selectedSprite.position=kOutOfLayerPoint;
                        [self exchangeSelectedCandySprites];
                        CCCallFunc *lCallFunc=[CCCallFunc actionWithTarget:self selector:@selector(check)];
                        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:kAnimationDuration],lCallFunc, nil]];
                        return NO;
                    }else{//如果选中的两个CandySprite不是相邻的，则将第一个选中的取消选中
                        _selectedSprite.position=lCandySprite.position;
                        [_selectedTiles removeObjectAtIndex:0];
                        return YES;
                    }
                }
            }
        }
    }
    return NO;
}
-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
    NSLog(@"Move");
}
-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
    NSLog(@"End");
}
-(void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event{
    NSLog(@"Cancelled");
}
@end
