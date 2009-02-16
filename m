From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 02/20] ide: use PageHighMem() instead of ifdefs in ide_pio_bytes()
Date: Mon, 16 Feb 2009 01:13:22 +0100
Message-ID: <20090216001322.27491.58344.sendpatchset@localhost.localdomain>
References: <20090216001309.27491.59759.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f20.google.com ([209.85.220.20]:51372 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754949AbZBPAL4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Feb 2009 19:11:56 -0500
In-Reply-To: <20090216001309.27491.59759.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: use PageHighMem() instead of ifdefs in ide_pio_bytes()

Use PageHighMem() instead of ifdefs in ide_pio_bytes()
(=> local IRQs won't be disabled when not necessary).

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-taskfile.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -195,9 +195,7 @@ static void ide_pio_bytes(ide_drive_t *d
 	struct scatterlist *sg = hwif->sg_table;
 	struct scatterlist *cursg = cmd->cursg;
 	struct page *page;
-#ifdef CONFIG_HIGHMEM
 	unsigned long flags;
-#endif
 	unsigned int offset;
 	u8 *buf;
 
@@ -215,9 +213,9 @@ static void ide_pio_bytes(ide_drive_t *d
 		page = nth_page(page, (offset >> PAGE_SHIFT));
 		offset %= PAGE_SIZE;
 
-#ifdef CONFIG_HIGHMEM
-		local_irq_save(flags);
-#endif
+		if (PageHighMem(page))
+			local_irq_save(flags);
+
 		buf = kmap_atomic(page, KM_BIO_SRC_IRQ) + offset;
 
 		cmd->nleft -= nr_bytes;
@@ -235,9 +233,9 @@ static void ide_pio_bytes(ide_drive_t *d
 			hwif->tp_ops->input_data(drive, cmd, buf, nr_bytes);
 
 		kunmap_atomic(buf, KM_BIO_SRC_IRQ);
-#ifdef CONFIG_HIGHMEM
-		local_irq_restore(flags);
-#endif
+
+		if (PageHighMem(page))
+			local_irq_restore(flags);
 
 		len -= nr_bytes;
 	}
