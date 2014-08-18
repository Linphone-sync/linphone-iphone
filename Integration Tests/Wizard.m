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
    SLWaitUntilTrue([wizardButton isValidAndVisible], 5);
    [UIAElement(wizardButton) tap];
    [self wait:2];
    
    SLElement* startButton = [SLElement elementWithAccessibilityLabel:@"Start"];
    SLWaitUntilTrue([startButton isValidAndVisible], 2);
    SLElement* signInLinphone = [SLElement elementWithAccessibilityLabel:@"Sign in linphone.org account"];

    SLAssertTrue(startButton!=nil, @"No start button");
    [UIAElement(startButton) tap];
	
    SLAssertTrueWithTimeout([signInLinphone isValidAndVisible], 0.5F, @"No Sign in button");
    
    [UIAElement(signInLinphone) tap];
    
    SLTextField* username = [SLTextField elementWithAccessibilityLabel:@"Username"];
    SLTextField* password = [SLTextField elementWithAccessibilityLabel:@"Password"];
    
    [UIAElement(username) setText:kTestUsername];
    [UIAElement(password) setText:kTestPassword];
    
    
    SLElement* signInButton = [SLElement elementWithAccessibilityLabel:@"Sign in"];
    
    [signInButton tap];
    
    [self checkIsRegisteredWithDelay:5];
}

@end
