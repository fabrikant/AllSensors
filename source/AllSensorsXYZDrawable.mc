using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.System;
using Toybox.Application;

class MenuItemXYZDrawable extends MenuItemDrawable {

    function initialize(options) {
        MenuItemDrawable.initialize(options);
    }

    function draw(dc) {
    	var app = Application.getApp();

		clear(dc, app.itemBackgroundColor );
		dc.setColor(app.valueColor, Graphics.COLOR_TRANSPARENT);
		MenuItemDrawable.drawTitle(dc, app);
		drawValue(dc, app);
    }

    function drawValue(dc, app){

    	var sensorsInfo = app.sensorInfo;
    	var text = "";
    	var y = Graphics.getFontHeight(app.titleFont);
    	var rawData = getRawData(app);
    	var font = Graphics.FONT_SYSTEM_SMALL;

    	if (rawData != null){
			text = Lang.format("x=$1$ y=$2$ z=$3$", rawData);
			dc.drawText(
				width/2,
				y+0.5*Graphics.getFontHeight(app.valueFont),
				font,
				text ,
				Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
			);
		}else{
			font = Graphics.FONT_LARGE;
			text = Application.loadResource(Rez.Strings.NotAvailable);
			dc.drawText(width/2, y, font, text ,Graphics.TEXT_JUSTIFY_CENTER);
    	}

    }


 }