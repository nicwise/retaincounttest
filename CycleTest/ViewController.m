//
//  ViewController.m
//  CycleTest
//
//  Created by Nic Wise on 10/02/16.
//  Copyright (c) 2016 Nic. All rights reserved.
//


#import "ViewController.h"
#import "OtherClass.h"

#define rc(val) CFGetRetainCount((__bridge CFTypeRef)val)
#define rcp(msg, val) NSLog(@"%ld\t\t%@", rc(val), msg)
#define line() NSLog(@"-----------------")

#define weakify(var) __weak typeof(var) AHKWeak_##var = var;

#define strongify(var) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong typeof(var) var = AHKWeak_##var; \
_Pragma("clang diagnostic pop")



@interface ViewController ()
@property int localVar;
@property (nonatomic, copy) void (^localProperty)();
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testWithStrongWeak {

    NSLog(@"%s", __PRETTY_FUNCTION__);
    line();
    rcp(@"starting retain count", self);

    weakify(self);
    OtherClass *other = [[OtherClass alloc] init];


    rcp(@"before calling with a local anon block", self);
    [self doStuff:^{
        strongify(self);
        self.localVar = 10;
        rcp(@"in block", self);
    }];
    rcp(@"after calling with a local anon block", self);


    line();
    rcp(@"before calling with a other anon block", self);
    [other doSomethingElse:^{
        strongify(self);
        self.localVar = 10;
        rcp(@"in block", self);
    }];
    rcp(@"after calling with a other anon block", self);

    rcp(@"end retain count", self);
    line();
}


- (void)testWithoutStrongWeak {


    NSLog(@"%s", __PRETTY_FUNCTION__);

    OtherClass *other = [[OtherClass alloc] init];

    line();
    rcp(@"starting retain count", self);

    rcp(@"before local anon block", self);
    [self doStuff:^{
        self.localVar = 10;
        rcp(@"in block", self);
    }];
    rcp(@"after local anon block", self);


    line();
    rcp(@"before other class anon block", self);
    [other doSomethingElse:^{
        self.localVar = 10;
        rcp(@"in block", self);
    }];
    rcp(@"after other class anon block", self);

    rcp(@"end retain count", self);
    line();
}

- (void)testWithStrongWeakWithLocalProperty {

    NSLog(@"%s", __PRETTY_FUNCTION__);

    weakify(self);

    OtherClass *other = [[OtherClass alloc] init];

    line();

    rcp(@"starting retain count", self);

    rcp(@"creating the block as property", self);
    self.localProperty = ^{
        strongify(self);
        self.localVar = 11;
        rcp(@"in local prop block", self);
    };
    rcp(@"after create block as property", self);

    line();

    rcp(@"self with block property", self);
    [self doStuff:self.localProperty];
    rcp(@"after self with block property", self);

    line();

    rcp(@"other object with block property", self);
    [other doSomethingElse:self.localProperty];
    rcp(@"after other object with block property", self);

    line();

    rcp(@"calling local prop directly", self);
    self.localProperty();
    rcp(@"end of calling local prop directly", self);

    line();

    rcp(@"before setting block to nil", self);
    self.localProperty = nil;
    rcp(@"local block is now nil", self);

    rcp(@"end retain count", self);
    line();
}


- (void)testWithoutStrongWeakWithLocalProperty {

    NSLog(@"%s", __PRETTY_FUNCTION__);

    OtherClass *other = [[OtherClass alloc] init];

    line();
    rcp(@"starting retain count", self);

    rcp(@"creating the block as property", self);
    self.localProperty = ^{
        self.localVar = 11;
        rcp(@"in local prop block", self);
    };
    rcp(@"after create block as property", self);

    line();

    rcp(@"self with block property", self);
    [self doStuff:self.localProperty];
    rcp(@"after self with block property", self);

    line();

    rcp(@"other object with block property", self);
    [other doSomethingElse:self.localProperty];
    rcp(@"after other object with block property", self);

    line();

    rcp(@"calling local prop directly", self);
    self.localProperty();
    rcp(@"end of calling local prop directly", self);

    line();

    rcp(@"before setting block to nil", self);
    self.localProperty = nil;
    rcp(@"local block is now nil", self);

    rcp(@"end retain count", self);
    line();
}

- (IBAction)button:(id)sender {

    [self testWithStrongWeak];

    [self testWithoutStrongWeak];

    [self testWithStrongWeakWithLocalProperty];

    [self testWithoutStrongWeakWithLocalProperty];






}

- (void)doStuff:(void(^)())block {

    rcp(@"calling block", self);
    block();
    rcp(@"after call", self);
}
@end