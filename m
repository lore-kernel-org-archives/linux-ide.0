From: Erik Slagter <erik@slagter.name>
Subject: Re: USB-Storage, slow speed with sync option
Date: Wed, 14 Sep 2005 12:33:33 +0200
Message-ID: <1126694013.4248.49.camel@localhost.localdomain>
References: <43277485.6030802@yahoo.de>
	 <1126690298.4248.44.camel@localhost.localdomain>
	 <4327FB2C.5000207@yahoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-kEOZaEp/2U6Q92ajXiBl"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:40422 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S932705AbVINKeI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Sep 2005 06:34:08 -0400
In-Reply-To: <4327FB2C.5000207@yahoo.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stefan <gentoopower@yahoo.de>
Cc: linux-ide@vger.kernel.org


--=-kEOZaEp/2U6Q92ajXiBl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-09-14 at 12:27 +0200, Stefan wrote:
> >>When I copy files to my USB 2.0 Stick , my transferspeed are horrible i=
n
> >>case I mount the device with sync option, the rates are around 50KB/s,
> >>doesn't really matter how big the files are.
> >>If I don't mount with option sync, then the speeds are as expected a
> >>couple of MB/s
> >Now do a complete benchmark and type "sync" after the cp command.

> I already did that:-)
>=20
> With sync option, a test directory takes about 15min to copy.
> Without sync option about 20s and running command sync afterwards takes
> about 5-10s.
>=20
> So roughly 15min compared to 30s

The problem is that with the "sync" option the metadata on the stick has
be written on every block write. That is not only terribly slow
(especially on a flash device), it also wears out certain sectors.
Compare it to using floppy's on a MS/DOS computer.

Why would you _ever_ want to use the sync mount option on a flash
device?

--=-kEOZaEp/2U6Q92ajXiBl
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
MBwGCSqGSIb3DQEJBTEPFw0wNTA5MTQxMDMzMzNaMCMGCSqGSIb3DQEJBDEWBBT6a+p78UwkZuQr
oUVKJjn3IIX4RzANBgkqhkiG9w0BAQEFAASCAQBMMLHzapr0hL36kPNrcFgDljN2aHlFsf7S47BP
obrO32O/+rYexKgG8N0QGR1kzzdvSEuAfdMmz+RCgjMztzkkOO/gKNuSkkQ8HVRx9F50mw4SLwHV
u2LD0ZZMKtA8xEDw4on/AThlEYXUu4b64zf1vUazCvSYQX/jxE313HX8EmcFavqZCBgNQAFqsprm
do6tVF5OYo1GakPBLvSfnSv9jU17qPLKnUahDQDXfHaoZFrwNGsZs1YcdybjjWdeihGO8qZhbXCS
zAVKhs738aiSbhBbQfzOrXvUtZbvFTKiqEZh9QVmXsIZxhF209gjboVtqdQnUWiq36Ci5S2Cw+tI
AAAAAAAA


--=-kEOZaEp/2U6Q92ajXiBl--
