// Emacs mode hint: -*- mode: JavaScript -*-
//
// Based on 
//
// https://stackoverflow.com/questions/25105269/silent-install-qt-run-installer-on-ubuntu-server
// https://github.com/wireshark/wireshark/blob/master/tools/qt-installer-windows.qs


// Look for Name elements in
//https://download.qt.io/online/qtsdkrepository/linux_x64/desktop/qt5_5141/Updates.xml
// Unfortunately it is not possible to disable deps like qt.tools.qtcreator

//[xml]$xml = Get-Content "Updates.xml"
//foreach( $packageUpdate in $xml.Updates.PackageUpdate)
//{ 
//    Write-Host "`"$($packageUpdate.Name)`","
//}

function Controller() {
    installer.autoRejectMessageBoxes();
    installer.installationFinished.connect(function() {
        gui.clickButton(buttons.NextButton);
    })
    // Copied from https://bugreports.qt.io/browse/QTIFW-1072?jql=project%20%3D%20QTIFW
    // there are some changes between Qt Online installer 3.0.1 and 3.0.2. Welcome page does some network
    // queries that is why the next button is called too early.
    var page = gui.pageWidgetByObjectName("WelcomePage")
    page.completeChanged.connect(welcomepageFinished)
}

// Skip the welcome page
// (delayed click, since the "next" button is not immediately enabled)
Controller.prototype.WelcomePageCallback = function() {
    gui.clickButton(buttons.NextButton, 3000);
}

welcomepageFinished = function() {
    //completeChange() -function is called also when other pages visible
    //Make sure that next button is clicked only when in welcome page
    if(gui.currentPageWidget().objectName == "WelcomePage") {
        gui.clickButton( buttons.NextButton);
    }
}

// skip the Qt Account credentials page
Controller.prototype.CredentialsPageCallback = function() {
    gui.clickButton(buttons.NextButton);
}

// skip the introduction page
Controller.prototype.IntroductionPageCallback = function() {
    gui.clickButton(buttons.NextButton);
}

// set the installation target directory
Controller.prototype.TargetDirectoryPageCallback = function() {
    gui.currentPageWidget().TargetDirectoryLineEdit.setText("/opt/Qt/");
    gui.clickButton(buttons.NextButton);
}

var version = "qt5.5141";

function list_packages() {
	var components = installer.components();
	console.log("Available components: " + components.length);
	var packages = ["Packages: "];
	for (var i = 0 ; i < components.length ;i++) {
		packages.push(components[i].name);
	}
	console.log(packages.join(" "));
}

