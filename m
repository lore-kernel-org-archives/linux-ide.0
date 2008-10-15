From: Damazy <damazy@gmail.com>
Subject: Re: sata_sil for 3512A chip on kernel 2.6.26.3
Date: Wed, 15 Oct 2008 09:03:38 +0200
Message-ID: <48F595CA.5000807@gmail.com>
References: <48E48BF2.1010403@gmail.com> <48E71DBC.5090301@kernel.org> <48F47924.9040504@gmail.com> <48F54E4C.1020704@kernel.org> <48F58FBE.909@gmail.com> <48F591CC.6090609@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms080008060607020100010905"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:58382 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbYJOHDX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Oct 2008 03:03:23 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2529700fkq.5
        for <linux-ide@vger.kernel.org>; Wed, 15 Oct 2008 00:03:21 -0700 (PDT)
In-Reply-To: <48F591CC.6090609@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms080008060607020100010905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tejun Heo wrote:
> Damazy wrote:
>> Error 190 occurred at disk power-on lifetime: 0 hours (0 days + 0 hours)
>>   When the command that caused the error occurred, the device was active
>> or idle.
> 
> The time record seems screwed.
> 
>>   After command completion occurred, registers were:
>>   ER ST SC SN CL CH DH
>>   -- -- -- -- -- -- --
>>   84 51 3f 00 ee 1d e0  Error: ICRC, ABRT 63 sectors at LBA = 0x001dee00
>> = 1961472
> 
> But the recorded error is consistent with the kernel messages.  It
> looks like you're suffering serious transmission problem over the SATA
> cable.  Those transmission errors appear as timeouts or when the drive
> detects it ABRTs w/ ICRC.  Please check cable, power and try to
> connect the drive to other ports.
> 
> Thanks.
> 

I'v already try several cable and external power supply, but with the 
same result.
This sata chip have only two sata port. If I connect to other one, 
errors still appear.
I don't know what can I do else.
The only thing works fine is when I copy something from disk connected 
to my Intel 82801DB (ICH4).

TIA

