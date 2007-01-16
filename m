From: "Ray Overdijk" <raymov@netro.com.au>
Subject: sata_via: eSATA drive not recognised on VT6421 card
Date: Tue, 16 Jan 2007 16:35:52 +1100
Message-ID: <011c01c73930$2fdbdce0$181012cb@samson>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bdr3.netro.com.au ([203.194.18.225]:57904 "EHLO
	picard.netro.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932333AbXAPFx5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Jan 2007 00:53:57 -0500
Received: from localhost (unknown [127.0.0.1])
	by picard.netro.com.au (Postfix) with ESMTP id 2E5BF2F5C96
	for <linux-ide@vger.kernel.org>; Tue, 16 Jan 2007 05:35:43 +0000 (UTC)
Received: from picard.netro.com.au ([127.0.0.1])
	by localhost (picard.netro.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1o4HV3J3XIvQ for <linux-ide@vger.kernel.org>;
	Tue, 16 Jan 2007 16:35:40 +1100 (EST)
Received: from samson (samson.netro.com.au [203.18.16.24])
	by picard.netro.com.au (Postfix) with ESMTP id 9A3132F5C95
	for <linux-ide@vger.kernel.org>; Tue, 16 Jan 2007 16:35:40 +1100 (EST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Any ideas on what would cause these errors?
http://www.kernel.org/hg/linux-2.6/file/68ac6248e71b/drivers/ata/sata_via.c

dmesg
SCSI subsystem initialized
libata version 2.00 loaded.
sata_via 0000:01:00.0: version 2.0
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 21 (level, low) -> IRQ 21
sata_via 0000:01:00.0: routed to hard irq line 10
ata1: SATA max UDMA/133 cmd 0xDC00 ctl 0xDC0A bmdma 0xD400 irq 21
ata2: SATA max UDMA/133 cmd 0xD880 ctl 0xD88A bmdma 0xD408 irq 21
scsi0 : sata_via
ata1: SATA link down (SStatus 0 SControl 310)
ATA: abnormal status 0x7F on port 0xDC07
scsi1 : sata_via
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ATA: abnormal status 0xD0 on port 0xD887
ATA: abnormal status 0xD0 on port 0xD887
ATA: abnormal status 0xD0 on port 0xD887
ATA: abnormal status 0xD0 on port 0xD887
ATA: abnormal status 0xD0 on port 0xD887
ATA: abnormal status 0xD0 on port 0xD887
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata2.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 0/32)
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: revalidation failed (errno=-5)
ata2.00: limiting speed to PIO0
ata2: failed to recover some devices, retrying in 5 secs
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: revalidation failed (errno=-5)
ata2.00: disabled

uname -r
2.6.18-1.2869.fc6xen

Thanks,
Ray
(please cc me directly on reply)

