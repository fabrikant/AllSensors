using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.System;
using Toybox.Application;

class MenuItemHeadingDrawable extends MenuItemDrawable {
    
    function initialize(options) {
        MenuItemDrawable.initialize(options);
    }

    function drawValue(dc, app){
    	MenuItemDrawable.drawValue(dc, app);
    	drawCompass(dc, app);
    }
    	
    function drawCompass(dc, app){

    	var sensorsInfo = app.sensorInfo;
    	var angleRad = sensorsInfo[sensorType];
    	
    	if(angleRad == null){
    		return;
    	}
    
    	//var dirHeight = 0.4*height;
    	var dirHeight = 0.4 * Graphics.getFontHeight(app.valueFont);
    	var dirWidth = dirHeight/3;
    	var centerPoint = [0, 0];
    	var north = [
    		[centerPoint[0]-dirWidth, centerPoint[1]], 
    		[centerPoint[0]+dirWidth, centerPoint[1]],
    		[centerPoint[0], centerPoint[1]-dirHeight]
    	];
      	var south = [
    		[centerPoint[0]-dirWidth, centerPoint[1]], 
    		[centerPoint[0]+dirWidth, centerPoint[1]],
    		[centerPoint[0], centerPoint[1]+dirHeight]
    	];
    	
    	centerPoint = [1.2*dirHeight,height-1.2*dirHeight];
      	dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
    	dc.fillPolygon(rotate(angleRad, north, centerPoint));
    	dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
    	dc.fillPolygon(rotate(angleRad, south, centerPoint));
    	
    	drawCase(dc, centerPoint, dirHeight+3);
    }
    
    function drawCase(dc, centerPoint, r){
    	
    	dc.setColor( Application.getApp().menuBackgroundColor , Graphics.COLOR_TRANSPARENT);
    	var serif = 6;
    	dc.drawLine(centerPoint[0] - r + 1, centerPoint[1], centerPoint[0] - r + serif + 1, centerPoint[1]);
    	dc.drawLine(centerPoint[0] + r, centerPoint[1], centerPoint[0] + r - serif, centerPoint[1]);
    	dc.drawLine(centerPoint[0], centerPoint[1] + r, centerPoint[0], centerPoint[1] + r - serif);
    	dc.drawLine(centerPoint[0], centerPoint[1] - r + 1, centerPoint[0], centerPoint[1] - r + serif + 1);
    	
    	dc.setPenWidth(2);
    	dc.drawCircle(centerPoint[0], centerPoint[1], r);
    }
    function rotate(angleRad, coord, centerPoint){

    	var result = new [coord.size()];
        var cos = Math.cos(angleRad);
        var sin = Math.sin(angleRad);
        // Transform the coordinates
        for (var i = 0; i < coord.size(); i += 1) {
            var x = (coord[i][0] * cos) - (coord[i][1] * sin) + 0.5;
            var y = (coord[i][0] * sin) + (coord[i][1] * cos) + 0.5;
            result[i] = [centerPoint[0] + x, centerPoint[1] + y];
        }
        //System.println(result);
        return result;
    }
 }