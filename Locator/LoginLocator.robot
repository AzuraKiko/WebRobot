*** Variables ***
# Login Button Locators
${btnSignIn}            //div[contains(@class,'loginBtnHeader') and contains(@class,'showTitle') and contains(@class,'text-capitalize')]
${btnSignIn2}           //input[@type='submit']//following-sibling::div

# Input Field Locators
${inputUsername}        //input[@name='username']
${inputPassword}        //input[@name='password']
${close_Popup_Login}    (//*[@class="CCmqaL2h1kwLflrsh6zo xfa0_FhmxUzwKzhL_6Wo"]//*[@class="svgIcon undefined"])[1]

# PIN Keyboard Locators
${keyBoard1}            //div[contains(@class,'keyBoardRoot')]//div[text()='1']
${keyBoard2}            //div[contains(@class,'keyBoardRoot')]//div[text()='2']
${keyBoard3}            //div[contains(@class,'keyBoardRoot')]//div[text()='3']
${keyBoard4}            //div[contains(@class,'keyBoardRoot')]//div[text()='4']
${keyBoard5}            //div[contains(@class,'keyBoardRoot')]//div[text()='5']
${keyBoard6}            //div[contains(@class,'keyBoardRoot')]//div[text()='6']
${keyBoard7}            //div[contains(@class,'keyBoardRoot')]//div[text()='7']
${keyBoard8}            //div[contains(@class,'keyBoardRoot')]//div[text()='8']
${keyBoard9}            //div[contains(@class,'keyBoardRoot')]//div[text()='9']
${keyBoard0}            //div[contains(@class,'keyBoardRoot')]//div[text()='0']
${keyBoardDel}          //*[@fill="var(--secondary-default)"]/ancestor::div[contains(@class, 'btnNumKeyBoard')]

# UI Element Locators
${link_Sign_In}         //*[@class="loginBtnHeader showTitle text-capitalize"]
${logo}                 //div[@class='headerRoot']//img[@class='logoWebsite']
${verifyUser}           //div[@class='headerRight']//div[text()='settings']/following-sibling::div/child::div[1]
${btnOK}                //span[contains(text(),'ok')]
${btnX}                 //li[@class='lm_close']
${acceptTerms}          //span[text()='i accept']

# Message Locators
${messageWarning_1}     //div[contains(text(),'Incorrect Password or User Login. Please make sure your details are correct and try again')]
${messageWarning_2}     //span[contains(.,'Enter Your PIN')]

# Logout Locators
${btnSignOut}           (//*[contains(text(),'sign out')])[1]
${popupSignOut}         //div[contains(text(),'Are you sure that you want to sign out?')]
${CancelLogout}         //span[text()='cancel']/parent::div[contains(@class, 'text-uppercase')]
${OkLogout}             //span[text()='ok']/parent::div[contains(@class, 'text-uppercase')]
