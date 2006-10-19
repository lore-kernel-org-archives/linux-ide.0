From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/4] sata_sil: implement Mod15Write workaround by split request processing
Date: Thu, 19 Oct 2006 14:51:39 +0900
Message-ID: <11612370993859-git-send-email-htejun@gmail.com>
References: <1161237098656-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:48810 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030305AbWJSFvr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Oct 2006 01:51:47 -0400
Received: by nf-out-0910.google.com with SMTP id c2so923945nfe
        for <linux-ide@vger.kernel.org>; Wed, 18 Oct 2006 22:51:46 -0700 (PDT)
In-Reply-To: <1161237098656-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Instead of limiting max_sectors to 15 unconditionally, this patch
leaves max_sectors at the default value and process write requests
larger than 15 sectors by processing them in <= 15 sectors chunks.
This results in unhamplered read performance and better write
performance.

Split request processing is performed only for DMA write requests > 15
sectors.  dev->max_sectors is limited to 15 sectors when the device is
put into PIO mode.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/sata_sil.c |  307 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 294 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index f844a1f..37e186f 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -43,6 +43,7 @@ #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
 #include <scsi/scsi_host.h>
+#include <scsi/scsi_device.h>
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_sil"
@@ -106,6 +107,9 @@ enum {
 	 */
 	SIL_QUIRK_MOD15WRITE	= (1 << 0),
 	SIL_QUIRK_UDMA5MAX	= (1 << 1),
+
+	SIL_M15W_ENABLED	= (1 << 0),
+	SIL_M15W_ACTIVATED	= (1 << 1),
 };
 
 static int sil_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
@@ -113,12 +117,16 @@ #ifdef CONFIG_PM
 static int sil_pci_device_resume(struct pci_dev *pdev);
 #endif
 static void sil_dev_config(struct ata_port *ap, struct ata_device *dev);
+static void sil_qc_prep(struct ata_queued_cmd *qc);
 static u32 sil_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void sil_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static void sil_post_set_mode (struct ata_port *ap);
 static irqreturn_t sil_interrupt(int irq, void *dev_instance);
 static void sil_freeze(struct ata_port *ap);
 static void sil_thaw(struct ata_port *ap);
+static void sil_error_handler(struct ata_port *ap);
+static int sil_port_start(struct ata_port *ap);
+static void sil_port_stop(struct ata_port *ap);
 
 
 static const struct pci_device_id sil_pci_tbl[] = {
@@ -198,19 +206,19 @@ static const struct ata_port_operations 
 	.bmdma_start            = ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
 	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
+	.qc_prep		= sil_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_mmio_data_xfer,
 	.freeze			= sil_freeze,
 	.thaw			= sil_thaw,
-	.error_handler		= ata_bmdma_error_handler,
+	.error_handler		= sil_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.irq_handler		= sil_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= sil_scr_read,
 	.scr_write		= sil_scr_write,
-	.port_start		= ata_port_start,
-	.port_stop		= ata_port_stop,
+	.port_start		= sil_port_start,
+	.port_stop		= sil_port_stop,
 	.host_stop		= ata_pci_host_stop,
 };
 
@@ -275,6 +283,48 @@ static const struct {
 	/* ... port 3 */
 };
 
+/*
+ * Context to loop over write requests > 15 sectors for Mod15Write bug.
+ *
+ * The following libata layer fields are saved at the beginning and
+ * mangled as necessary.
+ *
+ * qc->sg		: To fool ata_fill_sg().
+ * qc->n_elem		: ditto.
+ * qc->flags		: Except for the last iteration, ATA_QCFLAG_DMAMAP
+ *			  should be off on entering ata_interrupt() such
+ *			  that ata_qc_complete() doesn't call ata_sg_clean()
+ *			  before sil_m15w_chunk_complete(), but the flags
+ *			  should be set for ata_qc_prep() to work.
+ * qc->complete_fn	: Overrided to sil_m15w_chunk_complete().
+ *
+ * The following cxt fields are used to iterate over write requests.
+ *
+ * next_block		: The starting block of the next chunk.
+ * next_sg		: The first sg entry of the next chunk.
+ * left			: Total bytes left.
+ * cur_sg_ofs		: Number of processed bytes in the first sg entry
+ *			  of this chunk.
+ * next_sg_ofs		: Number of bytes to be processed in the last sg
+ *			  entry of this chunk.
+ * next_sg_len		: Number of bytes to be processed in the first sg
+ *			  entry of the next chunk.
+ */
+struct sil_m15w_cxt {
+	unsigned int		flags;
+	u64			next_block;
+	struct scatterlist *	next_sg;
+	unsigned int		left;
+	unsigned int		cur_sg_ofs;
+	unsigned int		next_sg_ofs;
+	unsigned int		next_sg_len;
+
+	struct scatterlist *	orig_sg;
+	unsigned int		orig_nelem;
+	unsigned long		orig_flags;
+	ata_qc_cb_t		orig_complete_fn;
+};
+
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("low-level driver for Silicon Image SATA controller");
 MODULE_LICENSE("GPL");
