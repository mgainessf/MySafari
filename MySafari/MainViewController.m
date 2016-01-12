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

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    self.urlTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    NSURL *url = [NSURL URLWithString:self.urlTextField.text];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    return YES;
}

-(void) webViewDidStartLoad:(UIWebView *)webView {
    [self.activityMonitor startAnimating];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityMonitor stopAnimating];
}

- (IBAction)onBackButtonPressed:(id)sender {
    [self.webView goBack];
}
@end
