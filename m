From: =?ISO-8859-1?Q?Jean-Fran=E7ois_Stenuit?= <jfs@keytradebank.com>
Subject: Re: [PATCH] ata_piix: ignore all zero PCS value on ICH5's
Date: Mon, 05 Dec 2005 11:07:25 +0100
Message-ID: <4394115D.2020603@keytradebank.com>
References: <438B6E05.8070009@eq.cz> <438D2C19.3030008@gmail.com> <438DA3FA.2010809@eq.cz> <a762e240511301405s433109b7n93e7fdcc7409bef5@mail.gmail.com> <438EC502.1090103@keytradebank.com> <20051201112015.GA10462@htj.dyndns.org> <438EF3B6.7020007@keytradebank.com> <438EFAA5.3070901@gmail.com> <438FA924.1090005@pobox.com> <438FB8B5.8070505@gmail.com> <20051202032605.GA15528@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms020607090700080601040305"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail114.messagelabs.com ([195.245.231.163]:8463 "HELO
	mail114.messagelabs.com") by vger.kernel.org with SMTP
	id S1750969AbVLEKHr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Dec 2005 05:07:47 -0500
In-Reply-To: <20051202032605.GA15528@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Keith Mannthey <kmannth@gmail.com>, "0602@eq.cz" <0602@eq.cz>, Linux-ide <linux-ide@vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms020607090700080601040305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi Tejun,

Back to work this morning. I applied this patch to 2.6.15-rc5 to test my 
problematic HP DL140G2.

Result of the tests :
Reboot 1 : successfull, patch code used
Reboot 2 : successfull, patch code not used
Reboot 3 : successfull, patch code used
Reboot 4 : successfull, patch code not used
Reboot 5 : successfull, patch code used
Cold boot 1 : successfull, patch code used
Cold boot 2 : successfull, patch code not used
Cold boot 3 : successfull, patch code not used
Cold boot 4 : successfull, patch code used
Cold boot 5 : successfull, patch code used

Seems the patch is working.

Tejun Heo wrote:

>Some ICH5's report 0 for PCS even when they have active working ports.
>This patch makes piix_sata_probe() ignore 0 PCS value on ICH5's and
>probe all ports in such cases.  And while at it, remove bogus
>assignment to mask.
>
>Signed-off-by: Tejun Heo <htejun@gmail.com>
>
>--
>
>Hi, Jean-Francois (sorry, cannot type that character) and 0602.
>
>Can you guys please verify that this patch works?  This patch is
>supposed to do the same thing as my previous patch with
>override_PCS=1.
>
>
>diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
>index 887b2b9..482995b 100644
>--- a/drivers/scsi/ata_piix.c
>+++ b/drivers/scsi/ata_piix.c
>@@ -58,6 +58,7 @@ enum {
> 	ICH5_PCS		= 0x92,	/* port control and status */
> 	PIIX_SCC		= 0x0A, /* sub-class code register */
> 
>+	PIIX_FLAG_UNRELIABLE_PCS= (1 << 27), /* PCS bits are unreliable */
> 	PIIX_FLAG_AHCI		= (1 << 28), /* AHCI possible */
> 	PIIX_FLAG_CHECKINTR	= (1 << 29), /* make sure PCI INTx enabled */
> 	PIIX_FLAG_COMBINED	= (1 << 30), /* combined mode possible */
>@@ -223,7 +224,8 @@ static struct ata_port_info piix_port_in
> 	{
> 		.sht		= &piix_sht,
> 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST |
>-				  PIIX_FLAG_COMBINED | PIIX_FLAG_CHECKINTR,
>+				  PIIX_FLAG_COMBINED | PIIX_FLAG_CHECKINTR |
>+				  PIIX_FLAG_UNRELIABLE_PCS,
> 		.pio_mask	= 0x1f,	/* pio0-4 */
> 		.mwdma_mask	= 0x07, /* mwdma0-2 */
> 		.udma_mask	= 0x7f,	/* udma0-6 */
>@@ -362,12 +364,15 @@ static int piix_sata_probe (struct ata_p
> 	int orig_mask, mask, i;
> 	u8 pcs;
> 
>-	mask = (PIIX_PORT_PRESENT << ap->hard_port_no) |
>-	       (PIIX_PORT_ENABLED << ap->hard_port_no);
>-
> 	pci_read_config_byte(pdev, ICH5_PCS, &pcs);
> 	orig_mask = (int) pcs & 0xff;
> 
>+	if (orig_mask == 0 && ap->flags & PIIX_FLAG_UNRELIABLE_PCS) {
>+		printk(KERN_INFO "ata%u: PIIX PCS reports 0x00, ignoring PCS\n",
>+		       ap->id);
>+		return 1;
>+	}
>+
> 	/* TODO: this is vaguely wrong for ICH6 combined mode,
> 	 * where only two of the four SATA ports are mapped
> 	 * onto a single ATA channel.  It is also vaguely inaccurate
>
>  
>


-- 
Jean-François "Jef" Stenuit
Network & Security manager
Keytrade Bank SA


--------------ms020607090700080601040305
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
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA1MTIwNTEwMDcyNVowIwYJ
KoZIhvcNAQkEMRYEFGJBIBChU+fwgp5ruWpsy8YiwzIlMFIGCSqGSIb3DQEJDzFFMEMwCgYI
KoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqG
SIb3DQMCAgEoMHgGCSsGAQQBgjcQBDFrMGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRo
YXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBG
cmVlbWFpbCBJc3N1aW5nIENBAgMPeNMwegYLKoZIhvcNAQkQAgsxa6BpMGIxCzAJBgNVBAYT
AlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNU
aGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIDD3jTMA0GCSqGSIb3DQEBAQUA
BIIBAEEorB1GXgNeUqkXMmMuCx9KSz8mKOPgrRVWpiba9uysKheU9dQVU8twYP2/Mj4Nn3M+
MT2IQTELa9wB6ulnj8QHjyGx+iUKt/gp1ZfHGMwHiVOLJi3WUlg7z7JcPjMt8XbwstzBJjIG
Aq0iJX84n1ocN0yl+HPnJUbse+a7pnUEyVHKpLGSWo245ZaT1hTNqK6XILfRV8XfqyDZk55x
D8tvNx3eirP94kVD0BEkyQk41sESDddKlpN7d6OngjveF6OvSmq7AFg+P9WYQA9fT7XaojIE
Dn+pfxaOrAzqS3lL71PGm3fSxhE8KVzbvOxmy8k0jxZJ6iDk+7Ht6Fg/29oAAAAAAAA=
--------------ms020607090700080601040305--
