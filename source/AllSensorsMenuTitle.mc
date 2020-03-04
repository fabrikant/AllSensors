using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.System;
using Toybox.Application;

class MenuTitleDrawable extends WatchUi.Drawable {
    
    var text;
 
    function initialize(options) {
    	
    	text = Application.loadResource(Rez.Strings.menuTitle);
    	
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
		clear(dc);
		dc.setColor(app.menuTitleColor, Graphics.COLOR_TRANSPARENT);
		dc.drawText(width/2, 0, app.titleFont, text ,Graphics.TEXT_JUSTIFY_CENTER);
    }
    
    function clear(dc){
    
    	dc.setColor(
            Application.getApp().menuBackgroundColor,
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
