# Apex HTTP Request Builder

![license](https://img.shields.io/npm/l/node-readme.svg)

A small library to make building [`HttpRequest`](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_restful_http_httprequest.htm) instances in [Apex](https://developer.salesforce.com/docs/atlas.en-us.214.0.apexcode.meta/apexcode/apex_dev_guide.htm) easy.

```java
new HttpRequestBuilder()
    .post('https://www.example.com')
    .json(new Account(Name = 'Example'))
    .send()
```

A POST request will be sent to `https://www.example.com` with the `Content-Type` header set to `application/json` and the Account serialized as JSON in the body.

# Usage

<code><b>HttpRequest build()</code></b>

Build a new client request.

<code><b>HttpRequest build(List\<String\> params)</code></b>

Build a new client request with the given parameters substituted within the endpoint.

<code><b>HttpResponse send()</code></b>

Sends the request and returns the response.

<code><b>HttpResponse send(List\<String\> params)</code></b>

Sends the request with the given parameters substituted within the endpoint and returns the response.

<code><b>HttpRequestBuilder get(String endpoint)</code></b>

Sets the type of method to be used for the HTTP request to GET and specifies the endpoint for this request.

<code><b>HttpRequestBuilder patch(String endpoint)</code></b>

Sets the type of method to be used for the HTTP request to PATCH and specifies the endpoint for this request.

<code><b>HttpRequestBuilder post(String endpoint)</code></b>

Sets the type of method to be used for the HTTP request to POST and specifies the endpoint for this request.

<code><b>HttpRequestBuilder put(String endpoint)</code></b>

Sets the type of method to be used for the HTTP request to PUT and specifies the endpoint for this request.

<code><b>HttpRequestBuilder json(Object data)</code></b>

Sets the contents of the body for this request. The contents are serialized as JSON.

<code><b>HttpRequestBuilder setBody(String body)</code></b>

Sets the contents of the body for this request.

<code><b>HttpRequestBuilder setBody(Blob body)</code></b>

Sets the contents of the body for this request using a Blob.

<code><b>HttpRequestBuilder setBody(Dom.Document document)</code></b>

Sets the contents of the body for this request. The contents represent a DOM document.

<code><b>HttpRequestBuilder setClientCertificateName(String certDevName)</code></b>

If the external service requires a client certificate for authentication, set the certificate name.

<code><b>HttpRequestBuilder setCompressed(Boolean flag)</code></b>

If true, the data in the body is delivered to the endpoint in the gzip compressed format. If false, no compression format is used.

<code><b>HttpRequestBuilder setEndpoint(String endpoint)</code></b>

Specifies the endpoint for this request.

<code><b>HttpRequestBuilder setHeader(String key, String value)</code></b>

Sets the contents of the request header.

<code><b>HttpRequestBuilder setHeaders(Map\<String, String\> headers)</code></b>

Sets the contents of multiple request headers.

<code><b>HttpRequestBuilder setMethod(String method)</code></b>

Sets the type of method to be used for the HTTP request.

<code><b>HttpRequestBuilder setTimeout(Integer timeout)</code></b>

Sets the timeout in milliseconds for the request.

# License

[MIT](https://github.com/adtennant/platform-event-stream/blob/master/LICENSE)