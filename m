From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/3] icside: remove superfluous ->maskproc method
Date: Mon, 1 Jun 2009 23:53:41 +0200
Message-ID: <200906012353.41504.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:50531 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759179AbZFAV4B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Jun 2009 17:56:01 -0400
Received: by ewy24 with SMTP id 24so8197883ewy.37
        for <linux-ide@vger.kernel.org>; Mon, 01 Jun 2009 14:56:02 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

[inspired by pata_icside]

Enabling/disabling of card IRQs is handled fine by IRQ and IDE
subsystems so there is no need for custom ->maskproc method.

Moreover icside_maskproc() would enable IRQ only if it was already
enabled [because of 'if (state->enabled && !mask)' check].

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/icside.c |   64 +++------------------------------------------------
 1 file changed, 4 insertions(+), 60 deletions(-)

Index: b/drivers/ide/icside.c
===================================================================
--- a/drivers/ide/icside.c
+++ b/drivers/ide/icside.c
@@ -65,8 +65,6 @@ static struct cardinfo icside_cardinfo_v
 };
 
 struct icside_state {
-	unsigned int channel;
-	unsigned int enabled;
 	void __iomem *irq_port;
 	void __iomem *ioc_base;
 	unsigned int sel;
@@ -116,18 +114,11 @@ static void icside_irqenable_arcin_v6 (s
 	struct icside_state *state = ec->irq_data;
 	void __iomem *base = state->irq_port;
 
-	state->enabled = 1;
+	writeb(0, base + ICS_ARCIN_V6_INTROFFSET_1);
+	readb(base + ICS_ARCIN_V6_INTROFFSET_2);
 
-	switch (state->channel) {
-	case 0:
-		writeb(0, base + ICS_ARCIN_V6_INTROFFSET_1);
-		readb(base + ICS_ARCIN_V6_INTROFFSET_2);
-		break;
-	case 1:
-		writeb(0, base + ICS_ARCIN_V6_INTROFFSET_2);
-		readb(base + ICS_ARCIN_V6_INTROFFSET_1);
-		break;
-	}
+	writeb(0, base + ICS_ARCIN_V6_INTROFFSET_2);
+	readb(base + ICS_ARCIN_V6_INTROFFSET_1);
 }
 
 /* Prototype: icside_irqdisable_arcin_v6 (struct expansion_card *ec, int irqnr)
@@ -137,8 +128,6 @@ static void icside_irqdisable_arcin_v6 (
 {
 	struct icside_state *state = ec->irq_data;
 
-	state->enabled = 0;
-
 	readb(state->irq_port + ICS_ARCIN_V6_INTROFFSET_1);
 	readb(state->irq_port + ICS_ARCIN_V6_INTROFFSET_2);
 }
@@ -160,44 +149,6 @@ static const expansioncard_ops_t icside_
 	.irqpending	= icside_irqpending_arcin_v6,
 };
 
-/*
- * Handle routing of interrupts.  This is called before
- * we write the command to the drive.
- */
-static void icside_maskproc(ide_drive_t *drive, int mask)
-{
-	ide_hwif_t *hwif = drive->hwif;
-	struct expansion_card *ec = ECARD_DEV(hwif->dev);
-	struct icside_state *state = ecard_get_drvdata(ec);
-	unsigned long flags;
-
-	local_irq_save(flags);
-
-	state->channel = hwif->channel;
-
-	if (state->enabled && !mask) {
-		switch (hwif->channel) {
-		case 0:
-			writeb(0, state->irq_port + ICS_ARCIN_V6_INTROFFSET_1);
-			readb(state->irq_port + ICS_ARCIN_V6_INTROFFSET_2);
-			break;
-		case 1:
-			writeb(0, state->irq_port + ICS_ARCIN_V6_INTROFFSET_2);
-			readb(state->irq_port + ICS_ARCIN_V6_INTROFFSET_1);
-			break;
-		}
-	} else {
-		readb(state->irq_port + ICS_ARCIN_V6_INTROFFSET_2);
-		readb(state->irq_port + ICS_ARCIN_V6_INTROFFSET_1);
-	}
-
-	local_irq_restore(flags);
-}
-
-static const struct ide_port_ops icside_v6_no_dma_port_ops = {
-	.maskproc		= icside_maskproc,
-};
-
 #ifdef CONFIG_BLK_DEV_IDEDMA_ICS
 /*
  * SG-DMA support.
@@ -275,7 +226,6 @@ static void icside_set_dma_mode(ide_driv
 
 static const struct ide_port_ops icside_v6_port_ops = {
 	.set_dma_mode		= icside_set_dma_mode,
-	.maskproc		= icside_maskproc,
 };
 
 static void icside_dma_host_set(ide_drive_t *drive, int on)
@@ -320,11 +270,6 @@ static int icside_dma_setup(ide_drive_t 
 	BUG_ON(dma_channel_active(ec->dma));
 
 	/*
-	 * Ensure that we have the right interrupt routed.
-	 */
-	icside_maskproc(drive, 0);
-
-	/*
 	 * Route the DMA signals to the correct interface.
 	 */
 	writeb(state->sel | hwif->channel, state->ioc_base);
@@ -452,7 +397,6 @@ err_free:
 
 static const struct ide_port_info icside_v6_port_info __initdata = {
 	.init_dma		= icside_dma_off_init,
-	.port_ops		= &icside_v6_no_dma_port_ops,
 	.dma_ops		= &icside_v6_dma_ops,
 	.host_flags		= IDE_HFLAG_SERIALIZE | IDE_HFLAG_MMIO,
 	.mwdma_mask		= ATA_MWDMA2,
