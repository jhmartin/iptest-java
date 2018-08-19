package us.toger;

import org.apache.http.client.fluent.*;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.apache.http.conn.HttpClientConnectionManager;
import org.apache.http.util.EntityUtils;

public class App 
{
    public static void main( String[] args )  throws Exception
    {
	//java.security.Security.setProperty("networkaddress.cache.ttl" , "0");
        int x = 10000;
        while (x > 0)
        {
          System.out.println("SIMPLE\t" + Request.Get("http://ip").execute().returnContent().toString().trim());
          x--;
	}

	//https://www.baeldung.com/httpclient-connection-management
	HttpClientConnectionManager poolingConnManager = new PoolingHttpClientConnectionManager();
	CloseableHttpClient client = HttpClients.custom().setConnectionManager(poolingConnManager).build();

        x = 10000;
        while (x > 0)
        {
          HttpEntity respEntity = client.execute(new HttpGet("http://ip")).getEntity();
    	  System.out.println("PERSISTENT\t" + EntityUtils.toString(respEntity).trim());
          EntityUtils.consume(respEntity);
          x--;
	}
    }
}
