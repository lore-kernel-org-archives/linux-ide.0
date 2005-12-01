From: =?ISO-8859-1?Q?Jean-Fran=E7ois_Stenuit?= <jfs@keytradebank.com>
Subject: Re: totally random "VFS: Cannot open root device"
Date: Thu, 01 Dec 2005 10:42:48 +0100
Message-ID: <438EC598.8050803@keytradebank.com>
References: <438B6E05.8070009@eq.cz> <438D2C19.3030008@gmail.com> <438D6B73.2060902@keytradebank.com> <Pine.LNX.4.58.0511300827410.18317@shark.he.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms080206070300040501050205"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail91.messagelabs.com ([194.106.220.35]:29662 "HELO
	mail91.messagelabs.com") by vger.kernel.org with SMTP
	id S932121AbVLAJnA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Dec 2005 04:43:00 -0500
In-Reply-To: <Pine.LNX.4.58.0511300827410.18317@shark.he.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Linux-ide <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, "0602@eq.cz" <0602@eq.cz>

This is a cryptographically signed message in MIME format.

--------------ms080206070300040501050205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit


Hi Randy,

Booting with irqpoll does not help. I guess we'll need to dig a little 
further ;-)

Randy.Dunlap wrote:

>On Wed, 30 Nov 2005, [ISO-8859-2] Jean-François Stenuit wrote:
>  
>
>>Note that I experienced the same problem yesterday evening with a
>>2.6.15-rc3 on HP Proliant DL140, which has an ICH-5 based controller and
>>a Maxtor drive
>>    
>>
>I've seen this a few times.
>If you were using MSI interrupts, I would blame that,
>but you aren't AFAICT, so try booting with the "irqpoll" kernel
>boot option to see if the kernel can reroute the (seemingly)
>lost interrupts.  Maybe we can deduce something from that.
>If it works, please post the /proc/interrupts file.
>  
>
-- 
Jean-François "Jef" Stenuit
Network & Security manager
Keytrade Bank SA


--------------ms080206070300040501050205
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
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA1MTIwMTA5NDI0OFowIwYJ
KoZIhvcNAQkEMRYEFLcZ8UvABZOJeaLF3Xj/gueZGWGkMFIGCSqGSIb3DQEJDzFFMEMwCgYI
KoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqG
SIb3DQMCAgEoMHgGCSsGAQQBgjcQBDFrMGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRo
YXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBG
cmVlbWFpbCBJc3N1aW5nIENBAgMPeNMwegYLKoZIhvcNAQkQAgsxa6BpMGIxCzAJBgNVBAYT
AlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNU
aGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIDD3jTMA0GCSqGSIb3DQEBAQUA
BIIBAGd8RmA50qtz3ZED3tzXaGLgPdzq8brWl4DD/906OaS0ERwyYMQy3LZq1DxXonuiT+0R
sLctE0Enueg7ORMViANnYR3Fhxx8QdtaA9djQh1jyq4uEO3QRD5N9NG+0p8VtfPUcwh6wI23
FQQRZL86mUaG1tGw0AfoM22CGkLnHJDTSrgDgSn2Uqd7p6oLF+CZoHSye0sSEafc0GWwxjBk
Ev+HqQhXDMS8B7cbBeej1+UvhN59KyKEQD84dh0sF4oR33m9U2n1t6BeAHSzq6sxnwqoX0kg
QCv030xJtFHwvtMuj5POZ8xQ74u+UXIbqElCUv272OMjDnYumhlxrNEw6tQAAAAAAAA=
--------------ms080206070300040501050205--