// select the components to install
Controller.prototype.ComponentSelectionPageCallback = function() {

	list_packages();

// "qt",
// "qt.tools",
// "qt."+version+"",
// "qt.tools.qtcreator",
// "qt."+version+".gcc_64",
// "qt."+version+".qtcharts",
// "qt."+version+".qtcharts.gcc_64",
// "qt."+version+".qtdatavis3d",
// "qt."+version+".qtdatavis3d.gcc_64",
// "qt."+version+".qtlottie",
// "qt."+version+".qtlottie.gcc_64",
// "qt."+version+".qtpurchasing",
// "qt."+version+".qtpurchasing.gcc_64",
// "qt."+version+".qtvirtualkeyboard",
// "qt."+version+".qtvirtualkeyboard.gcc_64",
// "qt."+version+".qtwebengine",
// "qt."+version+".qtwebengine.gcc_64",
// "qt."+version+".qtnetworkauth",
// "qt."+version+".qtnetworkauth.gcc_64",
// "qt."+version+".qtwebglplugin",
// "qt."+version+".qtwebglplugin.gcc_64",
// "qt."+version+".qtscript",
// "qt."+version+".qtscript.gcc_64",

// qt
// qt."+version+"
// qt.license.lgpl
// qt.license.gplv3except
// qt.license.python
// qt.installer.changelog
// qt.license.thirdparty
// qt.license.win10sdk

// qt.tools
// qt.tools.qtcreator
// qt."+version+".gcc_64
// qt."+version+".qtcharts
// qt."+version+".qtcharts.gcc_64
// qt."+version+".qtdatavis3d
// qt."+version+".qtdatavis3d.gcc_64
// qt."+version+".qtlottie
// qt."+version+".qtlottie.gcc_64
// qt."+version+".qtpurchasing
// qt."+version+".qtpurchasing.gcc_64
// qt."+version+".qtvirtualkeyboard
// qt."+version+".qtvirtualkeyboard.gcc_64
// qt."+version+".qtwebengine
// qt."+version+".qtwebengine.gcc_64
// qt."+version+".qtnetworkauth
// qt."+version+".qtnetworkauth.gcc_64
// qt."+version+".qtwebglplugin
// qt."+version+".qtwebglplugin.gcc_64
// qt."+version+".qtscript
// qt."+version+".qtscript.gcc_64
// qt."+version+".android_x86
// qt."+version+".android_x86_64
// qt."+version+".android_arm64_v8a
// qt."+version+".android_armv7
// qt."+version+".src
// qt."+version+".examples
// qt."+version+".doc
// qt."+version+".qtcharts.android_x86_64
// qt."+version+".qtcharts.android_arm64_v8a
// qt."+version+".qtcharts.android_x86
// qt."+version+".qtcharts.android_armv7
// qt."+version+".qtdatavis3d.android_x86_64
// qt."+version+".qtdatavis3d.android_x86
// qt."+version+".qtdatavis3d.android_armv7
// qt."+version+".qtdatavis3d.android_arm64_v8a
// qt."+version+".qtlottie.android_x86
// qt."+version+".qtlottie.android_arm64_v8a
// qt."+version+".qtlottie.android_x86_64
// qt."+version+".qtlottie.android_armv7
// qt."+version+".qtpurchasing.android_armv7
// qt."+version+".qtpurchasing.android_x86
// qt."+version+".qtpurchasing.android_arm64_v8a
// qt."+version+".qtpurchasing.android_x86_64
// qt."+version+".qtnetworkauth.android_x86
// qt."+version+".qtnetworkauth.android_armv7
// qt."+version+".qtnetworkauth.android_x86_64
// qt."+version+".qtnetworkauth.android_arm64_v8a
// qt."+version+".qtscript.android_armv7
// qt."+version+".qtscript.android_x86_64
// qt."+version+".qtscript.android_arm64_v8a
// qt."+version+".qtscript.android_x86
// qt."+version+".examples.qtcharts
// qt."+version+".examples.qtdatavis3d
// qt."+version+".examples.qtwebengine
// qt."+version+".examples.qtscript
// qt."+version+".examples.qtvirtualkeyboard
// qt."+version+".examples.qtpurchasing
// qt."+version+".examples.qtlottie
// qt."+version+".examples.qtnetworkauth
// qt."+version+".doc.qtscript
// qt."+version+".doc.qtlottie
// qt."+version+".doc.qtnetworkauth
// qt."+version+".doc.qtvirtualkeyboard
// qt."+version+".doc.qtcharts
// qt."+version+".doc.qtdatavis3d
// qt."+version+".doc.qtpurchasing
// qt."+version+".doc.qtwebengine

    var components = [
        "qt.tools.qtcreator",
        "qt."+version+".gcc_64",
        "qt."+version+".qtcharts.gcc_64",
        "qt."+version+".qtdatavis3d.gcc_64",
        "qt."+version+".qtlottie.gcc_64",
        "qt."+version+".qtpurchasing.gcc_64",
        "qt."+version+".qtvirtualkeyboard.gcc_64",
        "qt."+version+".qtwebengine.gcc_64",
        "qt."+version+".qtnetworkauth.gcc_64",
        "qt."+version+".qtwebglplugin.gcc_64",
    ]

    console.log("Select components");

    var widget = gui.currentPageWidget();
    console.log(widget);
    widget.deselectAll();

    // for (var i=0; i < components.length; i++){
        // widget.selectComponent(components[i]);
        // console.log("selected: " + components[i])
    // }

    gui.clickButton(buttons.NextButton);
}

// accept the license agreement
Controller.prototype.LicenseAgreementPageCallback = function() {
    gui.currentPageWidget().AcceptLicenseRadioButton.setChecked(true);
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.StartMenuDirectoryPageCallback = function() {
    gui.clickButton(buttons.NextButton);
}

// install
Controller.prototype.ReadyForInstallationPageCallback = function() {
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.FinishedPageCallback = function() {
    // do not launch QtCreator
    var checkBoxForm = gui.currentPageWidget().LaunchQtCreatorCheckBoxForm
    if (checkBoxForm && checkBoxForm.launchQtCreatorCheckBox) {
        checkBoxForm.launchQtCreatorCheckBox.checked = false;
    }
    gui.clickButton(buttons.FinishButton);
}

