# SPA Deployments

Resources for end-to-end deployment of secure SPAs on a development computer.

## Deployment Overview

Deployment involves the following main steps:

| Step | Description |
| ---- | ----------- |
| Prerequisites | See the section below on prerequisites needed |
| Build Code | This builds code ready for deploying |
| Configure SSL Trust | Ensure that development certificates are trusted |
| Deploy the System | Deploy the Curity Identity Server and other supporting components |
| Run a browser | Browse to the SPA URL and login as the preconfigured user account |

## End-to-End Deployment

Start with the [Main SPA repository](https://github.com/curityio/web-oauth-via-bff), and its README file.\
The SPA deployment will use resources from this repository, and these scenarios are supported:

- Basic SPA using an Authorization Code Flow (PKCE) and a Client Secret
- Financial-grade SPA using Mutual TLS, PAR and JARM

## Token Handler Implementations

Thr same SPA is used for both scenarios above, but with different token handlers:

- [Basic Token Handler in Node.js](https://github.com/curityio/bff-node-express)
- [Financial-grade Token Handler in Kotlin](https://github.com/curityio/token-handler-kotlin-spring-fapi)

## More Information

Please visit [curity.io](https://curity.io/) for more information about the Curity Identity Server.