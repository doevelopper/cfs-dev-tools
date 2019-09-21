//
// based on
// http://stackoverflow.com/questions/25105269/silent-install-qt-run-installer-on-ubuntu-server
//
// run the installer with:
// installer --script <this script>
//

function Controller() {
    installer.autoRejectMessageBoxes();
    installer.installationFinished.connect(function() {
        gui.clickButton(buttons.NextButton);
    })
}

// Skip the welcome page
// (delayed click, since the "next" button is not immediately enabled)
Controller.prototype.WelcomePageCallback = function() {
    gui.clickButton(buttons.NextButton, 1000);
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
//    gui.currentPageWidget().TargetDirectoryLineEdit.setText(installer.value("HomeDir") + "/Qt");
    gui.clickButton(buttons.NextButton);
}

// select the components to install
Controller.prototype.ComponentSelectionPageCallback = function() {
//    function list_packages() {
//        var components = installer.components();
//        console.log("Available components: " + components.length);
//        var packages = ["Packages: "];
//        for (var i = 0 ; i < components.length ;i++) {
//            packages.push(components[i].name);
//        }
//        console.log(packages.join(" "));
//    }

//    list_packages();

    var widget = gui.currentPageWidget();
    console.log(widget);

//  widget.selectAll();
//	widget.deselectComponent("qt.qt5.5130.src");
//	widget.deselectComponent("qt.qt5.5130.android_armv7");
//	widget.deselectComponent("qt.qt5.5130.android_x86_64");
//	widget.deselectComponent("qt.qt5.5130.android_x86");
//	widget.deselectComponent("qt.qt5.5130.doc");
//	widget.deselectComponent("qt.qt5.5130.qtscript");
//	widget.deselectComponent("qt.qt5.5130.examples");
//  widget.selectComponent("qt.qt5.5130.qtcharts");
//  widget.selectComponent("qt.qt5.5130.qtdatavis3d");
//  widget.selectComponent("qt.qt5.5130.qtlottie");
//  widget.selectComponent("qt.qt5.5130.qtpurchasing");
//  widget.selectComponent("qt.qt5.5130.qtvirtualkeyboard");
//  widget.selectComponent("qt.qt5.5130.qtwebengine");
//  widget.selectComponent("qt.qt5.5130.qtnetworkauth");
//  widget.selectComponent("qt.qt5.5130.qtwebglplugin");

    widget.deselectAll();
    widget.selectComponent("qt.qt5.5130.gcc_64");
    widget.selectComponent("qt.tools.qtcreator");
    widget.selectComponent("qt.qt5.5130.qtcharts.gcc_64");
    widget.selectComponent("qt.qt5.5130.qtdatavis3d.gcc_64");
    widget.selectComponent("qt.qt5.5130.qtlottie.gcc_64");
    widget.selectComponent("qt.qt5.5130.qtpurchasing.gcc_64");
    widget.selectComponent("qt.qt5.5130.qtvirtualkeyboard.gcc_64");
    widget.selectComponent("qt.qt5.5130.qtwebengine.gcc_64");
    widget.selectComponent("qt.qt5.5130.qtnetworkauth.gcc_64");
    widget.selectComponent("qt.qt5.5130.qtwebglplugin.gcc_64");
    gui.clickButton(buttons.NextButton);
}

// accept the license agreement
Controller.prototype.LicenseAgreementPageCallback = function() {
    gui.currentPageWidget().AcceptLicenseRadioButton.setChecked(true);
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
