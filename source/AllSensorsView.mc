using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Application;

class AllSensorsView extends WatchUi.View {
	
    function initialize() {
    	activateSensors();
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        //setLayout(Rez.Layouts.MainLayout(dc));
        var itemHeight = 80;
		var menu = new WatchUi.CustomMenu(itemHeight, Graphics.COLOR_DK_GRAY, {});
		addItem(menu, :pressure, itemHeight);
		addItem(menu, :temperature, itemHeight);
		addItem(menu, :heading, itemHeight);
		var delegate;
		delegate = new AllSensorsMenuDelegate(); // a WatchUi.Menu2InputDelegate
		WatchUi.pushView(menu, delegate, WatchUi.SLIDE_IMMEDIATE);
        
    }

    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    function onHide() {
    	Sensor.unregisterSensorDataListener();
    }

	function onSensor(inf){
		Application.getApp().sensorInfo = inf;
		requestUpdate();
//		System.println(sensorInfo.pressure);
//		System.println(sensorInfo.temperature);
	}
	
	///////////////////////////////////////////////////////////////////////////
	function activateSensors(){
		Sensor.setEnabledSensors( 
			[
				Sensor.SENSOR_HEARTRATE,
				Sensor.SENSOR_TEMPERATURE
			] 
		);
		Sensor.enableSensorEvents(method(:onSensor));
	}
	
	function addItem(menu, sensorType, height){
		menu.addItem(
		    new CustomMenuItem( // a WatchUi.CustomMenuItem
		        sensorType,
		        {:drawable => new MenuItemDrawable(sensorType, height)}
		    )
		);
	
	}
	
}
