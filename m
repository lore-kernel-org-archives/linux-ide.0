From: Erik Slagter <erik@slagter.name>
Subject: Re: USB-Storage, slow speed with sync option
Date: Wed, 14 Sep 2005 14:51:11 +0200
Message-ID: <1126702271.4248.56.camel@localhost.localdomain>
References: <43277485.6030802@yahoo.de>
	 <1126690298.4248.44.camel@localhost.localdomain>
	 <4327FB2C.5000207@yahoo.de>
	 <1126694013.4248.49.camel@localhost.localdomain>
	 <4327FEE7.7020707@yahoo.de>  <43281B5E.2090702@bouton.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-Mood23rkKKEJj/jBNgsZ"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:48574 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S965157AbVINMwH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Sep 2005 08:52:07 -0400
In-Reply-To: <43281B5E.2090702@bouton.name>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lionel Bouton <lionel-subscription@bouton.name>
Cc: linux-ide@vger.kernel.org


--=-Mood23rkKKEJj/jBNgsZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-09-14 at 14:45 +0200, Lionel Bouton wrote:
> >>Why would you _ever_ want to use the sync mount option on a flash
> >>device?
> >Don't ask me:-)

> >I used to mount without sync option, but I switched to hal + dbus now
> >and with gentoo it automatically sets sync option in fstab :-(

> This is purely a PBKAK :
> users want to remove the device as soon as they get feedback from their=20
> UI telling them that their transfer is done (in fact they even screw up=20
> and remove the device before it is done). sync in fstab isn't=20
> particularly clever, but sync with automount is more useful : when=20
> properly configured, as soon as the transfer is done the automounter can=20
> cleanly umount the block device which is nearly instantaneous when sync=20
> is used. Without sync there can be some awfully long delays with flash=20
> and huge caches (on a 512M slow SD, I saw 30+ seconds after transfering=20
> 10s or 100s of MB).

> This is understandable, for all the removable devices without a clean=20
> "eject" and VFAT formatted, using sync is probably the best safeguard=20
> against badly screwed up filesystems.

It's a very bad solution, because it's slow, but worse, it wears out
particular sectors, although the only good option (make the stick
non-removable when in use is not quite feasible).

People must be instructed to eject() before plug out. Just like
floppies.

--=-Mood23rkKKEJj/jBNgsZ
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
MBwGCSqGSIb3DQEJBTEPFw0wNTA5MTQxMjUxMTFaMCMGCSqGSIb3DQEJBDEWBBTMj0sxKpUnBHYA
K/UgT/H38SeYUzANBgkqhkiG9w0BAQEFAASCAQA7kPOqFKMfdA0/x+zR82Ee+PJPx5qqV0fcUbTJ
+o5SPEDH+HMj4GZn4AyQK5lwKOIMK6+jHaENDf7+nFcmAQW7OhggDneFRh7RvLDp6RCS4QUWT3uL
PJSjbwooR3SWyXMtqDUeX0sQScAHTDpcix5N5QP+wL5p3uMqOeTpKSpaIdRdJ74/IzFAmfZMAtpn
mLwZyKXZRdF+zB6oYPrIManAtDPO9bC4AV5zBOKqoyQeE9tQK6tCMktx621mn9EvWxBJYv3b4cMF
RVMExUMl4Ehb35P/oCG+FbDsaDk16SR3176OS60b4YKScpYbbv7xfI2XBSE0A2lhX7FF4DiXwdjf
AAAAAAAA


--=-Mood23rkKKEJj/jBNgsZ--
