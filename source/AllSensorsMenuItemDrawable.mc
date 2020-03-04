using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.System;
using Toybox.Application;

class MenuItemDrawable extends WatchUi.Drawable {
    
    var sensorType;

    function initialize(id, height) {
    	
    	sensorType = id;
		var params = {
			:identifier => id,
			:locX =>0,
			:locY => 0,
			:width => System.getDeviceSettings().screenWidth,
			:height => height
			
		};
        Drawable.initialize(params);
    }

    function draw(dc) {
    	var sensorsInfo = Application.getApp().sensorInfo;
		var color = Graphics.COLOR_WHITE;
		var backgroundColor = Graphics.COLOR_BLACK;
				
		clear(dc, backgroundColor);
		dc.setColor(color, Graphics.COLOR_TRANSPARENT);
//		dc.drawText(0, 0, Graphics.FONT_SYSTEM_SMALL, "asd", Graphics.TEXT_JUSTIFY_LEFT);
		
//		System.println(sensorsInfo);
//		System.println(sensorsInfo.temperature);
//		System.println(sensorsInfo[:temperature]);
//		System.println(sensorsInfo[sensorType]);
		
		//dc.drawText(0, 0, Graphics.FONT_SYSTEM_MEDIUM, "aaa");
		var text = "";
		if (sensorsInfo == null){
			text = "sensors \nN/A";						
		} else {
			var text = "N/A";
			if (sensorsInfo has sensorType){
				if (sensorsInfo[sensorType] != null){
					//System.println(sensorsInfo.get(identifier));
					text = sensorsInfo[sensorType];				
				}
			}
		}    	
		System.println(text);
		dc.drawText(0, 0, Graphics.FONT_SYSTEM_MEDIUM, sensorsInfo[sensorType] ,Graphics.TEXT_JUSTIFY_LEFT);
		
		
		    	
//    	//System.println(identifier);
//        //myShapes.draw(dc);
    }
    
    function clear(dc, backgroundColor){
        dc.setColor(
            backgroundColor,
            Graphics.COLOR_TRANSPARENT
        );
        dc.fillRectangle(
            0,
            0,
            dc.getWidth(),
            dc.getHeight()
        );
    }
}