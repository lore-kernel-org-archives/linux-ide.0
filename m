From: David Milburn <dmilburn@redhat.com>
Subject: [PATCH #sx4] sata_sx4: fixup interrupt handling
Date: Wed, 13 May 2009 18:02:21 -0500
Message-ID: <20090513230221.GB5863@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:39590 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752768AbZEMXFB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 May 2009 19:05:01 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: mikpe@it.uu.se, tj@kernel.org, linux-ide@vger.kernel.org

Issuing ATA_CMD_SET_FEATURES (0xef) times out because 
pdc20621_interrupt ignores command completion since
ATA_TFLAG_POLLING flag is set.

This has already been fixed for sata_promise:

commit 51b94d2a5a90d4800e74d7348bcde098a28f4fb3
Author: Tejun Heo <htejun@gmail.com>
Date:   Fri Jun 8 13:46:55 2007 -0700

    sata_promise: use TF interface for polling NODATA commands

Also, this patch includes Mikael's original patches:

http://marc.info/?l=linux-ide&m=121135828227724&w=2
http://marc.info/?l=linux-ide&m=121144512109826&w=2

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
Signed-off-by: David Milburn <dmilburn@redhat.com>
---
 drivers/ata/sata_sx4.c |   22 +++++++++-------------
 1 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index e6a866e..bbcf970 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -688,8 +688,11 @@ static void pdc20621_packet_start(struct ata_queued_cmd *qc)
 static unsigned int pdc20621_qc_issue(struct ata_queued_cmd *qc)
 {
 	switch (qc->tf.protocol) {
-	case ATA_PROT_DMA:
 	case ATA_PROT_NODATA:
+		if (qc->tf.flags & ATA_TFLAG_POLLING)
+			break;
+		/*FALLTHROUGH*/
+	case ATA_PROT_DMA:
 		pdc20621_packet_start(qc);
 		return 0;
 
@@ -788,12 +791,7 @@ static inline unsigned int pdc20621_host_intr(struct ata_port *ap,
 
 static void pdc20621_irq_clear(struct ata_port *ap)
 {
-	struct ata_host *host = ap->host;
-	void __iomem *mmio = host->iomap[PDC_MMIO_BAR];
-
-	mmio += PDC_CHIP0_OFS;
-
-	readl(mmio + PDC_20621_SEQMASK);
+	ioread8(ap->ioaddr.status_addr);
 }
 
 static irqreturn_t pdc20621_interrupt(int irq, void *dev_instance)
@@ -878,14 +876,12 @@ static void pdc_freeze(struct ata_port *ap)
 static void pdc_thaw(struct ata_port *ap)
 {
 	void __iomem *mmio = ap->ioaddr.cmd_addr;
-	void __iomem *mmio_base;
 	u32 tmp;
 
 	/* FIXME: start HDMA engine, if zero ATA engines running */
 
-	/* reading SEQ mask register clears IRQ */
-	mmio_base = ap->host->iomap[PDC_MMIO_BAR] + PDC_CHIP0_OFS;
-	readl(mmio_base + PDC_20621_SEQMASK);
+	/* clear IRQ */
+	ioread8(ap->ioaddr.status_addr);
 
 	/* turn IRQ back on */
 	tmp = readl(mmio + PDC_CTLSTAT);
@@ -975,7 +971,7 @@ static int pdc_check_atapi_dma(struct ata_queued_cmd *qc)
 static void pdc_tf_load_mmio(struct ata_port *ap, const struct ata_taskfile *tf)
 {
 	WARN_ON(tf->protocol == ATA_PROT_DMA ||
-		tf->protocol == ATA_PROT_NODATA);
+		tf->protocol == ATAPI_PROT_DMA);
 	ata_sff_tf_load(ap, tf);
 }
 
@@ -983,7 +979,7 @@ static void pdc_tf_load_mmio(struct ata_port *ap, const struct ata_taskfile *tf)
 static void pdc_exec_command_mmio(struct ata_port *ap, const struct ata_taskfile *tf)
 {
 	WARN_ON(tf->protocol == ATA_PROT_DMA ||
-		tf->protocol == ATA_PROT_NODATA);
+		tf->protocol == ATAPI_PROT_DMA);
 	ata_sff_exec_command(ap, tf);
 }
 
