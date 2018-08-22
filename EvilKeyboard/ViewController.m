#import "ViewController.h"
#import "AppDelegate.h"
#import "DetectedAppsManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title = @"Evil Keyboard";
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload:) name:DetectedAppsManagerDidAddAppNotification object:nil];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
}

- (void)goBack
{
	[(AppDelegate *)[UIApplication sharedApplication].delegate goBack];
}

#pragma mark -

- (void)reload:(NSNotification *)n
{
	[self.tableView reloadData];
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [DetectedAppsManager sharedManager].apps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
	}
	DetectedApp *app = [DetectedAppsManager sharedManager].apps[indexPath.row];
	cell.textLabel.text = app.bundleID;
	cell.detailTextLabel.text = app.date.description;
	return cell;
}


@end
