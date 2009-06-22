From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] IDE: Silent compiler warning in ide_pio_bytes()
Date: Mon, 22 Jun 2009 21:10:52 +0200
Message-ID: <20090622211052.45b3cfc5@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:5991 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbZFVTLB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Jun 2009 15:11:01 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

PageHighMem() isn't cheap so avoid calling it several times on the
same page. I had the hope that this would silent the following
compilation warning:

drivers/ide/ide-taskfile.c: In function 'ide_pio_bytes':
drivers/ide/ide-taskfile.c:229: warning: 'flags' may be used uninitialized in this function

which is a false positive, but it did not. So let's just initialize the
flags and be done with it, so that other developers don't waste their
time looking at it.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-taskfile.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- linux-2.6.31-pre.orig/drivers/ide/ide-taskfile.c	2009-06-21 09:37:02.000000000 +0200
+++ linux-2.6.31-pre/drivers/ide/ide-taskfile.c	2009-06-21 12:18:47.000000000 +0200
@@ -226,7 +226,7 @@ void ide_pio_bytes(ide_drive_t *drive, s
 	struct scatterlist *sg = hwif->sg_table;
 	struct scatterlist *cursg = cmd->cursg;
 	struct page *page;
-	unsigned long flags;
+	unsigned long flags = 0;	/* Silent compiler warning */
 	unsigned int offset;
 	u8 *buf;
 
@@ -236,6 +236,7 @@ void ide_pio_bytes(ide_drive_t *drive, s
 
 	while (len) {
 		unsigned nr_bytes = min(len, cursg->length - cmd->cursg_ofs);
+		int page_is_high;
 
 		if (nr_bytes > PAGE_SIZE)
 			nr_bytes = PAGE_SIZE;
@@ -247,7 +248,8 @@ void ide_pio_bytes(ide_drive_t *drive, s
 		page = nth_page(page, (offset >> PAGE_SHIFT));
 		offset %= PAGE_SIZE;
 
-		if (PageHighMem(page))
+		page_is_high = PageHighMem(page);
+		if (page_is_high)
 			local_irq_save(flags);
 
 		buf = kmap_atomic(page, KM_BIO_SRC_IRQ) + offset;
@@ -268,7 +270,7 @@ void ide_pio_bytes(ide_drive_t *drive, s
 
 		kunmap_atomic(buf, KM_BIO_SRC_IRQ);
 
-		if (PageHighMem(page))
+		if (page_is_high)
 			local_irq_restore(flags);
 
 		len -= nr_bytes;


-- 
Jean Delvare
