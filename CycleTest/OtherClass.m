//
// Created by Nic Wise on 10/02/16.
// Copyright (c) 2016 Nic. All rights reserved.
//

#import "OtherClass.h"


@implementation OtherClass {

}

- (void)doSomethingElse:(void (^)())block {
    block();
}

@end