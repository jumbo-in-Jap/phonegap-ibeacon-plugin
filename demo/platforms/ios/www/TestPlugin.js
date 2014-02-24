var TestPlugin = {
	    
	    callNativeFunction: function (success, fail, resultType) {
				            return Cordova.exec( success, fail, 
																				                    "com.tricedesigns.HelloPlugin", 
																														                    "nativeFunction", 
																																								                    [resultType]);
																																																		    }
};
