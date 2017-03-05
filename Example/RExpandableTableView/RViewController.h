//
//  RViewController.h
//  RExpandableTableView
//
//  Created by rallahaseh on 03/05/2017.
//  Copyright (c) 2017 rallahaseh. All rights reserved.
//

@import UIKit;

#import "RExpandableTableView.h"

@interface RViewController : UIViewController {
    NSMutableDictionary* data;
}

@property (weak, nonatomic) IBOutlet RExpandableTableView *tableView;


@end
