From: Erik Slagter <erik@slagter.name>
Subject: Re: TX4000 RAID and sata_promise
Date: Mon, 29 Aug 2005 10:52:06 +0200
Message-ID: <1125305526.31694.75.camel@localhost.localdomain>
References: <923172921.20050828173310@rccb.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-HhOEyudmS6sgqFEkZebo"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:20964 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S1750793AbVH2Iwd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Aug 2005 04:52:33 -0400
In-Reply-To: <923172921.20050828173310@rccb.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yuri Kirsanov <flash@rccb.ru>
Cc: linux-ide@vger.kernel.org


--=-HhOEyudmS6sgqFEkZebo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2005-08-28 at 17:33 +0400, Yuri Kirsanov wrote:
> Good day. I've tried latest kernel 2.6.13-rc7, TX4000 support seems to
> be in sata_promise already. After startup I see following in dmesg:
>=20
> libata version 1.12 loaded.
> sata_promise version 1.02
> PCI: Found IRQ 5 for device 0000:01:09.0
> ata1: PATA max UDMA/133 cmd 0xCC81C200 ctl 0xCC81C238 bmdma 0x0 irq 5
> ata2: PATA max UDMA/133 cmd 0xCC81C280 ctl 0xCC81C2B8 bmdma 0x0 irq 5
> ata3: PATA max UDMA/133 cmd 0xCC81C300 ctl 0xCC81C338 bmdma 0x0 irq 5
> ata4: PATA max UDMA/133 cmd 0xCC81C380 ctl 0xCC81C3B8 bmdma 0x0 irq 5
> ata1: no device found (phy stat 00000000)
> scsi0 : sata_promise
> ata2: no device found (phy stat 00000000)
> scsi1 : sata_promise
> ata3: no device found (phy stat 00000000)
> scsi2 : sata_promise
> ata4: no device found (phy stat 00000000)
> scsi3 : sata_promise
>=20
>=20
> Anybody has any ideas? As I can see, my TX4000 is found by
> sata_promise, it even detects it's UDMA modes, but it still can't find
> any of my hard drives, while TX4000 BIOS shows all of them ok.

Maybe you have to enable PATA support in include/libata.h?

--=-HhOEyudmS6sgqFEkZebo
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
MBwGCSqGSIb3DQEJBTEPFw0wNTA4MjkwODUyMDZaMCMGCSqGSIb3DQEJBDEWBBQOgkJ8s7o6Xrks
4ezE2ZY2MhO6IDANBgkqhkiG9w0BAQEFAASCAQC2oELY/edaQJX0i3AjvSQ1mrUvJ6SnrYh6ezF2
x6Ys8MnlAuTn44Q1LFnqLjzGr08H38HEDBAc0mucS4GmBggcytOuSrqHJEkEk0wyM3JQO8MpOUPS
l+Kzj9tRrIvPJ/lLlmmXa2oiSmf3ZH3gOZnIBqQQpscM0BxEXW/d4u1BZU7PJR25TtLazE11Kn5b
WDQU2LxomvMsq0rsmyfcimgHSi9jr8G4j20gqz60DcKwTse2Atr1DYfKxWJN6mJHLp+jbfrGUE5Y
MXwOAW4DdUK4Zpos7Ktm/tCnHJOvMq61WwzIVB+IjIv3lc/TWyWOC0OTkFACs6I24hSvitSCugD/
AAAAAAAA


--=-HhOEyudmS6sgqFEkZebo--
