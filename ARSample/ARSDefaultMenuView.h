//
//  ARSDefaultMenuView.h
//  ARSample
//
//  Created by Adithya Ravikumar on 3/9/14.
//  Copyright (c) 2014 Nothing. All rights reserved.
//

@interface ARSDefaultMenuView : UIView

@property (nonatomic, strong, readonly) UIButton *paintBucketButton;
@property (nonatomic, strong, readonly) UIButton *paintBrushButton;
@property (nonatomic, strong, readonly) UIButton *eraseButton;
@property (nonatomic, strong, readonly) UIButton *shareButton;

- (void)layoutMenuItems;
- (void)removeLayout;

@end
