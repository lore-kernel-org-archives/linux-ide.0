From: "Christian P. Schmidt" <schmidt@digadd.de>
Subject: Support for Marvel 6141 in ahci.c
Date: Sat, 10 Jan 2009 12:31:20 +0300
Message-ID: <49686AE8.1050209@digadd.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090906060008070608010308"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.digadd.de ([195.47.195.236]:47174 "EHLO mx2.digadd.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752150AbZAJKD5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 Jan 2009 05:03:57 -0500
Received: from [192.168.255.30]
	by mx2.digadd.de with esmtp (Exim 4.69)
	(envelope-from <schmidt@digadd.de>)
	id 1LLaA2-0000tG-G2
	for linux-ide@vger.kernel.org; Sat, 10 Jan 2009 10:29:43 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------090906060008070608010308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

The Marvell 6141
08:00.0 SATA controller: Marvell Technology Group Ltd. 88SE614x SATA II PCI-E controller (rev 01)
08:00.0 0106: 11ab:6141 (rev 01)
seems to work with the ahci driver with the attached patch:

[17988264.905007] ahci 0000:08:00.0: version 3.0
[17988264.905029] ACPI: PCI Interrupt 0000:08:00.0[A] -> Link [APC7] -> GSI 16 (level, low) -> IRQ 16
[17988264.905054] ahci 0000:08:00.0: controller can't do NCQ, turning off CAP_NCQ
[17988264.905056] ahci 0000:08:00.0: MV_AHCI HACK: port_map 1f -> f
[17988266.267187] ahci 0000:08:00.0: AHCI 0001.0000 32 slots 5 ports 3 Gbps 0xf impl SATA mode
[17988266.267194] ahci 0000:08:00.0: flags: 64bit stag nz only pmp slum part
[17988266.267198] PCI: Setting latency timer of device 0000:08:00.0 to 64
[17988266.268188] scsi12 : ahci
[17988266.268760] scsi13 : ahci
[17988266.268770] scsi14 : ahci
[17988266.268770] scsi15 : ahci
[17988266.268770] scsi16 : ahci
[17988266.268770] ata13: SATA max UDMA/133 abar m1024@0xfdbff000 port 0xfdbff100 irq 16
[17988266.268770] ata14: SATA max UDMA/133 abar m1024@0xfdbff000 port 0xfdbff180 irq 16
[17988266.268770] ata15: SATA max UDMA/133 abar m1024@0xfdbff000 port 0xfdbff200 irq 16
[17988266.268770] ata16: SATA max UDMA/133 abar m1024@0xfdbff000 port 0xfdbff280 irq 16
[17988266.268770] ata17: DUMMY
[14472041.032859] ata13: SATA link up 1.5 Gbps (SStatus 113 SControl 113)
[17988267.192200] ata13.00: ATA-7: ST3500641AS, 3.AAJ, max UDMA/133
[17988267.192200] ata13.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[17988267.289287] ata13.00: configured for UDMA/133
[14472041.486215] ata14: SATA link down (SStatus 0 SControl 0)
[17988268.150351] ata15: SATA link down (SStatus 0 SControl 0)
[14472042.140943] ata16: SATA link down (SStatus 0 SControl 0)
[17988268.564933] scsi 12:0:0:0: Direct-Access     ATA      ST3500641AS      3.AA PQ: 0 ANSI: 5
[17988268.565456] sd 12:0:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
[17988268.565472] sd 12:0:0:0: [sdg] Write Protect is off
[17988268.565474] sd 12:0:0:0: [sdg] Mode Sense: 00 3a 00 00
[17988268.565494] sd 12:0:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[17988268.565579] sd 12:0:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
[17988268.565590] sd 12:0:0:0: [sdg] Write Protect is off
[17988268.565592] sd 12:0:0:0: [sdg] Mode Sense: 00 3a 00 00
[17988268.565611] sd 12:0:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[17988268.565614]  sdg: sdg1
[17988268.585221] sd 12:0:0:0: [sdg] Attached SCSI disk
[17988268.585221] sd 12:0:0:0: Attached scsi generic sg6 type 0

The patch was done on top of Gentoo's 2.6.25-r6, and before that on some 2.6.24 release.

I'm not subscribed, so please CC: me directly on follow-ups.

Regards,
Chris

--------------090906060008070608010308
Content-Type: text/plain;
 name="6141.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="6141.patch"

--- ahci.c.orig	2009-01-10 11:44:28.000000000 +0300
+++ ahci.c	2009-01-10 11:45:18.000000000 +0300
@@ -597,6 +597,7 @@
 
 	/* Marvell */
 	{ PCI_VDEVICE(MARVELL, 0x6145), board_ahci_mv },	/* 6145 */
+	{ PCI_VDEVICE(MARVELL, 0x6141), board_ahci_mv },	/* 6141 */
 	{ PCI_VDEVICE(MARVELL, 0x6121), board_ahci_mv },	/* 6121 */
 
 	/* Promise */

--------------090906060008070608010308--
