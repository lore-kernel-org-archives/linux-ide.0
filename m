From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH linux-2.6.13-rc3] Mod15Write quirk against v2.6.13
Date: Thu, 28 Jul 2005 23:12:42 +0900
Message-ID: <20050728141242.GA10010@htj.dyndns.org>
References: <1121894035.4885.15.camel@drevil.aslab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.200]:5161 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261468AbVG1OMt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jul 2005 10:12:49 -0400
Received: by rproxy.gmail.com with SMTP id r35so681682rna
        for <linux-ide@vger.kernel.org>; Thu, 28 Jul 2005 07:12:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1121894035.4885.15.camel@drevil.aslab.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Madore <Michael.Madore@aslab.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, albertcc@tw.ibm.com

On Wed, Jul 20, 2005 at 02:13:55PM -0700, Michael Madore wrote:
> Hi,
> 
> I have been successfully using your mod15write quirk patch with 2.6.12-
> rc3.  I recently applied the patch (with a minor reject) to 2.6.12.3.
> Reading seems to work fine, but writing to the disk results in the
> following output:
> 
> irq 169: nobody cared!
> 
> Call Trace: <IRQ> <ffffffff80161e15>{__report_bad_irq+53}
> <ffffffff80161eec>{note_interrupt+92}
>        <ffffffff80161730>{__do_IRQ+256} <ffffffff801116b8>{do_IRQ+72}
>        <ffffffff8010f057>{ret_from_intr+0}  <EOI>
> <ffffffff8010d390>{default_idle+0}
>        <ffffffff8010d3b2>{default_idle+34} <ffffffff8010d407>{cpu_idle
> +71}
>        <ffffffff80515094>{start_secondary+564} 
> handlers:
> [<ffffffff88035490>] (ata_interrupt+0x0/0x180 [libata])
> [<ffffffff88151440>] (snd_intel8x0_interrupt+0x0/0x240 [snd_intel8x0])
> Disabling IRQ #169
> 
> Shortly thereafter, there is a kernel oops and the machine has to be
> rebooted.  Do you have an updated driver for 2.6.12?  I assume something
> has changed in libata.
> 

 Hello, Michael, again.
 Hello, Jeff, Albert & ATA guys.

 This is reply message to Michael's private mail reporting patch apply
failure and (after hand-fixing it) malfunction.  I hope Michael
wouldn't mind adding recipients to this reply.

 sata_sil Mod15Write workaround was broken by the following commit by
Albert Lee.

Commit: 21b1ed74ee3667dcabcba92e486988ea9119a085
[PATCH] libata: Prevent the interrupt handler from completing a command twice

 This commit clears ATA_QCFLAG_ACTIVE in ata_qc_complete() and doesn't
handle IRQ if ATA_QCFLAG_ACTIVE is cleared on entry to interrupt
routine.  As m15w workaround executes single command multiple times,
the flag is cleared after the first chunk completion and the following
interrupt gets ignored resulting in "nobody cared" interrupt error.

 The following changes are made in m15w workaround to fix this.

 * Moved clearing of ATA_QCFLAG_ACTIVE before invoking ->complete_fn,
   so that ->complete_fn can mangle with the flag.  This doesn't affect
   any users.
 * Added setting ATA_QCFLAG_ACTIVE in m15w chunk completion function.

 One thing that bothers me is how Albert's commit and the original
ata_host_intr tell IRQ subsystem that an interrupt isn't ours when we
know that we have generated a spurious interrupt.  IMHO, we always
should enter ata_host_intr and always tell IRQ subsystem that it's our
interrupt if bmdma_status tells us so, regardless of ata status value.
The current code is likely to cause "nobody cared" error which can be
avoided.

 Also, Jeff, I know you're very busy, but what do you think about
taking m15w workaround into ata tree?  It's been around for a while
now and I haven't received any complaints (except for this one) yet.
The workaround is ugly but it surely helps and I'm willing to maintain
it.

 This patch is against v2.6.13-rc3 but also applies to v2.6.12 (with a
fuss).

 Thanks.


Signed-off-by: Tejun Heo <htejun@gmail.com>


diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -3087,8 +3087,8 @@ void ata_qc_complete(struct ata_queued_c
 		ata_sg_clean(qc);
 
 	/* call completion callback */
-	rc = qc->complete_fn(qc, drv_stat);
 	qc->flags &= ~ATA_QCFLAG_ACTIVE;
+	rc = qc->complete_fn(qc, drv_stat);
 
 	/* if callback indicates not to complete command (non-zero),
 	 * return immediately
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -71,9 +71,12 @@ enum {
 
 static int sil_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static void sil_dev_config(struct ata_port *ap, struct ata_device *dev);
+static void sil_qc_prep (struct ata_queued_cmd *qc);
+static void sil_eng_timeout (struct ata_port *ap);
 static u32 sil_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void sil_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static void sil_post_set_mode (struct ata_port *ap);
+static void sil_host_stop (struct ata_host_set *host_set);
 
 static struct pci_device_id sil_pci_tbl[] = {
 	{ 0x1095, 0x3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
@@ -152,16 +155,16 @@ static struct ata_port_operations sil_op
 	.bmdma_start            = ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
 	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
+	.qc_prep		= sil_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
-	.eng_timeout		= ata_eng_timeout,
+	.eng_timeout		= sil_eng_timeout,
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= sil_scr_read,
 	.scr_write		= sil_scr_write,
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
-	.host_stop		= ata_host_stop,
+	.host_stop		= sil_host_stop,
 };
 
 static struct ata_port_info sil_port_info[] = {
@@ -204,6 +207,53 @@ static const struct {
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
+ *			  should be set for ata_qc_prep() to work.  This flag
+ *			  handling is the hackiest part of this workaround.
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
+#define M15W_DEBUG
+struct sil_m15w_cxt {
+	u64			next_block;
+	struct scatterlist *	next_sg;
+	unsigned int		left;
+	unsigned int		cur_sg_ofs;
+	unsigned int		next_sg_ofs;
+	unsigned int		next_sg_len;
+	int			timedout;
+
+	struct scatterlist *	orig_sg;
+	unsigned int		orig_nelem;
+	unsigned long		orig_flags;
+	ata_qc_cb_t		orig_complete_fn;
+#ifdef M15W_DEBUG
+	struct scatterlist	sg_copy[LIBATA_MAX_PRD];
+#endif
+};
+
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("low-level driver for Silicon Image SATA controller");
 MODULE_LICENSE("GPL");
@@ -244,6 +294,226 @@ static void sil_post_set_mode (struct at
 	readl(addr);	/* flush */
 }
 
