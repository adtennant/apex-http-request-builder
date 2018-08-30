// Copyright (c) Alex Tennant
// All rights reserved.
//
// This code is licensed under the MIT License.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files(the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and / or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions :
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
 
 /**
 * @description This class provides test methods for HttpRequestBuilder.
 */
@isTest
private class HttpRequestBuilderTest
{
    private static final String BODY = 'test';
    private static final Blob BODY_BLOB = Blob.valueOf('test');
    private static final Dom.Document BODY_DOCUMENT = new DOM.Document();

    static
    {
        BODY.createRootElement('Envelope', 'http://schemas.xmlsoap.org/soap/envelope/', 'soapenv');
    }
    
    private static final Boolean FLAG = true;
    
    private static final String ENDPOINT = 'https://www.example.com/{0}/{1}';

    private static final String HEADER_KEY = HttpRequestBuilder.CONTENT_TYPE_HEADER;
    private static final String HEADER_VALUE = HttpRequestBuilder.CONTENT_TYPE_APPLICATION_JSON;
    
    private static final Map<String, String> HEADERS = new Map<String, String> {
        'Accept' => 'application/xml'
    };
    
    private static final String METHOD = HttpRequestBuilder.HTTP_METHOD_POST;

    private static final List<String> PARAMS = new List<String> { 'param1' , 'param2' };

    @isTest
    private static void itShoulBuildARequest()
    {
        HttpRequest result = new HttpRequestBuilder()
            .setBody(BODY)
            .setCompressed(FLAG)
            .setEndpoint(ENDPOINT)
            .setHeader(HttpRequestBuilder.CONTENT_TYPE_HEADER, HttpRequestBuilder.CONTENT_TYPE_APPLICATION_JSON)
            .setHeaders(HEADERS)
            .setMethod(METHOD)
            .build();

        System.assertEquals(BODY, result.getBody());
        System.assertEquals(FLAG, result.getCompressed());
        System.assertEquals(ENDPOINT, result.getEndpoint());
        System.assertEquals(HttpRequestBuilder.CONTENT_TYPE_APPLICATION_JSON, result.getHeader(HttpRequestBuilder.CONTENT_TYPE_HEADER));

        for(String key : HEADERS.keySet())
        {
            System.assertEquals(HEADERS.get(key), result.getHeader(key));
        }

        System.assertEquals(METHOD, result.getMethod());
    }

    @isTest
    private static void itShouldBuildARequestWithParams()
    {
        HttpRequest result = new HttpRequestBuilder()
            .setBody(BODY)
            .setCompressed(FLAG)
            .setEndpoint(ENDPOINT)
            .setHeader(HttpRequestBuilder.CONTENT_TYPE_HEADER, HttpRequestBuilder.CONTENT_TYPE_APPLICATION_JSON)
            .setHeaders(HEADERS)
            .setMethod(METHOD)
            .build(PARAMS);

        System.assertEquals(BODY, result.getBody());
        System.assertEquals(FLAG, result.getCompressed());
        System.assertEquals(String.format(ENDPOINT, PARAMS), result.getEndpoint());
        System.assertEquals(HttpRequestBuilder.CONTENT_TYPE_APPLICATION_JSON, result.getHeader(HttpRequestBuilder.CONTENT_TYPE_HEADER));

        for(String key : HEADERS.keySet())
        {
            System.assertEquals(HEADERS.get(key), result.getHeader(key));
        }

        System.assertEquals(METHOD, result.getMethod());
    }

    private class HttpRequestBuilderMock implements HttpCalloutMock
    {
        private final List<String> params;

        private HttpRequestBuilderMock()
        {
            this(new List<String>());
        }

        private HttpRequestBuilderMock(List<String> params)
        {
            this.params = params;
        }

        public HttpResponse respond(HttpRequest request)
        {
            System.assertEquals(BODY, result.getBody());
            System.assertEquals(FLAG, result.getCompressed());
            System.assertEquals(String.format(ENDPOINT, this.params), result.getEndpoint());
            System.assertEquals(HttpRequestBuilder.CONTENT_TYPE_APPLICATION_JSON, result.getHeader(HttpRequestBuilder.CONTENT_TYPE_HEADER));

            for(String key : HEADERS.keySet())
            {
                System.assertEquals(HEADERS.get(key), result.getHeader(key));
            }

            System.assertEquals(METHOD, result.getMethod());
        }
    }

    @isTest
    private static void itShoulSendARequest()
    {
        Test.setMock(HttpCalloutMock.class, new HttpRequestBuilderMock());

        HttpRequest result = new HttpRequestBuilder()
            .setBody(BODY)
            .setCompressed(FLAG)
            .setEndpoint(ENDPOINT)
            .setHeader(HttpRequestBuilder.CONTENT_TYPE_HEADER, HttpRequestBuilder.CONTENT_TYPE_APPLICATION_JSON)
            .setHeaders(HEADERS)
            .setMethod(METHOD)
            .send();

        System.assertNotEquals(null, result);
    }

