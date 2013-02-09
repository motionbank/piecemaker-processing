/**
 *    Motion Bank research, http://motionbank.org/
 *    PieceMaker, http://piecemaker.org/
 *
 *    Testing time syncing of devices using QRCodes
 *
 *    P2.0
 *    updated: fjenett 20130209
 */
 
QRCode qrcode;
boolean libLoaded;
int loc = 0;

void setup ()
{
    size( 600, 400, OPENGL );
    noStroke();
    //frameRate( 10 );
}

void draw ()
{
    background( 255 );
    
    if ( libLoaded )
    {
        translate( (loc % 3) * 200, (int)(loc / 3) * 200 );
        qrcode = newQRCode( 3, 'M' );
        qrcode.addData( getDateString() );
        qrcode.make();
        float w = (height/2) / qrcode.getModuleCount();
        fill( 0 );
        for ( int i = 0, k = qrcode.getModuleCount(); i < k; i++ )
        {
            for ( int j = 0; j < k; j++ )
            {
                if ( qrcode.isDark(i,j) )
                {
                    rect( j*w, i*w, w, w );
                }
            }
        }
    
        loc++;
        loc %= 6;
    }
}

void loadedQRCodeLib ()
{
    libLoaded = true;
}

interface QRCode
{
    //QRCode ( int type, char errCorr );  // type = ( 1 to 10 ), errCorr = ( 'L','M','Q','H' )
    void addData ( String data );       // set text
    int getModuleCount();               // == width / height
    boolean isDark ( int r, int c );    // get bit for y, x
}

