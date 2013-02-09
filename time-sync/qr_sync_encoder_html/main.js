// partially originates from
// http://html5-demos.appspot.com/static/fullscreen.html

document.cancelFullScreen = document.webkitCancelFullScreen || document.mozCancelFullScreen;
var elem;

window.onload = function () {
	elem = document.getElementsByTagName('iframe').item(0);
}

window.addEventListener( "message", function(e){
	if ( e.data == 'cancel-fs') {
		document.cancelFullScreen();
	}
});

document.addEventListener('keydown', function(e) {
    switch (e.keyCode) {
	
        case 13: // ENTER. ESC should also take you out of fullscreen by default.
            e.preventDefault();
            document.cancelFullScreen(); // explicitly go out of fs.
            break;

        case 70: // f
            enterFullscreen();
            break;
    }
}, false);

document.addEventListener('mousedown', function(e) {
	enterFullscreen();
}, false);

function onFullScreenEnter() {
	
    elem.onwebkitfullscreenchange = onFullScreenExit;
    document.onmozfullscreenchange = onFullScreenExit;

	elem.setAttribute('class', '');
	elem.contentWindow.postMessage( 'enter-fs', '*' );
};

// Called whenever the browser exits fullscreen.
function onFullScreenExit() {
	
	elem.setAttribute('class', 'hidden');
	elem.contentWindow.postMessage( 'exit-fs', '*' );
	
};

// Note: FF nightly needs about:config full-screen-api.enabled set to true.
function enterFullscreen() {
	
    elem.onwebkitfullscreenchange = onFullScreenEnter;
    document.onmozfullscreenchange = onFullScreenEnter;

    if ( elem.webkitRequestFullScreen ) {
	
        elem.webkitRequestFullScreen( Element.ALLOW_KEYBOARD_INPUT );
		if ( !document.webkitCurrentFullScreenElement ) {
			// http://stackoverflow.com/questions/8427413/webkitrequestfullscreen-fails-when-passing-element-allow-keyboard-input-in-safar
			elem.webkitRequestFullScreen();
		}

    } else {
	
        elem.mozRequestFullScreen();
    }
}