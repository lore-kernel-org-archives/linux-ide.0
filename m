From: Erik Slagter <erik@slagter.name>
Subject: Re: [PATCH/RFC] SCSI mid-layer suspend/resume
Date: Thu, 27 Oct 2005 17:07:36 +0200
Message-ID: <1130425656.8768.22.camel@localhost.localdomain>
References: <20051024160531.7d879a7c.randy_d_dunlap@linux.intel.com>
	 <435D6E47.1030409@pobox.com>
	 <20051025142529.7b23bbc0.randy_d_dunlap@linux.intel.com>
	 <435EA5AB.9010805@pobox.com>  <43604B14.7080903@rtr.ca>
	 <1130404638.8768.4.camel@localhost.localdomain>  <4360CD57.7080208@rtr.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-0VCdmpVcq0fUeXz7oeP8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from erik-slagter.demon.nl ([83.161.107.130]:12722 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S1750917AbVJ0PIq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Oct 2005 11:08:46 -0400
In-Reply-To: <4360CD57.7080208@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org


--=-0VCdmpVcq0fUeXz7oeP8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-10-27 at 08:51 -0400, Mark Lord wrote:
> Erik Slagter wrote:
> > On Wed, 2005-10-26 at 23:35 -0400, Mark Lord wrote:
> > =20
> >>I have an extra hard drive caddy for my Dell notebook,
> >>with a different 2.5" drive mounted in it.
> ..
> > Any idea how this extra drive is actually connected? I was thinking PAT=
A
> > drive with SATA bridge, PATA directly (comes to mind...) or maybe it's
> > even a SATA drive connected directly...
>=20
> Definitely, absolutely, I have it in the palm of my hand,
> this is a PATA drive.
>=20
> Jeff suspects that there must be a SATA bridge
> inside the notebook itself.

Ah, OK, I think I understand now (also read your other mail), this drive
is a _replacement_ for the original drive, not additional, right?

In that case it's a very strange phenomena indeed.

BTW I'd rather have an _extra_ drive to run mirroring on ;-)

--=-0VCdmpVcq0fUeXz7oeP8
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
MBwGCSqGSIb3DQEJBTEPFw0wNTEwMjcxNTA3MzZaMCMGCSqGSIb3DQEJBDEWBBTxFIIfsAC+NvH8
/giLRErXMAYIuDANBgkqhkiG9w0BAQEFAASCAQCOTwlBzG8PvhpPjW4n1X4Tyfl8jk0+53mSnom5
zK3Uf/3Um9siifRevluJQ2sKSWQM+NTbDO5SwT5NGC3CiRAUtzMlXMzEbUFtoW3pL/b3SdR2ovjK
jGivRa4OtCR0P7nZdQz1IP8or+r0MIkw1bctYG5uQfe0/qwc/yE1zcCucuWlTtv9fH0XFjO7msLK
Prjgk46rLTB3MICx283mGV9l4NAHDil3d8xar+fDRzBTdRbS9O6bsvuc5zlySaDW4v+FRhTBAyEu
DtUaYrMWVyHhCYOyEgsKPopPyTxP06AgV12O2U/FtVT5tHFc5dutVonL2B9zjte4WtQTdM9Bzxlj
AAAAAAAA


--=-0VCdmpVcq0fUeXz7oeP8--
