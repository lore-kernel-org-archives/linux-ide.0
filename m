From: =?UTF-8?B?VG9iaWFzIE3DvGxsZXI=?= <Tobias_Mueller@twam.info>
Subject: Re: 40-wire cable detected when directly connected
Date: Sat, 12 Jan 2008 14:40:18 +0100
Message-ID: <4788C342.2000308@twam.info>
References: <200801101824.04863.Tobias_Mueller@twam.info> <4786E82A.7010208@gmail.com> <47875755.4000109@twam.info> <47883378.9060507@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms060003030807080006050400"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ceres.twam.info ([84.16.224.131]:40646 "EHLO smtp.twam.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751760AbYALNkf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 12 Jan 2008 08:40:35 -0500
Received: from [192.168.23.51] (p5B2EE4A7.dip.t-dialin.net [91.46.228.167])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.twam.info (Postfix) with ESMTP id 0330A2089C
	for <linux-ide@vger.kernel.org>; Sat, 12 Jan 2008 14:40:38 +0100 (CET)
In-Reply-To: <47883378.9060507@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms060003030807080006050400
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

> Please apply the attached patch and specify libata.force_cbl=80 as
> kernel boot parameter.  If you load libata from initrd or after boot you
> need to pass 'force_cbl=80' as module parameter.  How you do it depends
> on your distro.

[   41.116289] ata7: forcing 80c
[   41.116356] ata7.00: ATA-4: SanDisk SDCFX4-8192, HDX 4.20, max UDMA/66
[   41.116420] ata7.00: 16007040 sectors, multi 0: LBA
[   41.116489] ata7.00: limited to UDMA/33 due to 40-wire cable
[   41.117219] ata7.00: configured for UDMA/33

Speed is still the same and hdparm -I /dev/sdc sill says

[...]
Capabilities:
         LBA, IORDY(may be)(cannot be disabled)
         Standby timer values: spec'd by Vendor
         R/W multiple sector transfer: Max = 4   Current = 0
         DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4
              Cycle time: min=120ns recommended=120ns
         PIO: pio0 pio1 pio2 pio3 pio4
              Cycle time: no flow control=120ns  IORDY flow control=120ns
[...]

Regards
   Tobias