+static inline u64 sil_m15w_read_tf_block (struct ata_taskfile *tf)
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
+static inline void sil_m15w_rewrite_tf (struct ata_taskfile *tf,
+					u64 block, u16 nsect)
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
+	struct sil_m15w_cxt *cxt = qc->private_data;
+	struct scatterlist *sg;
+	unsigned int todo, res, nelem;
+
+	if (qc->sg != cxt->next_sg) {
+		sg_dma_address(qc->sg) -= cxt->cur_sg_ofs;
+		sg_dma_len(qc->sg) += cxt->cur_sg_ofs;
+		cxt->cur_sg_ofs = 0;
+	}
+	cxt->cur_sg_ofs += cxt->next_sg_ofs;
+
+	qc->sg = sg = cxt->next_sg;
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
+static inline void sil_m15w_restore_qc (struct ata_queued_cmd *qc)
+{
+	struct sil_m15w_cxt *cxt = qc->private_data;
+
+	DPRINTK("ENTER\n");
+
+	sg_dma_address(qc->sg) -= cxt->cur_sg_ofs;
+	sg_dma_len(qc->sg) += cxt->cur_sg_ofs;
+	if (cxt->next_sg_ofs)
+		sg_dma_len(cxt->next_sg) += cxt->next_sg_len;
+	qc->sg = cxt->orig_sg;
+	qc->n_elem = cxt->orig_nelem;
+	qc->flags |= cxt->orig_flags;
+	qc->complete_fn = cxt->orig_complete_fn;
+#ifdef M15W_DEBUG
+	{
+		int i, j;
+		for (i = 0; i < qc->n_elem; i++)
+			if (memcmp(&cxt->sg_copy[i], &qc->sg[i],
+				   sizeof(qc->sg[0])))
+				break;
+		if (i < qc->n_elem) {
+			printk(KERN_ERR "sil_m15w: sg mismatch\n");
+			printk(KERN_ERR "orig: ");
+			for (j = 0; j < qc->n_elem; j++)
+				printk("%s%08x:%04u ",
+				       i == j ? "*" : "",
+				       (u32)sg_dma_address(&cxt->sg_copy[j]),
+				       sg_dma_len(&cxt->sg_copy[j]));
+			printk("\n");
+			printk(KERN_ERR "used: ");
+			for (j = 0; j < qc->n_elem; j++)
+				printk("%s%08x:%04u ",
+				       i == j ? "*" : "",
+				       (u32)sg_dma_address(&qc->sg[j]),
+				       sg_dma_len(&qc->sg[j]));
+			printk("\n");
+		}
+	}
+#endif
+}
+
+static int sil_m15w_chunk_complete (struct ata_queued_cmd *qc, u8 drv_stat)
+{
+	struct sil_m15w_cxt *cxt = qc->private_data;
+
+	DPRINTK("ENTER\n");
+
+	/* This command is still active, turn ACTIVE back on */
+	qc->flags |= ATA_QCFLAG_ACTIVE;
+
+	if (unlikely(cxt->timedout))
+		drv_stat |= ATA_BUSY;	/* Any better error status? */
+
+	/* Complete the command immediately on error */
+	if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ))) {
+		sil_m15w_restore_qc(qc);
+		ata_qc_complete(qc, drv_stat);
+		return 1;
+	}
+
+	sil_m15w_next(qc);
+
+	qc->flags |= cxt->orig_flags;
+	ata_qc_prep(qc);
+	qc->flags &= ~ATA_QCFLAG_DMAMAP;
+
+	/* On last iteration, restore fields such that normal
+	 * completion path is run */
+	if (!cxt->left)
+		sil_m15w_restore_qc(qc);
+	sil_ops.qc_issue(qc);
+	return 1;
+}
+
+static void sil_qc_prep (struct ata_queued_cmd *qc)
+{
+	struct sil_m15w_cxt *cxt = qc->private_data;
+
+	if (unlikely(cxt && qc->tf.flags & ATA_TFLAG_WRITE && qc->nsect > 15)) {
+		BUG_ON(cxt->left);
+		if (qc->tf.protocol == ATA_PROT_DMA) {
+			/* Okay, begin mod15write workaround */
+			cxt->next_block = sil_m15w_read_tf_block(&qc->tf);
+			cxt->next_sg = qc->sg;
+			cxt->left = qc->nsect << 9;
+			cxt->cur_sg_ofs = 0;
+			cxt->next_sg_ofs = 0;
+			cxt->next_sg_len = sg_dma_len(qc->sg);
+			cxt->timedout = 0;
+
+			/* Save fields we're gonna mess with.  Read comments
+			 * above struct sil_m15w_cxt for more info. */
+			cxt->orig_sg = qc->sg;
+			cxt->orig_nelem = qc->n_elem;
+			cxt->orig_flags = qc->flags & ATA_QCFLAG_DMAMAP;
+			cxt->orig_complete_fn = qc->complete_fn;
+			qc->complete_fn = sil_m15w_chunk_complete;
+#ifdef M15W_DEBUG
+			{
+				int i;
+				for (i = 0; i < qc->n_elem; i++)
+					cxt->sg_copy[i] = qc->sg[i];
+			}
+#endif
+			DPRINTK("MOD15WRITE, block=%llu nsect=%u\n",
+				cxt->next_block, qc->nsect);
+			sil_m15w_next(qc);
+
+			ata_qc_prep(qc);
+			qc->flags &= ~ATA_QCFLAG_DMAMAP;
+			return;
+		} else
+			printk(KERN_WARNING "ata%u(%u): write request > 15 "
+			       "issued using non-DMA protocol.  Drive may "
+			       "lock up.\n", qc->ap->id, qc->dev->devno);
+	}
+
+	ata_qc_prep(qc);
+}
+
+static void sil_eng_timeout (struct ata_port *ap)
+{
+	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
+
+	if (qc && qc->private_data) {
+		struct sil_m15w_cxt *cxt = qc->private_data;
+		if (cxt->left)
+			cxt->timedout = 1;
+	}
+
+	ata_eng_timeout(ap);
+}
+
 static inline unsigned long sil_scr_addr(struct ata_port *ap, unsigned int sc_reg)
 {
 	unsigned long offset = ap->ioaddr.scr_addr;
@@ -278,6 +548,14 @@ static void sil_scr_write (struct ata_po
 		writel(val, mmio);
 }
 
+static void sil_host_stop (struct ata_host_set *host_set)
+{
+	/* Free mod15write context array. */
+	kfree(host_set->private_data);
+
+	ata_host_stop(host_set);
+}
+
 /**
  *	sil_dev_config - Apply device/host-specific errata fixups
  *	@ap: Port containing device to be examined
@@ -288,17 +566,12 @@ static void sil_scr_write (struct ata_po
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
@@ -306,6 +579,15 @@ static void sil_scr_write (struct ata_po
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
@@ -313,6 +595,7 @@ static void sil_dev_config(struct ata_po
 	unsigned char model_num[40];
 	const char *s;
 	unsigned int len;
+	int i;
 
 	ata_dev_id_string(dev->id, model_num, ATA_ID_PROD_OFS,
 			  sizeof(model_num));
@@ -330,15 +613,23 @@ static void sil_dev_config(struct ata_po
 			break;
 		}
 	
-	/* limit requests to 15 sectors */
+	/* Activate mod15write quirk workaround */
 	if (quirks & SIL_QUIRK_MOD15WRITE) {
+		struct sil_m15w_cxt *cxt;
+
 		printk(KERN_INFO "ata%u(%u): applying Seagate errata fix\n",
 		       ap->id, dev->devno);
-		ap->host->max_sectors = 15;
-		ap->host->hostt->max_sectors = 15;
-		dev->flags |= ATA_DFLAG_LOCK_SECTORS;
+
+		cxt = ap->host_set->private_data;
+		cxt += ap->port_no * ATA_MAX_QUEUE;
+		for (i = 0; i < ATA_MAX_QUEUE; i++)
+			ap->qcmd[i].private_data = cxt++;
+
 		return;
 	}
+	/* Clear qcmd->private_data if mod15write quirk isn't present */
+	for (i = 0; i < ATA_MAX_QUEUE; i++)
+		ap->qcmd[i].private_data = NULL;
 
 	/* limit to udma5 */
 	if (quirks & SIL_QUIRK_UDMA5MAX) {
@@ -352,7 +643,8 @@ static void sil_dev_config(struct ata_po
 static int sil_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
-	struct ata_probe_ent *probe_ent = NULL;
+	struct ata_probe_ent *probe_ent;
+	struct sil_m15w_cxt *m15w_cxt;
 	unsigned long base;
 	void *mmio_base;
 	int rc;
@@ -385,11 +677,17 @@ static int sil_init_one (struct pci_dev 
 	if (rc)
 		goto err_out_regions;
 
-	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
-	if (probe_ent == NULL) {
-		rc = -ENOMEM;
+	rc = -ENOMEM;
+
+	tmp = sizeof(m15w_cxt[0]) * ATA_MAX_PORTS * ATA_MAX_QUEUE;
+	m15w_cxt = kmalloc(tmp, GFP_KERNEL);
+	if (m15w_cxt == NULL)
 		goto err_out_regions;
-	}
+	memset(m15w_cxt, 0, tmp);
+
+	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
+	if (probe_ent == NULL)
+		goto err_out_free_m15w;
 
 	memset(probe_ent, 0, sizeof(*probe_ent));
 	INIT_LIST_HEAD(&probe_ent->node);
@@ -403,6 +701,7 @@ static int sil_init_one (struct pci_dev 
        	probe_ent->irq = pdev->irq;
        	probe_ent->irq_flags = SA_SHIRQ;
 	probe_ent->host_flags = sil_port_info[ent->driver_data].host_flags;
+	probe_ent->private_data = m15w_cxt;
 
 	mmio_base = ioremap(pci_resource_start(pdev, 5),
 		            pci_resource_len(pdev, 5));
@@ -479,6 +778,8 @@ static int sil_init_one (struct pci_dev 
 
 err_out_free_ent:
 	kfree(probe_ent);
+err_out_free_m15w:
+	kfree(m15w_cxt);
 err_out_regions:
 	pci_release_regions(pdev);
 err_out:

