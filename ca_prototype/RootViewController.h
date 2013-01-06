//
//  RootViewController.h
//  ca_prototype
//
//  Created by Jan on 02.01.13.
//  Copyright (c) 2013 Jan Zahula. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "DataViewController.h"



@interface RootViewController : UIViewController <UIPageViewControllerDelegate, PageViewControllerDelegate>



@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (weak, nonatomic) IBOutlet UIImageView *backgroudImage;
@property (weak, nonatomic) IBOutlet UIImageView *noTextBackgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *bookImage;
@property (weak, nonatomic) IBOutlet UIImageView *mapImage;
@property (weak, nonatomic) IBOutlet UIImageView *rightPageOpened;
@property (weak, nonatomic) IBOutlet UIImageView *wholeOpenedBookImage;
@property (weak, nonatomic) IBOutlet UIImageView *lightImage;

@end
