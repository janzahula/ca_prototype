//
//  RootViewController.m
//  ca_prototype
//
//  Created by Jan on 02.01.13.
//  Copyright (c) 2013 Jan Zahula. All rights reserved.
//

#import "RootViewController.h"

#import "ModelController.h"

#import "DataViewController.h"

@interface RootViewController ()
@property (readonly, strong, nonatomic) ModelController *modelController;
@end

@implementation RootViewController

@synthesize modelController = _modelController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.bookImage.layer.shadowColor = [[UIColor blackColor]CGColor];
    self.bookImage.layer.shadowOffset = CGSizeMake(2, 2);
    self.bookImage.layer.shadowOpacity = 0.8;
    self.bookImage.layer.shadowRadius = 2;
    self.bookImage.layer.masksToBounds = NO;
   // self.mapImage.transform = CGAffineTransformMakeRotation(-1.38+M_PI_2);
    
     
    self.rightPageOpened.bounds = self.bookImage.bounds;
	// Do any additional setup after loading the view, typically from a nib.
    // Configure the page view controller and add it as a child view controller.
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;

    DataViewController *startingViewController = [self.modelController viewControllerAtIndex:0 storyboard:self.storyboard];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];

    self.pageViewController.dataSource = self.modelController;
    

    //
    // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
    CGRect pageViewRect = self.view.bounds;
    self.pageViewController.view.frame = pageViewRect;

    [self.pageViewController didMoveToParentViewController:self];

    // Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
    
    
   
}
- (void)viewDidAppear:(BOOL)animated{
    //kniha se otevira, mizi napisy
    
    self.bookImage.center = CGPointMake((self.bookImage.center.x - self.bookImage.bounds.size.width/2.0f), self.bookImage.center.y);
    
    [self openBook];
     
    
    [self performSelector:@selector(zoomOpenedBook) withObject:nil afterDelay:1.6 inModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
    
    
}
-(void)changeSidesOfBook{
    self.bookImage.image = [UIImage imageNamed:@"right_page_opened.png"];
}
-(void)openBook{
    
       
    self.bookImage.layer.anchorPoint=CGPointMake(0, .5);
    [self openBookFirstPart];
    [self performSelector:@selector(openBookSecondPart) withObject:nil afterDelay:0.8 inModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
    [self performSelector:@selector(finishBookOpening) withObject:nil afterDelay:1.6 inModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
    [self performSelector:@selector(activatePageViewController) withObject:nil afterDelay:2.6 inModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
    
    
    
}
-(void)openBookFirstPart{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelay:0];
    self.bookImage.transform = CGAffineTransformMakeTranslation(0,0);
    CATransform3D _3Dt = CATransform3DIdentity;
    _3Dt = CATransform3DMakeRotation(-(M_PI_2),0,1,0);
    _3Dt.m34 = 0.001f;
    _3Dt.m14 = -0.0015f;
    self.bookImage.layer.transform =_3Dt;
    
    [UIView commitAnimations];
}
-(void)openBookSecondPart{
    [self changeSidesOfBook];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelay:0];
    CATransform3D _3Dt1 = CATransform3DIdentity;
    _3Dt1 = CATransform3DMakeRotation(M_PI,0,1,0);
    self.bookImage.layer.transform =_3Dt1;
    
    [UIView commitAnimations];
    
}
-(void)finishBookOpening{
         
   //zobrazim nove view s celou otevrenou knihou
    self.wholeOpenedBookImage.image = [UIImage imageNamed:@"whole_book_opened.png"];

    //skryju levou i pravou
    self.bookImage.hidden = YES;
    self.rightPageOpened.hidden = YES;
    
}
-(void)zoomOpenedBook{
    self.noTextBackgroundImage.alpha = 1.0;
            [UIView animateWithDuration:2.0 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
        
         //1.7 je presne na celou obrazovku
        self.view.transform = CGAffineTransformMakeScale(1.65, 1.65);
        
       
    } completion:^(BOOL finished) {

        
        [UIView animateWithDuration:2 animations:^{
            self.mapImage.frame = CGRectMake(self.backgroudImage.frame.size.width-(self.mapImage.frame.size.width)-10,self.backgroudImage.frame.size.height-(self.mapImage.frame.size.height)-20,self.mapImage.frame.size.width,self.mapImage.frame.size.height);
        }];
        
    }];
    
}
-(void)activatePageViewController{
    //prida se strankovaci viewcontroller
    self.pageViewController.view.frame = CGRectMake(self.rightPageOpened.frame.origin.x, self.rightPageOpened.frame.origin.y+5, self.rightPageOpened.frame.size.width-10, self.rightPageOpened.frame.size.height-11);
    [self.view insertSubview:self.pageViewController.view belowSubview:self.mapImage];
    //[self.view addSubview:self.pageViewController.view];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ModelController *)modelController
{
     // Return the model controller object, creating it if necessary.
     // In more complex implementations, the model controller may be passed to the view controller.
    if (!_modelController) {
        _modelController = [[ModelController alloc] init];
    }
    return _modelController;
}

#pragma mark - UIPageViewController delegate methods

/*
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    
}
 */

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    // Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to YES, so set it to NO here.
    UIViewController *currentViewController = self.pageViewController.viewControllers[0];
    NSArray *viewControllers = @[currentViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];

    self.pageViewController.doubleSided = NO;
    return UIPageViewControllerSpineLocationMin;
}

@end
