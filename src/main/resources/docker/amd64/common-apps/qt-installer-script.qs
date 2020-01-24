//
// based on
// http://stackoverflow.com/questions/25105269/silent-install-qt-run-installer-on-ubuntu-server
//

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

// select the components to install
Controller.prototype.ComponentSelectionPageCallback = function() {
    // function list_packages() {
        // var components = installer.components();
        // console.log("Available components: " + components.length);
        // var packages = ["Packages: "];
        // for (var i = 0 ; i < components.length ;i++) {
            // packages.push(components[i].name);
        // }
        // console.log(packages.join(" "));
    // }
    // list_packages();

// "qt",
// "qt.tools",
// "qt.qt5.5131",
// "qt.tools.qtcreator",
// "qt.qt5.5131.gcc_64",
// "qt.qt5.5131.qtcharts",
// "qt.qt5.5131.qtcharts.gcc_64",
// "qt.qt5.5131.qtdatavis3d",
// "qt.qt5.5131.qtdatavis3d.gcc_64",
// "qt.qt5.5131.qtlottie",
// "qt.qt5.5131.qtlottie.gcc_64",
// "qt.qt5.5131.qtpurchasing",
// "qt.qt5.5131.qtpurchasing.gcc_64",
// "qt.qt5.5131.qtvirtualkeyboard",
// "qt.qt5.5131.qtvirtualkeyboard.gcc_64",
// "qt.qt5.5131.qtwebengine",
// "qt.qt5.5131.qtwebengine.gcc_64",
// "qt.qt5.5131.qtnetworkauth",
// "qt.qt5.5131.qtnetworkauth.gcc_64",
// "qt.qt5.5131.qtwebglplugin",
// "qt.qt5.5131.qtwebglplugin.gcc_64",
// "qt.qt5.5131.qtscript",
// "qt.qt5.5131.qtscript.gcc_64",

// qt
// qt.qt5.5131
// qt.license.lgpl
// qt.license.gplv3except
// qt.license.python
// qt.installer.changelog
// qt.license.thirdparty
// qt.license.win10sdk

// qt.tools
// qt.tools.qtcreator
// qt.qt5.5131.gcc_64
// qt.qt5.5131.qtcharts
// qt.qt5.5131.qtcharts.gcc_64
// qt.qt5.5131.qtdatavis3d
// qt.qt5.5131.qtdatavis3d.gcc_64
// qt.qt5.5131.qtlottie
// qt.qt5.5131.qtlottie.gcc_64
// qt.qt5.5131.qtpurchasing
// qt.qt5.5131.qtpurchasing.gcc_64
// qt.qt5.5131.qtvirtualkeyboard
// qt.qt5.5131.qtvirtualkeyboard.gcc_64
// qt.qt5.5131.qtwebengine
// qt.qt5.5131.qtwebengine.gcc_64
// qt.qt5.5131.qtnetworkauth
// qt.qt5.5131.qtnetworkauth.gcc_64
// qt.qt5.5131.qtwebglplugin
// qt.qt5.5131.qtwebglplugin.gcc_64
// qt.qt5.5131.qtscript
// qt.qt5.5131.qtscript.gcc_64

// qt.qt5.5131.android_x86
// qt.qt5.5131.android_x86_64
// qt.qt5.5131.android_arm64_v8a
// qt.qt5.5131.android_armv7
// qt.qt5.5131.src
// qt.qt5.5131.examples
// qt.qt5.5131.doc
// qt.qt5.5131.qtcharts.android_x86_64
// qt.qt5.5131.qtcharts.android_arm64_v8a
// qt.qt5.5131.qtcharts.android_x86
// qt.qt5.5131.qtcharts.android_armv7
// qt.qt5.5131.qtdatavis3d.android_x86_64
// qt.qt5.5131.qtdatavis3d.android_x86
// qt.qt5.5131.qtdatavis3d.android_armv7
// qt.qt5.5131.qtdatavis3d.android_arm64_v8a
// qt.qt5.5131.qtlottie.android_x86
// qt.qt5.5131.qtlottie.android_arm64_v8a
// qt.qt5.5131.qtlottie.android_x86_64
// qt.qt5.5131.qtlottie.android_armv7
// qt.qt5.5131.qtpurchasing.android_armv7
// qt.qt5.5131.qtpurchasing.android_x86
// qt.qt5.5131.qtpurchasing.android_arm64_v8a
// qt.qt5.5131.qtpurchasing.android_x86_64
// qt.qt5.5131.qtnetworkauth.android_x86
// qt.qt5.5131.qtnetworkauth.android_armv7
// qt.qt5.5131.qtnetworkauth.android_x86_64
// qt.qt5.5131.qtnetworkauth.android_arm64_v8a
// qt.qt5.5131.qtscript.android_armv7
// qt.qt5.5131.qtscript.android_x86_64
// qt.qt5.5131.qtscript.android_arm64_v8a
// qt.qt5.5131.qtscript.android_x86
// qt.qt5.5131.examples.qtcharts
// qt.qt5.5131.examples.qtdatavis3d
// qt.qt5.5131.examples.qtwebengine
// qt.qt5.5131.examples.qtscript
// qt.qt5.5131.examples.qtvirtualkeyboard
// qt.qt5.5131.examples.qtpurchasing
// qt.qt5.5131.examples.qtlottie
// qt.qt5.5131.examples.qtnetworkauth
// qt.qt5.5131.doc.qtscript
// qt.qt5.5131.doc.qtlottie
// qt.qt5.5131.doc.qtnetworkauth
// qt.qt5.5131.doc.qtvirtualkeyboard
// qt.qt5.5131.doc.qtcharts
// qt.qt5.5131.doc.qtdatavis3d
// qt.qt5.5131.doc.qtpurchasing
// qt.qt5.5131.doc.qtwebengine
    var components = [
        "qt.tools.qtcreator",
        "qt.qt5.5132.gcc_64",
        "qt.qt5.5132.qtcharts.gcc_64",
        "qt.qt5.5132.qtdatavis3d.gcc_64",
        "qt.qt5.5132.qtlottie.gcc_64",
        "qt.qt5.5132.qtpurchasing.gcc_64",
        "qt.qt5.5132.qtvirtualkeyboard.gcc_64",
        "qt.qt5.5132.qtwebengine.gcc_64",
        "qt.qt5.5132.qtnetworkauth.gcc_64",
        "qt.qt5.5132.qtwebglplugin.gcc_64",
    ]

    console.log("Select components");

    var widget = gui.currentPageWidget();
    console.log(widget);
    widget.deselectAll();

    for (var i=0; i < components.length; i++){
        widget.selectComponent(components[i]);
        console.log("selected: " + components[i])
    }

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

