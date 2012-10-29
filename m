From: David Milburn <dmilburn@redhat.com>
Subject: [PATCH] sata_svw: check DMA start bit before reset
Date: Mon, 29 Oct 2012 18:00:22 -0500
Message-ID: <1351551622-1193-1-git-send-email-dmilburn@redhat.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:14970 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754754Ab2J2WyZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Oct 2012 18:54:25 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, benh@kernel.crashing.org, caiqian@redhat.com

If kdump is triggered with pending IO, controller may not respond causing
kdump to fail.

http://marc.info/?l=linux-ide&m=133032255424658&w=2

During error recovery ata_do_dev_read_id never completes due hang
in mmio_insw.

ata_do_dev_read_id
 ata_sff_data_xfer
  ioread16_rep
   mmio_insw

if DMA start bit is cleared before reset, PIO command is successful
and kdump succeeds.

Signed-off-by: David Milburn <dmilburn@redhat.com>
---
 drivers/ata/sata_svw.c |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index 44a4256..08608de 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -142,6 +142,39 @@ static int k2_sata_scr_write(struct ata_link *link,
 	return 0;
 }
 
+static int k2_sata_softreset(struct ata_link *link,
+			     unsigned int *class, unsigned long deadline)
+{
+	u8 dmactl;
+	void __iomem *mmio = link->ap->ioaddr.bmdma_addr;
+
+	dmactl = readb(mmio + ATA_DMA_CMD);
+
+	/* Clear the start bit */
+	if (dmactl & ATA_DMA_START) {
+		dmactl &= ~ATA_DMA_START;
+		writeb(dmactl, mmio + ATA_DMA_CMD);
+	}
+
+	return ata_sff_softreset(link, class, deadline);
+}
+
+static int k2_sata_hardreset(struct ata_link *link,
+			     unsigned int *class, unsigned long deadline)
+{
+	u8 dmactl;
+	void __iomem *mmio = link->ap->ioaddr.bmdma_addr;
+
+	dmactl = readb(mmio + ATA_DMA_CMD);
+
+	/* Clear the start bit */
+	if (dmactl & ATA_DMA_START) {
+		dmactl &= ~ATA_DMA_START;
+		writeb(dmactl, mmio + ATA_DMA_CMD);
+	}
+
+	return sata_sff_hardreset(link, class, deadline);
+}
 
 static void k2_sata_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
 {
@@ -346,6 +379,8 @@ static struct scsi_host_template k2_sata_sht = {
 
 static struct ata_port_operations k2_sata_ops = {
 	.inherits		= &ata_bmdma_port_ops,
+	.softreset              = k2_sata_softreset,
+	.hardreset              = k2_sata_hardreset,
 	.sff_tf_load		= k2_sata_tf_load,
 	.sff_tf_read		= k2_sata_tf_read,
 	.sff_check_status	= k2_stat_check_status,
