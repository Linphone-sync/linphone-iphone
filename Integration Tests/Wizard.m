//
//  Wizard.m
//  linphone
//
//  Created by Guillaume BIENKOWSKI on 10/07/2014.
//
//

#import <Subliminal/Subliminal.h>
#import "BaseTestsUtils.h"

@interface Wizard : BaseTestsUtils

@end

@implementation Wizard

// keep the '\n' at the end, they ensure the keyboard is dismissed
static NSString* const test_username = @"testios\n";
static NSString* const test_password = @"testtest\n";

- (void)setUpTest {
    [self addContactPopupHandler];
}

- (void)tearDownTest {
    SLButton* dialer = [SLButton elementWithAccessibilityLabel:@"Dialer"];
    [dialer tap];
}

- (void)testWizardWithExistingAccount {
    [self exitWizardIfNecessary];
   
    [self goToSettings];
    
    //go to wizard and back to clear all config
    [self addWizardPopupHandler];
    SLElement* wizardButton = [SLElement elementWithAccessibilityLabel:@"Run assistant"];
    [wizardButton tap];
    [self wait:2];

    
    SLElement* startButton = [SLElement elementWithAccessibilityLabel:@"Start"];
    SLElement* signInLinphone = [SLElement elementWithAccessibilityLabel:@"Sign in linphone.org account"];
    
    SLAssertTrue(startButton!=nil, @"No start button");
    [startButton tap];
	
    SLAssertTrueWithTimeout([signInLinphone isValidAndVisible], 0.5F, @"No Sign in button");
    
    [signInLinphone tap];
    
    SLTextField* username = [SLTextField elementWithAccessibilityLabel:@"Username"];
    SLTextField* password = [SLTextField elementWithAccessibilityLabel:@"Password"];
    
    [username setText:test_username];
    [password setText:test_password];
    
    
    SLElement* signInButton = [SLElement elementWithAccessibilityLabel:@"Sign in"];
    
    [signInButton tap];
    
    [self checkIsRegisteredWithDelay:5];
}

@end
