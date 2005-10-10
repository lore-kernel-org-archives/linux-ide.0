From: Erik Slagter <erik@slagter.name>
Subject: Re: Problems with Promise SATAII TX4
Date: Mon, 10 Oct 2005 12:23:08 +0200
Message-ID: <1128939788.4775.41.camel@localhost.localdomain>
References: <20050330001007.GA16954@cebitec.uni-bielefeld.de>
	 <430404A5.7060000@avona.com> <430B1D5E.9070201@avona.com>
	 <4347C5A1.1020504@avona.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-24XRNskvKn42YqD9hWXZ"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wlz.nl ([194.53.3.6]:62085 "HELO mx1.wlz.nl")
	by vger.kernel.org with SMTP id S1750733AbVJJKYH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Oct 2005 06:24:07 -0400
In-Reply-To: <4347C5A1.1020504@avona.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fabian Knittel <fabian.knittel@avona.com>
Cc: linux-ide@vger.kernel.org


--=-24XRNskvKn42YqD9hWXZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-10-08 at 15:12 +0200, Fabian Knittel wrote:
> to follow up on myself again and just for the record, the problems
> ("nobody cared, disabling" interrupt errors while accessing several
> drives simultaneously on the same Promise SATAII TX4 controller)
> disappeared after hanging all drives on a seperate power supply unit. So
> now I'm happily running with a 430W PSU powering the system and a ~200W
> PSU powering the 4 drives.
>=20
> I'm not sure why the system needs more than 430W, but with the new
> setup, I can read from 4 drives at once without any problems. Before
> this box was converted into a server we probably never tried to access
> several drives simultaneously, so I can't really blame anything in specif=
ic.

Interesting, in relation to my setup and problems. I have a 300W PSU
feeding 2/3 (one standby/spun down). It works with harddisk cooling fans
installed (wow... noise!!!) and stops working with the fans removed.

I guess harddisks (and IC's in general) start using more power when
they're hotter)?!

New PSU is underway, including more power (har, har) and better fans.
I'll report when all is installed.

--=-24XRNskvKn42YqD9hWXZ
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
MBwGCSqGSIb3DQEJBTEPFw0wNTEwMTAxMDIzMDhaMCMGCSqGSIb3DQEJBDEWBBQcvgFxZK/NI+Se
dm9my989RUCvhTANBgkqhkiG9w0BAQEFAASCAQC0ZNKqDqwAb/1abW9um0ti0bJQOY1XNpwojEBs
KJVXXcw48G+NsO+XxzDlj0RtSfZDX+4ARRoHy4zBsvTLASiyqvJKhzsgtBw3+HEjgUyFGsmlEgUD
mDl60U4EVQtlCZR2sS76tauimx5jWAo1Gtu5P/pcRw4D6DwlF2IowerGJXQZWI4lRI8wR3rvrLaG
9DFB+EctG5chw712jgjbpXUfMW8r74ZqTr1m+aHxpNqUEwt+acKN4KBuJniBhyOz8X6L9pF9vcP0
s7QBLtxzEd+60+f6Uo1BGI11G6rY3ymcg878+xOziRklJz7Qj3KK1jwokjqXiXkEjxi1IeoVH94d
AAAAAAAA


--=-24XRNskvKn42YqD9hWXZ--
