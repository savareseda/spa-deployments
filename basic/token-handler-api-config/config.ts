import {BFFConfiguration} from './lib'
import {CookieSerializeOptions} from 'cookie'

export const config: BFFConfiguration = {
    clientID: 'spa-client',
    clientSecret: 'Password1',
    redirectUri: 'http://www.example.com/',
    postLogoutRedirectURI: 'http://www.example.com/',
    scope: 'openid profile',
    encKey: 'NF65meV>Ls#8GP>;!Cnov)rIPRoK^.NP',
    cookieNamePrefix: 'example',
    bffEndpointsPrefix: '/tokenhandler',
    cookieOptions: {
        httpOnly: true,
        sameSite: true,
        secure: false,
        domain: 'api.example.com',
        path: '/',
    } as CookieSerializeOptions,
    trustedWebOrigins: ['http://www.example.com'],
    authorizeEndpoint: 'http://login.example.com:8443/oauth/v2/oauth-authorize',
    logoutEndpoint: 'http://login.example.com:8443/oauth/v2/oauth-session/logout',
    tokenEndpoint: 'http://login-internal.example.com:8443/oauth/v2/oauth-token',
}
