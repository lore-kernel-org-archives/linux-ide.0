From: =?ISO-8859-1?Q?Jean-Fran=E7ois_Stenuit?= <jfs@keytradebank.com>
Subject: Re: totally random "VFS: Cannot open root device"
Date: Thu, 01 Dec 2005 13:59:34 +0100
Message-ID: <438EF3B6.7020007@keytradebank.com>
References: <438B6E05.8070009@eq.cz> <438D2C19.3030008@gmail.com> <438DA3FA.2010809@eq.cz> <a762e240511301405s433109b7n93e7fdcc7409bef5@mail.gmail.com> <438EC502.1090103@keytradebank.com> <20051201112015.GA10462@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms080403000103030004030009"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail91.messagelabs.com ([194.106.220.35]:12210 "HELO
	mail91.messagelabs.com") by vger.kernel.org with SMTP
	id S932214AbVLAM7u (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Dec 2005 07:59:50 -0500
In-Reply-To: <20051201112015.GA10462@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Keith Mannthey <kmannth@gmail.com>, "0602@eq.cz" <0602@eq.cz>, Linux-ide <linux-ide@vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms080403000103030004030009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi Tejun,

Thanks for taking the time to check.

Output of your trace with ata_piix.override_PCS=0
  1st boot : success : combined=0 orig_mask=0x11
  2nd boot : success : combined=0 orig_mask=0x11
  3rd boot : failure : combined=0 orig_mask=0x0
  4th boot : failure : combined=0 orig_mask=0x0
  5th boot : failure : combined=0 orig_mask=0x0
  6th boot : failure : combined=0 orig_mask=0x0
  7th boot : success : combined=0 orig_mask=0x11
Output of your trace with ata_piix.override_PCS=1
  1st boot : success : combined=0 orig_mask=0x0
  2nd boot : success : combined=0 orig_mask=0x0
  3rd boot : success : combined=0 orig_mask=0x0
  4th boot : success : combined=0 orig_mask=0x0
  5th boot : success : combined=0 orig_mask=0x0
  6th boot : success : combined=0 orig_mask=0x0
  7th boot : success : combined=0 orig_mask=0x0
  8th boot : success : combined=0 orig_mask=0x0

Looks like you have found a fix/workaround for this bug (but it still 
does not give the reason why it's failing).

Tejun Heo wrote:

>On Thu, Dec 01, 2005 at 10:40:18AM +0100, Jean-Fran?ois Stenuit wrote:
>  
>
>>Hi Keith,
>>
>>I have been able to reproduce the bug (randomly - needing a few reboots 
>>to make it happen) on a 2.6.15-rc3 kernel.
>>
>>System is an HP DL140G2 with following SATA controller (from lspci -vv) :
>>
>>0000:00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 
>>Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
>>       Subsystem: Hewlett-Packard Company: Unknown device 3208
>>       Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>>ParErr- Stepping- SERR- FastB2B-
>>       Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
>><TAbort- <MAbort- >SERR- <PERR-
>>       Latency: 0
>>       Interrupt: pin A routed to IRQ 17
>>       Region 0: I/O ports at <unassigned>
>>       Region 1: I/O ports at <unassigned>
>>       Region 2: I/O ports at <unassigned>
>>       Region 3: I/O ports at <unassigned>
>>       Region 4: I/O ports at 1470 [size=16]
>>    
>>
>
>Hi,
>
>Can you try the following patch?  It adds a module parameter
>override_PCS.  If your piix module is built into the kernel, adding
>the following to the kernel paramter shoudl work.
>
>ata_piix.override_PCS=n
>
>Where, n is one of
>
>0: normal behavior
>1: ignore PCS and always try to probe ports
>2: overwrite PCS such that all ENABLED bits are 1
>
>First, try with override_PCS=0 and make not of the printed combined
>and orig_mask values on success and failure cases.  Then, try with
>override_PCS=1, if it also fails, try with override_PCS=2.
>
>You can tell if an override option works or not by comparing the
>combined and orig_mask value to the failure case.  If the machine
>boots successfully with the same combined/orig_mask values as the
>failure case, it means that the override option works.
>
>BTW, all these are based on the previous message in which you said
>that when boot failed the kernel printed the following log message.
>
>"ata1: SATA port has no device."
>
>Right?
>
>
>diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
>index 887b2b9..639da80 100644
>--- a/drivers/scsi/ata_piix.c
>+++ b/drivers/scsi/ata_piix.c
>@@ -340,6 +340,9 @@ static void piix_pata_phy_reset(struct a
> 	ata_bus_reset(ap);
> }
> 
>+static int override_PCS;
>+module_param(override_PCS, int, 0700);
>+
> /**
>  *	piix_sata_probe - Probe PCI device for present SATA devices
>  *	@ap: Port associated with the PCI device we wish to probe
>@@ -367,6 +370,17 @@ static int piix_sata_probe (struct ata_p
> 
> 	pci_read_config_byte(pdev, ICH5_PCS, &pcs);
> 	orig_mask = (int) pcs & 0xff;
>+	printk("ata%u: combined=%d orig_mask=0x%x\n", ap->id, combined, orig_mask);
>+
>+	switch (override_PCS) {
>+	case 1:
>+		printk("ata%u: ignoring PCS\n", ap->id);
>+		return 1;
>+	case 2:
>+		printk("ata%u: turning on PCS ENABLED bits\n", ap->id);
>+		pci_write_config_byte(pdev, ICH5_PCS, 0x0f);
>+		return 1;
>+	}
> 
> 	/* TODO: this is vaguely wrong for ICH6 combined mode,
> 	 * where only two of the four SATA ports are mapped
>
>  
>


-- 
Jean-François "Jef" Stenuit
Network & Security manager
Keytrade Bank SA


--------------ms080403000103030004030009
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
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA1MTIwMTEyNTkzNFowIwYJ
KoZIhvcNAQkEMRYEFC7s8CZHm3ZqAA8xc9TOm7rwkZaTMFIGCSqGSIb3DQEJDzFFMEMwCgYI
KoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqG
SIb3DQMCAgEoMHgGCSsGAQQBgjcQBDFrMGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRo
YXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBG
cmVlbWFpbCBJc3N1aW5nIENBAgMPeNMwegYLKoZIhvcNAQkQAgsxa6BpMGIxCzAJBgNVBAYT
AlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNU
aGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIDD3jTMA0GCSqGSIb3DQEBAQUA
BIIBAAf5fQGphT1U5IpoWWVKeQY2yzcY+KLvWNZPlToUo4D+wOlvFe8kDIKjWB/3JVu7TZzS
cyyHDMWcd9dtdZbfm+JwxtaGzxXcIoLkXP9qe5l871wfFbXhFSmDBQrB/S9vqj+ZXEeh12Xr
qAbpxgX+4XdcmDizq2F7cubaU4LbPQq0rbLypa6iJU+VwbNmsCTRaWLNGk7KZvENmXhSFKvG
Y0Zd8LlzuVvtWTl8/J8TkR3oMfbzzlwf34EA0LJyFqDtnHYkdVmbPhJu73a36wSBCdxo0Oom
Cxq8RicfGv1eejJbBAjEkL8vcyBJ+ptaVC0QNdd1R2yVA1IislG4HUh/Z8YAAAAAAAA=
--------------ms080403000103030004030009--
