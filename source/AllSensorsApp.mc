using Toybox.Application;
using Toybox.Graphics;

class AllSensorsApp extends Application.AppBase {

	var gView;
	var sensorInfo;
	var settings = {};
	var menuBackgroundColor, itemBackgroundColor, menuTitleColor, titleColor, valueColor;
	var titleFont, valueFont;

    function initialize() {
    	AppBase.initialize();

    	menuBackgroundColor = Graphics.COLOR_BLACK;
		itemBackgroundColor = Graphics.COLOR_WHITE;
		menuTitleColor		= Graphics.COLOR_WHITE;
		titleColor			= Graphics.COLOR_BLACK;
		valueColor			= Graphics.COLOR_BLACK;
		titleFont			= Graphics.FONT_MEDIUM;
		valueFont			= Graphics.FONT_NUMBER_HOT;

        loadSettings();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

	function onSettingsChanged() {
		loadSettings();
		gView.createMenu();
	}

	function loadSettings(){

		settings = {
			:pressureUnit => Application.Properties.getValue("PrU"),
			:speedUnit => Application.Properties.getValue("SpU"),
		};
	}

    // Return the initial view of your application here
    function getInitialView() {
    	gView = new AllSensorsView();
        return [gView];
    }

}