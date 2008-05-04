From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: IDE_HFLAG_SERIALIZE_DMA bugfix
Date: Sun, 4 May 2008 16:54:35 +0200
Message-ID: <200805041654.35362.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:52788 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347AbYEDOiw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 May 2008 10:38:52 -0400
Received: by fk-out-0910.google.com with SMTP id 18so312763fkq.5
        for <linux-ide@vger.kernel.org>; Sun, 04 May 2008 07:38:49 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Patch re-ordering could be harmful:

commit 1fd1890594bd355a4217f5658a34763e77decee3
Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date:   Sat Apr 26 22:25:24 2008 +0200

    ide: add IDE_HFLAG_SERIALIZE_DMA host flag
...

is buggy because ->init_dma method / ide_hwif_setup_dma() is called
before IDE_HFLAG_SERIALIZE_DMA host flag is checked.

Fix it by checking IDE_HFLAG_SERIALIZE[_DMA] after DMA initialization.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1355,12 +1355,6 @@ static void ide_init_port(ide_hwif_t *hw
 	if (hwif->chipset != ide_dtc2278 || hwif->channel == 0)
 		hwif->port_ops = d->port_ops;
 
-	if ((d->host_flags & IDE_HFLAG_SERIALIZE) ||
-	    ((d->host_flags & IDE_HFLAG_SERIALIZE_DMA) && hwif->dma_base)) {
-		if (hwif->mate)
-			hwif->mate->serialized = hwif->serialized = 1;
-	}
-
 	hwif->swdma_mask = d->swdma_mask;
 	hwif->mwdma_mask = d->mwdma_mask;
 	hwif->ultra_mask = d->udma_mask;
@@ -1382,6 +1376,12 @@ static void ide_init_port(ide_hwif_t *hw
 			hwif->dma_ops = d->dma_ops;
 	}
 
+	if ((d->host_flags & IDE_HFLAG_SERIALIZE) ||
+	    ((d->host_flags & IDE_HFLAG_SERIALIZE_DMA) && hwif->dma_base)) {
+		if (hwif->mate)
+			hwif->mate->serialized = hwif->serialized = 1;
+	}
+
 	if (d->host_flags & IDE_HFLAG_RQSIZE_256)
 		hwif->rqsize = 256;
 
