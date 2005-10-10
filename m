From: Erik Slagter <erik@slagter.name>
Subject: Re: Dreaded PDC irq nobody cared
Date: Mon, 10 Oct 2005 12:31:18 +0200
Message-ID: <1128940278.4775.50.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0510081313300.28615-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-Wmp8mIR6MTnBOOGVMl1V"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wlz.nl ([194.53.3.6]:3718 "HELO mx1.wlz.nl")
	by vger.kernel.org with SMTP id S1750739AbVJJKcH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Oct 2005 06:32:07 -0400
In-Reply-To: <Pine.LNX.4.44.0510081313300.28615-100000@coffee.psychology.mcmaster.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: Linux IDE <linux-ide@vger.kernel.org>


--=-Wmp8mIR6MTnBOOGVMl1V
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-10-08 at 13:17 -0400, Mark Hahn wrote:
> > > >  - The difference between having or having not the stuck interrupt =
seems
> > > > to be the forced cooling of the attached harddisks; I find this als=
o
> ...
> >  - various people have this problem with various brands and models disk=
s
> >  - the temperature of the disks is ~40 C, without cooling, and also ~40
> > C with cooling (?!) according to smartctl attribute 195, so either the
> > temperature sensors are wrong (silly location?) or it really doesn't
> > matter?!
> >  - I cannot pinpoint the problem to one harddisk, and probably never
> > will, because the problem only occurs with > 1 harddisk
> > connected :-( (as the other people experience)
> >  - the temperature in the case is not very cool but also not extremely
> > hot, imho it shouldn't bother the harddisks.
>=20
> you added ventilation to your case, and the problem went away.
> this doesn't mean the problem was disk temperature, especially
> since your disks report no real change.  instead, I suggest that=20
> your PSU was too hot and regulating poorly.  greater airflow=20
> resulted in better regulation, and made the disks happier.
> (note another recent message here regarding a similar problem machine
> which was fixed by providing better power...)

This may very well at least have something to do with the problem. I
must say that the air coming from the PSU is rather warm. Anyway, new
PSU is underway (high-tech/high quality, replacing existing no-name
PSU).

--=-Wmp8mIR6MTnBOOGVMl1V
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
MBwGCSqGSIb3DQEJBTEPFw0wNTEwMTAxMDMxMThaMCMGCSqGSIb3DQEJBDEWBBRK6NU/ltcdRXMf
H2buckPNdD3HbzANBgkqhkiG9w0BAQEFAASCAQABPstFERV6fCtF4G7VVTwF4/iUQW8lIJzlE/qs
EtAli2u3zTgD8r9a/4jZwJunWxf8LA2nQCYLvYm99LIqL2NfS+vytWtCNE6JBD6VeenN0CoIdod8
WR4yOuNJHy7ZqrWRC3MiFJ1w1Tc2ENaJOl686XBCafHPWUSWj8zXN570EJfrmxJn4bEPnsnE6ks4
84Akxsx8qWLZGT+l3jlIx0ojbnwCu++Fv/oVQj/aT8bZbJ7NfpskioiTxhcW9P7PMmmotyxxSQw6
AZFKPhACEDJcZQaUkhgnVhBhNgi2tU7Li14cVmuKNEmxGf5VofIA/uRKHsa0BmLgnnzJ7ou0qWgx
AAAAAAAA


--=-Wmp8mIR6MTnBOOGVMl1V--
