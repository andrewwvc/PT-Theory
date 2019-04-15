

var widget365851 = {};
                        
widget365851.scriptUrl = "http://api.content-ad.net/Scripts/widget2.aspx?id=f8d51b5c-27cc-457c-82d6-d162ea945efe&d=NGNoYW4ub3Jn&wid=365851&cb=1532449866433";
widget365851.b64={key:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",decode:function(input){var output="";var chr1,chr2,chr3;var enc1,enc2,enc3,enc4;var i=0;input=input.replace(/[^A-Za-z0-9\+\/\=]/g,"");while(i<input.length){enc1=this.key.indexOf(input.charAt(i++));enc2=this.key.indexOf(input.charAt(i++));enc3=this.key.indexOf(input.charAt(i++));enc4=this.key.indexOf(input.charAt(i++));chr1=(enc1<<2)|(enc2>>4);chr2=((enc2&15)<<4)|(enc3>>2);chr3=((enc3&3)<<6)|enc4;output=output+String.fromCharCode(chr1);if(enc3!=64){output=output+String.fromCharCode(chr2)}if(enc4!=64){output=output+String.fromCharCode(chr3)}}return output}};
widget365851.readCookie = function (name) {
    var nameWithEqual = name + "=";
    var params = document.cookie.split(';');
    for(var i = 0; i < params.length; i++) {
        var nameValuePair = params[i];
        while (nameValuePair.charAt(0) == ' ') nameValuePair = nameValuePair.substring(1, nameValuePair.length);
        if (nameValuePair.indexOf(nameWithEqual) == 0) return nameValuePair.substring(nameWithEqual.length, nameValuePair.length);
    }
    return null;
};

widget365851.updateSourceCookie = function (name, value) {
    var d = new Date();
    d.setTime(d.getTime() + (30*60*1000));
    document.cookie = name + "=" + value + ";path=/;expires=" + d.toUTCString();
};

widget365851.params = (function () {
    var result = {}, queryString = widget365851.scriptUrl.substring(widget365851.scriptUrl.indexOf("?")+1), re = /([^&=]+)=([^&]*)/g, m;
    while (m = re.exec(queryString)) {
        result[decodeURIComponent(m[1])] = decodeURIComponent(m[2]);
    }

    var scriptUrlFromDomain = widget365851.scriptUrl.substr(widget365851.scriptUrl.indexOf("://") + 3);
    var server = scriptUrlFromDomain.substr(0, scriptUrlFromDomain.indexOf("/"));
    var url = result["url"] ? decodeURIComponent(result["url"]) : decodeURIComponent(window.location);
    
    result["lazyLoad"] = (result["lazyLoad"] == true ? true : false);
    result["server"] = (result["test"] == true ? "test." + server : server);
    if (result["server"].indexOf(widget365851.b64.decode("YXBpLmNvbnRlbnQuYWQ=")) > -1) {
        result["server"] = widget365851.b64.decode("YXBpLmNvbnRlbnQtYWQubmV0");
    }
    result["title"] = (result["title"] ? result["title"] : encodeURI(escape(document.title)));
    result["url"] = encodeURIComponent(url);
    result["ik"] = encodeURI("2018072409_865e4f8d66f12fc29a15b0bdf89729f8");
    result["ikb"] = encodeURI("865e4f8d66f12fc29a15b0bdf89729f8");
    result["duid"] = encodeURI("e1e3345caed2964a4101f70d931fb39528214ecee5231c03dcd6758c4b2475dd");
    result["ls"] = encodeURI("ip-172-18-60-165");
    result["dstlload"] = true;

    if (result["pre"] != undefined) {
        result["pre"] = encodeURIComponent(result["pre"]);
    }

    if (result["clientId"] === undefined && result["clientId2"] === undefined) {
        var pageParams = {}, pageQueryString = url.substring(url.indexOf("?")+1), pm;
	    while (pm = re.exec(pageQueryString)) {
	        pageParams[decodeURIComponent(pm[1])] = decodeURIComponent(pm[2]);
	    }
	    
	    var source = widget365851.readCookie("source");
	    var campaign = widget365851.readCookie("campaign");
        if (pageParams["utm_source"] !== undefined && pageParams["utm_source"] !== "") {
            if (pageParams["utm_source"] !== source) {
                widget365851.updateSourceCookie("source", pageParams["utm_source"]);
            }
            result["clientId"] = pageParams["utm_source"];
        } else if (source !== null && source !== "") {
            result["clientId"] = source;
        }

        if (pageParams["utm_campaign"] !== undefined && pageParams["utm_campaign"] !== "") {
            if (pageParams["utm_campaign"] !== campaign) {
                widget365851.updateSourceCookie("campaign", pageParams["utm_campaign"]);
            }
            result["clientId2"] = pageParams["utm_campaign"];
        } else if (campaign !== null && campaign !== "") {
            result["clientId2"] = campaign;
        }
    }
    return result;
} ());

widget365851.paramList = [];
for (var key in widget365851.params) {
    widget365851.paramList.push(key + '=' + widget365851.params[key]);
}

widget365851.widgetUrl = (location.protocol === 'https:' ? 'https:' : 'http:') + "//" + widget365851.params.server + "/GetWidget.aspx?" + widget365851.paramList.join('&');
widget365851.isLoaded = false;

widget365851.init = function (widgetId, widgetUrl, lazyLoad, loadMultiple) {
    if (typeof (window["contentAd" + widgetId]) == 'undefined') {
        if (!widget365851.isLoaded) {
            widget365851.isLoaded = true;
            if (lazyLoad) {
                (function () {
                    function asyncLoad() {
                        var s = document.createElement('script');
                        s.type = 'text/javascript';
                        s.async = true;
                        s.src = widgetUrl;
                        var x = document.getElementsByTagName('script')[0];
                        x.parentNode.insertBefore(s, x);
                    }
                    if (window.attachEvent)
                        window.attachEvent('onload', asyncLoad);
                    else
                        window.addEventListener('load', asyncLoad, false);
                })();
            } else {
                (function () {
                    var s = document.createElement('script');
                    s.type = 'text/javascript';
                    s.async = true;
                    s.src = widgetUrl;
                    var x = document.getElementsByTagName('script')[0];
                    x.parentNode.insertBefore(s, x);
                })();
            }
        }
        setTimeout(function () { widget365851.init(widgetId, widgetUrl, lazyLoad, loadMultiple) }, 50);
    } else {
        var content = window["contentAd" + widgetId]();
        var container = document.getElementById(widget365851.b64.decode("Y29udGVudGFk") + widgetId);
        var newDiv = document.createElement("div");
        newDiv.innerHTML = content;
        if (container === undefined || container === null) {
            var scripts = document.getElementsByTagName("script");
		    for (var i = 0; i < scripts.length; i++) {
			    if (scripts[i].innerHTML !== undefined && scripts[i].innerHTML.toLowerCase().indexOf("f8d51b5c-27cc-457c-82d6-d162ea945efe") !== -1) {
			        scripts[i].parentNode.insertBefore(newDiv, scripts[i]);
			    }
	        }
        } else {            
            container.parentNode.insertBefore(newDiv, container);
        }
        
        if (typeof (window["initJQuery" + widgetId]) != 'undefined') {
            window["initJQuery" + widgetId]();
        }
        if (loadMultiple) {
            window["contentAd" + widgetId] = undefined;
        }
        
        if (typeof (window["widget" + widgetId]) != 'undefined' && typeof (window["widget" + widgetId].customPlacement) != 'undefined') {
            if (typeof (window["widget" + widgetId].renderCustomStyleAndHtml) != 'undefined') {
	            widget365851.customContent = window["widget" + widgetId].renderCustomStyleAndHtml();
	            widget365851.customContainer = document.createElement("div");
	            widget365851.customContainer.innerHTML = widget365851.customContent;
	            
	            if (window["widget" + widgetId].customPlacement() === 'top') {
	                newDiv.parentNode.insertBefore(widget365851.customContainer, newDiv);
	            } else {
	                newDiv.parentNode.insertBefore(widget365851.customContainer, newDiv.nextSibling);
	            }
            }
            
            if (typeof (window["widget" + widgetId].renderCustomScript) != 'undefined') {
                widget365851.customScript = window["widget" + widgetId].renderCustomScript();
                widget365851.customScriptTag = document.createElement("script");
                widget365851.customScriptTag.innerHTML = widget365851.customScript;
                
                widget365851.documentWrite = document.write;
                widget365851.customScriptOutput = document.createElement("div");
                widget365851.customScriptOutput.innerHTML = '';
				document.write = function(line) {
				    widget365851.customScriptOutput.innerHTML += line;
				}
				
                if (window["widget" + widgetId].customPlacement() === 'top') {
                    newDiv.parentNode.insertBefore(widget365851.customScriptTag, newDiv);
                    newDiv.parentNode.insertBefore(widget365851.customScriptOutput, newDiv);
                } else {
                    if (typeof (window["widget" + widgetId].renderCustomStyleAndHtml) != 'undefined') {
                        newDiv.parentNode.insertBefore(widget365851.customScriptTag, newDiv.nextSibling.nextSibling);
                        newDiv.parentNode.insertBefore(widget365851.customScriptOutput, newDiv.nextSibling.nextSibling);
                    } else {
                        newDiv.parentNode.insertBefore(widget365851.customScriptTag, newDiv.nextSibling);
                        newDiv.parentNode.insertBefore(widget365851.customScriptOutput, newDiv.nextSibling);
                    }                
                }
                
                document.write = widget365851.documentWrite;
            }
        }
    }
};

widget365851.updatePopCookie = function () {
    if (document.cookie.indexOf("popdays") == -1) {
        var d = new Date();
        if (widget365851.params.exitPopExpireDays === undefined) {
            widget365851.params.exitPopExpireDays = 0;
            d.setTime(d.getTime() + (30*60*1000));
        } else {
            d.setTime(d.getTime() + (widget365851.params.exitPopExpireDays*24*60*60*1000));
        }
        document.cookie = "popdays=" + widget365851.params.exitPopExpireDays + ";path=/;expires=" + d.toUTCString();

        widget365851.init(widget365851.params.wid, widget365851.widgetUrl, widget365851.params.lazyLoad, widget365851.params.loadMultiple);
    } else {
        if (widget365851.params.exitPopExpireDays > 0 && widget365851.readCookie("popdays") != widget365851.params.exitPopExpireDays) {
            var d = new Date();
            d.setTime(d.getTime() + (widget365851.params.exitPopExpireDays*24*60*60*1000));
            document.cookie = "popdays=" + widget365851.params.exitPopExpireDays + ";path=/;expires=" + d.toUTCString();
        } else if (widget365851.params.exitPopExpireDays <= 0) {
            document.cookie = "popdays=-1;path=/;expires=Thu, 01 Jan 1970 00:00:01 GMT";
            widget365851.init(widget365851.params.wid, widget365851.widgetUrl, widget365851.params.lazyLoad, widget365851.params.loadMultiple);
        } else if (widget365851.params.exitPopExpireDays === undefined && widget365851.readCookie("popdays") > 0) {
            var d = new Date();
            d.setTime(d.getTime() + (30*60*1000));
            document.cookie = "popdays=0;path=/;expires=" + d.toUTCString();
        }
    }
};

widget365851.scrollChange = function () {
    var totalHeight, currentScroll, visibleHeight;
      
    if (document.documentElement.scrollTop) {
        currentScroll = document.documentElement.scrollTop;
    } else { 
        currentScroll = document.body.scrollTop;
    }
      
    totalHeight = document.body.offsetHeight;
    visibleHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
    var tempScroll = currentScroll + visibleHeight;
    var atEndOfPage = totalHeight <= tempScroll + (totalHeight * 0.10);
    var isScrollingUp = tempScroll < widget365851.lowestScroll;
    var hasScrolledDown = widget365851.lowestScroll > 100;
    
    if (widget365851.lowestScroll === undefined || tempScroll > widget365851.lowestScroll) {
        widget365851.lowestScroll = tempScroll;
    }

    if ((atEndOfPage || (hasScrolledDown && isScrollingUp)) && !widget365851.isLoaded) {
        widget365851.updatePopCookie();
    }
};

widget365851.mouseCoordinates = function (e) {
    var tempX = 0, tempY = 0;

    if (!e) var e = window.event;
    tempX = e.clientX;
    tempY = e.clientY;
        
    if (tempX < 0) tempX = 0;
    if (tempY < 0) tempY = 0;
    
    if (widget365851.lowestY === undefined || tempY > widget365851.lowestY) {
        widget365851.lowestY = tempY;
    }
    
    if (tempY <= 20 && tempY < widget365851.lowestY && widget365851.lowestY > 100 && !widget365851.isLoaded) {
        widget365851.updatePopCookie();
    }
};

widget365851.exitPopMobile = false;
if (widget365851.params.exitPopMobile === 'true' || widget365851.params.exitPopMobile === '1') {
    widget365851.exitPopMobile = true;
    var touchEnabled = ('ontouchstart' in window) || (window.DocumentTouch && document instanceof DocumentTouch);
    var isMobile = false;
    if (navigator.userAgent !== undefined) {
        var userAgent = navigator.userAgent.toLowerCase();
        var iPhoneIndex = userAgent.indexOf("iphone");
        var iPadIndex = userAgent.indexOf("ipad");
        var isIPhone = (iPhoneIndex !== -1 && iPadIndex === -1) || (iPhoneIndex !== -1 && iPhoneIndex < iPadIndex);
        var isAndroid = userAgent.indexOf("android") !== -1 && userAgent.indexOf("mobile") !== -1;
        var isOtherMobile = userAgent.match(/^.*?(ipod|blackberry|mini|windows\\sce|palm|phone|mobile|smartphone|iemobile).*?$/) != null;
        isMobile = isIPhone || isAndroid || isOtherMobile;
    }
    
    if (touchEnabled && isMobile) {
        setInterval(widget365851.scrollChange, 50);
    }
}

widget365851.exitPop = false;
if (widget365851.params.exitPop === 'true' || widget365851.params.exitPop === '1') {
    widget365851.exitPop = true;
    if (widget365851.params.exitPopExpireDays === undefined && widget365851.readCookie("popdays") == 0) {
        var d = new Date();
        d.setTime(d.getTime() + (30*60*1000));
        document.cookie = "popdays=0;path=/;expires=" + d.toUTCString();
    }
    var isInternetExplorer = document.all ? true : false;
    if (!isInternetExplorer) document.captureEvents(Event.MOUSEMOVE);
    try {
        document.addEventListener('mousemove', widget365851.mouseCoordinates, false);
    } catch (e) {
        document.attachEvent('onmousemove', widget365851.mouseCoordinates);
    } finally {
        try {
            if (document.onmousemove) {
                var oldOnMouseMove = document.onmousemove;
                document.onmousemove = function(e) {
                    oldOnMouseMove(e);
                    widget365851.mouseCoordinates(e);
                };
            } else {
                document.onmousemove = function(e) {
                   widget365851.mouseCoordinates(e);
                };
            }
        } catch(e) {
        
        }
    }
} 

if (!widget365851.exitPop && !widget365851.exitPopMobile) {
    widget365851.init(widget365851.params.wid, widget365851.widgetUrl, widget365851.params.lazyLoad, widget365851.params.loadMultiple);
}