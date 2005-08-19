From: Erik Slagter <erik@slagter.name>
Subject: Re: libata total system lockup fix
Date: Fri, 19 Aug 2005 11:37:40 +0200
Message-ID: <1124444261.2217.66.camel@localhost.localdomain>
References: <42E4ED70.1050501@pobox.com> <42E4FC75.70006@pobox.com>
	 <42E50AE9.3000207@rtr.ca> <42F2E267.50402@gmail.com>
	 <42FA70A9.6080608@pobox.com> <43052C03.7060306@pobox.com>
	 <4305504B.7080201@gmail.com>  <430553DB.5030807@rtr.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-GaUbEtSWrOFnxF9R+RG+"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:62168 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S932599AbVHSJiF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Aug 2005 05:38:05 -0400
In-Reply-To: <430553DB.5030807@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>


--=-GaUbEtSWrOFnxF9R+RG+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-08-18 at 23:36 -0400, Mark Lord wrote:

> However, I have had the machine lock up solid during suspend/resume (RAM)
> at least once in the past couple of days --> perhaps a command timeout
> on accessing the disk on resume (or suspend?) is aggrievating
> the situation.  No problems with the large "broken" fix,
> but the one-liner was just giving me too much grief.

Metoo (C) ;-)

I had the nerve to open the drive while suspending and had a solid
lockup.

--=-GaUbEtSWrOFnxF9R+RG+
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
MBwGCSqGSIb3DQEJBTEPFw0wNTA4MTkwOTM3NDBaMCMGCSqGSIb3DQEJBDEWBBReOAPzUSvY/b0r
Mjenx1TL/9yKgzANBgkqhkiG9w0BAQEFAASCAQCmnU+X51+flOhhqRqGbvyZdeYqUzrzQ87EA3f0
Ii7vrEuKfX0p1QmTY6n3NpLoRs1MSl2OwVyB4pv9LJFD27ZrISJS/I8d+NmsoEtZmusFCuSdUmFt
3Z4OoF4z6pA6hzxfZwCJZ5RMUoVx2p6fe3mAKpWHwtqcrY4jrWnzAaJAgbtBdvVCjk5HUgyoxlC1
DfQATnZXOb9aSg2gBUON7S36aMaOTbCf/ekZnHLDeRqupC6xTxp0WPfF9BruIb0/LkNWht7sFiT4
r+kvZeSEVzRDA5jlVzsWC9lspb8hNZ6v43rC8i8XZiVT7wLVXtwGm1qyhooxTyyjcAFpluw93Z6/
AAAAAAAA


--=-GaUbEtSWrOFnxF9R+RG+--
