//
//  ViewController.m
//  MeetMeUp
//
//  Created by Syed Amaanullah on 1/19/15.
//  Copyright (c) 2015 Syed Amaanullah. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *eventsTableView;
@property NSDictionary *events;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=477d1928246a4e162252547b766d3c6d"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         self.events = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
         [self.eventsTableView reloadData];
     }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.events.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventCell"];
    NSArray *eventArray = [self.events objectForKey:@"results"];
  NSDictionary *event = [eventArray objectAtIndex:indexPath.row];

    cell.textLabel.text = [event objectForKey:@"name"];
    cell.detailTextLabel.text = [event objectForKey:@"city"];
    return cell;
}


@end
