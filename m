From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/3] libata: add hp-poll support to controllers without hotplug interrupts
Date: Tue, 10 Oct 2006 14:36:13 +0900
Message-ID: <11604585733365-git-send-email-htejun@gmail.com>
References: <116045857221-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:21600 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964990AbWJJFgV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Oct 2006 01:36:21 -0400
Received: by py-out-1112.google.com with SMTP id n25so2655679pyg
        for <linux-ide@vger.kernel.org>; Mon, 09 Oct 2006 22:36:20 -0700 (PDT)
In-Reply-To: <116045857221-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

This patch adds hp-poll support to the following drivers.

* sata_nv (generic)
* sata_sil (SIL_FLAG_NO_SATA_IRQ replaced w/ ATA_FLAG_HP_POLLING)
* sata_sis
* sata_svw
* sata_uli
* sata_vsc

All the above drivers currently don't support hotplug interrupts (H/W
restrictions or lack of doc/effort) and all hotplug operations should
be done via hp-poll; thus, ATA_FLAG_HP_POLLING is set for these
drivers.

sata_via is excluded because it randomly locks up on SCR register
access.
---
 drivers/ata/sata_nv.c  |    5 ++++-
 drivers/ata/sata_sil.c |    9 ++++-----
 drivers/ata/sata_sis.c |    5 ++++-
 drivers/ata/sata_svw.c |    4 +++-
 drivers/ata/sata_uli.c |    6 +++++-
 drivers/ata/sata_vsc.c |    4 +++-
 6 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index a75d5cc..fcdae1a 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -173,6 +173,8 @@ static const struct ata_port_operations 
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= nv_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.hp_poll_activate	= sata_std_hp_poll_activate,
+	.hp_poll		= sata_std_hp_poll,
 	.data_xfer		= ata_pio_data_xfer,
 	.irq_handler		= nv_generic_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
@@ -245,7 +247,8 @@ static struct ata_port_info nv_port_info
 	/* generic */
 	{
 		.sht		= &nv_sht,
-		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
+		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_HP_POLLING,
 		.pio_mask	= NV_PIO_MASK,
 		.mwdma_mask	= NV_MWDMA_MASK,
 		.udma_mask	= NV_UDMA_MASK,
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 43553db..71d9264 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -52,7 +52,6 @@ enum {
 	/*
 	 * host flags
 	 */
-	SIL_FLAG_NO_SATA_IRQ	= (1 << 28),
 	SIL_FLAG_RERR_ON_DMA_ACT = (1 << 29),
 	SIL_FLAG_MOD15WRITE	= (1 << 30),
 
@@ -230,7 +229,7 @@ static const struct ata_port_info sil_po
 	{
 		.sht		= &sil_sht,
 		.flags		= SIL_DFL_PORT_FLAGS | SIL_FLAG_MOD15WRITE |
-				  SIL_FLAG_NO_SATA_IRQ,
+				  ATA_FLAG_HP_POLLING,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
@@ -454,8 +453,8 @@ static irqreturn_t sil_interrupt(int irq
 		if (unlikely(!ap || ap->flags & ATA_FLAG_DISABLED))
 			continue;
 
-		/* turn off SATA_IRQ if not supported */
-		if (ap->flags & SIL_FLAG_NO_SATA_IRQ)
+		/* ignore SATA_IRQ if not supported */
+		if (ap->flags & ATA_FLAG_HP_POLLING)
 			bmdma2 &= ~SIL_DMA_SATA_IRQ;
 
 		if (bmdma2 == 0xffffffff ||
@@ -496,7 +495,7 @@ static void sil_thaw(struct ata_port *ap
 	ata_bmdma_irq_clear(ap);
 
 	/* turn on SATA IRQ if supported */
-	if (!(ap->flags & SIL_FLAG_NO_SATA_IRQ))
+	if (!(ap->flags & ATA_FLAG_HP_POLLING))
 		writel(SIL_SIEN_N, mmio_base + sil_port[ap->port_no].sien);
 
 	/* turn on IRQ */
diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index 0738f52..f31ff5f 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -117,6 +117,8 @@ static const struct ata_port_operations 
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.hp_poll_activate	= sata_std_hp_poll_activate,
+	.hp_poll		= sata_std_hp_poll,
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= sis_scr_read,
@@ -128,7 +130,8 @@ static const struct ata_port_operations 
 
 static struct ata_port_info sis_port_info = {
 	.sht		= &sis_sht,
-	.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
+	.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+			  ATA_FLAG_HP_POLLING,
 	.pio_mask	= 0x1f,
 	.mwdma_mask	= 0x7,
 	.udma_mask	= 0x7f,
diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index 84025a2..244a698 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -324,6 +324,8 @@ static const struct ata_port_operations 
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.hp_poll_activate	= sata_std_hp_poll_activate,
+	.hp_poll		= sata_std_hp_poll,
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= k2_sata_scr_read,
@@ -424,7 +426,7 @@ static int k2_sata_init_one (struct pci_
 
 	probe_ent->sht = &k2_sata_sht;
 	probe_ent->port_flags = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				ATA_FLAG_MMIO;
+				ATA_FLAG_MMIO | ATA_FLAG_HP_POLLING;
 	probe_ent->port_ops = &k2_sata_ops;
 	probe_ent->n_ports = 4;
 	probe_ent->irq = pdev->irq;
diff --git a/drivers/ata/sata_uli.c b/drivers/ata/sata_uli.c
index 5c603ca..6e9a8dd 100644
--- a/drivers/ata/sata_uli.c
+++ b/drivers/ata/sata_uli.c
@@ -115,6 +115,9 @@ static const struct ata_port_operations 
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
+	.hp_poll_activate	= sata_std_hp_poll_activate,
+	.hp_poll		= sata_std_hp_poll,
+
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 
@@ -128,7 +131,8 @@ static const struct ata_port_operations 
 
 static struct ata_port_info uli_port_info = {
 	.sht            = &uli_sht,
-	.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
+	.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+			  ATA_FLAG_HP_POLLING,
 	.pio_mask       = 0x1f,		/* pio0-4 */
 	.udma_mask      = 0x7f,		/* udma0-6 */
 	.port_ops       = &uli_ops,
diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index e654b99..c92fb0d 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -301,6 +301,8 @@ static const struct ata_port_operations 
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.hp_poll_activate	= sata_std_hp_poll_activate,
+	.hp_poll		= sata_std_hp_poll,
 	.irq_handler		= vsc_sata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= vsc_sata_scr_read,
@@ -395,7 +397,7 @@ static int __devinit vsc_sata_init_one (
 
 	probe_ent->sht = &vsc_sata_sht;
 	probe_ent->port_flags = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				ATA_FLAG_MMIO;
+				ATA_FLAG_MMIO | ATA_FLAG_HP_POLLING;
 	probe_ent->port_ops = &vsc_sata_ops;
 	probe_ent->n_ports = 4;
 	probe_ent->irq = pdev->irq;
-- 
1.4.2.3


