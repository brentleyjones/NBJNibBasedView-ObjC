//
//  NBJNibBasedView.h
//  NBJNibBasedView-ObjC
//
//  Created by Brentley Jones on 6/22/14.
//  Copyright (c) 2014 Brentley Jones. All rights reserved.
//

@import Foundation;

/**
 *  A nib-based view will load it's view from a specified nib
 *  (defaults to class name).
 *  This allows for custom views and controls to be designed in a nib and
 *  included in other storyboards and nibs without convoluted steps.
 *  To add this functionality to a view, simply add the `NBJNibBasedView`
 *  protocol to the view.
 *
 *  This works because the catagory `UIView (`NBJNibBasedView)` uses method
 *  swizzling to swizzle <initWithFrame:>, in which it checks for conformace
 *  to the `NBJNibBasedView` protocol. If the view conforms to this protocol it
 *  does its magic.
 *
 *  Using a protocol and method swizzling is prefered because it allows the base
 *  class to be whatever it needs to be. It can for example be a <UIView> or
 *  a <UIControl>.
 */
@protocol NBJNibBasedView <NSObject>

@optional
+ (BOOL)nibBasedSubviewTranslatesAutoresizingMaskIntoConstraints;

@optional
+ (NSString *)nibBasedViewNibName;

@end
