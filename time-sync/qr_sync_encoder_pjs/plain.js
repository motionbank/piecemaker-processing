
document.write("<script src=\"qrcode.js\" type=\"text/javascript\"></script>");

window.onload = function () {
    findSketch();
};

var findSketch = function () {
    var sketch = Processing.getInstanceById( getProcessingSketchId() );
    if ( !sketch ) {
        setTimeout( findSketch, 100 ); // wait a little and retry
        return;
    }
    var qrreset = function () {
        this._dataList = new Array();
        this._dataCache = null;
    };
    sketch.loadedQRCodeLib();
}

var newQRCode = function ( type, errLev ) {
    return qrcode( type, errLev );
}

var getDateString = function () {
    var d = new Date();
    return d.getFullYear() + "-" + (d.getMonth()+1) + "-" + d.getDate() + " " +
           d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds() + ":" + d.getMilliseconds();
}

/*
var draw_qrcode = function(text, typeNumber, errorCorrectLevel) {
    document.write(create_qrcode(text, typeNumber, errorCorrectLevel) );
};

var create_qrcode = function(text, typeNumber, errorCorrectLevel, table) {

    var qr = qrcode(typeNumber || 4, errorCorrectLevel || 'M');
    qr.addData(text);
    qr.make();

//    return qr.createTableTag();
    return qr.createImgTag();
};

var update_qrcode = function() {
    var text = document.forms[0].elements['msg'].value.
        replace(/^[\s\u3000]+|[\s\u3000]+$/g, '');
    document.getElementById('qr').innerHTML = create_qrcode(text);
};
*/
