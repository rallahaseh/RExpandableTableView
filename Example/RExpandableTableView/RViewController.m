//
//  RViewController.m
//  RExpandableTableView
//
//  Created by rallahaseh on 03/05/2017.
//  Copyright (c) 2017 rallahaseh. All rights reserved.
//

#import "RViewController.h"

@interface RViewController ()

@end

@implementation RViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    data = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            [[NSMutableArray alloc] initWithObjects:@"1. Question One", @"2. Question Two",
             @"3. Question Three", @"4. Question Four", nil], @"question",
            [[NSMutableArray alloc] initWithObjects:@"Answer One!", @"Answer Two!",
             @"Answer Three!", @"Answer Four!", nil], @"answer", nil];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath * adjustedIndexPath = [self.tableView adjustedIndexPathFromTable:indexPath];
    NSString *questionSTR;
    NSString *answerSTR;
    questionSTR = [data[@"question"] objectAtIndex: adjustedIndexPath.row];
    answerSTR = [data[@"answer"] objectAtIndex: adjustedIndexPath.row];
    
    CGFloat questionSize = [self getTextHeight:questionSTR
                                      withFont:[UIFont systemFontOfSize:14.0f]
                                   withinWidth:(self.tableView.frame.size.width - 20)];
    CGFloat answerSize = [self getTextHeight:answerSTR
                                    withFont:[UIFont systemFontOfSize:14.0f]
                                 withinWidth:(self.tableView.frame.size.width - 20)];
    
    
    if ([indexPath isEqual:self.tableView.expandedContentIndexPath])
        return questionSize + answerSize;
    else
        return questionSize;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return RExpandableTableViewNumberOfRowsInSection((RExpandableTableView *)tableView, section, 4);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSIndexPath * adjustedIndexPath = [self.tableView adjustedIndexPathFromTable:indexPath];
    if ([self.tableView.expandedContentIndexPath isEqual:indexPath]) {
        static NSString *CellIdentifier = @"expandedCell";
        UITableViewCell *cell = [[UITableViewCell alloc]
                                 initWithStyle:UITableViewCellSelectionStyleNone reuseIdentifier:CellIdentifier];
        [cell setBackgroundColor: [UIColor clearColor]];
        for (UIView *v in [cell.contentView subviews]) {
            [v removeFromSuperview];
        }
        // Answer
        NSString *answerSTR;
        answerSTR = [data[@"answer"] objectAtIndex: adjustedIndexPath.row];
        
        CGFloat answerSize = [self getTextHeight:answerSTR
                                        withFont:[UIFont systemFontOfSize:14.0f]
                                     withinWidth:(self.tableView.frame.size.width - 20)];
        
        UILabel *answerLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, (CGRectGetWidth(cell.frame) - 10), answerSize)];
        
        [answerLabel setFont: [UIFont systemFontOfSize:14.0f]];
        [answerLabel setTextColor: [UIColor colorWithRed:200.0/255.0 green:160.0/255.0 blue:118.0/255.0 alpha:1.0]];
        [answerLabel setNumberOfLines: 50];
        [answerLabel setText: answerSTR];
        [cell.contentView addSubview: answerLabel];
        
        UIView *line = [[UIView alloc] initWithFrame: CGRectMake(0, CGRectGetHeight(answerLabel.frame) + 30,
                                                                 CGRectGetWidth(cell.frame), 1)];
        [line setBackgroundColor: [UIColor colorWithRed:67.0/255.0 green:69.0/255.0 blue:79.0/255.0 alpha:1.0]];
        [cell.contentView addSubview:line];
        
        return cell;
    }
    else {
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setBackgroundColor: [UIColor clearColor]];
        [cell setSelectionStyle: UITableViewCellSelectionStyleNone];
        
        for (UIView *v in [cell.contentView subviews]) {
            [v removeFromSuperview];
        }
        // Question
        UILabel *questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, (CGRectGetWidth(cell.frame) - 10), CGRectGetHeight(cell.frame))];
        [questionLabel setFont: [UIFont systemFontOfSize:14.0f]];
        [questionLabel setTextColor: [UIColor colorWithRed:67.0/255.0 green:69.0/255.0 blue:79.0/255.0 alpha:1.0]];
        [questionLabel setNumberOfLines: 50];
        [questionLabel setText: [data[@"question"] objectAtIndex: adjustedIndexPath.row]];
        
        [cell.contentView addSubview: questionLabel];
        
        UIView *line = [[UIView alloc] initWithFrame: CGRectMake(0, CGRectGetHeight(questionLabel.frame) + 5, CGRectGetWidth(cell.contentView.frame), 1)];
        [line setBackgroundColor: [UIColor colorWithRed:67.0/255.0 green:69.0/255.0 blue:79.0/255.0 alpha:1.0]];
        [line setTag:adjustedIndexPath.row+100];
        [cell.contentView addSubview:line];
        
        return cell;
    }
}

#pragma mark ExpandableTableView DataSource
- (BOOL)tableView:(RExpandableTableView *)tableView canExpand:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)tableView:(RExpandableTableView *)tableView willExpand:(NSIndexPath *)indexPath
{
    NSIndexPath * adjustedIndexPath = [self.tableView adjustedIndexPathFromTable:indexPath];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:adjustedIndexPath];
    [[cell.contentView viewWithTag:adjustedIndexPath.row+100] setHidden:YES];
    
    NSLog(@"Will Expand: %@",indexPath);
}
- (void)tableView:(RExpandableTableView *)tableView willCollapse:(NSIndexPath *)indexPath
{
    NSIndexPath * adjustedIndexPath = [self.tableView adjustedIndexPathFromTable:indexPath];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:adjustedIndexPath];
    [[cell.contentView viewWithTag:adjustedIndexPath.row+100] setHidden: NO];
    
    NSLog(@"Will Collapse: %@",indexPath);
}

- (CGFloat)getTextHeight:(NSString*)text withFont:(UIFont*)font withinWidth:(CGFloat)width {
    CGSize constraint = CGSizeMake(width - 10, CGFLOAT_MAX);
    CGSize size;
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [text boundingRectWithSize:constraint
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName:font}
                                            context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    return size.height + 20;
}


@end
