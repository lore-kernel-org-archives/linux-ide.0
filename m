From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata: Add pata_dma option so users can disable pata_dma
 as they can with old-ide
Date: Fri, 22 Jun 2007 14:49:39 +0100
Message-ID: <20070622144939.026ed6ac@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37655 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750718AbXFVNn7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Jun 2007 09:43:59 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, davej@redhat.com, linux-ide@vger.kernel.org

Allow

	libata.pata_dma=0

to disable DMA (default is 1)

SATA is unaffected as disabling DMA for SATA makes no sense at all.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc4-mm2/drivers/ata/libata-core.c linux-2.6.22-rc4-mm2/drivers/ata/libata-core.c
--- linux.vanilla-2.6.22-rc4-mm2/drivers/ata/libata-core.c	2007-06-07 14:26:08.000000000 +0100
+++ linux-2.6.22-rc4-mm2/drivers/ata/libata-core.c	2007-06-07 16:53:43.000000000 +0100
@@ -94,6 +94,10 @@
 module_param_named(ignore_hpa, ata_ignore_hpa, int, 0644);
 MODULE_PARM_DESC(ignore_hpa, "Ignore HPA limit (0=keep BIOS limits, 1=ignore limits, using full disk)");
 
+static int ata_pata_dma = 1;
+module_param_named(pata_dma, ata_pata_dma, int, 0644);
+MODULE_PARM_DESC(pata_dma, "Use DMA on PATA devices");
+
 static int ata_probe_timeout = ATA_TMOUT_INTERNAL / HZ;
 module_param(ata_probe_timeout, int, 0444);
 MODULE_PARM_DESC(ata_probe_timeout, "Set ATA probing timeout (seconds)");
@@ -2815,7 +2831,12 @@
 		ata_dev_xfermask(dev);
 
 		pio_mask = ata_pack_xfermask(dev->pio_mask, 0, 0);
-		dma_mask = ata_pack_xfermask(0, dev->mwdma_mask, dev->udma_mask);
+		
+		if (ata_pata_dma || ap->cbl == ATA_CBL_SATA)
+			dma_mask = ata_pack_xfermask(0, dev->mwdma_mask, dev->udma_mask);
+		else
+			dma_mask = 0;
+
 		dev->pio_mode = ata_xfer_mask2mode(pio_mask);
 		dev->dma_mode = ata_xfer_mask2mode(dma_mask);
 
