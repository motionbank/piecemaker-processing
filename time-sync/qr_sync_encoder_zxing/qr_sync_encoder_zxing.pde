
// http://code.google.com/p/zxing/
import com.google.zxing.common.*;
import java.nio.charset.*;
import java.util.Date;

QRCodeWriter codeWriter;
java.text.SimpleDateFormat format;

void setup () 
{
    size( 200, 200 );
    
    codeWriter = new QRCodeWriter();
    format = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss:SSSS");
}

void draw ()
{
    Date d = new Date();
    try {
        // see sizes here:
        // http://en.wikipedia.org/wiki/QR_code
        BitMatrix bitMatrix = codeWriter.encode( format.format(d), BarcodeFormat.QR_CODE, 25, 25);

        float w = 200.0/bitMatrix.getHeight();

        background( 255 );
        fill( 0 );
        noStroke();

        for ( int i = 0; i < 25; i++ )
            for ( int k = 0; k < 25; k++ )
                if ( bitMatrix.get( i, k ) )
                    rect( i*w, k*w, w, w );
    } 
    catch ( Exception e ) {
        e.printStackTrace();
    }
}
