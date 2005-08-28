From: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH #2] sata_sil: enable Large Block Transfers
Date: Sun, 28 Aug 2005 13:28:06 -0400
Message-ID: <4311F426.60907@pobox.com>
References: <20050828093404.GA29039@havoc.gtf.org> <20050828103959.GA19154@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050300080402020403010900"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:56508 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750703AbVH1R2Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Aug 2005 13:28:16 -0400
In-Reply-To: <20050828103959.GA19154@electric-eye.fr.zoreil.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Francois Romieu <romieu@fr.zoreil.com>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------050300080402020403010900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Francois Romieu wrote:
> Does it not lack an 'idx++' somewhere ?

Good catch, yes it does.

New patch attached.

	Jeff



--------------050300080402020403010900
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -67,6 +67,8 @@ enum {
 	SIL_INTR_STEERING	= (1 << 1),
 	SIL_QUIRK_MOD15WRITE	= (1 << 0),
 	SIL_QUIRK_UDMA5MAX	= (1 << 1),
+
+	SIL_DMA_BOUNDARY	= 0xffffffffU,
 };
 
 static int sil_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
@@ -74,6 +76,8 @@ static void sil_dev_config(struct ata_po
 static u32 sil_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void sil_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static void sil_post_set_mode (struct ata_port *ap);
+static void sil_qc_prep(struct ata_queued_cmd *qc);
+
 
 static struct pci_device_id sil_pci_tbl[] = {
 	{ 0x1095, 0x3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
@@ -126,13 +130,13 @@ static Scsi_Host_Template sil_sht = {
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
+	.sg_tablesize		= ATA_MAX_PRD,
 	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.dma_boundary		= SIL_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
 	.ordered_flush		= 1,
@@ -152,7 +156,7 @@ static struct ata_port_operations sil_op
 	.bmdma_start            = ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
 	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
+	.qc_prep		= sil_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= ata_eng_timeout,
 	.irq_handler		= ata_interrupt,
@@ -197,10 +201,10 @@ static const struct {
 	unsigned long xfer_mode;/* data transfer mode register */
 } sil_port[] = {
 	/* port 0 ... */
-	{ 0x80, 0x8A, 0x00, 0x100, 0x148, 0xb4 },
-	{ 0xC0, 0xCA, 0x08, 0x180, 0x1c8, 0xf4 },
-	{ 0x280, 0x28A, 0x200, 0x300, 0x348, 0x2b4 },
-	{ 0x2C0, 0x2CA, 0x208, 0x380, 0x3c8, 0x2f4 },
+	{ 0x80, 0x8A, 0x10, 0x100, 0x148, 0xb4 },
+	{ 0xC0, 0xCA, 0x18, 0x180, 0x1c8, 0xf4 },
+	{ 0x280, 0x28A, 0x210, 0x300, 0x348, 0x2b4 },
+	{ 0x2C0, 0x2CA, 0x218, 0x380, 0x3c8, 0x2f4 },
 	/* ... port 3 */
 };
 
@@ -210,6 +214,39 @@ MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, sil_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
+
+static inline void sil_fill_sg(struct ata_queued_cmd *qc)
+{
+	struct scatterlist *sg = qc->sg;
+	struct ata_port *ap = qc->ap;
+	unsigned int idx, nelem;
+
+	assert(sg != NULL);
+	assert(qc->n_elem > 0);
+
+	idx = 0;
+	for (nelem = qc->n_elem; nelem; nelem--,sg++) {
+		u32 addr = sg_dma_address(sg);
+		u32 sg_len = sg_dma_len(sg);
+
+		ap->prd[idx].addr = cpu_to_le32(addr);
+		ap->prd[idx].flags_len = cpu_to_le32(sg_len);
+
+		idx++;
+	}
+
+	if (idx)
+		ap->prd[idx - 1].flags_len |= cpu_to_le32(ATA_PRD_EOT);
+}
+
+static void sil_qc_prep(struct ata_queued_cmd *qc)
+{
+	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
+		return;
+
+	sil_fill_sg(qc);
+}
+
 static unsigned char sil_get_device_cache_line(struct pci_dev *pdev)
 {
 	u8 cache_line = 0;

--------------050300080402020403010900--
