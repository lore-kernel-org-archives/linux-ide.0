From: Petr Vandrovec <petr@vandrovec.name>
Subject: [PATCH] Fix simplex adapters with libata
Date: Thu, 8 Mar 2007 10:12:12 +0100
Message-ID: <20070308091211.GA7257@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vana.vc.cvut.cz ([147.32.240.58]:38960 "EHLO vana.vc.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030505AbXCHJpG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Mar 2007 04:45:06 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hello Jeff,

[please cc me, I'm not subscribed to linux-ide]

Recently I got my hands on nVidia's MCP61 PM-AM board, and
it contains IDE chip configured by BIOS with only primary
channel enabled.  This confuses code which probes for
device DMA capabilities - it gets 0x60 (happy duplex
device) from primary channel BMDMA, but 0xFF (nobody here)
from secondary channel BMDMA.  Due to this code then believes
that chip is simplex.  I do not address this problem in
my patch, as I'm not sure how to handle this.  Probably
ata_pci_init_one should have bitmap of enabled/possible
interfaces instead of their count, but it looks like
quite intrusive change, and maybe we do not care - for device
with only one channel simplex and regular DMA engines are
same.

But making device simplex pointed out that support for
DMA on simplex devices is currently broken - ata_dev_xfermask
tests whether device is simplex and if it is whether DMA
engine was assigned to this port.  If not then it strips
out DMA bits from device.  Problem is that code which assigns
DMA engine to port in ata_set_mode first detect device
mode and assigns DMA engine to channel only if some DMA
capable device was found.

And as xfermask stripped out DMA bits, host->simplex_claimed
is always NULL with current implementation.

By allowing DMA either if simplex_claimed is NULL or if it
points to current port DMA can be finally used - it gets
assigned to first port which contains any DMA capable
device.

Patch is for current Linus git tree (post 2.6.21-rc3).
				Thanks,
					Petr Vandrovec

Before:
pata_amd 0000:00:06.0: version 0.2.8
PCI: Setting latency timer of device 0000:00:06.0 to 64
ata5: PATA max UDMA/133 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001f000 irq 14
ata6: PATA max UDMA/133 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001f008 irq 15
scsi4 : pata_amd
ata5.00: ATAPI, max UDMA/66
ata5.00: simplex DMA is claimed by other device, disabling DMA
ata5.00: configured for PIO4
scsi5 : pata_amd
ata6: port disabled. ignoring.
ata6: reset failed, giving up
scsi 4:0:0:0: CD-ROM            ATAPI    DVD W  DH16W1P   LG12 PQ: 0 ANSI: 5

After:
pata_amd 0000:00:06.0: version 0.2.8
PCI: Setting latency timer of device 0000:00:06.0 to 64
ata5: PATA max UDMA/133 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001f000 irq 14
ata6: PATA max UDMA/133 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001f008 irq 15
scsi4 : pata_amd
ata5.00: ATAPI, max UDMA/66
ata5.00: configured for UDMA/33
scsi5 : pata_amd
ata6: port disabled. ignoring.
ata6: reset failed, giving up
scsi 4:0:0:0: CD-ROM            ATAPI    DVD W  DH16W1P   LG12 PQ: 0 ANSI: 5

Signed-off-by: Petr Vandrovec <petr@vandrovec.name>

diff -uprdN linux/drivers/ata/libata-core.c linux/drivers/ata/libata-core.c
--- linux/drivers/ata/libata-core.c	2007-03-07 22:13:24.000000000 -0800
+++ linux/drivers/ata/libata-core.c	2007-03-08 00:15:37.000000000 -0800
@@ -3455,7 +3455,8 @@ static void ata_dev_xfermask(struct ata_
 			       "device is on DMA blacklist, disabling DMA\n");
 	}
 
-	if ((host->flags & ATA_HOST_SIMPLEX) && host->simplex_claimed != ap) {
+	if ((host->flags & ATA_HOST_SIMPLEX) &&
+            host->simplex_claimed && host->simplex_claimed != ap) {
 		xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
 		ata_dev_printk(dev, KERN_WARNING, "simplex DMA is claimed by "
 			       "other device, disabling DMA\n");
