//
//  Wizard.m
//  linphone
//
//  Created by Guillaume BIENKOWSKI on 10/07/2014.
//
//

#import <Subliminal/Subliminal.h>

@interface Wizard : SLTest

@end

@implementation Wizard

- (void)setUpTest {
	// Navigate to the part of the app being exercised by the test cases,
	// initialize SLElements common to the test cases, etc.
}

- (void)tearDownTest {
	// Navigate back to "home", if applicable.
}

- (void)testWizardWithExisting {
    SLElement* startButton = [SLElement elementWithAccessibilityLabel:@"Start"];
    
    SLAssertTrue(startButton!=nil, @"No start button");
    [startButton tap];
	// Rename and implement test case.
}

@end
