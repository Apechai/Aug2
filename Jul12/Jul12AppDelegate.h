//
//  Jul12AppDelegate.h
//  Jul12
//
//  Created by Matthew Fong on 7/11/12.
//  Copyright (c) 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

@class View;

@interface Jul12AppDelegate : UIResponder <UIApplicationDelegate>{
    View *view;
    UIWindow *_window;
}

@property (strong, nonatomic) UIWindow *window;

@end
