//
//  ViewController.m
//  Demo
//
//  Created by YYB on 2020/10/11.
//

#import "ViewController.h"
#import "YYBSegmentedControl.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet YYBSegmentedControl *segmentedControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.segmentedControl addSegmentArray:@[@"一",@"二三",@"四五六"]];
}


@end
