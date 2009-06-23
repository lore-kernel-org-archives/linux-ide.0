From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] IDE: Save a call to PageHighMem()
Date: Tue, 23 Jun 2009 10:12:39 +0200
Message-ID: <20090623101239.2f510604@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:17794 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbZFWIMt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jun 2009 04:12:49 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

PageHighMem() isn't cheap so avoid calling it twice on the same page.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-taskfile.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.31-pre.orig/drivers/ide/ide-taskfile.c	2009-06-23 09:01:10.000000000 +0200
+++ linux-2.6.31-pre/drivers/ide/ide-taskfile.c	2009-06-23 09:50:33.000000000 +0200
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
