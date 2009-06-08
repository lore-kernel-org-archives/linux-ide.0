From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git pull] IDE fixes
Date: Mon, 8 Jun 2009 02:54:14 +0200
Message-ID: <200906080254.14427.bzolnier@gmail.com>
References: <200906071444.33047.bzolnier@gmail.com> <200906080147.12274.bzolnier@gmail.com> <alpine.LFD.2.01.0906071651250.6847@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:42664 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968AbZFHAwK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Jun 2009 20:52:10 -0400
In-Reply-To: <alpine.LFD.2.01.0906071651250.6847@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, James Bottomley <James.Bottomley@hansenpartnership.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 08 June 2009 01:57:19 Linus Torvalds wrote:
> 
> On Mon, 8 Jun 2009, Bartlomiej Zolnierkiewicz wrote:
> > 
> > This is not a new feature and basing your opinions on opinions of people
> > who don't read the code before commenting is bad, really bad, m'kay?
> 
> The thing is, I had planned on doing a final release yesterday, even 

I don't want IDE to possibly hold off the final release so...


Linus, please pull from 'for-linus' branch of:

master.kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git for-linus

to receive the following updates:

 drivers/ide/pdc202xx_old.c |   22 ++++++----------------
 1 files changed, 6 insertions(+), 16 deletions(-)


Sergei Shtylyov (2):
      pdc202xx_old: fix 'pdc20246_dma_ops'
      pdc202xx_old: fix resetproc() method


diff --git a/drivers/ide/pdc202xx_old.c b/drivers/ide/pdc202xx_old.c
index 248a54b..b3bc96f 100644
--- a/drivers/ide/pdc202xx_old.c
+++ b/drivers/ide/pdc202xx_old.c
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
 
@@ -328,9 +319,8 @@ static const struct ide_dma_ops pdc20246_dma_ops = {
 	.dma_start		= ide_dma_start,
 	.dma_end		= ide_dma_end,
 	.dma_test_irq		= pdc202xx_dma_test_irq,
-	.dma_lost_irq		= pdc202xx_dma_lost_irq,
+	.dma_lost_irq		= ide_dma_lost_irq,
 	.dma_timer_expiry	= ide_dma_sff_timer_expiry,
-	.dma_clear		= pdc202xx_reset,
 	.dma_sff_read_status	= ide_dma_sff_read_status,
 };
 
