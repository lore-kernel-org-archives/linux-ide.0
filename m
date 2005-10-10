From: Erik Slagter <erik@slagter.name>
Subject: Re: Problems with Promise SATAII TX4
Date: Mon, 10 Oct 2005 12:29:13 +0200
Message-ID: <1128940153.4775.48.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0510081259090.28615-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-UbNznDSvb0kTsD3KOY7B"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wlz.nl ([194.53.3.6]:2438 "HELO mx1.wlz.nl")
	by vger.kernel.org with SMTP id S1750736AbVJJKaG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Oct 2005 06:30:06 -0400
In-Reply-To: <Pine.LNX.4.44.0510081259090.28615-100000@coffee.psychology.mcmaster.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-ide@vger.kernel.org


--=-UbNznDSvb0kTsD3KOY7B
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-10-08 at 13:06 -0400, Mark Hahn wrote:
> > I'm not sure why the system needs more than 430W, but with the new
>=20
> unfortunately, total watts is inadequate for characterizing a PSU.
> it's about like classifying cars by how tall they are.
>=20
> in particular, many non-server higher-watt PSU's are designed to provide
> extra power for systems which consume power mainly on the CPU/video volta=
ges,
> and may not provide enough power for disks.  further, modern motherboards
> have voltage converters for the CPU and video which are less sensitive=20
> to power quality, and will thus "brownout" some power buses.  after all,=20
> a typical CPU wants 1.5V or so at an obscene current.  disk electronics,=20
> as far as I have seen, tend to treat their supply as clean and regulated.

BTW my system has a 300W PSU but consumes about 195W according to a
power meter on the primary (230V) side. Which of course is only
comparable up to a certain level.

Also BTW note that besides a total max power, PSU's also have ratings
per voltage and some even per outlet. Maybe that's where the pain comes
from ;-)

A nice "bogus power" error message in the (S)ATA standard would have
been ehrm... beneficial.

--=-UbNznDSvb0kTsD3KOY7B
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
MBwGCSqGSIb3DQEJBTEPFw0wNTEwMTAxMDI5MTNaMCMGCSqGSIb3DQEJBDEWBBRIRVEopqkqP2W8
G8TrC4d7tdr2hDANBgkqhkiG9w0BAQEFAASCAQAWret1mYMigmZuq2aqsk0WZcIt7z+6yNVjBFz7
9sAiK9Ms8zZwH4LXC0dJnkR5RUXLI2UPVTtDoLsEYnuVNWQAdvAzXCC++Z/zg+SOUrCbFLkRSqS0
u+ncFH77MoY/urRvaw6KdDToEFxF75Tyx/kQBsFfs3JxRva2sYzuRfaAmcAoTrA0oxEwkO0tc5rO
RpfYFo0QgPsmI3OtHUijpcdcL75bwh1zPRicWJkUSfyWPOJ8rYaaEOcaDk94eN/fcBmZFm6TyJ6Z
x/jKMQKTnpLMWPjxavE5hCpMhwbZoWcTm03VYUMPwQWLyQRwVeVvWVLUKg3eBd0qFiMcrL0aw7A8
AAAAAAAA


--=-UbNznDSvb0kTsD3KOY7B--
