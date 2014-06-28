# NBJNibBasedView-ObjC
**Easy Nib based custom views**

NBJNibBasedView is an easy way to use Nibs for custom views and controls. By conforming to the `NBJNibBasedView` protocol your view  automatically loads its view hierarchy from the desired Nib, regardless of if you instantiated your view in code or in Interface Builder.

When used with [NBJMergeLayout](https://github.com/BrentleyJones/NBJMergeLayout-ObjC) the resulting view doesn't have an unnecessary extra shim view in the view hierarchy.

## How it works

Along with the `NBJNibBasedView` protocol there is the `UIView (NBJNibBasedView)` category. This category uses method swizzling on the `initWithFrame:` and `initWithCoder:` methods of `UIView` to load the desired Nib and add its first object (which should be a view) to the view hierarchy.

## Customization

To customize how the view hierarchy is loaded implement any of the following `NBJNibBasedView` protocol methods:
- `+ (BOOL)nibBasedSubviewTranslatesAutoresizingMaskIntoConstraints`
  - Defaults to `NO`
- `+ (NSString *)nibBasedViewNibName`
  - Defaults to the name of the class (so `CustomView` would load `CustomView.xib`)
- `+ (NSBundle *)nibBasedViewBundle`
  - Defaults to `[NSBundle bundleForClass:[self class]]`
