From: Erik Slagter <erik@slagter.name>
Subject: RE: Promise SATAII150 TX4: strange disk ordering
Date: Fri, 26 Aug 2005 10:46:48 +0200
Message-ID: <1125046008.10546.14.camel@localhost.localdomain>
References: <EC70EFBFB6977A478BEB386684E8A7420CE728@pwfsbs01.pwf.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-/SEtwU5DIcQmVgA7UhQr"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:37288 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S932305AbVHZIrF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 Aug 2005 04:47:05 -0400
In-Reply-To: <EC70EFBFB6977A478BEB386684E8A7420CE728@pwfsbs01.pwf.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Allen Bolderoff <allen@gist.net.au>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>, jgarzik@pobox.com, linux-ide@vger.kernel.org


--=-/SEtwU5DIcQmVgA7UhQr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-08-26 at 12:35 +0930, Allen Bolderoff wrote:
> > driver" and introducing driver options to manually order the ports?
> > How can I ensure stable device names (/dev/sd*)?

> I use LVM.
>=20
> However - this card/driver is known to break when using more than 1
> drive at a time (ie accessing 2 or 3 drives at once)=20

Interesting. I am using a TX2 with two drives attached as softraid-1 (so
they are accessed at the same time all of the time) and I have no
problems at all.

--=-/SEtwU5DIcQmVgA7UhQr
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
MBwGCSqGSIb3DQEJBTEPFw0wNTA4MjYwODQ2NDRaMCMGCSqGSIb3DQEJBDEWBBTuSq+jNlO5wprc
wVJ8/KWmVaHQDDANBgkqhkiG9w0BAQEFAASCAQBBdnNWQKwBubuCUriMoypKgAAaSgwoxEAl4FVF
PuTLM5uM5Ue+N/JFsyoVZP+UN8c/5mA7lyVPowe8fFTYGNFq9dKct7xjI139NJ9wsXl32bqvqaE4
eqR1FwMhdCQPw2VO/KqoZoOioABibsxy2B8yIJeLx/OT1IyKIE3bIO809QyALI2i3JsM8v+jlhJZ
XVZeHD2X6T4HhreiogJPsPTQmZFpL00NI6Fwj9ms6j9mc0kuXDoeqjLbY0Ubc77ET5MWhMqHehwd
bs137IkQA7jzu6jrszWI2vVxjFEIJUiG5vkdU8LaorOjIXuawcjSf3Y5hjeFkJH0TItYz8bCQQWq
AAAAAAAA


--=-/SEtwU5DIcQmVgA7UhQr--
