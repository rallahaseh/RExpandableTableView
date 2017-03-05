//
//  RExpandableTableView.h
//  Pods
//
//  Created by Rashed Al Lahaseh on 3/5/17.
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class RExpandableTableView;


// Function to help calculating the number of rows
extern NSInteger RExpandableTableViewNumberOfRowsInSection (RExpandableTableView * tableView,
                                                             NSInteger section,
                                                             NSInteger rows);


@protocol RExpandableTableViewDataSource <NSObject, UITableViewDataSource>

- (BOOL)tableView:(RExpandableTableView *)tableView canExpand:(NSIndexPath *)indexPath;

@end



@protocol RExpandableTableViewDelegate <NSObject, UITableViewDelegate>

@optional
- (void)tableView:(RExpandableTableView *)tableView willExpand:(NSIndexPath *)indexPath;
- (void)tableView:(RExpandableTableView *)tableView willCollapse:(NSIndexPath *)indexPath;

@end



@interface RExpandableTableView : UITableView


@property (nonatomic, weak, nullable) id <RExpandableTableViewDataSource> dataSource;
@property (nonatomic, weak, nullable) id <RExpandableTableViewDelegate> delegate;


// IndexPath of the expanded cell
@property (nonatomic, nullable)  NSIndexPath * expandedIndexPath;

// IndexPath holding the newly created expanded cell
@property (nonatomic, readonly, nullable) NSIndexPath * expandedContentIndexPath;

// returns an adjusted indexPath that the table gave to the delegate/datasource
- (NSIndexPath *)adjustedIndexPathFromTable:(NSIndexPath *)indexPath;

// returns an adjusted indexPath that the delegate/datasource gave to the table
- (NSIndexPath *)adjustedIndexPathFromDelegate:(NSIndexPath *)indexPath;


@end

NS_ASSUME_NONNULL_END
