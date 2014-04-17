/**
 *    Motion Bank research
 *    http://motionbank.org/
 *
 *    Workshop FH Hof / MÜnchhausen, April 2014
 *    florian@motionbank.org
 */

// http://bit.ly/1jJol6C
import org.piecemaker2.api.*;
import org.piecemaker2.models.*;
import java.util.*;

String email = "";
String password = "";
int group_id = 29, video_id = 78138;

PieceMakerApi api;
User user;
org.piecemaker2.models.Event video;
org.piecemaker2.models.Event[] annotations;

void setup ()
{
    size( 600, 200 );
    
    textFont( createFont( "*", 16 ) );
    
    api = new PieceMakerApi(this,"http://deborah-hay-pm2.herokuapp.com",null);
    api.login( email, password, api.createCallback("isLoggedIn") );
}

void draw ()
{
    if ( annotations != null && annotations.length > 0 )
    {
        background( 255 );
        
        stroke( 0 );
        strokeWeight( 1 );
        line( 10, height/2, width-10, height/2 );
        
        float video_start = video.utc_timestamp.getTime() / 1000.0;
        float video_end = video_start + video.duration;
        
        fill( 0 );
        noStroke();
        for ( org.piecemaker2.models.Event e : annotations )
        {
            float event_time = e.utc_timestamp.getTime() / 1000.0;
            float x = map( event_time, video_start, video_end, 10, width-10 );
            
            ellipse( x, height/2, 6, 6 );
        }
    }
    else
    {
        background( 200, 100, 0 );
        fill( 255 );
        text( "Loading", 10, 22 );
    }
}

void isLoggedIn ( String api_key )
{
    api.whoAmI( api.createCallback("userLoaded") );
}

void userLoaded ( User u )
{
    user = u;
    api.getEvent( group_id, video_id, api.createCallback("videoLoaded") );
}

void videoLoaded ( org.piecemaker2.models.Event v )
{
    video = v;
    
    Calendar cal = Calendar.getInstance();
    cal.setTime(video.utc_timestamp);
    cal.add(Calendar.SECOND,int(video.duration));
    Date to = cal.getTime();
    
    HashMap query = new HashMap();
    query.put( "from", video.utc_timestamp.getTime() / 1000.0 );
    query.put( "to", to.getTime() / 1000.0 );
    query.put( "type", "annotation" );
    
    api.findEvents( group_id, query, api.createCallback("videoEventsLoaded") );
}

void videoEventsLoaded ( org.piecemaker2.models.Event[] events )
{
    annotations = new org.piecemaker2.models.Event[0];
    
    for ( org.piecemaker2.models.Event e : events )
    { 
        if ( e.type.equals("annotation") && e.created_by_user_id == user.id )
        {
            println( e.getClass().getName() + " " + e.fields.get("title") );
            annotations = (org.piecemaker2.models.Event[])append( annotations, e );
        }
    }
}
