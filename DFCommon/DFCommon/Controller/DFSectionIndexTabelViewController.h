//
//  DFSectionIndexTabelViewController.h
//  coder
//
//  Created by Allen Zhong on 15/5/15.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFBaseTableViewController.h"

@interface DFSectionIndexTabelViewController : DFBaseTableViewController

-(NSMutableArray *) getTitles;
-(void) onClickIndex:(NSInteger)index;
-(UITableViewCell *) tableViewCellAtIndex:(NSUInteger)index tableView:(UITableView *)tableView;
@end
