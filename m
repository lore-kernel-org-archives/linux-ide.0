From: Erik Slagter <erik@slagter.name>
Subject: Re: #undef ATA_ENABLE_PATA
Date: Fri, 26 Aug 2005 10:49:00 +0200
Message-ID: <1125046140.10546.17.camel@localhost.localdomain>
References: <20050723192433.GA25240@canonical.org>
	 <20050723201010.GE6913@bugs.debian.org>
	 <20050723223744.GA18882@canonical.org>
	 <20050724091729.GF6913@bugs.debian.org>
	 <20050724140705.GA6942@canonical.org> <20050725035430.GJ10254@verge.net.au>
	 <20050826032417.GA6065@canonical.org>  <20050826043601.GY6418@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-XkqDyvXDz1WcWeD2Nwln"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:39336 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S932544AbVHZItE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 Aug 2005 04:49:04 -0400
In-Reply-To: <20050826043601.GY6418@verge.net.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Horms <horms@verge.net.au>
Cc: 319659@bugs.debian.org, Brett Smith <debbug@brettcsmith.org>, linux-ide@vger.kernel.org, jgarzik@pobox.com


--=-XkqDyvXDz1WcWeD2Nwln
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-08-26 at 13:36 +0900, Horms wrote:

> #undef ATA_ENABLE_ATAPI         /* define to enable ATAPI support */
> #undef ATA_ENABLE_PATA          /* define to enable PATA support in some

These two would very interesting to me to be included in Kconfig.

--=-XkqDyvXDz1WcWeD2Nwln
Content-Type: application/x-pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGFjCCAs8w
ggI4oAMCAQICAw9TczANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhh
d3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVt
YWlsIElzc3VpbmcgQ0EwHhcNMDUwODE4MTE1NDA1WhcNMDYwODE4MTE1NDA1WjBDMR8wHQYDVQQD
ExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMSAwHgYJKoZIhvcNAQkBFhFlcmlrQHNsYWd0ZXIubmFt
ZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANAMKW15OgreNb+Wd++Xcw6uNJUXXIfX
56u1rtTObMmbbDY2wNc4Iqwbuwaysvox3z+YElXBibE8BAyV1iMjhee4mOfAy38dGHtWDxhOGke8
VpkyY8DSWgMN5p4egTiT6YNdHW75iiQ+Vh5zMHju1UXnIqgf5zkUGkNuxYp15jLZvRDbfA5H+Sil
jbZGB2fiPOJHpyI61ZidcMgdow31qm70/oe6vXxhSZLzo7OLvExE+mQHwbCSIJMN/hPTK1z0lmQ1
kkaEjHrefqIgoF9Dk/WfOtulzvR3xBzDL50GZ32BxT/OhXYe1SHEJpSM1S/aq8TBQJYwjzREWyDh
0OYsmr0CAwEAAaMuMCwwHAYDVR0RBBUwE4ERZXJpa0BzbGFndGVyLm5hbWUwDAYDVR0TAQH/BAIw
ADANBgkqhkiG9w0BAQQFAAOBgQCCpzoneRQIKsUO8zSnwQ7yhJTrS/EaDibiIVrkkCbzXwCiHFAi
7nmTRF0DlLVF3Ssf97ITWT/RSdkj9Xke0OHH7724PJdfpA6OglMnx2i7IcJLzPgPjB+fOmfR0nYX
UYKuzGxTOXmshLmPcwKdpFuRLLk7n+vrTAwJYJI++crhJzCCAz8wggKooAMCAQICAQ0wDQYJKoZI
hvcNAQEFBQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcT
CUNhcGUgVG93bjEaMBgGA1UEChMRVGhhd3RlIENvbnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmlj
YXRpb24gU2VydmljZXMgRGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFp
bCBDQTErMCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3
MTcwMDAwMDBaFw0xMzA3MTYyMzU5NTlaMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUg
Q29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwg
SXNzdWluZyBDQTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAxKY8VXNV+065yplaHmjAdQRw
nd/p/6Me7L3N9VvyGna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FWy688Cwfn8R+R
NiQqE88r1fOCdz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEA
AaOBlDCBkTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwu
dGhhd3RlLmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3JsMAsGA1UdDwQEAwIBBjApBgNV
HREEIjAgpB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgwDQYJKoZIhvcNAQEFBQADgYEA
SIzRUIPqCy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A9BxQIJNwPP2t4WFiw9k6GX6E
sZkbAMUaC4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYITq726jTlEBpbNU1341YheILc
IRk13iSx0x1G/11fZU8xggHvMIIB6wIBATBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3
dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1h
aWwgSXNzdWluZyBDQQIDD1NzMAkGBSsOAwIaBQCgXTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0wNTA4MjYwODQ5MDBaMCMGCSqGSIb3DQEJBDEWBBS4+Bm/2IZl4QIe
7tNchix4iZ4MpzANBgkqhkiG9w0BAQEFAASCAQABc3ykcVGK+Pv1bKwLduGWzQPFeUFkANYxUXOG
gyY9nw2vUTurlofTG1FWvzTMat0FtS3cexmcotd1s/OmK0T+wA+XR0BWXaFfSz1st4h4rGDmIE6G
3x6NUJ1wyL9pTnFn61Anr5Cxgl3jMeItL7SoGOmh+RxDJTTb7YTFqwuXL/aJmKNE9dqFP51bTTCr
R0wMpNgwIqkCkbvXlVgWsuKeo37aVra/7uGWeMYEbwntZ8I8d+JAHAiH8bSfkGJ7xxpV9a9+/swA
tAdNvJn4YA3Ay1o6eNal5y9dnF21X8bj63cbwydctHmyxsAvVVAHvaqZAwClFl3hwHmIHap+Ku9Y
AAAAAAAA


--=-XkqDyvXDz1WcWeD2Nwln--
