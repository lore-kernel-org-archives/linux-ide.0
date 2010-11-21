From: Mark Lord <kernel@teksavvy.com>
Subject: Why so much PIO for r/w accesses ?
Date: Sun, 21 Nov 2010 18:35:06 -0500
Message-ID: <4CE9ACAA.9060203@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:48879 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754857Ab0KUXfM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Nov 2010 18:35:12 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>

While working on something unrelated today,
I instrumented ata_sff_data_xfer32() to generate a printk() on each invocation.

Imagine then my complete surprise to see that print() being invoked very frequently
after rebooting with the modified kernel.

ata_sff_data_xfer32() is for PIO read/writes.. something that I don't expect to see.

This is an ata_piix system, with a pure SATA SSD.
Why are we using PIO so much?
Or am I simply misunderstanding something basic here.. ?

Confused.

ata_sff_data_xfer32: buf=f68015fc:512 (write)
ata1.00: ATA-8: OCZ-VERTEX, 1.6, max UDMA/133
ata1.00: 250069680 sectors, multi 1: LBA48 NCQ (depth 0/32)
ata_sff_data_xfer32: buf=f6801f80:512 (write)
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      OCZ-VERTEX       1.6  PQ: 0 ANSI: 5
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:0:0: [sda] 250069680 512-byte logical blocks: (128 GB/119 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO 
or FUA
  sda:
  sda1 sda2
sd 0:0:0:0: [sda] Attached SCSI disk
ata_sff_data_xfer32: buf=f68055fc:512 (write)
ata2.00: ATAPI: SlimtypeDVD A  DS8A1P, CX16, max UDMA/33
ata_sff_data_xfer32: buf=f6805f80:512 (write)
ata2.00: configured for UDMA/33
ata_sff_data_xfer32: buf=f68053a8:12 (read)
ata_sff_data_xfer32: buf=f68040c4:12 (read)
ata_sff_data_xfer32: buf=f7088e00:36 (write)
ata_sff_data_xfer32: buf=f68040c4:12 (read)
scsi 1:0:0:0: CD-ROM            Slimtype DVD A  DS8A1P    CX16 PQ: 0 ANSI: 5
ata_sff_data_xfer32: buf=f68040c4:12 (read)
ata_sff_data_xfer32: buf=f68053a8:12 (read)
ata_sff_data_xfer32: buf=f73b1580:18 (write)
ata_sff_data_xfer32: buf=f68040c4:12 (read)
ata_sff_data_xfer32: buf=f68053a8:12 (read)
ata_sff_data_xfer32: buf=f73b1580:18 (write)
ata_sff_data_xfer32: buf=f68040c4:12 (read)
ata_sff_data_xfer32: buf=f68053a8:12 (read)
ata_sff_data_xfer32: buf=f73f1900:18 (write)
ata_sff_data_xfer32: buf=f68040c4:12 (read)
...

ata_sff_data_xfer32: buf=f6601000:512 (write)
ata_sff_data_xfer32: buf=f68040c4:12 (read)
ata_sff_data_xfer32: buf=f68053a8:12 (read)
ata_sff_data_xfer32: buf=f648fe00:18 (write)
ata_sff_data_xfer32: buf=f68040c4:12 (read)
ata_sff_data_xfer32: buf=f68053a8:12 (read)
ata_sff_data_xfer32: buf=f65b5000:18 (write)
ata_sff_data_xfer32: buf=f68040c4:12 (read)
ata_sff_data_xfer32: buf=f68053a8:12 (read)
ata_sff_data_xfer32: buf=f6568900:18 (write)
ata_sff_data_xfer32: buf=f68040c4:12 (read)
ata_sff_data_xfer32: buf=f68053a8:12 (read)
ata_sff_data_xfer32: buf=f6891d80:18 (write)
ata_sff_data_xfer32: buf=f68040c4:12 (read)
ata_sff_data_xfer32: buf=f68053a8:12 (read)
ata_sff_data_xfer32: buf=f65abf00:18 (write)
ata_sff_data_xfer32: buf=f68040c4:12 (read)
ata_sff_data_xfer32: buf=f68053a8:12 (read)
ata_sff_data_xfer32: buf=f6918780:18 (write)
ata_sff_data_xfer32: buf=f68040c4:12 (read)
ata_sff_data_xfer32: buf=f651a000:8 (write)
ata_sff_data_xfer32: buf=f68040c4:12 (read)
ata_sff_data_xfer32: buf=fffb1bac:36 (write)
ata_sff_data_xfer32: buf=f68040c4:12 (read)
ata_sff_data_xfer32: buf=f651a000:348 (write)
ata_sff_data_xfer32: buf=f68040c4:12 (read)
ata_sff_data_xfer32: buf=f68040c4:12 (read)
ata_sff_data_xfer32: buf=f68053a8:12 (read)
ata_sff_data_xfer32: buf=f65ab680:18 (write)
ata_sff_data_xfer32: buf=f68040c4:12 (read)
ata_sff_data_xfer32: buf=f68053a8:12 (read)
ata_sff_data_xfer32: buf=f68d2400:18 (write)
ata_sff_data_xfer32: buf=f68040c4:12 (read)
ata_sff_data_xfer32: buf=f68053a8:12 (read)
ata_sff_data_xfer32: buf=f65b5980:18 (write)
ata_sff_data_xfer32: buf=f68040c4:12 (read)
ata_sff_data_xfer32: buf=f68040c4:12 (read)
ata_sff_data_xfer32: buf=f68040c4:12 (read)
ata_sff_data_xfer32: buf=f68053a8:12 (read)
ata_sff_data_xfer32: buf=f6aa4200:18 (write)
ata_sff_data_xfer32: buf=f68040c4:12 (read)
ata_sff_data_xfer32: buf=f68053a8:12 (read)
ata_sff_data_xfer32: buf=f6b8b380:18 (write)
ata_sff_data_xfer32: buf=f68040c4:12 (read)
ata_sff_data_xfer32: buf=f68053a8:12 (read)
ata_sff_data_xfer32: buf=f69c2600:18 (write)
ata_sff_data_xfer32: buf=f68040c4:12 (read)
ata_sff_data_xfer32: buf=f68053a8:12 (read)
ata_sff_data_xfer32: buf=f65b8980:18 (write)
ata_sff_data_xfer32: buf=f68040c4:12 (read)
...
