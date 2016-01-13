//
//  MainViewController.m
//  MySafari
//
//  Created by Steve Uffelman on 1/12/16.
//  Copyright © 2016 mobile makers. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController () <UIWebViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityMonitor;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    self.urlTextField.delegate = self;
    if ([self.webView canGoBack] == YES) {
        [self.backButton setEnabled:YES];
    }else{
        [self.backButton setEnabled:NO];
    }
    if ([self.webView canGoForward] == YES) {
        [self.forwardButton setEnabled:YES];
    }else{
        [self.forwardButton setEnabled:NO];
    }
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    if ([self.urlTextField.text hasPrefix:@"http://"]) {
        NSURL *url = [NSURL URLWithString:self.urlTextField.text];
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    }else{
        NSString *fixedURL = [NSString stringWithFormat:@"http://%@", self.urlTextField.text];
        NSURL *url = [NSURL URLWithString:fixedURL];
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    }
    
    return YES;
}

-(void) webViewDidStartLoad:(UIWebView *)webView {
    [self.activityMonitor startAnimating];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
    if ([self.webView canGoBack] == YES) {
        [self.backButton setEnabled:YES];
    }else{
        [self.backButton setEnabled:NO];
    }
    [self.activityMonitor stopAnimating];
}

- (IBAction)onBackButtonPressed:(id)sender {
    if ([self.webView canGoBack] == YES) {
        [self.webView goBack];
    }
    
}
- (IBAction)onForwardButtonPressed:(id)sender {
    if ([self.webView canGoForward] == YES) {
        [self.forwardButton setEnabled:YES];
    }else{
        [self.forwardButton setEnabled:NO];
    }
}
- (IBAction)onStopLoadingButtonPressed:(id)sender {
    [self.webView stopLoading];
}
- (IBAction)reload:(id)sender {
    [self.webView reload];
}
- (IBAction)onPlusButtonTapped:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Coming Soon" message:@"Feature to come in future update" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okay = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okay];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
