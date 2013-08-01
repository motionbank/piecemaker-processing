/**
 *    Motion Bank research, http://motionbank.org/
 *
 *    Fetch Date object from qr-encoded timestamp image (piecemaker) 
 */

import java.io.FileInputStream;
import javax.imageio.ImageIO;

import com.google.zxing.BinaryBitmap;
import com.google.zxing.MultiFormatReader;
import com.google.zxing.Result;
import com.google.zxing.client.j2se.BufferedImageLuminanceSource;
import com.google.zxing.common.HybridBinarizer;

import java.util.Date;
import java.text.SimpleDateFormat;

void setup ()
{
    size( 200, 200 );
    
    String qrCodeData = decodeQRCodeFromFile(
                            dataPath( "1017077_10151550685874811_589977550_n.jpg" )
                        );
    println( qrCodeData );
    try {
        Date qrCodeDate = new SimpleDateFormat( "y-M-d H:m:s:S" ).parse( qrCodeData );
        println( qrCodeDate + " (" + qrCodeDate.getTime() + ")" );
    } catch ( Exception e ) {
        e.printStackTrace();
    }
}

void draw () {}

String decodeQRCodeFromFile ( String filePath )
{
    Result result = null;
    BinaryBitmap binaryBitmap;
    
    File imageFile = new File( filePath );

    try {
        binaryBitmap = new BinaryBitmap(
                        new HybridBinarizer(
                            new BufferedImageLuminanceSource(
                                ImageIO.read(
                                    new FileInputStream(
                                        imageFile.getAbsolutePath()
                                    )))));
        result = new MultiFormatReader().decode( binaryBitmap );
        return result.getText();
        
    } catch(Exception ex) {
        ex.printStackTrace();
        
    }
    
    return null;
}
