From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 13/40] ide-tape: remove SIMULATE_ERRORS debug code
Date: Sun, 18 May 2008 20:56:25 +0200
Message-ID: <20080518185625.5636.30760.sendpatchset@localhost.localdomain>
References: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:28019 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756459AbYERSjA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 14:39:00 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1425593fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 11:38:58 -0700 (PDT)
In-Reply-To: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-tape.c |   14 --------------
 1 file changed, 14 deletions(-)

Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -144,9 +144,6 @@ enum {
 
 /*************************** End of tunable parameters ***********************/
 
-/* Read/Write error simulation */
-#define SIMULATE_ERRORS			0
-
 /* tape directions */
 enum {
 	IDETAPE_DIR_NONE  = (1 << 0),
@@ -745,9 +742,6 @@ static ide_startstop_t idetape_pc_intr(i
 	xfer_func_t *xferfunc;
 	idetape_io_buf *iobuf;
 	unsigned int temp;
-#if SIMULATE_ERRORS
-	static int error_sim_count;
-#endif
 	u16 bcount;
 	u8 stat, ireason;
 
@@ -775,14 +769,6 @@ static ide_startstop_t idetape_pc_intr(i
 		pc->flags &= ~PC_FLAG_DMA_IN_PROGRESS;
 		local_irq_enable_in_hardirq();
 
-#if SIMULATE_ERRORS
-		if ((pc->c[0] == WRITE_6 || pc->c[0] == READ_6) &&
-		    (++error_sim_count % 100) == 0) {
-			printk(KERN_INFO "ide-tape: %s: simulating error\n",
-				tape->name);
-			stat |= ERR_STAT;
-		}
-#endif
 		if ((stat & ERR_STAT) && pc->c[0] == REQUEST_SENSE)
 			stat &= ~ERR_STAT;
 		if ((stat & ERR_STAT) || (pc->flags & PC_FLAG_DMA_ERROR)) {
