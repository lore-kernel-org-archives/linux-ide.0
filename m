From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] pdc202xx_old: fix resetproc() method
Date: Sat, 30 May 2009 00:07:12 +0400
Message-ID: <200905300007.13113.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:2020 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756515AbZE2UGD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 May 2009 16:06:03 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

pdc202xx_reset() calls pdc202xx_reset_host() twice, for both channels, while
that function actually twiddles the single, shared software reset bit -- the
net effect is a duplicated reset and horrendous 4 second delay happening not
only on a channel reset but also when dma_lost_irq() and dma_clear() methods
are called.  Fold pdc202xx_reset_host() into pdc202xx_reset(), fix printk(),
and move it before the actual reset...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the ide-2.6.git master branch...

Bart, I know you have the docs... from the now removed source code I was able
to figure out that the bit in question most probably drives RST- signal on both
channels (it seems to require re-tuning drives on both channels which we are
currently not doing). If I'm right, why the hell we're twiddling it on a normal
SRST reset, and what's worse on an interrupt timeout conditions? Anyway, it's
hardly a good idea to reset both channels when you only have problem with only
one of them, and I don't see any justification to doing that... So maybe this
patch should've actually wiped out that whole reset insanity for good?..

 drivers/ide/pdc202xx_old.c |   19 +++++--------------
 1 files changed, 5 insertions(+), 14 deletions(-)

Index: ide-2.6/drivers/ide/pdc202xx_old.c
===================================================================
--- ide-2.6.orig/drivers/ide/pdc202xx_old.c
+++ ide-2.6/drivers/ide/pdc202xx_old.c
@@ -1,6 +1,6 @@
 /*
  *  Copyright (C) 1998-2002		Andre Hedrick <andre@linux-ide.org>
- *  Copyright (C) 2006-2007		MontaVista Software, Inc.
+ *  Copyright (C) 2006-2007, 2009	MontaVista Software, Inc.
  *  Copyright (C) 2007			Bartlomiej Zolnierkiewicz
  *
  *  Portions Copyright (C) 1999 Promise Technology, Inc.
@@ -227,28 +227,19 @@ somebody_else:
 	return (dma_stat & 4) == 4;	/* return 1 if INTR asserted */
 }
 
-static void pdc202xx_reset_host (ide_hwif_t *hwif)
+static void pdc202xx_reset(ide_drive_t *drive)
 {
+	ide_hwif_t *hwif	= drive->hwif;
 	unsigned long high_16	= hwif->extra_base - 16;
 	u8 udma_speed_flag	= inb(high_16 | 0x001f);
 
+	printk(KERN_WARNING "PDC202xx: software reset...\n");
+
 	outb(udma_speed_flag | 0x10, high_16 | 0x001f);
 	mdelay(100);
 	outb(udma_speed_flag & ~0x10, high_16 | 0x001f);
 	mdelay(2000);	/* 2 seconds ?! */
 
-	printk(KERN_WARNING "PDC202XX: %s channel reset.\n",
-		hwif->channel ? "Secondary" : "Primary");
-}
-
-static void pdc202xx_reset (ide_drive_t *drive)
-{
-	ide_hwif_t *hwif	= drive->hwif;
-	ide_hwif_t *mate	= hwif->mate;
-
-	pdc202xx_reset_host(hwif);
-	pdc202xx_reset_host(mate);
-
 	ide_set_max_pio(drive);
 }
 

