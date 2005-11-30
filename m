From: =?ISO-8859-2?Q?Jean-Fran=E7ois_Stenuit?= <jfs@keytradebank.com>
Subject: Re: totally random "VFS: Cannot open root device"
Date: Wed, 30 Nov 2005 10:05:55 +0100
Message-ID: <438D6B73.2060902@keytradebank.com>
References: <438B6E05.8070009@eq.cz> <438D2C19.3030008@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms010007040900030102060401"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail123.messagelabs.com ([85.158.136.3]:33378 "HELO
	mail123.messagelabs.com") by vger.kernel.org with SMTP
	id S1751154AbVK3JGP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Nov 2005 04:06:15 -0500
In-Reply-To: <438D2C19.3030008@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux-ide <linux-ide@vger.kernel.org>
Cc: Tejun Heo <htejun@gmail.com>, "0602@eq.cz" <0602@eq.cz>

This is a cryptographically signed message in MIME format.

--------------ms010007040900030102060401
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit


Note that I experienced the same problem yesterday evening with a 
2.6.15-rc3 on HP Proliant DL140, which has an ICH-5 based controller and 
a Maxtor drive

Successfull boot shows :
...
libata version 1.12 loaded.
ata_piix version 1.04
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x1470 irq 14
ata1: dev 0 cfg 49:2f00 82:7869 83:7d09 84:4633 85:7869 86:3c01 87:4623 
88:203f
ata1: dev 0 ATA, max UDMA/100, 156301488 sectors: lba48
ata1: dev 0 configured for UDMA/100
scsi0 : ata_piix
  Vendor: ATA       Model: Maxtor 6L080M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x1478 irq 15
ata2: SATA port has no device.
scsi1 : ata_piix
st: Version 20050830, fixed bufsize 32768, s/g segs 256
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
...

A failed boot shows "ata1: SATA port has no device". I'll try to set-up 
a serial console to log the boot messages.

This behaviour can be reproduced on four different DL140's, so it's 
fairly safe to say it's not a cabling/hardware problem.

Tejun Heo wrote:

> 0602@eq.cz wrote:
>
>> Hi!
>>
>> (Please CC me your answers as I am not subscribed.)
>>
>> I have a problem with 2.6.14.3 kernel (but this probably isn't too 
>> version-specific). I have a kernel which succesfully boots on totally 
>> random basis (cca 70% is success). My root partition resides on a 
>> SATA disc connected to a controller on Intel 6300ESB ICH southbridge 
>> (mb Intel se7320vp2). There is a reiserfs 3 filesystem on my root 
>> partition. Without any changes to configuration (os or bios or 
>> whatever) I sometimes get:
>>
>> VFS: Cannot open root device "801" or unknown block(8,1)
>>
>> Could this be some timeout issue, or indication of crappy hw? I've 
>> tried this about 10 times (immediately ctrl+alt+del on successfull 
>> boot or reset button on aforementioned panic) and I saw no 
>> regularities in this misbehaviour.
>>
>> I sincerely appreciate any advice anyone can give.
>>
>
> [CC'ing linux-ide]
>
> Hello, 0602.  :-)
>
> Can you please post dmesg of a successful booting?  That will tell us 
> which SATA controller/disks you are using.  Also, the boot log of a 
> failed boot will be very helpful - the best way to get this is via 
> serial console.  If you don't have access to serial console, taking 
> note   / picture of the part where SATA detection fails will do too.
>
> Also, when the machine boots successfully, does it work without 
> generating disk related kernel logs?  Just perform any IO-heavy 
> operations - cp'ing directories which contain large files, 
> tar/untarring... - and see if the kernel complains about anyting.
>


-- 
Jean-François "Jef" Stenuit
Network & Security manager
Keytrade Bank SA


--------------ms010007040900030102060401
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
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA1MTEzMDA5MDU1NlowIwYJ
KoZIhvcNAQkEMRYEFL5Km/pf2sJLlyq64s8oCCyT89XDMFIGCSqGSIb3DQEJDzFFMEMwCgYI
KoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqG
SIb3DQMCAgEoMHgGCSsGAQQBgjcQBDFrMGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRo
YXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBG
cmVlbWFpbCBJc3N1aW5nIENBAgMPeNMwegYLKoZIhvcNAQkQAgsxa6BpMGIxCzAJBgNVBAYT
AlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNU
aGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIDD3jTMA0GCSqGSIb3DQEBAQUA
BIIBAIix1UWzzOBqxDgFE0EXI5BfZ32qY1CppLAOra7f/CZ9RiqIgRr1h5m/QoMzJSdnYjtl
eyOjP2PyoI01aEYfqC1PoKgL39yztjkQKlWA0dBoMBfDj28aksI43RD1y4n8aO/fwqj9B1TO
0McxsRrszBem0eQomxUCShtgGXHyDrdXEmckLYbrquel+T+HpwNoKOOS3pZnWFs42h29a1Tq
hrOtNHnB41C/TeIhRbWzjuOCPzG+KGzTBMl8yoE346GsCoL+FmAGIIcGDGN221rZdnuDGBH5
KGBDPAdopb7poM4tYqModwJRUCDtJpzANc4AWsZSG8VKMhhWMfrlO0A4d00AAAAAAAA=
--------------ms010007040900030102060401--
