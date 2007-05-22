From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: new libata-code breaks functionality of sata_sis
Date: Wed, 23 May 2007 00:42:22 +0200
Message-ID: <465371CE.70201@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:40666 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761287AbXEVWmX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 May 2007 18:42:23 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, htejun@gmail.com
Cc: "linux.ide" <linux-ide@vger.kernel.org>

a  SiS180  controller is connected with a PATA-disk.
Starting with 2.6.22-rc1 the disk is no longer working.

sata_sis 0000:01:07.0: version 0.7
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
ACPI: PCI Interrupt 0000:01:07.0[A] -> Link [APC4] -> GSI 19 (level,
low) -> IRQ 16
sata_sis 0000:01:07.0: Detected SiS 180/181 chipset in combined mode
scsi0 : sata_sis
scsi1 : sata_sis
ata1: PATA max UDMA/133 cmd 0x00019000 ctl 0x00019402 bmdma 0x0001a000 irq 0
ata2: PATA max UDMA/133 cmd 0x00019800 ctl 0x00019c02 bmdma 0x0001a008 irq 0
ata1: port disabled. ignoring.
ata2: port disabled. ignoring.
ATA: abnormal status 0x7F on port 0x00019807

ata2 must be a SATA port.
this problem can be solved by the patch.

ata1 must not be disabled
For this problem i have no solution.


--- a/drivers/ata/sata_sis.c       2007-05-22 11:05:38.000000000 +0200
+++ b/drivers/ata/sata_sis.c  2007-05-23 00:24:28.000000000 +0200
@@ -255,7 +255,7 @@
 {
        static int printed_version;
        struct ata_port_info pi = sis_port_info;
-       const struct ata_port_info *ppi[] = { &pi, NULL };
+       const struct ata_port_info *ppi[] = { &pi, &pi };
        struct ata_host *host;
        u32 genctl, val;
        u8 pmr;



