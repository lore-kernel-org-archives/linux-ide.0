From: Erik Slagter <erik@slagter.name>
Subject: Re: TX4000 RAID and sata_promise
Date: Mon, 29 Aug 2005 10:57:26 +0200
Message-ID: <1125305846.31694.79.camel@localhost.localdomain>
References: <15736083109.20050828210820@rccb.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-9aK1w642Bl88I4R8OhgF"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:34438 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S1750866AbVH2I6H (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Aug 2005 04:58:07 -0400
In-Reply-To: <15736083109.20050828210820@rccb.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yuri Kirsanov <flash@rccb.ru>
Cc: linux-ide@vger.kernel.org


--=-9aK1w642Bl88I4R8OhgF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2005-08-28 at 21:08 +0400, Yuri Kirsanov wrote:
> As you can see, only one hard drive is connected to my TX4000, and
> because I disabled sata check I get abnormal status on another ports.
> But my hard drive works just fine! I'm looking forward to attach
> another hard drive and create RAID in TX4000 BIOS. I wonder, will
> sata_promise detect two disks on two ports, or just one thru BIOS?

As mentioned before, don't use the promise softraid, you're much better
of using the linux kernel raid implementation. Yes I know you need to
configure "something" in the bios to make it continue booting ;-) I
suggest making all your harddisks a stripe.

Strange nobody answers your TX4000 mails. I could only explain that by
the topic having been discussed over and over, but that doesn't seem to
be the case (at least not in the last month).

--=-9aK1w642Bl88I4R8OhgF
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
MBwGCSqGSIb3DQEJBTEPFw0wNTA4MjkwODU3MjZaMCMGCSqGSIb3DQEJBDEWBBRmSQVl/vu9yhk+
DgHHW9AaGp7pojANBgkqhkiG9w0BAQEFAASCAQApv5eQlmCeHKNmdpISeqhRfi5zE4f7tAov+rvO
mNMkZtpm/6vJFaQvnSHs60mYfPeIh5mnmP9HXruHo5YVAWCilcG5uynpjpUa9etC3OlMTxzSdJzA
MtFVyvfEixX38g6gHB/a3dHPm/8zEP99ZCPeZuKwV8+jPATdtJ+ExXsM6ibg+qR9nSqTGSIhQmLe
1q5cGqdvp1lFJCukL66Vk/xL7FrvFQG9YDkLVOPv2424HwTvSWF2LWuZcjQYY7VemL37TyYAhOVW
JuVPmmBaFNbLEuzaOQfOO8vZAJIBJvPV+mBRXuWffwdp3uGpU/YakPdcXgn0/YSNDCZRFQGso0Bu
AAAAAAAA


--=-9aK1w642Bl88I4R8OhgF--
