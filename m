From: Erik Slagter <erik@slagter.name>
Subject: Re: Dreaded PDC irq nobody cared
Date: Wed, 05 Oct 2005 12:04:56 +0200
Message-ID: <1128506696.4964.28.camel@localhost.localdomain>
References: <1128079936.6097.16.camel@localhost.localdomain>
	 <1128329273.4237.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-QsEolGu/2uu0Z6Dbl/tz"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wlz.nl ([194.53.3.6]:3785 "HELO mx1.wlz.nl")
	by vger.kernel.org with SMTP id S965095AbVJEKFJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Oct 2005 06:05:09 -0400
In-Reply-To: <1128329273.4237.9.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE <linux-ide@vger.kernel.org>


--=-QsEolGu/2uu0Z6Dbl/tz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-10-03 at 10:47 +0200, Erik Slagter wrote:
> >  - is there any chance booting with noapic would make a difference? I
> > must say my apic is a bit flaky (according to the logs)
>=20
> BTW I tried noapic, it did seem to work for two days, but then again
> crashed with the same problem :-(

I have played around a little more and found these interesting results.

 - The difference between having or having not the stuck interrupt seems
to be the forced cooling of the attached harddisks; I find this also
very hard to believe, but it is very reproducable; so to anyone having
problems with the promise sata controllers I'd recommend buying
dedicated harddisk coolers.
 - I did a test run with disabling of "stuck" interrupts disabled and I
can say: the interrupt is really stuck, it's no kernel bug; after some
time I rebooted and the controller (or harddisk) still was in a confused
state (no booting possible at all), only after an hour it started
working again; indeed looks like a heat problem.

--=-QsEolGu/2uu0Z6Dbl/tz
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
MBwGCSqGSIb3DQEJBTEPFw0wNTEwMDUxMDA0NTZaMCMGCSqGSIb3DQEJBDEWBBR8ZSXqUbw3DUYE
3jCpJfXgUzmlHzANBgkqhkiG9w0BAQEFAASCAQBcnG8Ravui5/gY1/TbYHbFLVtiDE4bGol0fX5Y
bYILTH0xne95xJ+ybkezScwvpN4GsRrkCARKqR1QZ204i/O6ps6opsXuLmGH7EaRvCFIb2DQ9V3C
Pr+6IOxqrmQgFOfWwKhu7tTpsJSdFsLlz22HisBfwlonLuebyjuQKzErUP29oGljDVF6fOzoGiUu
SVaDavCZ5BRky3tbXzksl72voV02G5e96h1uaeWzxWb2eRu7YzfJPiTQ7cCbmfgmAYEV8iaa0dcc
RDAZoyW9vv3Ocwp3pYHUNZqjWIogOw1V5+ISFLi7tHMUE0iZzWpIHZ8Y8muSu5Q1TnbcdP3yQqvt
AAAAAAAA


--=-QsEolGu/2uu0Z6Dbl/tz--
