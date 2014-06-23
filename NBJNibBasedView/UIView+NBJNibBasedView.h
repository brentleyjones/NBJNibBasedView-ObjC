//
//  UIView+NBJNibBasedView.h
//  NBJNibBasedView-ObjC
//
//  Created by Brentley Jones on 6/22/14.
//  Copyright (c) 2014 Brentley Jones. All rights reserved.
//

#include "TargetConditionals.h"

#if TARGET_OS_IPHONE

@import UIKit;
#define View UIView

#else

@import AppKit;
#define View NSView

#endif

@interface View (NBJNibBasedView)

@end
