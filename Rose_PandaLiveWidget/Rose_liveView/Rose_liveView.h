//
//  Rose_liveView.h
//  Rose_PandaLiveWidget
//
//  Created by Marilyn_Rose on 2017/5/15.
//  Copyright © 2017年 Marilyn_Rose. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, viewStyleENUM)
{
    NORMAL    = 0,
    LIVEWIDGET  = 1
};

typedef void(^enlargeBlock)();

@interface Rose_liveView : UIView

@property(nonatomic,copy)enlargeBlock enlargeBlock;

+(Rose_liveView *)shared;

-(void)setFrame:(CGRect)frame withViewStyle:(viewStyleENUM)style;

-(void)setLiveURL:(NSURL *)url;

-(void)play;

-(void)reloadUrl:(NSURL *)url;

@end
