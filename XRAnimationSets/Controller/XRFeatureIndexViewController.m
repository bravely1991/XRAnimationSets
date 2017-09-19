//
//  XRFeatureIndexViewController.m
//  XRAnnularPieView
//
//  Created by brave on 2017/9/10.
//  Copyright © 2017年 brave. All rights reserved.
//

#import "XRFeatureIndexViewController.h"
#import "XRFeatureIndexModel.h"


@interface XRFeatureIndexViewController ()

@property (nonatomic, strong) NSArray <XRFeatureIndexModel *> *indexArray;

@end

@implementation XRFeatureIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"功能目录";
    
    [self loadFeatureIndex];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadFeatureIndex {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"FeatureIndex" ofType:@"plist"];
    NSArray *indexArray = [NSArray arrayWithContentsOfFile:filePath];
    
    NSMutableArray *indexArrayMutable = [NSMutableArray array];
    for (NSDictionary *dict in indexArray) {
        XRFeatureIndexModel *model = [XRFeatureIndexModel modelWithDict:dict];
        [indexArrayMutable addObject:model];
    }
    self.indexArray = [indexArrayMutable copy];
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return self.indexArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NSIndexPath"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    XRFeatureIndexModel *model = self.indexArray[indexPath.row];
    cell.textLabel.text = model.featureName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XRFeatureIndexModel *model = self.indexArray[indexPath.row];
    UIViewController *VC = [(UIViewController *)[NSClassFromString(model.featureClass) alloc] init];

    if ([VC isKindOfClass:[XRSuccessViewController class]]) {
        VC.title = @"数字资产兑现";
        ((XRSuccessViewController *)VC).message = @"交易接收成功，请以明细为准。";
    }
    
    [self.navigationController pushViewController:VC animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
