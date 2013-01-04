//
//  DataViewController.h
//  ca_prototype
//
//  Created by Jan on 02.01.13.
//  Copyright (c) 2013 Jan Zahula. All rights reserved.
//

#import <UIKit/UIKit.h>
 

@protocol PageViewControllerDelegate
-(void)zoomAndRotateView;

@end

@interface DataViewController : UIViewController  

@property (weak, nonatomic) id <PageViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) id dataObject;
- (IBAction)playButtonTapped:(id)sender;

@end
