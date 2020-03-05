using Toybox.Application;
using Toybox.System;
using Toybox.Math;
using Toybox.SensorHistory;
using Toybox.Lang;

module Tools {

 	function pressure(rawData){
		var value = rawData; /*Pa */
		var unit  = Application.getApp().settings[:pressureUnit];
		//System.println(rawData);
		if (unit == 0){ /*MmHg*/
			value = Math.round(rawData/133.322).format("%d");
		}else if (unit == 1){ /*Psi*/
			value = (rawData/6894.757).format("%.1f");
		}else if (unit == 2){ /*InchHg*/
			value = (rawData/3386.389).format("%.1f");
		}else if (unit == 3){ /*bar*/
			value = (rawData/100000).format("%.2f");
		}else if (unit == 4){ /*kPa*/
			value = (rawData/1000).format("%.1f");
		}else if (unit == 5){ /*hPa*/
			value = (rawData/100).format("%d");
		}
		return value;
	}

	function temperature(rawData){
		var value = rawData;/*C*/
		var unit  = System.getDeviceSettings().temperatureUnits;
		if (unit == System.UNIT_STATUTE){ /*F*/
			value = ((rawData*9/5) + 32);
		}
		return value.format("%d")+"°";
	}

	function heading(rawData){
		var value = Math.round( Math.toDegrees(rawData));
		if (value < 0){
			value += 360;
		}
		return value.format("%d");
	}

	function elevation(rawData){
		var value = rawData;//meters
		var unit =  System.getDeviceSettings().elevationUnits;
		if (unit == System.UNIT_STATUTE){ /*foot*/
			value = rawData*3.281;
		}
		return value.format("%d");
	}

	function speed(rawData){
		var value = rawData;//meters/sec
		//var unit =  Application.Properties.getValue("WU");
		var unit = Application.getApp().settings[:speedUnit];
		if (unit == 1){ /*km/h*/
			value = rawData*3.6;
		}else if (unit == 2){ /*mile/h*/
			value = rawData*2.237;
		}else if (unit == 3){ /*ft/s*/
			value = rawData*3.281;
		}
		return value.format("%.2f");
	}


}