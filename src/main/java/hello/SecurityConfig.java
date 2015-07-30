package hello;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableResourceServer;
import org.springframework.security.oauth2.config.annotation.web.configuration.ResourceServerConfigurer;
import org.springframework.security.oauth2.config.annotation.web.configurers.ResourceServerSecurityConfigurer;
import org.springframework.security.oauth2.provider.token.RemoteTokenServices;

@Configuration
@EnableWebSecurity
@EnableResourceServer
public class SecurityConfig implements ResourceServerConfigurer {


	private static final String RESOURCE_ID = "resource_id";
	private static final String CHECK_TOKEN_ENDPOINT = "http://localhost:8080/metaisiam/introspect";
	private static final String CLIENT_ID = "typesrepo";
	private static final String CLIENT_SECRET = "Tyc5kF0FDtxrvqlsrA2DKMExvUyWDspvtJnaf9rBGpeYofI1MuI_JL4rXaBulSZQuRNSzozo9pexelrhiDDVDg";


	public void configure(ResourceServerSecurityConfigurer resources) throws Exception {
		resources
				.tokenServices( remoteTokenServices() )
				.resourceId( RESOURCE_ID );
	}

	public void configure(HttpSecurity http) throws Exception {
		http.authorizeRequests()
				.antMatchers("/ws/**")
				.access("#oauth2.hasScope('openid')");
	}

	@Bean
	RemoteTokenServices remoteTokenServices() {
		CustomRemoteTokenServices s = new CustomRemoteTokenServices();
		s.setCheckTokenEndpointUrl(CHECK_TOKEN_ENDPOINT);
		s.setClientId(CLIENT_ID);
		s.setClientSecret(CLIENT_SECRET);
		return s;
	}

}
