//
//  HyLoglnButton.h
//  Example
//
//  Created by  东海 on 15/9/2.
//  Copyright (c) 2015年 Jonathan Tribouharet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RXSpinerLayer.h"

typedef void(^Completion)();

@interface RXHyLoglnButton : UIButton

@property (nonatomic,strong) RXSpinerLayer *spiner;

- (void)setCompletion:(Completion)completion;

- (void)StartAnimation;

- (void)ErrorRevertAnimationCompletion:(Completion)completion;

- (void)ExitAnimationCompletion:(Completion)completion;

@end
