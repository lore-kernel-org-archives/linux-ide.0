From: Erik Slagter <erik@slagter.name>
Subject: Re: Dreaded PDC irq nobody cared
Date: Thu, 06 Oct 2005 11:20:41 +0200
Message-ID: <1128590441.5964.37.camel@localhost.localdomain>
References: <1128079936.6097.16.camel@localhost.localdomain>
	 <1128329273.4237.9.camel@localhost.localdomain>
	 <1128506696.4964.28.camel@localhost.localdomain>
	 <4344BFB4.4080600@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-y6j+XylQ+uq52iOo9wNC"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wlz.nl ([194.53.3.6]:38099 "HELO mx1.wlz.nl")
	by vger.kernel.org with SMTP id S1750759AbVJFJVV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Oct 2005 05:21:21 -0400
In-Reply-To: <4344BFB4.4080600@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>


--=-y6j+XylQ+uq52iOo9wNC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-10-06 at 15:09 +0900, Tejun Heo wrote:

> >>> - is there any chance booting with noapic would make a difference? I
> >>>must say my apic is a bit flaky (according to the logs)
> >>
> >>BTW I tried noapic, it did seem to work for two days, but then again
> >>crashed with the same problem :-(
> > =20
> > I have played around a little more and found these interesting results.
> >=20
> >  - The difference between having or having not the stuck interrupt seem=
s
> > to be the forced cooling of the attached harddisks; I find this also
> > very hard to believe, but it is very reproducable; so to anyone having
> > problems with the promise sata controllers I'd recommend buying
> > dedicated harddisk coolers.

> >  - I did a test run with disabling of "stuck" interrupts disabled and I
> > can say: the interrupt is really stuck, it's no kernel bug; after some
> > time I rebooted and the controller (or harddisk) still was in a confuse=
d
> > state (no booting possible at all), only after an hour it started
> > working again; indeed looks like a heat problem.
>=20
>   Sounds like you got a faulty drive or really bad ventilation in your ca=
se.

That would be the logical conclusion.

What puzzles me still is:

 - various people have this problem with various brands and models disks
 - the temperature of the disks is ~40 C, without cooling, and also ~40
C with cooling (?!) according to smartctl attribute 195, so either the
temperature sensors are wrong (silly location?) or it really doesn't
matter?!
 - I cannot pinpoint the problem to one harddisk, and probably never
will, because the problem only occurs with > 1 harddisk
connected :-( (as the other people experience)
 - the temperature in the case is not very cool but also not extremely
hot, imho it shouldn't bother the harddisks.

I am very interested in the experiences of the other people that have
problems with the promise sata controller cards.

--=-y6j+XylQ+uq52iOo9wNC
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
MBwGCSqGSIb3DQEJBTEPFw0wNTEwMDYwOTIwNDFaMCMGCSqGSIb3DQEJBDEWBBRkbNdxnukvjVEd
FPf/OQYqfvYEtzANBgkqhkiG9w0BAQEFAASCAQCLwlPuQpjajs7URq1Nqnml72KI/TiStpk4Qc92
B4ox1P1LZ1DYnC1cV1abWd9n4f+vBdB6rZDYVmt04QPpnHhSjz/gtqYw3vWhdBKKQwnx3MBcXUik
ZjuUsDNwhL/iBQSNEe+GImgB7tG0sT8N8fGlRSCmwmc2lHi8lk9cFa8m64PPT9I0gpGxYH+B9tcg
HRaMbe8ROie0tbhJtkAHtci51O2x+T4zy+Ep95hnhOMvwVhhE3FOgd6eVTGos0I95po8IV9fbRlo
Obd9mv94Pdbv9uPDTJBkL3g5z2Unys4Ndc5d/z7kbE4j8mESPyMYs57h6M9oGOAH/A1+CSURBt8A
AAAAAAAA


--=-y6j+XylQ+uq52iOo9wNC--
