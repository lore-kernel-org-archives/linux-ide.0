From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 06/07] sata_mv: introduce support for ATAPI devices
Date: Fri, 30 Jan 2009 18:51:54 -0500
Message-ID: <4983929A.7010501@rtr.ca>
References: <49839107.2040603@rtr.ca> <4983915F.7090705@rtr.ca> <498391A7.1090209@rtr.ca> <498391D9.2000403@rtr.ca> <49839209.9010602@rtr.ca> <49839256.7090402@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:57882 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754424AbZA3Xvz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Jan 2009 18:51:55 -0500
In-Reply-To: <49839256.7090402@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Add ATAPI support to sata_mv, using sff DMA for GEN_II chipsets,
and plain old PIO for GEN_IIE.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2009-01-30 18:32:08.000000000 -0500
+++ linux/drivers/ata/sata_mv.c	2009-01-30 18:33:04.000000000 -0500
@@ -31,8 +31,6 @@
  *
  * --> Complete a full errata audit for all chipsets to identify others.
  *
- * --> ATAPI support (Marvell claims the 60xx/70xx chips can do it).
- *
  * --> Develop a low-power-consumption strategy, and implement it.
  *
  * --> [Experiment, low priority] Investigate interrupt coalescing.
@@ -68,7 +66,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_mv"
-#define DRV_VERSION	"1.25"
+#define DRV_VERSION	"1.26"
 
 enum {
 	/* BAR's are enumerated in terms of pci_resource_start() terms */
@@ -126,7 +124,7 @@
 
 	MV_GEN_II_FLAGS		= MV_COMMON_FLAGS | MV_FLAG_IRQ_COALESCE |
 				  ATA_FLAG_PMP | ATA_FLAG_ACPI_SATA |
-				  ATA_FLAG_NCQ | ATA_FLAG_NO_ATAPI,
+				  ATA_FLAG_NCQ,
 
 	MV_GEN_IIE_FLAGS	= MV_GEN_II_FLAGS | ATA_FLAG_AN,
 
@@ -348,6 +346,12 @@
 
 	EDMA_HALTCOND_OFS	= 0x60,		/* GenIIe halt conditions */
 
+
+	BMDMA_CMD_OFS		= 0x224,	/* bmdma command register */
+	BMDMA_STATUS_OFS	= 0x228,	/* bmdma status register */
+	BMDMA_PRD_LOW_OFS	= 0x22c,	/* bmdma PRD addr 31:0 */
+	BMDMA_PRD_HIGH_OFS	= 0x230,	/* bmdma PRD addr 63:32 */
+
 	/* Host private flags (hp_flags) */
 	MV_HP_FLAG_MSI		= (1 << 0),
 	MV_HP_ERRATA_50XXB0	= (1 << 1),
@@ -547,6 +551,15 @@
 static void mv_process_crpb_entries(struct ata_port *ap,
 					struct mv_port_priv *pp);
 
+static unsigned long mv_mode_filter(struct ata_device *dev,
+				    unsigned long xfer_mask);
+static void mv_sff_irq_clear(struct ata_port *ap);
+static int mv_check_atapi_dma(struct ata_queued_cmd *qc);
+static void mv_bmdma_setup(struct ata_queued_cmd *qc);
+static void mv_bmdma_start(struct ata_queued_cmd *qc);
+static void mv_bmdma_stop(struct ata_queued_cmd *qc);
+static u8   mv_bmdma_status(struct ata_port *ap);
+
 /* .sg_tablesize is (MV_MAX_SG_CT / 2) in the structures below
  * because we have to allow room for worst case splitting of
  * PRDs for 64K boundaries in mv_fill_sg().
@@ -594,6 +607,14 @@
 	.pmp_softreset		= mv_softreset,
 	.softreset		= mv_softreset,
 	.error_handler		= mv_pmp_error_handler,
+
+	.sff_irq_clear		= mv_sff_irq_clear,
+	.check_atapi_dma	= mv_check_atapi_dma,
+	.bmdma_setup		= mv_bmdma_setup,
+	.bmdma_start		= mv_bmdma_start,
+	.bmdma_stop		= mv_bmdma_stop,
+	.bmdma_status		= mv_bmdma_status,
+	.mode_filter		= mv_mode_filter,
 };
 
 static struct ata_port_operations mv_iie_ops = {
@@ -1393,6 +1414,167 @@
 }
 
 /**
+ *	mv_mode_filter - Allow ATAPI DMA only on GenII chips.
+ *	@dev: device whose xfer modes are being configured.
+ *
+ *	Only the GenII hardware can use DMA with ATAPI drives.
+ */
+static unsigned long mv_mode_filter(struct ata_device *adev,
+				    unsigned long xfer_mask)
+{
+	if (adev->class == ATA_DEV_ATAPI) {
+		struct mv_host_priv *hpriv = adev->link->ap->host->private_data;
+		if (!IS_GEN_II(hpriv)) {
+			xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
+			ata_dev_printk(adev, KERN_INFO,
+				"ATAPI DMA not supported on this chipset\n");
+		}
+	}
+	return xfer_mask;
+}
+
+/**
+ *	mv_sff_irq_clear - Clear hardware interrupt after DMA.
+ *	@ap: Port associated with this ATA transaction.
+ *
+ *	We need this only for ATAPI bmdma transactions,
+ *	as otherwise we experience spurious interrupts
+ *	after libata-sff handles the bmdma interrupts.
+ */
+static void mv_sff_irq_clear(struct ata_port *ap)
+{
+	mv_clear_and_enable_port_irqs(ap, mv_ap_base(ap), ERR_IRQ);
+}
+
+/**
+ *	mv_check_atapi_dma - Filter ATAPI cmds which are unsuitable for DMA.
+ *	@qc: queued command to check for chipset/DMA compatibility.
+ *
+ *	The bmdma engines cannot handle speculative data sizes
+ *	(bytecount under/over flow).  So only allow DMA for
+ *	data transfer commands with known data sizes.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+static int mv_check_atapi_dma(struct ata_queued_cmd *qc)
+{
+	struct scsi_cmnd *scmd = qc->scsicmd;
+
+	if (scmd) {
+		switch (scmd->cmnd[0]) {
+		case READ_6:
+		case READ_10:
+		case READ_12:
+		case WRITE_6:
+		case WRITE_10:
+		case WRITE_12:
+		case GPCMD_READ_CD:
+		case GPCMD_SEND_DVD_STRUCTURE:
+		case GPCMD_SEND_CUE_SHEET:
+			return 0; /* DMA is safe */
+		}
+	}
+	return -EOPNOTSUPP; /* use PIO instead */
+}
+
+/**
+ *	mv_bmdma_setup - Set up BMDMA transaction
+ *	@qc: queued command to prepare DMA for.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+static void mv_bmdma_setup(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	void __iomem *port_mmio = mv_ap_base(ap);
+	struct mv_port_priv *pp = ap->private_data;
+
+	mv_fill_sg(qc);
+
+	/* clear all DMA cmd bits */
+	writel(0, port_mmio + BMDMA_CMD_OFS);
+
+	/* load PRD table addr. */
+	writel((pp->sg_tbl_dma[qc->tag] >> 16) >> 16,
+		port_mmio + BMDMA_PRD_HIGH_OFS);
+	writelfl(pp->sg_tbl_dma[qc->tag],
+		port_mmio + BMDMA_PRD_LOW_OFS);
+
+	/* issue r/w command */
+	ap->ops->sff_exec_command(ap, &qc->tf);
+}
+
+/**
+ *	mv_bmdma_start - Start a BMDMA transaction
+ *	@qc: queued command to start DMA on.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+static void mv_bmdma_start(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	void __iomem *port_mmio = mv_ap_base(ap);
+	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
+	u32 cmd = (rw ? 0 : ATA_DMA_WR) | ATA_DMA_START;
+
+	/* start host DMA transaction */
+	writelfl(cmd, port_mmio + BMDMA_CMD_OFS);
+}
+
+/**
+ *	mv_bmdma_stop - Stop BMDMA transfer
+ *	@qc: queued command to stop DMA on.
+ *
+ *	Clears the ATA_DMA_START flag in the bmdma control register
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+static void mv_bmdma_stop(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	void __iomem *port_mmio = mv_ap_base(ap);
+	u32 cmd;
+
+	/* clear start/stop bit */
+	cmd = readl(port_mmio + BMDMA_CMD_OFS);
+	cmd &= ~ATA_DMA_START;
+	writelfl(cmd, port_mmio + BMDMA_CMD_OFS);
+
+	/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
+	ata_sff_dma_pause(ap);
+}
+
+/**
+ *	mv_bmdma_status - Read BMDMA status
+ *	@ap: port for which to retrieve DMA status.
+ *
+ *	Read and return equivalent of the sff BMDMA status register.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+static u8 mv_bmdma_status(struct ata_port *ap)
+{
+	void __iomem *port_mmio = mv_ap_base(ap);
+	u32 reg, status;
+
+	/*
+	 * Other bits are valid only if ATA_DMA_ACTIVE==0,
+	 * and the ATA_DMA_INTR bit doesn't exist.
+	 */
+	reg = readl(port_mmio + BMDMA_STATUS_OFS);
+	if (reg & ATA_DMA_ACTIVE)
+		status = ATA_DMA_ACTIVE;
+	else
+		status = (reg & ATA_DMA_ERR) | ATA_DMA_INTR;
+	return status;
+}
+
+/**
  *      mv_qc_prep - Host specific command preparation.
  *      @qc: queued command to prepare
  *