--------------ms080008060607020100010905
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIILyzCC
Ao0wggF1oAMCAQICAwEAITANBgkqhkiG9w0BAQUFADA+MQswCQYDVQQGEwJQTDEbMBkGA1UE
ChMSVW5pemV0byBTcC4geiBvLm8uMRIwEAYDVQQDEwlDZXJ0dW0gQ0EwHhcNMDIwNzEyMTYz
MTUzWhcNMTIwNzEyMTYzMTUzWjBDMQswCQYDVQQGEwJQTDEbMBkGA1UEChMSVW5pemV0byBT
cC4geiBvLm8uMRcwFQYDVQQDEw5DZXJ0dW0gTGV2ZWwgSTCBnzANBgkqhkiG9w0BAQEFAAOB
jQAwgYkCgYEApe96WfQxXJ+0MtKgWSvkqNfHGr+3a1KyfEomDpQw1bJLfNfniHC/+BXpU0ho
7gDr2HZpvhxmBvffETwdImfgJOu71xSed+70VjnLumjIzbgMLvATnXOXkoAdGPF+PtyzmH7o
LWmWvJqxEPB4rdMixPVAXFPSfuD5pFRnnJmfI2UCAwEAAaMTMBEwDwYDVR0TAQH/BAUwAwEB
/zANBgkqhkiG9w0BAQUFAAOCAQEAJQ0uGk5oCtGIJlL7f98zextv2a7QQQrTjZVLwuvXO05i
yVifONstgB+68jV15HLJ+qdGQU60ydrQNsv49j1yXl6wpCv6gCSKTNJeLtDE+3p2OWpGrHbh
6djVzD/bw5YDMu3pVNrN55Dk+/YH4eV7bQvuQ/8eCQzYtQzAAPYZNegyuM1pg1X45Ij/xt3x
J3bSYDQ0LMqp2kNxN25Y7939SiU42VL7QNjJejD9oRUYYGT7MboVvEF4nUGDYrmtYe11FIj4
hESwy1mZn2OncRqx140k8d7IRzWkDNKpA7PYEulCvLliTdm39mAZ7xps8tCEL8ecAwh+4fAH
WgQ+g4CBtTCCBJkwggQCoAMCAQICAwRFUjANBgkqhkiG9w0BAQUFADBDMQswCQYDVQQGEwJQ
TDEbMBkGA1UEChMSVW5pemV0byBTcC4geiBvLm8uMRcwFQYDVQQDEw5DZXJ0dW0gTGV2ZWwg
STAeFw0wODA3MzEyMDA2MDdaFw0wODEwMjkyMDA2MDdaMG4xCzAJBgNVBAYTAlBMMRwwGgYD
VQQKExNQcml2YXRlIENlcnRpZmljYXRlMSAwHgYDVQQDExdNYXRldXN6IERhbWF6eSBIb3Jv
d3NraTEfMB0GCSqGSIb3DQEJARYQZGFtYXp5QGdtYWlsLmNvbTCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBAPZvBpH21zlkJtf5zQjscR4xIxTzijGozZxGKvTkEBvX3MQSarVg
E9kFB3xxhrzjJSFlALL06Keett8Kk8yCD/zw9dLgA06st7gizjPPF6Q92rKCbiC6SIq7DXa6
G95qL5Z5kta5vpkuOkWVL8Ao9YvNUG/OSQkd6RvOPv16DS0ltrqRq3AAWi6hG66cIUhCXwpq
3dONWdmXUd+rlxhmTcA3ZR6bnhffdaWSnnXntEsEHIkBOxBt/KUSVXckmmpCjKyPS+j0d80/
JDz83+YJiagZ2VcfWpub23+MVYUXHUKhOwf8RREELgwbnWm6rwmGfUjnnyezsMaL84PmQg9J
nX8CAwEAAaOCAeowggHmMBsGA1UdEQQUMBKBEGRhbWF6eUBnbWFpbC5jb20wCQYDVR0TBAIw
ADALBgNVHQ8EBAMCBPAwEQYJYIZIAYb4QgEBBAQDAgWgMDAGA1UdHwQpMCcwJaAjoCGGH2h0
dHA6Ly9jcmwuY2VydHVtLnBsL2NsYXNzMS5jcmwwMQYIKwYBBQUHAQEEJTAjMCEGCCsGAQUF
BzABhhVodHRwOi8vb2NzcC5jZXJ0dW0ucGwwggE1BgNVHSAEggEsMIIBKDCCASQGCiqEaAGG
9ncCAgEwggEUMCQGCCsGAQUFBwIBFhhodHRwOi8vd3d3LmNlcnR1bS5wbC9DUFMwgesGCCsG
AQUFBwICMIHeMBkWElVuaXpldG8gU3AuIHogby5vLjADAgEBGoHAVXNhZ2Ugb2YgdGhpcyBj
ZXJ0aWZpY2F0ZSBpcyBzdHJpY3RseSBzdWJqZWN0ZWQgdG8gdGhlIENFUlRVTSBDZXJ0aWZp
Y2F0aW9uClByYWN0aWNlIFN0YXRlbWVudCAoQ1BTKSBpbmNvcnBvcmF0ZWQgYnkgcmVmZXJl
bmNlIGhlcmVpbiBhbmQgaW4gdGhlIHJlcG9zaXRvcnkKYXQgaHR0cHM6Ly93d3cuY2VydHVt
LnBsL3JlcG9zaXRvcnkuMA0GCSqGSIb3DQEBBQUAA4GBAI05m1hYt5fBfrjl9meJXJJMmyjl
LtneiRX/C3yrIprGacR24MXVULxQf3YnGRi5dQ4bV9/DdV2R1Kac3Xwk3OOMydSxmwdC0RrS
8VN8+9n9/vdHWtiZATgFMWlOZAvLvezCXHfwfk9jtAYJJewQu6sJn7fN1CBlQ9Eo28wOczRM
MIIEmTCCBAKgAwIBAgIDBEVSMA0GCSqGSIb3DQEBBQUAMEMxCzAJBgNVBAYTAlBMMRswGQYD
VQQKExJVbml6ZXRvIFNwLiB6IG8uby4xFzAVBgNVBAMTDkNlcnR1bSBMZXZlbCBJMB4XDTA4
MDczMTIwMDYwN1oXDTA4MTAyOTIwMDYwN1owbjELMAkGA1UEBhMCUEwxHDAaBgNVBAoTE1By
aXZhdGUgQ2VydGlmaWNhdGUxIDAeBgNVBAMTF01hdGV1c3ogRGFtYXp5IEhvcm93c2tpMR8w
HQYJKoZIhvcNAQkBFhBkYW1henlAZ21haWwuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
MIIBCgKCAQEA9m8GkfbXOWQm1/nNCOxxHjEjFPOKMajNnEYq9OQQG9fcxBJqtWAT2QUHfHGG
vOMlIWUAsvTop5623wqTzIIP/PD10uADTqy3uCLOM88XpD3asoJuILpIirsNdrob3movlnmS
1rm+mS46RZUvwCj1i81Qb85JCR3pG84+/XoNLSW2upGrcABaLqEbrpwhSEJfCmrd041Z2ZdR
36uXGGZNwDdlHpueF991pZKedee0SwQciQE7EG38pRJVdySaakKMrI9L6PR3zT8kPPzf5gmJ
qBnZVx9am5vbf4xVhRcdQqE7B/xFEQQuDBudabqvCYZ9SOefJ7Owxovzg+ZCD0mdfwIDAQAB
o4IB6jCCAeYwGwYDVR0RBBQwEoEQZGFtYXp5QGdtYWlsLmNvbTAJBgNVHRMEAjAAMAsGA1Ud
DwQEAwIE8DARBglghkgBhvhCAQEEBAMCBaAwMAYDVR0fBCkwJzAloCOgIYYfaHR0cDovL2Ny
bC5jZXJ0dW0ucGwvY2xhc3MxLmNybDAxBggrBgEFBQcBAQQlMCMwIQYIKwYBBQUHMAGGFWh0
dHA6Ly9vY3NwLmNlcnR1bS5wbDCCATUGA1UdIASCASwwggEoMIIBJAYKKoRoAYb2dwICATCC
ARQwJAYIKwYBBQUHAgEWGGh0dHA6Ly93d3cuY2VydHVtLnBsL0NQUzCB6wYIKwYBBQUHAgIw
gd4wGRYSVW5pemV0byBTcC4geiBvLm8uMAMCAQEagcBVc2FnZSBvZiB0aGlzIGNlcnRpZmlj
YXRlIGlzIHN0cmljdGx5IHN1YmplY3RlZCB0byB0aGUgQ0VSVFVNIENlcnRpZmljYXRpb24K
UHJhY3RpY2UgU3RhdGVtZW50IChDUFMpIGluY29ycG9yYXRlZCBieSByZWZlcmVuY2UgaGVy
ZWluIGFuZCBpbiB0aGUgcmVwb3NpdG9yeQphdCBodHRwczovL3d3dy5jZXJ0dW0ucGwvcmVw
b3NpdG9yeS4wDQYJKoZIhvcNAQEFBQADgYEAjTmbWFi3l8F+uOX2Z4lckkybKOUu2d6JFf8L
fKsimsZpxHbgxdVQvFB/dicZGLl1DhtX38N1XZHUppzdfCTc44zJ1LGbB0LRGtLxU3z72f3+
90da2JkBOAUxaU5kC8u97MJcd/B+T2O0Bgkl7BC7qwmft83UIGVD0SjbzA5zNEwxggLrMIIC
5wIBATBKMEMxCzAJBgNVBAYTAlBMMRswGQYDVQQKExJVbml6ZXRvIFNwLiB6IG8uby4xFzAV
BgNVBAMTDkNlcnR1bSBMZXZlbCBJAgMERVIwCQYFKw4DAhoFAKCCAXYwGAYJKoZIhvcNAQkD
MQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMDgxMDE1MDcwMzM4WjAjBgkqhkiG9w0B
CQQxFgQUWk9uOPo3wGZVUElth2xkQFVJgDMwWQYJKwYBBAGCNxAEMUwwSjBDMQswCQYDVQQG
EwJQTDEbMBkGA1UEChMSVW5pemV0byBTcC4geiBvLm8uMRcwFQYDVQQDEw5DZXJ0dW0gTGV2
ZWwgSQIDBEVSMFsGCyqGSIb3DQEJEAILMUygSjBDMQswCQYDVQQGEwJQTDEbMBkGA1UEChMS
VW5pemV0byBTcC4geiBvLm8uMRcwFQYDVQQDEw5DZXJ0dW0gTGV2ZWwgSQIDBEVSMF8GCSqG
SIb3DQEJDzFSMFAwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAN
BggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDANBgkqhkiG9w0BAQEFAASC
AQAEYy41YELbdFSqzrM0PBbVJXQZ195qcc6VJnr6VPaZGMOdYwowrdP7pnL77pBZRoYXG5s0
R+DVtnDq8UXJPYEf2vBdS4P5A+8Xmhw6KoV5j07rXuLDMiyQOPIxCDWHWXhxjAJr1T1Vs9Ug
PVggUtruY5RGq5kUBQzcwZ8Ztv6yK/DrwztyiLyWRQfKQwlfe97e3rPOGFtpG+1Krl7Y7aAF
JdAW6z/NJtn2NyivQDQiAFn59Y7ZQt92iGmgGNPtF9EeOBlLqOvUxYDyOeojedHaTTOqW1D2
G2kZoub/qRJWAGeZaeBiy1ku7wOq+hL3ubigfraJRAyf1iae5jByXq2AAAAAAAAA
--------------ms080008060607020100010905--
