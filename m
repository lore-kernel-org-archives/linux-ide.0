From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [PATCH 2.6.24-rc1 1/2] sata_promise: ASIC PRD table bug workaround, take 2
Date: Tue, 30 Oct 2007 14:20:49 +0100 (MET)
Message-ID: <200710301320.l9UDKndW028161@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:60100 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155AbXJ3NVJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Oct 2007 09:21:09 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, Alexander Sabourenkov <screwdriver@lxnt.info>

Second-generation Promise SATA controllers have an ASIC bug
which can trigger if the last PRD entry is larger than 164 bytes,
resulting in intermittent errors and possible data corruption.

Work around this by replacing calls to ata_qc_prep() with a
private version that fills the PRD, checks the size of the
last entry, and if necessary splits it to avoid the bug.
Also reduce sg_tablesize by 1 to accommodate the new entry.

Tested on the second-generation SATA300 TX4 and SATA300 TX2plus,
and the first-generation PDC20378.

Thanks to Alexander Sabourenkov for verifying the bug by
studying the vendor driver, and for writing the initial patch
upon which this one is based.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
--
Changes since previous version:
* use new PDC_MAX_PRD constant to initialise sg_tablesize

 drivers/ata/sata_promise.c |   87 ++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 83 insertions(+), 4 deletions(-)

diff -rupN linux-2.6.24-rc1/drivers/ata/sata_promise.c linux-2.6.24-rc1.sata_promise-asic-sg-bug-fix-v2/drivers/ata/sata_promise.c
--- linux-2.6.24-rc1/drivers/ata/sata_promise.c	2007-10-24 23:22:55.000000000 +0200
+++ linux-2.6.24-rc1.sata_promise-asic-sg-bug-fix-v2/drivers/ata/sata_promise.c	2007-10-30 13:18:25.000000000 +0100
@@ -50,6 +50,7 @@
 enum {
 	PDC_MAX_PORTS		= 4,
 	PDC_MMIO_BAR		= 3,
+	PDC_MAX_PRD		= LIBATA_MAX_PRD - 1, /* -1 for ASIC PRD bug workaround */
 
 	/* register offsets */
 	PDC_FEATURE		= 0x04, /* Feature/Error reg (per port) */
@@ -155,7 +156,7 @@ static struct scsi_host_template pdc_ata
 	.queuecommand		= ata_scsi_queuecmd,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
+	.sg_tablesize		= PDC_MAX_PRD,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
@@ -521,6 +522,84 @@ static void pdc_atapi_pkt(struct ata_que
 	memcpy(buf+31, cdb, cdb_len);
 }
 
+/**
+ *	pdc_fill_sg - Fill PCI IDE PRD table
+ *	@qc: Metadata associated with taskfile to be transferred
+ *
+ *	Fill PCI IDE PRD (scatter-gather) table with segments
+ *	associated with the current disk command.
+ *	Make sure hardware does not choke on it.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ *
+ */
+static void pdc_fill_sg(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct scatterlist *sg;
+	unsigned int idx;
+	const u32 SG_COUNT_ASIC_BUG = 41*4;
+
+	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
+		return;
+
+	WARN_ON(qc->__sg == NULL);
+	WARN_ON(qc->n_elem == 0 && qc->pad_len == 0);
+
+	idx = 0;
+	ata_for_each_sg(sg, qc) {
+		u32 addr, offset;
+		u32 sg_len, len;
+
+		/* determine if physical DMA addr spans 64K boundary.
+		 * Note h/w doesn't support 64-bit, so we unconditionally
+		 * truncate dma_addr_t to u32.
+		 */
+		addr = (u32) sg_dma_address(sg);
+		sg_len = sg_dma_len(sg);
+
+		while (sg_len) {
+			offset = addr & 0xffff;
+			len = sg_len;
+			if ((offset + sg_len) > 0x10000)
+				len = 0x10000 - offset;
+
+			ap->prd[idx].addr = cpu_to_le32(addr);
+			ap->prd[idx].flags_len = cpu_to_le32(len & 0xffff);
+			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", idx, addr, len);
+
+			idx++;
+			sg_len -= len;
+			addr += len;
+		}
+	}
+
+	if (idx) {
+		u32 len = le32_to_cpu(ap->prd[idx - 1].flags_len);
+
+		if (len > SG_COUNT_ASIC_BUG) {
+			u32 addr;
+
+			VPRINTK("Splitting last PRD.\n");
+
+			addr = le32_to_cpu(ap->prd[idx - 1].addr);
+			ap->prd[idx - 1].flags_len -= cpu_to_le32(SG_COUNT_ASIC_BUG);
+			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", idx - 1, addr, SG_COUNT_ASIC_BUG);
+
+			addr = addr + len - SG_COUNT_ASIC_BUG;
+			len = SG_COUNT_ASIC_BUG;
+			ap->prd[idx].addr = cpu_to_le32(addr);
+			ap->prd[idx].flags_len = cpu_to_le32(len);
+			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", idx, addr, len);
+
+			idx++;
+		}
+
+		ap->prd[idx - 1].flags_len |= cpu_to_le32(ATA_PRD_EOT);
+	}
+}
+
 static void pdc_qc_prep(struct ata_queued_cmd *qc)
 {
 	struct pdc_port_priv *pp = qc->ap->private_data;
@@ -530,7 +609,7 @@ static void pdc_qc_prep(struct ata_queue
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
-		ata_qc_prep(qc);
+		pdc_fill_sg(qc);
 		/* fall through */
 
 	case ATA_PROT_NODATA:
@@ -546,11 +625,11 @@ static void pdc_qc_prep(struct ata_queue
 		break;
 
 	case ATA_PROT_ATAPI:
-		ata_qc_prep(qc);
+		pdc_fill_sg(qc);
 		break;
 
 	case ATA_PROT_ATAPI_DMA:
-		ata_qc_prep(qc);
+		pdc_fill_sg(qc);
 		/*FALLTHROUGH*/
 	case ATA_PROT_ATAPI_NODATA:
 		pdc_atapi_pkt(qc);
