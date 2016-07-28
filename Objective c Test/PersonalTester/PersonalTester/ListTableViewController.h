//
//  ListTableViewController.h
//  PersonalTester
//
//  Created by Thongpak on 7/2/2559 BE.
//  Copyright © 2559 Witawat Wanamonthon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListTableViewModelDelegate.h"

@interface ListTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, ListTableViewModelDelegate>

@end
