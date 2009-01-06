From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 7/9] ide: move ->rqsize init from init_irq() to ide_init_port()
Date: Tue, 06 Jan 2009 19:36:02 +0100
Message-ID: <20090106183602.21193.67001.sendpatchset@localhost.localdomain>
References: <20090106183520.21193.63704.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:63672 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755151AbZAFSfT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Jan 2009 13:35:19 -0500
In-Reply-To: <20090106183520.21193.63704.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: move ->rqsize init from init_irq() to ide_init_port()

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -958,14 +958,6 @@ static int init_irq (ide_hwif_t *hwif)
 	if (request_irq(hwif->irq, &ide_intr, sa, hwif->name, hwif))
 		goto out_up;
 
-	if (!hwif->rqsize) {
-		if ((hwif->host_flags & IDE_HFLAG_NO_LBA48) ||
-		    (hwif->host_flags & IDE_HFLAG_NO_LBA48_DMA))
-			hwif->rqsize = 256;
-		else
-			hwif->rqsize = 65536;
-	}
-
 #if !defined(__mc68000__)
 	printk(KERN_INFO "%s at 0x%03lx-0x%03lx,0x%03lx on irq %d", hwif->name,
 		io_ports->data_addr, io_ports->status_addr,
@@ -1242,6 +1234,13 @@ static void ide_init_port(ide_hwif_t *hw
 
 	if (d->max_sectors)
 		hwif->rqsize = d->max_sectors;
+	else {
+		if ((hwif->host_flags & IDE_HFLAG_NO_LBA48) ||
+		    (hwif->host_flags & IDE_HFLAG_NO_LBA48_DMA))
+			hwif->rqsize = 256;
+		else
+			hwif->rqsize = 65536;
+	}
 
 	/* call chipset specific routine for each enabled port */
 	if (d->init_hwif)
