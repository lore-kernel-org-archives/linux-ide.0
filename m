From: =?ISO-8859-1?Q?Jean-Fran=E7ois_Stenuit?= <jfs@keytradebank.com>
Subject: Re: totally random "VFS: Cannot open root device"
Date: Thu, 01 Dec 2005 10:40:18 +0100
Message-ID: <438EC502.1090103@keytradebank.com>
References: <438B6E05.8070009@eq.cz> <438D2C19.3030008@gmail.com>	 <438DA3FA.2010809@eq.cz> <a762e240511301405s433109b7n93e7fdcc7409bef5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms050404060906010904050401"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail92.messagelabs.com ([194.106.220.51]:64488 "HELO
	mail92.messagelabs.com") by vger.kernel.org with SMTP
	id S932119AbVLAJki (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Dec 2005 04:40:38 -0500
In-Reply-To: <a762e240511301405s433109b7n93e7fdcc7409bef5@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Keith Mannthey <kmannth@gmail.com>
Cc: "0602@eq.cz" <0602@eq.cz>, Tejun Heo <htejun@gmail.com>, Linux-ide <linux-ide@vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms050404060906010904050401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit


Hi Keith,

I have been able to reproduce the bug (randomly - needing a few reboots 
to make it happen) on a 2.6.15-rc3 kernel.

System is an HP DL140G2 with following SATA controller (from lspci -vv) :

0000:00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 
Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Hewlett-Packard Company: Unknown device 3208
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at 1470 [size=16]

Keith Mannthey wrote:

>On 11/30/05, 0602@eq.cz <0602@eq.cz> wrote:
>
>Best guess is driver initilization troubles. The screen shot only
>dosen't really show anything besides it is broken. A full boot log
>from the failed boot would be nice.  There were some recent SATA
>change could you try the current 2.6.15-rc3 as well?
>
>Thanks,
> Keith
>
-- 
Jean-François "Jef" Stenuit
Network & Security manager
Keytrade Bank SA


--------------ms050404060906010904050401
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIII9TCC
AtUwggI+oAMCAQICAw940zANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UE
ChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNv
bmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDUwOTEzMTU0NDM0WhcNMDYwOTEzMTU0NDM0
WjBGMR8wHQYDVQQDExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMSMwIQYJKoZIhvcNAQkBFhRq
ZnNAa2V5dHJhZGViYW5rLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJvF
EsxKTbVcg2evoxzm3Gs2PErR2jLXLyAosTiTvopWw3HZAKTD+3rVBQKZA4ykdbC4Spk7ca05
2ENgt3naP/6bJ8gWCrgd9AQ0CRRDNuyE1A0YWjM4G8SYaKNXC+yjhrhaobmKcBQhtysQxHMo
s0+SDVbNAOdYjK7rdjN+WGZQpbjJ3E8LtP4Vqv4YoA5LpyumVGq1aCcRNvHC0EbNfGi9p6R6
sIjMglPH0ZAa9YGcX9U6qz/je8ImvL/k9B7Hys8YAN8uLDol9qMKXkys7Nc2UA/V6Qy3/vME
PkQ6mnx8m30a1IAHK8zxvpRSpY/SmdSGIk3PGrOwXnCazsAKyX8CAwEAAaMxMC8wHwYDVR0R
BBgwFoEUamZzQGtleXRyYWRlYmFuay5jb20wDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQQF
AAOBgQC0RNI63E0hHdNOy1ffX2Vg+qddH4vJDdtKHcYbI6B3/C8OJTCQLWRRZpOPwVQqNpVL
8OzsDYTX1ARzlzMA9H0grN5AD3hLZxSsNJj0X47SpEq8OyVPlACaKa1YAulRg5QL57gCDSGf
9xPO1nrA9sdlRG0fZLSauFLf4IOdnF7hJzCCAtUwggI+oAMCAQICAw940zANBgkqhkiG9w0B
AQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkg
THRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcN
MDUwOTEzMTU0NDM0WhcNMDYwOTEzMTU0NDM0WjBGMR8wHQYDVQQDExZUaGF3dGUgRnJlZW1h
aWwgTWVtYmVyMSMwIQYJKoZIhvcNAQkBFhRqZnNAa2V5dHJhZGViYW5rLmNvbTCCASIwDQYJ
KoZIhvcNAQEBBQADggEPADCCAQoCggEBAJvFEsxKTbVcg2evoxzm3Gs2PErR2jLXLyAosTiT
vopWw3HZAKTD+3rVBQKZA4ykdbC4Spk7ca052ENgt3naP/6bJ8gWCrgd9AQ0CRRDNuyE1A0Y
WjM4G8SYaKNXC+yjhrhaobmKcBQhtysQxHMos0+SDVbNAOdYjK7rdjN+WGZQpbjJ3E8LtP4V
qv4YoA5LpyumVGq1aCcRNvHC0EbNfGi9p6R6sIjMglPH0ZAa9YGcX9U6qz/je8ImvL/k9B7H
ys8YAN8uLDol9qMKXkys7Nc2UA/V6Qy3/vMEPkQ6mnx8m30a1IAHK8zxvpRSpY/SmdSGIk3P
GrOwXnCazsAKyX8CAwEAAaMxMC8wHwYDVR0RBBgwFoEUamZzQGtleXRyYWRlYmFuay5jb20w
DAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQQFAAOBgQC0RNI63E0hHdNOy1ffX2Vg+qddH4vJ
DdtKHcYbI6B3/C8OJTCQLWRRZpOPwVQqNpVL8OzsDYTX1ARzlzMA9H0grN5AD3hLZxSsNJj0
X47SpEq8OyVPlACaKa1YAulRg5QL57gCDSGf9xPO1nrA9sdlRG0fZLSauFLf4IOdnF7hJzCC
Az8wggKooAMCAQICAQ0wDQYJKoZIhvcNAQEFBQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQI
EwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEaMBgGA1UEChMRVGhhd3RlIENv
bnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2VydmljZXMgRGl2aXNpb24xJDAi
BgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTErMCkGCSqGSIb3DQEJARYccGVy
c29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAwMDBaFw0xMzA3MTYyMzU5
NTlaMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBM
dGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTCBnzAN
BgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAxKY8VXNV+065yplaHmjAdQRwnd/p/6Me7L3N9Vvy
Gna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FWy688Cwfn8R+RNiQqE88r1fOC
dz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEAAaOBlDCB
kTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwudGhh
d3RlLmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3JsMAsGA1UdDwQEAwIBBjApBgNV
HREEIjAgpB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgwDQYJKoZIhvcNAQEFBQAD
gYEASIzRUIPqCy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A9BxQIJNwPP2t4WFi
w9k6GX6EsZkbAMUaC4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYITq726jTlEBpb
NU1341YheILcIRk13iSx0x1G/11fZU8xggM7MIIDNwIBATBpMGIxCzAJBgNVBAYTAlpBMSUw
IwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUg
UGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIDD3jTMAkGBSsOAwIaBQCgggGnMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA1MTIwMTA5NDAxOVowIwYJ
KoZIhvcNAQkEMRYEFNFPtt3wMehSFP912E2zcJLWLneBMFIGCSqGSIb3DQEJDzFFMEMwCgYI
KoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqG
SIb3DQMCAgEoMHgGCSsGAQQBgjcQBDFrMGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRo
YXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBG
cmVlbWFpbCBJc3N1aW5nIENBAgMPeNMwegYLKoZIhvcNAQkQAgsxa6BpMGIxCzAJBgNVBAYT
AlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNU
aGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIDD3jTMA0GCSqGSIb3DQEBAQUA
BIIBABeeThhYFLhMAGzFCejaiGwHhsGdaoh2Glu2QJPD/suXp5Dwi/9DUHQv3ogBl2y+zC9O
OU5JurywWNG+QCUCsQw1VtoluocSn8OkPQWO1SD9lW1/5JuiV6E1c4zwgIkAT9OKSLp0tMwR
WXSrCpfVTgfTEyBUx7GZHCkShhdcfgwm1Cb0BREsb3ZQ2OzXGKjx6QXVdwFI3K8hkpvERIOt
xZIW+LhxAjRzFolA4/cwhn69BQK+z3eppQIH5C2EoFvA1vXmy1CDPdeFmanBz233ZwyW4fAl
TAq2RAcc0eGOb1eJLkgra2di4XBDgD4hIrMKQPSzCtKXNXKGX30wx49Rc5MAAAAAAAA=
--------------ms050404060906010904050401--