    @isTest
    private static void itShouldSendARequestWithParams()
    {
        Test.setMock(HttpCalloutMock.class, new HttpRequestBuilderMock(PARAMS));

        HttpResponse result = new HttpRequestBuilder()
            .setBody(BODY)
            .setCompressed(FLAG)
            .setEndpoint(ENDPOINT)
            .setHeader(HttpRequestBuilder.CONTENT_TYPE_HEADER, HttpRequestBuilder.CONTENT_TYPE_APPLICATION_JSON)
            .setHeaders(HEADERS)
            .setMethod(METHOD)
            .send(PARAMS);

        System.assertNotEquals(null, result);
    }

    @isTest
    private static void itShouldCreateAGETRequest()
    {
        HttpRequest result = new HttpRequestBuilder()
            .get(ENDPOINT)
            .build();

        System.assertEquals(HttpRequestBuilder.HTTP_METHOD_GET, result.getMethod());
        System.assertEquals(ENDPOINT, result.getEndpoint());
    }

    @isTest
    private static void itShouldCreateAPATCHRequest()
    {
        HttpRequest result = new HttpRequestBuilder()
            .patch(ENDPOINT)
            .build();

        System.assertEquals(HttpRequestBuilder.HTTP_METHOD_PATCH, result.getMethod());
        System.assertEquals(ENDPOINT, result.getEndpoint());
    }

    @isTest
    private static void itShouldCreateAPOSTRequest()
    {
        HttpRequest result = new HttpRequestBuilder()
            .post(ENDPOINT)
            .build();

        System.assertEquals(HttpRequestBuilder.HTTP_METHOD_POST, result.getMethod());
        System.assertEquals(ENDPOINT, result.getEndpoint());
    }

    @isTest
    private static void itShouldCreateAPUTRequest()
    {
        HttpRequest result = new HttpRequestBuilder()
            .put(ENDPOINT)
            .build();

        System.assertEquals(HttpRequestBuilder.HTTP_METHOD_PUT, result.getMethod());
        System.assertEquals(ENDPOINT, result.getEndpoint());
    }

    @isTest
    private static void itShouldCreateAJSONRequest()
    {
        HttpRequest result = new HttpRequestBuilder()
            .json(JSON_DATA)
            .build();

        System.assertEquals(HttpRequestBuilder.CONTENT_TYPE_APPLICATION_JSON, result.getHeader(HttpRequestBuilder.CONTENT_TYPE_HEADER));
        System.assertEquals(JSON.serialize(JSON_DATA), result.getBody());
    }

    @isTest
    private static void itShouldSetBody()
    {
        HttpRequest result = new HttpRequestBuilder()
            .setBody(BODY)
            .build();

        System.assertEquals(BODY, result.getBody());
    }

    @isTest
    private static void itShouldSetBodyAsBlob()
    {
        HttpRequest result = new HttpRequestBuilder()
            .setBody(BODY_BLOB)
            .build();

        System.assertEquals(BODY_BLOB, result.getBodyAsBlob());
    }

    @isTest
    private static void itShouldSetBodyDocument()
    {
        HttpRequest result = new HttpRequestBuilder()
            .setBody(BODY_DOCUMENT)
            .build();

        System.assertEquals(BODY_DOCUMENT, result.getBodyDocument());
    }

    @isTest
    private static void itShouldSetCompressed()
    {
        HttpRequest result = new HttpRequestBuilder()
            .setCompressed(FLAG)
            .build();

        System.assertEquals(FLAG, result.getCompressed());
    }

    @isTest
    private static void itShouldSetEndpoint()
    {
        HttpRequest result = new HttpRequestBuilder()
            .setEndpoint(ENDPOINT)
            .build();

        System.assertEquals(ENDPOINT, result.getEndpoint());
    }

    @isTest
    private static void itShouldSetHeader()
    {
        final String KEY = 'Accept';
        final String VALUE = 'application/xml';

        HttpRequest result = new HttpRequestBuilder()
            .setHeader(HEADER_KEY, HEADER_VALUE)
            .build();

        System.assertEquals(HEADER_VALUE, result.getHeader(HEADER_KEY));
    }

    @isTest
    private static void itShouldSetHeaders()
    {
        HttpRequest result = new HttpRequestBuilder()
            .setHeaders(HEADERS)
            .build();

        for(String key : HEADERS.keySet())
        {
            System.assertEquals(HEADERS.get(key), result.getHeader(key));
        }
    }

    @isTest
    private static void itShouldSetMethod()
    {
        HttpRequest result = new HttpRequestBuilder()
            .setMethod(METHOD)
            .build();

        System.assertEquals(METHOD, result.getMethod());
    }
}