@@ -295,6 +345,7 @@ static unsigned char sil_get_device_cach
 
 static void sil_post_set_mode (struct ata_port *ap)
 {
+	struct sil_m15w_cxt *m15w_cxt = ap->private_data;
 	struct ata_host *host = ap->host;
 	struct ata_device *dev;
 	void __iomem *addr = host->mmio_base + sil_port[ap->port_no].xfer_mode;
@@ -318,6 +369,193 @@ static void sil_post_set_mode (struct at
 	tmp |= (dev_mode[1] << 4);
 	writel(tmp, addr);
 	readl(addr);	/* flush */
+
+	if (m15w_cxt->flags & SIL_M15W_ENABLED) {
+		struct ata_device *dev = ap->device;
+		struct scsi_device *sdev = dev->sdev;
+
+		if (!(dev->flags & ATA_DFLAG_PIO))
+			m15w_cxt->flags |= SIL_M15W_ACTIVATED;
+		else
+			dev->max_sectors = 15;
+
+		if (sdev)
+			blk_queue_max_sectors(sdev->request_queue,
+					      dev->max_sectors);
+	}
+}
+
+static inline u64 sil_m15w_read_tf_block(struct ata_taskfile *tf)
+{
+	u64 block = 0;
+
+	block |= (u64)tf->lbal;
+	block |= (u64)tf->lbam << 8;
+	block |= (u64)tf->lbah << 16;
+
+	if (tf->flags & ATA_TFLAG_LBA48) {
+		block |= (u64)tf->hob_lbal << 24;
+		block |= (u64)tf->hob_lbam << 32;
+		block |= (u64)tf->hob_lbah << 40;
+	} else
+		block |= (u64)(tf->device & 0xf) << 24;
+
+	return block;
+}
+
+static inline void sil_m15w_rewrite_tf(struct ata_taskfile *tf,
+				       u64 block, u16 nsect)
+{
+	tf->nsect = nsect & 0xff;
+	tf->lbal = block & 0xff;
+	tf->lbam = (block >> 8) & 0xff;
+	tf->lbah = (block >> 16) & 0xff;
+
+	if (tf->flags & ATA_TFLAG_LBA48) {
+		tf->hob_nsect = (nsect >> 8) & 0xff;
+		tf->hob_lbal = (block >> 24) & 0xff;
+		tf->hob_lbam = (block >> 32) & 0xff;
+		tf->hob_lbah = (block >> 40) & 0xff;
+	} else {
+		tf->device &= ~0xf;
+		tf->device |= (block >> 24) & 0xf;
+	}
+}
+
+static void sil_m15w_next(struct ata_queued_cmd *qc)
+{
+	struct sil_m15w_cxt *cxt = qc->ap->private_data;
+	struct scatterlist *sg;
+	unsigned int todo, res, nelem;
+
+	if (qc->__sg != cxt->next_sg) {
+		sg_dma_address(qc->__sg) -= cxt->cur_sg_ofs;
+		sg_dma_len(qc->__sg) += cxt->cur_sg_ofs;
+		cxt->cur_sg_ofs = 0;
+	}
+	cxt->cur_sg_ofs += cxt->next_sg_ofs;
+
+	qc->__sg = sg = cxt->next_sg;
+	sg_dma_address(sg) += cxt->next_sg_ofs;
+	sg_dma_len(sg) = cxt->next_sg_len;
+
+	res = todo = min_t(unsigned int, cxt->left, 15 << 9);
+
+	nelem = 0;
+	while (sg_dma_len(sg) <= res) {
+		res -= sg_dma_len(sg);
+		sg++;
+		nelem++;
+	}
+
+	if (todo < cxt->left) {
+		cxt->next_sg = sg;
+		cxt->next_sg_ofs = res;
+		cxt->next_sg_len = sg_dma_len(sg) - res;
+		if (res) {
+			nelem++;
+			sg_dma_len(sg) = res;
+		}
+	} else {
+		cxt->next_sg = NULL;
+		cxt->next_sg_ofs = 0;
+		cxt->next_sg_len = 0;
+	}
+
+	DPRINTK("block=%llu nelem=%u todo=%u left=%u\n",
+		cxt->next_block, nelem, todo, cxt->left);
+
+	qc->n_elem = nelem;
+	sil_m15w_rewrite_tf(&qc->tf, cxt->next_block, todo >> 9);
+	cxt->left -= todo;
+	cxt->next_block += todo >> 9;
+}
+
+static inline void sil_m15w_restore_qc(struct ata_queued_cmd *qc)
+{
+	struct sil_m15w_cxt *cxt = qc->ap->private_data;
+
+	DPRINTK("ENTER\n");
+
+	sg_dma_address(qc->__sg) -= cxt->cur_sg_ofs;
+	sg_dma_len(qc->__sg) += cxt->cur_sg_ofs;
+	if (cxt->next_sg_ofs)
+		sg_dma_len(cxt->next_sg) += cxt->next_sg_len;
+	qc->__sg = cxt->orig_sg;
+	qc->n_elem = cxt->orig_nelem;
+	qc->flags |= cxt->orig_flags;
+	qc->complete_fn = cxt->orig_complete_fn;
+}
+
+static void sil_m15w_chunk_complete(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct sil_m15w_cxt *cxt = ap->private_data;
+
+	DPRINTK("ENTER\n");
+
+	/* sil_error_handler() restores qc before EH and this function
+	 * must never be invoked for a failed qc.
+	 */
+	BUG_ON(qc->err_mask);
+
+	/* this command is still active, turn ACTIVE back on */
+	qc->flags |= ATA_QCFLAG_ACTIVE;
+	ap->active_tag = qc->tag;
+	ap->qc_active |= 1 << qc->tag;
+
+	/* iterate to the next chunk and fill sg */
+	sil_m15w_next(qc);
+	qc->flags |= cxt->orig_flags;
+	ata_qc_prep(qc);
+	qc->flags &= ~ATA_QCFLAG_DMAMAP;
+
+	/* If this is the last iteration, restore fields such that
+	 * normal completion path is run on chunk completion.
+	 */
+	if (!cxt->left)
+		sil_m15w_restore_qc(qc);
+
+	/* issue the next chunk */
+	sil_ops.qc_issue(qc);
+}
+
+static void sil_qc_prep(struct ata_queued_cmd *qc)
+{
+	struct sil_m15w_cxt *m15w_cxt = qc->ap->private_data;
+
+	if (unlikely((m15w_cxt->flags & SIL_M15W_ACTIVATED) &&
+		     (qc->tf.flags & ATA_TFLAG_WRITE) && qc->nsect > 15)) {
+		BUG_ON(m15w_cxt->left || qc->tf.protocol != ATA_PROT_DMA);
+
+		/* okay, begin mod15write workaround */
+		m15w_cxt->next_block = sil_m15w_read_tf_block(&qc->tf);
+		m15w_cxt->next_sg = qc->__sg;
+		m15w_cxt->left = qc->nsect << 9;
+		m15w_cxt->cur_sg_ofs = 0;
+		m15w_cxt->next_sg_ofs = 0;
+		m15w_cxt->next_sg_len = sg_dma_len(qc->__sg);
+
+		/* Save fields we're gonna mess with.  Read comments
+		 * above struct sil_m15w_cxt for more info.
+		 */
+		m15w_cxt->orig_sg = qc->__sg;
+		m15w_cxt->orig_nelem = qc->n_elem;
+		m15w_cxt->orig_flags = qc->flags & ATA_QCFLAG_DMAMAP;
+		m15w_cxt->orig_complete_fn = qc->complete_fn;
+		qc->complete_fn = sil_m15w_chunk_complete;
+
+		DPRINTK("MOD15WRITE, block=%llu nsect=%u\n",
+			m15w_cxt->next_block, qc->nsect);
+
+		sil_m15w_next(qc);
+
+		ata_qc_prep(qc);
+		qc->flags &= ~ATA_QCFLAG_DMAMAP;
+		return;
+	}
+
+	ata_qc_prep(qc);
 }
 
 static inline unsigned long sil_scr_addr(struct ata_port *ap, unsigned int sc_reg)
@@ -503,6 +741,23 @@ static void sil_thaw(struct ata_port *ap
 	writel(tmp, mmio_base + SIL_SYSCFG);
 }
 
+static void sil_error_handler(struct ata_port *ap)
+{
+	struct sil_m15w_cxt *m15w_cxt = ap->private_data;
+	struct ata_queued_cmd *qc = __ata_qc_from_tag(ap, ap->active_tag);
+
+	if (m15w_cxt->left) {
+		BUG_ON(!qc);
+		ata_port_printk(ap, KERN_INFO, "exception while processing "
+				"m15w chunks, left=%u, restoring qc\n",
+				m15w_cxt->left);
+		sil_m15w_restore_qc(qc);
+		m15w_cxt->left = 0;
+	}
+
+	ata_bmdma_error_handler(ap);
+}
+
 /**
  *	sil_dev_config - Apply device/host-specific errata fixups
  *	@ap: Port containing device to be examined
@@ -513,17 +768,12 @@ static void sil_thaw(struct ata_port *ap
  *	We apply two errata fixups which are specific to Silicon Image,
  *	a Seagate and a Maxtor fixup.
  *
- *	For certain Seagate devices, we must limit the maximum sectors
- *	to under 8K.
+ *	For certain Seagate devices, we cannot issue write requests
+ *	larger than 15 sectors.
  *
  *	For certain Maxtor devices, we must not program the drive
  *	beyond udma5.
  *
- *	Both fixups are unfairly pessimistic.  As soon as I get more
- *	information on these errata, I will create a more exhaustive
- *	list, and apply the fixups to only the specific
- *	devices/hosts/firmwares that need it.
- *
  *	20040111 - Seagate drives affected by the Mod15Write bug are blacklisted
  *	The Maxtor quirk is in the blacklist, but I'm keeping the original
  *	pessimistic fix for the following reasons...
@@ -531,9 +781,19 @@ static void sil_thaw(struct ata_port *ap
  *	Windows	driver, maybe only one is affected.  More info would be greatly
  *	appreciated.
  *	- But then again UDMA5 is hardly anything to complain about
+ *
+ *	20050316 Tejun Heo - Proper Mod15Write workaround implemented.
+ *	sata_sil doesn't report affected Seagate drives as having max
+ *	sectors of 15 anymore, but handle write requests larger than
+ *	15 sectors by looping over it inside this driver proper.  This
+ *	is messy but it's better to isolate this kind of peculiar bug
+ *	handling inside individual drivers than tainting libata layer.
+ *	This workaround results in unhampered read performance and
+ *	much better write performance.
  */
 static void sil_dev_config(struct ata_port *ap, struct ata_device *dev)
 {
+	struct sil_m15w_cxt *m15w_cxt = ap->private_data;
 	int print_info = ap->eh_context.i.flags & ATA_EHI_PRINTINFO;
 	unsigned int n, quirks = 0;
 	unsigned char model_num[41];
@@ -546,14 +806,15 @@ static void sil_dev_config(struct ata_po
 			break;
 		}
 
-	/* limit requests to 15 sectors */
+	/* activate mod15write quirk workaround */
+	m15w_cxt->flags = 0;
 	if (slow_down ||
 	    ((ap->flags & SIL_FLAG_MOD15WRITE) &&
 	     (quirks & SIL_QUIRK_MOD15WRITE))) {
 		if (print_info)
 			ata_dev_printk(dev, KERN_INFO, "applying Seagate "
 				       "errata fix (mod15write workaround)\n");
-		dev->max_sectors = 15;
+		m15w_cxt->flags |= SIL_M15W_ENABLED;
 		return;
 	}
 
@@ -613,6 +874,26 @@ static void sil_init_controller(struct p
 	}
 }
 
+static int sil_port_start(struct ata_port *ap)
+{
+	struct sil_m15w_cxt *m15w_cxt;
+
+	m15w_cxt = kzalloc(sizeof(m15w_cxt[0]), GFP_KERNEL);
+	if (!m15w_cxt)
+		return -ENOMEM;
+
+	ap->private_data = m15w_cxt;
+
+	return ata_port_start(ap);
+}
+
+static void sil_port_stop(struct ata_port *ap)
+{
+	kfree(ap->private_data);
+
+	ata_port_stop(ap);
+}
+
 static int sil_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
-- 
1.4.2.3


