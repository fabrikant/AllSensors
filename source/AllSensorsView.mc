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

        var options;
        var app = Application.getApp();
        var itemHeight = Graphics.getFontHeight(app.titleFont) + Graphics.getFontHeight(app.valueFont);
        var menuTitleOptions = {
			:id => :menuTitle,
			:height => itemHeight
		};
		var menu = new WatchUi.CustomMenu(itemHeight, app.menuBackgroundColor, 
			{
				:title => new MenuTitleDrawable(menuTitleOptions),
			}
		);
		
		//Давление
		if ( Application.Properties.getValue("pressure")){
			options = {	
				:id => :pressure,
				:method => new Lang.Method(Tools, :pressure),
				:title => Application.loadResource(Rez.Strings.prTitle),
				:height => itemHeight
			};
			addItem(menu, new MenuItemDrawable(options), options);
		}
		
		//Компас
		if ( Application.Properties.getValue("heading")){
			options = {	
				:id => :heading ,
				:method => new Lang.Method(Tools, :heading),
				:title => Application.loadResource(Rez.Strings.headTitle),
				:height => itemHeight
			};
			addItem(menu, new MenuItemHeadingDrawable(options), options);
		}
		
		//Высота
		if ( Application.Properties.getValue("altitude")){
			options = {	
				:id => :altitude ,
				:method => new Lang.Method(Tools, :elevation),
				:title => Application.loadResource(Rez.Strings.altTitle),
				:height => itemHeight
			};
			addItem(menu, new MenuItemDrawable(options), options);
		}
	
		//Температура
		if ( Application.Properties.getValue("temperature")){
			options = {	
				:id => :temperature,
				:method => new Lang.Method(Tools, :temperature),
				:title => Application.loadResource(Rez.Strings.tTitle),
				:height => itemHeight
			};
			addItem(menu, new MenuItemDrawable(options), options);
		}

		//Пульс
		if ( Application.Properties.getValue("heartRate")){
			options = {	
				:id => :heartRate ,
				:method => null,
				:title => Application.loadResource(Rez.Strings.hrTitle),
				:height => itemHeight
			};
			addItem(menu, new MenuItemDrawable(options), options);
		}
		
		//Скорость
		if ( Application.Properties.getValue("speed")){
			options = {	
				:id => :speed ,
				:method => new Lang.Method(Tools, :speed),
				:title => Application.loadResource(Rez.Strings.spTitle),
				:height => itemHeight
			};
			addItem(menu, new MenuItemDrawable(options), options);
		}
		
		//Каденс
		if ( Application.Properties.getValue("cadence")){
			options = {	
				:id => :cadence ,
				:method => null,
				:title => Application.loadResource(Rez.Strings.cadTitle),
				:height => itemHeight
			};
			addItem(menu, new MenuItemDrawable(options), options);
		}
		
		//Мощность
		if ( Application.Properties.getValue("power")){
			options = {	
				:id => :power ,
				:method => null,
				:title => Application.loadResource(Rez.Strings.powTitle),
				:height => itemHeight
			};
			addItem(menu, new MenuItemDrawable(options), options);
		}
		
		//Акселерометр
		if ( Application.Properties.getValue("accel")){
			options = {	
				:id => :accel ,
				:method => null,
				:title => Application.loadResource(Rez.Strings.accelTitle),
				:height => itemHeight
			};
			addItem(menu, new MenuItemXYZDrawable(options), options);
		}
		
		//Магнетометр
		if ( Application.Properties.getValue("mag")){
			options = {	
				:id => :mag ,
				:method => null,
				:title => Application.loadResource(Rez.Strings.magTitle),
				:height => itemHeight
			};
			addItem(menu, new MenuItemXYZDrawable(options), options);
		}

		var delegate;
		delegate = new AllSensorsMenuDelegate(); 
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
	}
	
	///////////////////////////////////////////////////////////////////////////
	function activateSensors(){
	
		var arrSensors = new [0];
		
		if (Application.Properties.getValue("speed")){
			arrSensors.add( Sensor.SENSOR_BIKESPEED);
		}
		if (Application.Properties.getValue("cadence")){
			arrSensors.add( Sensor.SENSOR_BIKECADENCE);
		}
		if (Application.Properties.getValue("power")){
			arrSensors.add( Sensor.SENSOR_BIKEPOWER);
		}
		if (Application.Properties.getValue("cadence")){
			arrSensors.add( Sensor.SENSOR_FOOTPOD);
		}
		if (Application.Properties.getValue("heartRate")){
			arrSensors.add( Sensor.SENSOR_HEARTRATE);
		}
		if (Application.Properties.getValue("temperature")){
			arrSensors.add( Sensor.SENSOR_TEMPERATURE);
		}
			
		Sensor.setEnabledSensors(arrSensors);
		Sensor.enableSensorEvents(method(:onSensor));
	}
	
	function addItem(menu, obj, options){
	
		menu.addItem(
		    new CustomMenuItem(
		        options[:id],
		        {:drawable => obj}
		    )
		);
	}
	
}