--------------ms060003030807080006050400
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJmzCC
AygwggKRoAMCAQICEDdfXmLiPCut3WRIWKcEfrgwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UE
BhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMT
I1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA3MTIxMTE0NDIyNVoX
DTA4MTIxMDE0NDIyNVowgYcxEDAOBgNVBAQTB011ZWxsZXIxIDAeBgNVBCoTF1RvYmlhcyBX
b2xmZ2FuZyBBbmRyZWFzMSgwJgYDVQQDEx9Ub2JpYXMgV29sZmdhbmcgQW5kcmVhcyBNdWVs
bGVyMScwJQYJKoZIhvcNAQkBFhhUb2JpYXNfTXVlbGxlckB0d2FtLmluZm8wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQC3vN/xQv+Nqk74OxgDpqJHwYGdwWOemIfl/W1sOlIE
FXzO9IDR57fa4FlqIUFrezqlolzipm1ZJAfxVhO4pdSjtwNj/4Z6ap5c3LbTjZYwL2abiFPi
qQPrwyIzYYKTyRpWetnTs0BVohEHMR38/sA3LMI4VQQEBYAd/XnPQPOLObLqbUggI1JZwmgO
zLEI1GSUEI2fUVyMeKIyXqX293cgw/5zQuoyZ87PQX80LsBkRx7JOnyUZ94+togZU/NtHso4
u+GcxVK8II/BN5wXYCoIQvNxsR0jc1AGJ7Y2xnjACjUVFeK/n1gZYTa4ZPPm3F/4XyGbd88U
3Qd2cBgP4cF5AgMBAAGjNTAzMCMGA1UdEQQcMBqBGFRvYmlhc19NdWVsbGVyQHR3YW0uaW5m
bzAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBQUAA4GBACk9SGx4seRUhysubF04VghMmHFt
ap3+um/34i+t7rAFxAjA3Fj1NRxyTDuy3TT6M0yO4Toak4778ssDJP8fWIY71DvP5VYhHUJw
F+nCPacU2HRORLTXf61GhqzQzrvujj/yj3Z6z6c2OLc90CaDaoVjTb3nf9F6+1L7ID5ecozo
MIIDKDCCApGgAwIBAgIQN19eYuI8K63dZEhYpwR+uDANBgkqhkiG9w0BAQUFADBiMQswCQYD
VQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UE
AxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDcxMjExMTQ0MjI1
WhcNMDgxMjEwMTQ0MjI1WjCBhzEQMA4GA1UEBBMHTXVlbGxlcjEgMB4GA1UEKhMXVG9iaWFz
IFdvbGZnYW5nIEFuZHJlYXMxKDAmBgNVBAMTH1RvYmlhcyBXb2xmZ2FuZyBBbmRyZWFzIE11
ZWxsZXIxJzAlBgkqhkiG9w0BCQEWGFRvYmlhc19NdWVsbGVyQHR3YW0uaW5mbzCCASIwDQYJ
KoZIhvcNAQEBBQADggEPADCCAQoCggEBALe83/FC/42qTvg7GAOmokfBgZ3BY56Yh+X9bWw6
UgQVfM70gNHnt9rgWWohQWt7OqWiXOKmbVkkB/FWE7il1KO3A2P/hnpqnlzcttONljAvZpuI
U+KpA+vDIjNhgpPJGlZ62dOzQFWiEQcxHfz+wDcswjhVBAQFgB39ec9A84s5suptSCAjUlnC
aA7MsQjUZJQQjZ9RXIx4ojJepfb3dyDD/nNC6jJnzs9BfzQuwGRHHsk6fJRn3j62iBlT820e
yji74ZzFUrwgj8E3nBdgKghC83GxHSNzUAYntjbGeMAKNRUV4r+fWBlhNrhk8+bcX/hfIZt3
zxTdB3ZwGA/hwXkCAwEAAaM1MDMwIwYDVR0RBBwwGoEYVG9iaWFzX011ZWxsZXJAdHdhbS5p
bmZvMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEAKT1IbHix5FSHKy5sXThWCEyY
cW1qnf66b/fiL63usAXECMDcWPU1HHJMO7LdNPozTI7hOhqTjvvyywMk/x9YhjvUO8/lViEd
QnAX6cI9pxTYdE5EtNd/rUaGrNDOu+6OP/KPdnrPpzY4tz3QJoNqhWNNved/0Xr7UvsgPl5y
jOgwggM/MIICqKADAgECAgENMA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMG
A1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0
ZSBDb25zdWx0aW5nMSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9u
MSQwIgYDVQQDExtUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEW
HHBlcnNvbmFsLWZyZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2
MjM1OTU5WjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0
eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0Ew
gZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAMSmPFVzVftOucqZWh5owHUEcJ3f6f+jHuy9
zfVb8hp2vX8MOmHyv1HOAdTlUAow1wJjWiyJFXCO3cnwK4Vaqj9xVsuvPAsH5/EfkTYkKhPP
K9Xzgnc9A74r/rsYPge/QIACZNenprufZdHFKlSFD0gEf6e20TxhBEAeZBlyYLf7AgMBAAGj
gZQwgZEwEgYDVR0TAQH/BAgwBgEB/wIBADBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3Js
LnRoYXd0ZS5jb20vVGhhd3RlUGVyc29uYWxGcmVlbWFpbENBLmNybDALBgNVHQ8EBAMCAQYw
KQYDVR0RBCIwIKQeMBwxGjAYBgNVBAMTEVByaXZhdGVMYWJlbDItMTM4MA0GCSqGSIb3DQEB
BQUAA4GBAEiM0VCD6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0whuPg2H6otnzYvwPQcUCCTcDz9
reFhYsPZOhl+hLGZGwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBPZV+V2vf3h9bGCE6u9uo0
5RAaWzVNd+NWIXiC3CEZNd4ksdMdRv9dX2VPMYIDZDCCA2ACAQEwdjBiMQswCQYDVQQGEwJa
QTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhh
d3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEDdfXmLiPCut3WRIWKcEfrgwCQYF
Kw4DAhoFAKCCAcMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcN
MDgwMTEyMTM0MDE4WjAjBgkqhkiG9w0BCQQxFgQU6FQWtZlDxO4C5FcK76ZK8JmTJYQwUgYJ
KoZIhvcNAQkPMUUwQzAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwgYUGCSsGAQQBgjcQBDF4MHYwYjELMAkGA1UE
BhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMT
I1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA3X15i4jwrrd1kSFinBH64
MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBD
b25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFp
bCBJc3N1aW5nIENBAhA3X15i4jwrrd1kSFinBH64MA0GCSqGSIb3DQEBAQUABIIBAJgW0BxP
DFaz16a4XuxjXYscMQisvd90ZCCP+N/3YnZWMpy0MIg4uTaKNQaHJRvJQwqKi8FP798p1Hig
KEFd/Nrxbw05aVbfVwlJTBqtbXBhqrZsSmEvh2a6PFZJd3wcW2czDCYy49sd9H4dD0gyoE1V
N4v885d1YeVLLerwllZsBmVGM8TWbAd0dVM1i76tE9F0E0aFTXCI3yuTScp2ILpB7YCLYZvU
LsOEAOYsq3bYBAIiNV1lRTaZnU0BWS/+ttqFgrjO53Y8eQgtMVnMdVkqHwrOILu/tRpy0mpf
KMHMhEQNPO/zH0AdVJJmqxQlOvHNK2qByI6vkdOWr9pMuMcAAAAAAAA=
--------------ms060003030807080006050400--
