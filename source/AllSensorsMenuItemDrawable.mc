using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.System;
using Toybox.Application;

class MenuItemDrawable extends WatchUi.Drawable {
    
    var sensorType, convertMethod, title;

    function initialize(options) {
    	
    	sensorType = options[:id];
    	convertMethod = options[:method];
    	title = options[:title];  
		var params = {
			:identifier => options[:id],
			:locX =>0,
			:locY => 0,
			:width => System.getDeviceSettings().screenWidth,
			:height => options[:height]
			
		};
        Drawable.initialize(params);
    }

    function draw(dc) {
    	var app = Application.getApp();
    	
		clear(dc, app.itemBackgroundColor );
		dc.setColor(app.valueColor, Graphics.COLOR_TRANSPARENT);
		drawTitle(dc, app);
		drawValue(dc, app);
    }
    
    function drawTitle(dc, app){
    	dc.drawText(width/2, 0, app.titleFont, title ,Graphics.TEXT_JUSTIFY_CENTER);
    }
    
    function drawValue(dc, app){
    	
    	var sensorsInfo = app.sensorInfo;
    	var text = "";
    	var y = Graphics.getFontHeight(app.titleFont);
    	var rawData = sensorsInfo[sensorType];
    	var font = app.valueFont;
    	
    	if (rawData != null){
			if(convertMethod != null){
				text = convertMethod.invoke(rawData);
			} else {
				text = rawData.toString();
			}
		}else{
			text = Application.loadResource(Rez.Strings.NotAvailable);
			font = Graphics.FONT_LARGE;		    		
    	}
    	dc.drawText(width/2, y, font, text ,Graphics.TEXT_JUSTIFY_CENTER);
    	
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