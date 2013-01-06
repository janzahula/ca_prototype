//
//  MapView.m
//  ca_prototype
//
//  Created by Jan on 06.01.13.
//  Copyright (c) 2013 Jan Zahula. All rights reserved.
//

#import "MapView.h"

@implementation MapView
-(id)init{
    self = [super init];
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    NSLog(@"drawRect mapview");
}


@end
