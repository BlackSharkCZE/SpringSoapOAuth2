package hello;

import org.springframework.security.oauth2.provider.token.RemoteTokenServices;

/**
 * <strong>Created with IntelliJ IDEA</strong><br/>
 * User: Jiri Pejsa<br/>
 * Date: 30.7.15<br/>
 * Time: 11:24<br/>
 * <p>To change this template use File | Settings | File Templates.</p>
 */
public class CustomRemoteTokenServices extends RemoteTokenServices {

	public CustomRemoteTokenServices() {
		setAccessTokenConverter(new CustomDefaultAccessTokenConverter());
	}


}
