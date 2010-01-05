From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] icside: bring back ->maskproc method
Date: Tue, 5 Jan 2010 18:07:27 +0100
Message-ID: <201001051807.27660.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:34479 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754766Ab0AETAt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Jan 2010 14:00:49 -0500
Received: by ewy19 with SMTP id 19so8778241ewy.21
        for <linux-ide@vger.kernel.org>; Tue, 05 Jan 2010 11:00:47 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-ide@vger.kernel.org


Bring back ->maskproc method since it is still needed for proper operation,
as noticed by Russell King:

> This change is bogus.
> 
>         writeb(0, base + ICS_ARCIN_V6_INTROFFSET_1);
>         readb(base + ICS_ARCIN_V6_INTROFFSET_2);
> 
>         writeb(0, base + ICS_ARCIN_V6_INTROFFSET_2);
>         readb(base + ICS_ARCIN_V6_INTROFFSET_1);
> 
> This sequence of code does:
> 
> 1. enable interrupt 1
> 2. disable interrupt 2
> 3. enable interrupt 2
> 4. disable interrupt 1
> 
> which results in the interrupt for the second channel being enabled -
> leaving channel 1 blocked.
> 
> Firstly, icside shares its two IDE channels with one DMA engine - so it's
> a simplex interface.  IDE supports those (or did when the code was written)
> serializing requests between the two interfaces.  libata does not.
> 
> Secondly, the interrupt lines on icside float when there's no drive connected
> or when the drive has its NIEN bit set, which means that you get spurious
> screaming interrupts which can kill off all expansion card interrupts on
> the machine unless you disable the channel interrupt on the card.
> 
> Since libata can not serialize the operation of the two channels like IDE
> can, the libata version of the icside driver does not contain the interrupt
> stearing logic.  Instead, it looks at the status after reset, and if
> nothing was found on that channel, it masks the interrupt from that
> channel.

This patch reverts changes done in commit dff8817 (I became confused due to
non-standard & undocumented ->maskproc method, anyway sorry about that).

Noticed-by: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
against Linus' tree, I'm not cc:ing -stable since the patch is untested

 drivers/ide/icside.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/drivers/ide/icside.c b/drivers/ide/icside.c
index 0f67f1a..d7e6f09 100644
--- a/drivers/ide/icside.c
+++ b/drivers/ide/icside.c
@@ -65,6 +65,8 @@ static struct cardinfo icside_cardinfo_v6_2 = {
 };
 
 struct icside_state {
+	unsigned int channel;
+	unsigned int enabled;
 	void __iomem *irq_port;
 	void __iomem *ioc_base;
 	unsigned int sel;
@@ -114,11 +116,18 @@ static void icside_irqenable_arcin_v6 (struct expansion_card *ec, int irqnr)
 	struct icside_state *state = ec->irq_data;
 	void __iomem *base = state->irq_port;
 
-	writeb(0, base + ICS_ARCIN_V6_INTROFFSET_1);
-	readb(base + ICS_ARCIN_V6_INTROFFSET_2);
+	state->enabled = 1;
 
-	writeb(0, base + ICS_ARCIN_V6_INTROFFSET_2);
-	readb(base + ICS_ARCIN_V6_INTROFFSET_1);
+	switch (state->channel) {
+	case 0:
+		writeb(0, base + ICS_ARCIN_V6_INTROFFSET_1);
+		readb(base + ICS_ARCIN_V6_INTROFFSET_2);
+		break;
+	case 1:
+		writeb(0, base + ICS_ARCIN_V6_INTROFFSET_2);
+		readb(base + ICS_ARCIN_V6_INTROFFSET_1);
+		break;
+	}
 }
 
 /* Prototype: icside_irqdisable_arcin_v6 (struct expansion_card *ec, int irqnr)
@@ -128,6 +137,8 @@ static void icside_irqdisable_arcin_v6 (struct expansion_card *ec, int irqnr)
 {
 	struct icside_state *state = ec->irq_data;
 
+	state->enabled = 0;
+
 	readb(state->irq_port + ICS_ARCIN_V6_INTROFFSET_1);
 	readb(state->irq_port + ICS_ARCIN_V6_INTROFFSET_2);
 }
@@ -149,6 +160,44 @@ static const expansioncard_ops_t icside_ops_arcin_v6 = {
 	.irqpending	= icside_irqpending_arcin_v6,
 };
 
+/*
+ * Handle routing of interrupts.  This is called before
+ * we write the command to the drive.
+ */
+static void icside_maskproc(ide_drive_t *drive, int mask)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct expansion_card *ec = ECARD_DEV(hwif->dev);
+	struct icside_state *state = ecard_get_drvdata(ec);
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	state->channel = hwif->channel;
+
+	if (state->enabled && !mask) {
+		switch (hwif->channel) {
+		case 0:
+			writeb(0, state->irq_port + ICS_ARCIN_V6_INTROFFSET_1);
+			readb(state->irq_port + ICS_ARCIN_V6_INTROFFSET_2);
+			break;
+		case 1:
+			writeb(0, state->irq_port + ICS_ARCIN_V6_INTROFFSET_2);
+			readb(state->irq_port + ICS_ARCIN_V6_INTROFFSET_1);
+			break;
+		}
+	} else {
+		readb(state->irq_port + ICS_ARCIN_V6_INTROFFSET_2);
+		readb(state->irq_port + ICS_ARCIN_V6_INTROFFSET_1);
+	}
+
+	local_irq_restore(flags);
+}
+
+static const struct ide_port_ops icside_v6_no_dma_port_ops = {
+	.maskproc		= icside_maskproc,
+};
+
 #ifdef CONFIG_BLK_DEV_IDEDMA_ICS
 /*
  * SG-DMA support.
@@ -228,6 +277,7 @@ static void icside_set_dma_mode(ide_drive_t *drive, const u8 xfer_mode)
 
 static const struct ide_port_ops icside_v6_port_ops = {
 	.set_dma_mode		= icside_set_dma_mode,
+	.maskproc		= icside_maskproc,
 };
 
 static void icside_dma_host_set(ide_drive_t *drive, int on)
@@ -272,6 +322,11 @@ static int icside_dma_setup(ide_drive_t *drive, struct ide_cmd *cmd)
 	BUG_ON(dma_channel_active(ec->dma));
 
 	/*
+	 * Ensure that we have the right interrupt routed.
+	 */
+	icside_maskproc(drive, 0);
+
+	/*
 	 * Route the DMA signals to the correct interface.
 	 */
 	writeb(state->sel | hwif->channel, state->ioc_base);
@@ -399,6 +454,7 @@ err_free:
 
 static const struct ide_port_info icside_v6_port_info __initdata = {
 	.init_dma		= icside_dma_off_init,
+	.port_ops		= &icside_v6_no_dma_port_ops,
 	.dma_ops		= &icside_v6_dma_ops,
 	.host_flags		= IDE_HFLAG_SERIALIZE | IDE_HFLAG_MMIO,
 	.mwdma_mask		= ATA_MWDMA2,
