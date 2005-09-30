From: Erik Slagter <erik@slagter.name>
Subject: Dreaded PDC irq nobody cared
Date: Fri, 30 Sep 2005 13:32:16 +0200
Message-ID: <1128079936.6097.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-XRKow09uFiCPzLI2Ngu2"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wlz.nl ([194.53.3.6]:46752 "HELO mx1.wlz.nl")
	by vger.kernel.org with SMTP id S1751361AbVI3LcU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Sep 2005 07:32:20 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE <linux-ide@vger.kernel.org>


--=-XRKow09uFiCPzLI2Ngu2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I've been running with a PDC (sata150tx2plus) for a few months now, two
harddisk attached, softraid-1 config.

This has been working perfectly, in contrary to the many bug reports
posted here.

I now have moved to another house, connected up the server again, found
out that the disk cooling fans (bought these just to be sure, not
standard) were making way too much noise and I disconnected them.

=46rom this moment on, I have the dreaded "irq xx nobody cared" problem. I
installed 2.6.14-rc2 in the hope that it includes all patches that might
fix this issue, and all of the relevant patches I saw here are in.

Still no joy!=20

The problem notably occurs when the array is resyncing, which
corresponds to the other's reports. Sometimes it doesn't even manage to
boot completely.

So... I have a notion and a question:=20

 - it seems to matter what the temperature of the harddisks is!?
 - are there any newer patches than those in 2.6.14-rc2 that I might
try?
 - is there any chance booting with noapic would make a difference? I
must say my apic is a bit flaky (according to the logs)

Thx.

--=-XRKow09uFiCPzLI2Ngu2
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
MBwGCSqGSIb3DQEJBTEPFw0wNTA5MzAxMTMyMTZaMCMGCSqGSIb3DQEJBDEWBBQ0y1Sbs+P2dNNq
ef5divCRjQcMezANBgkqhkiG9w0BAQEFAASCAQBx40Ct/JdYwBQceoZPXWKQChR8nwy56cfoqNcU
AphSOuqwNEKuHhjci/71c7rRaSiD1RUGfAqPVE+jT9+gqu67UFTRV1FcR8Oirc/tKL0q4AWJlLYB
lxf4w7dg04zvi8Ln2a1YjvcCnojHS/zoDWkSWCkjVxppXbRdsosGgM3Ff17MTB3EKtk0x4Jq1XOA
0VqsDzQm+K9CVPOPulZRvfOVSu66s8JR3G+dcxj+7YBlpqdmzhwrc2k24Ch8Jbp+sZLK+WCAI3dy
yGFTYY1xVpQP1P8Kqqx3vBDsyAYWEb5sNWt3eCn+Y+7mKFq2D6ZP03X2T4vbkcyTrw2iHcfP4Uhm
AAAAAAAA


--=-XRKow09uFiCPzLI2Ngu2--
