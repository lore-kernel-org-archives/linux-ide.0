From: Jeff Garzik <jgarzik@pobox.com>
Subject: [BK PATCHES] 2.6.x libata fixes and updates
Date: Sun, 4 Jul 2004 11:10:22 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040704151022.GA24873@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([216.162.42.101]:29835 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S265719AbUGDPLY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Jul 2004 11:11:24 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org


There are some more core changes coming, but I wanted to push this out
since it appears to address a problem a couple lkml users were seeing.

Tested on ich5, silicon image, promise and via.

Please do a

	bk pull bk://gkernel.bkbits.net/libata-2.6

This will update the following files:

 drivers/scsi/ata_piix.c     |    6 +
 drivers/scsi/libata-core.c  |  134 +++++++++++++++++++++++---------------------
 drivers/scsi/libata-scsi.c  |   29 +++++++++
 drivers/scsi/sata_nv.c      |    2 
 drivers/scsi/sata_promise.c |   49 +++++++++++-----
 drivers/scsi/sata_sil.c     |    3 
 drivers/scsi/sata_sis.c     |    2 
 drivers/scsi/sata_svw.c     |    2 
 drivers/scsi/sata_sx4.c     |   15 ++++
 drivers/scsi/sata_via.c     |    3 
 drivers/scsi/sata_vsc.c     |    2 
 include/linux/ata.h         |   10 ++-
 include/linux/libata.h      |   31 ++++++++--
 13 files changed, 206 insertions(+), 82 deletions(-)

through these ChangeSets:

<jgarzik@pobox.com> (04/07/04 1.1792)
   [libata sata_promise] update driver to use new ->qc_issue hook
   
   The ->qc_issue hook was designed to allow drivers to override some
   or all of the actual delivery of the taskfile to hardware.
   
   In the case of Promise, the hardware has its own packet format when doing
   read/write DMA commands, but uses traditional ATA taskfile registers
   for other types of commands.

<jgarzik@pobox.com> (04/07/04 1.1791)
   [libata] create, and use aga_sg_init[_one] helpers
   
   Move more SCSI-specific code out of libata core.

<jgarzik@pobox.com> (04/07/04 1.1790)
   [libata] split ATA_QCFLAG_SG into ATA_QCFLAG_{SG,SINGLE}
   
   In part of the effort to remove SCSI specifics from the libata
   internals, remove references to cmd->use_sg.  cmd->use_sg
   becomes ATA_QCFLAG_SG, and !cmd->use_sg becomes ATA_QCFLAG_SINGLE.
   
   Convenience constant ATA_QCFLAG_DMAMAP is created when the programmer
   wishes to refer collectively to ATA_QCFLAG_{SG,SINGLE}.

<jgarzik@pobox.com> (04/07/03 1.1789)
   [ata] add ata_ok() inlined helper, and ATA_{DRDY,DF} bit to linux/ata.h

<jgarzik@pobox.com> (04/07/03 1.1788)
   [libata] create, and use, ->irq_clear hook
   
   This is more conservative in general, and so applies to multiple
   controllers.  Specifically it attempts to address irq-related issues
   on the Intel ICH5/6 hardware.  On Intel ICH5/6, the BMDMA 'interrupt'
   status bit will be set even on non-DMA commands, which software
   (and I) did not expect.
   
   This change clears pending interrupts once upon initialization,
   and then each time ata_irq_on() is called.

<jfbeam@bluetronic.net> (04/07/03 1.1787)
   [libata sata_sil] add drive to mod15write quirk list

<jgarzik@pobox.com> (04/07/03 1.1786)
   [libata] add ata_queued_cmd completion hook

<jgarzik@pobox.com> (04/07/03 1.1785)
   [libata] add ->qc_issue hook
   
   This hook is used when an ATA controller wishes to use
   hardware-specific methods of taskfile delivery, rather
   than the standard method of bitbanging the ATA shadow
   registers.

diff -Nru a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c	2004-07-04 10:48:31 -04:00
+++ b/drivers/scsi/ata_piix.c	2004-07-04 10:48:31 -04:00
@@ -138,9 +138,12 @@
 	.bmdma_setup		= ata_bmdma_setup_pio,
 	.bmdma_start		= ata_bmdma_start_pio,
 	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
+
 	.eng_timeout		= ata_eng_timeout,
 
 	.irq_handler		= ata_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
@@ -161,9 +164,12 @@
 	.bmdma_setup		= ata_bmdma_setup_pio,
 	.bmdma_start		= ata_bmdma_start_pio,
 	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
+
 	.eng_timeout		= ata_eng_timeout,
 
 	.irq_handler		= ata_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2004-07-04 10:48:31 -04:00
+++ b/drivers/scsi/libata-core.c	2004-07-04 10:48:31 -04:00
@@ -55,7 +55,6 @@
 static void ata_dev_set_pio(struct ata_port *ap, unsigned int device);
 static void ata_dev_set_udma(struct ata_port *ap, unsigned int device);
 static void ata_set_mode(struct ata_port *ap);
-static int ata_qc_issue_prot(struct ata_queued_cmd *qc);
 
 static unsigned int ata_unique_id = 1;
 static struct workqueue_struct *ata_wq;
@@ -1751,26 +1750,24 @@
 static void ata_sg_clean(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	struct scsi_cmnd *cmd = qc->scsicmd;
 	struct scatterlist *sg = qc->sg;
-	int dir = scsi_to_pci_dma_dir(cmd->sc_data_direction);
+	int dir = qc->pci_dma_dir;
 
-	assert(dir == SCSI_DATA_READ || dir == SCSI_DATA_WRITE);
-	assert(qc->flags & ATA_QCFLAG_SG);
+	assert(qc->flags & ATA_QCFLAG_DMAMAP);
 	assert(sg != NULL);
 
-	if (!cmd->use_sg)
+	if (qc->flags & ATA_QCFLAG_SINGLE)
 		assert(qc->n_elem == 1);
 
 	DPRINTK("unmapping %u sg elements\n", qc->n_elem);
 
-	if (cmd->use_sg)
+	if (qc->flags & ATA_QCFLAG_SG)
 		pci_unmap_sg(ap->host_set->pdev, sg, qc->n_elem, dir);
 	else
 		pci_unmap_single(ap->host_set->pdev, sg_dma_address(&sg[0]),
 				 sg_dma_len(&sg[0]), dir);
 
-	qc->flags &= ~ATA_QCFLAG_SG;
+	qc->flags &= ~ATA_QCFLAG_DMAMAP;
 	qc->sg = NULL;
 }
 
@@ -1831,12 +1828,39 @@
  */
 void ata_qc_prep(struct ata_queued_cmd *qc)
 {
-	if (!(qc->flags & ATA_QCFLAG_SG))
+	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
 		return;
 
 	ata_fill_sg(qc);
 }
 
+void ata_sg_init_one(struct ata_queued_cmd *qc, void *buf, unsigned int buflen)
+{
+	struct scatterlist *sg;
+
+	qc->flags |= ATA_QCFLAG_SINGLE;
+
+	memset(&qc->sgent, 0, sizeof(qc->sgent));
+	qc->sg = &qc->sgent;
+	qc->n_elem = 1;
+	qc->buf_virt = buf;
+
+	sg = qc->sg;
+	sg->page = virt_to_page(buf);
+	sg->offset = (unsigned long) buf & ~PAGE_MASK;
+	sg_dma_len(sg) = buflen;
+
+	WARN_ON(buflen > PAGE_SIZE);
+}
+
+void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
+		 unsigned int n_elem)
+{
+	qc->flags |= ATA_QCFLAG_SG;
+	qc->sg = sg;
+	qc->n_elem = n_elem;
+}
+
 /**
  *	ata_sg_setup_one -
  *	@qc:
@@ -1851,26 +1875,18 @@
 static int ata_sg_setup_one(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	struct scsi_cmnd *cmd = qc->scsicmd;
-	int dir = scsi_to_pci_dma_dir(cmd->sc_data_direction);
+	int dir = qc->pci_dma_dir;
 	struct scatterlist *sg = qc->sg;
 	dma_addr_t dma_address;
 
-	assert(sg == &qc->sgent);
-	assert(qc->n_elem == 1);
-
-	sg->page = virt_to_page(cmd->request_buffer);
-	sg->offset = (unsigned long) cmd->request_buffer & ~PAGE_MASK;
-	sg_dma_len(sg) = cmd->request_bufflen;
-
-	dma_address = pci_map_single(ap->host_set->pdev, cmd->request_buffer,
-				     cmd->request_bufflen, dir);
+	dma_address = pci_map_single(ap->host_set->pdev, qc->buf_virt,
+				     sg_dma_len(sg), dir);
 	if (pci_dma_mapping_error(dma_address))
 		return -1;
 
 	sg_dma_address(sg) = dma_address;
 
-	DPRINTK("mapped buffer of %d bytes for %s\n", cmd->request_bufflen,
+	DPRINTK("mapped buffer of %d bytes for %s\n", sg_dma_len(sg),
 		qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
 
 	return 0;
@@ -1890,16 +1906,14 @@
 static int ata_sg_setup(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	struct scsi_cmnd *cmd = qc->scsicmd;
-	struct scatterlist *sg;
+	struct scatterlist *sg = qc->sg;
 	int n_elem, dir;
 
-	VPRINTK("ENTER, ata%u, use_sg %d\n", ap->id, cmd->use_sg);
-	assert(cmd->use_sg > 0);
+	VPRINTK("ENTER, ata%u\n", ap->id);
+	assert(qc->flags & ATA_QCFLAG_SG);
 
-	sg = (struct scatterlist *)cmd->request_buffer;
-	dir = scsi_to_pci_dma_dir(cmd->sc_data_direction);
-	n_elem = pci_map_sg(ap->host_set->pdev, sg, cmd->use_sg, dir);
+	dir = qc->pci_dma_dir;
+	n_elem = pci_map_sg(ap->host_set->pdev, sg, qc->n_elem, dir);
 	if (n_elem < 1)
 		return -1;
 
@@ -2015,7 +2029,6 @@
 {
 	struct ata_queued_cmd *qc;
 	struct scatterlist *sg;
-	struct scsi_cmnd *cmd;
 	unsigned char *buf;
 	u8 status;
 
@@ -2047,7 +2060,6 @@
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	assert(qc != NULL);
 
-	cmd = qc->scsicmd;
 	sg = qc->sg;
 
 	if (qc->cursect == (qc->nsect - 1))
@@ -2059,7 +2071,7 @@
 	qc->cursect++;
 	qc->cursg_ofs++;
 
-	if (cmd->use_sg)
+	if (qc->flags & ATA_QCFLAG_SG)
 		if ((qc->cursg_ofs * ATA_SECT_SIZE) == sg_dma_len(&sg[qc->cursg])) {
 			qc->cursg++;
 			qc->cursg_ofs = 0;
@@ -2294,27 +2306,23 @@
 void ata_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
 {
 	struct ata_port *ap = qc->ap;
-	struct scsi_cmnd *cmd = qc->scsicmd;
 	unsigned int tag, do_clear = 0;
+	int rc;
 
 	assert(qc != NULL);	/* ata_qc_from_tag _might_ return NULL */
 	assert(qc->flags & ATA_QCFLAG_ACTIVE);
 
-	if (likely(qc->flags & ATA_QCFLAG_SG))
+	if (likely(qc->flags & ATA_QCFLAG_DMAMAP))
 		ata_sg_clean(qc);
 
-	if (cmd) {
-		if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ))) {
-			if (is_atapi_taskfile(&qc->tf))
-				cmd->result = SAM_STAT_CHECK_CONDITION;
-			else
-				ata_to_sense_error(qc);
-		} else {
-			cmd->result = SAM_STAT_GOOD;
-		}
+	/* call completion callback */
+	rc = qc->complete_fn(qc, drv_stat);
 
-		qc->scsidone(cmd);
-	}
+	/* if callback indicates not to complete command (non-zero),
+	 * return immediately
+	 */
+	if (rc != 0)
+		return;
 
 	qc->flags = 0;
 	tag = qc->tag;
@@ -2351,17 +2359,13 @@
 int ata_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	struct scsi_cmnd *cmd = qc->scsicmd;
 
 	if (qc->flags & ATA_QCFLAG_SG) {
-		/* set up SG table */
-		if (cmd->use_sg) {
-			if (ata_sg_setup(qc))
-				goto err_out;
-		} else {
-			if (ata_sg_setup_one(qc))
-				goto err_out;
-		}
+		if (ata_sg_setup(qc))
+			goto err_out;
+	} else if (qc->flags & ATA_QCFLAG_SINGLE) {
+		if (ata_sg_setup_one(qc))
+			goto err_out;
 	}
 
 	ap->ops->qc_prep(qc);
@@ -2369,7 +2373,7 @@
 	qc->ap->active_tag = qc->tag;
 	qc->flags |= ATA_QCFLAG_ACTIVE;
 
-	return ata_qc_issue_prot(qc);
+	return ap->ops->qc_issue(qc);
 
 err_out:
 	return -1;
@@ -2391,7 +2395,7 @@
  *	Zero on success, negative on error.
  */
 
-static int ata_qc_issue_prot(struct ata_queued_cmd *qc)
+int ata_qc_issue_prot(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 
@@ -2542,6 +2546,11 @@
 	     ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 }
 
+void ata_bmdma_irq_clear(struct ata_port *ap)
+{
+	ata_bmdma_ack_irq(ap);
+}
+
 /**
  *	ata_host_intr - Handle host interrupt for given (port, task)
  *	@ap: Port on which interrupt arrived (possibly...)
@@ -2884,6 +2893,7 @@
 	host_set->irq = ent->irq;
 	host_set->mmio_base = ent->mmio_base;
 	host_set->private_data = ent->private_data;
+	host_set->ops = ent->port_ops;
 
 	/* register each port bound to this device */
 	for (i = 0; i < ent->n_ports; i++) {
@@ -2906,6 +2916,8 @@
 	       		ap->ioaddr.bmdma_addr,
 	       		ent->irq);
 
+		ata_chk_status(ap);
+		host_set->ops->irq_clear(ap);
 		count++;
 	}
 
@@ -2914,10 +2926,6 @@
 		return 0;
 	}
 
-	/* TODO: ack irq here, to ensure it won't scream
-	 * when we enable it?
-	 */
-
 	/* obtain irq, that is shared between channels */
 	if (request_irq(ent->irq, ent->port_ops->irq_handler, ent->irq_flags,
 			DRV_NAME, host_set))
@@ -3243,8 +3251,8 @@
 	free_irq(host_set->irq, host_set);
 	if (host_set->mmio_base)
 		iounmap(host_set->mmio_base);
-	if (host_set->ports[0]->ops->host_stop)
-		host_set->ports[0]->ops->host_stop(host_set);
+	if (host_set->ops->host_stop)
+		host_set->ops->host_stop(host_set);
 
 	for (i = 0; i < host_set->n_ports; i++) {
 		ap = host_set->ports[i];
@@ -3347,7 +3355,10 @@
 EXPORT_SYMBOL_GPL(ata_std_bios_param);
 EXPORT_SYMBOL_GPL(ata_std_ports);
 EXPORT_SYMBOL_GPL(ata_device_add);
+EXPORT_SYMBOL_GPL(ata_sg_init);
+EXPORT_SYMBOL_GPL(ata_sg_init_one);
 EXPORT_SYMBOL_GPL(ata_qc_complete);
+EXPORT_SYMBOL_GPL(ata_qc_issue_prot);
 EXPORT_SYMBOL_GPL(ata_eng_timeout);
 EXPORT_SYMBOL_GPL(ata_tf_load_pio);
 EXPORT_SYMBOL_GPL(ata_tf_load_mmio);
@@ -3367,6 +3378,7 @@
 EXPORT_SYMBOL_GPL(ata_bmdma_start_pio);
 EXPORT_SYMBOL_GPL(ata_bmdma_setup_mmio);
 EXPORT_SYMBOL_GPL(ata_bmdma_start_mmio);
+EXPORT_SYMBOL_GPL(ata_bmdma_irq_clear);
 EXPORT_SYMBOL_GPL(ata_port_probe);
 EXPORT_SYMBOL_GPL(sata_phy_reset);
 EXPORT_SYMBOL_GPL(ata_bus_reset);
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	2004-07-04 10:48:31 -04:00
+++ b/drivers/scsi/libata-scsi.c	2004-07-04 10:48:31 -04:00
@@ -335,6 +335,24 @@
 	return 1;
 }
 
+static int ata_scsi_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
+{
+	struct scsi_cmnd *cmd = qc->scsicmd;
+
+	if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ))) {
+		if (is_atapi_taskfile(&qc->tf))
+			cmd->result = SAM_STAT_CHECK_CONDITION;
+		else
+			ata_to_sense_error(qc);
+	} else {
+		cmd->result = SAM_STAT_GOOD;
+	}
+
+	qc->scsidone(cmd);
+
+	return 0;
+}
+
 /**
  *	ata_scsi_translate - Translate then issue SCSI command to ATA device
  *	@ap: ATA port to which the command is addressed
@@ -368,6 +386,7 @@
 	if (!qc)
 		return;
 
+	/* data is present; dma-map it */
 	if (cmd->sc_data_direction == SCSI_DATA_READ ||
 	    cmd->sc_data_direction == SCSI_DATA_WRITE) {
 		if (unlikely(cmd->request_bufflen < 1)) {
@@ -376,8 +395,16 @@
 			goto err_out;
 		}
 
-		qc->flags |= ATA_QCFLAG_SG; /* data is present; dma-map it */
+		if (cmd->use_sg)
+			ata_sg_init(qc, cmd->request_buffer, cmd->use_sg);
+		else
+			ata_sg_init_one(qc, cmd->request_buffer,
+					cmd->request_bufflen);
+
+		qc->pci_dma_dir = scsi_to_pci_dma_dir(cmd->sc_data_direction);
 	}
+
+	qc->complete_fn = ata_scsi_qc_complete;
 
 	if (xlat_func(qc, scsicmd))
 		goto err_out;
diff -Nru a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c	2004-07-04 10:48:31 -04:00
+++ b/drivers/scsi/sata_nv.c	2004-07-04 10:48:31 -04:00
@@ -139,8 +139,10 @@
 	.bmdma_setup		= ata_bmdma_setup_pio,
 	.bmdma_start		= ata_bmdma_start_pio,
 	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= ata_eng_timeout,
 	.irq_handler		= nv_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
 	.port_start		= ata_port_start,
diff -Nru a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c	2004-07-04 10:48:31 -04:00
+++ b/drivers/scsi/sata_promise.c	2004-07-04 10:48:31 -04:00
@@ -74,7 +74,6 @@
 static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void pdc_sata_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static int pdc_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
-static void pdc_dma_setup(struct ata_queued_cmd *qc);
 static void pdc_dma_start(struct ata_queued_cmd *qc);
 static irqreturn_t pdc_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 static void pdc_eng_timeout(struct ata_port *ap);
@@ -86,6 +85,8 @@
 static void pdc_exec_command_mmio(struct ata_port *ap, struct ata_taskfile *tf);
 static inline void pdc_dma_complete (struct ata_port *ap,
                                      struct ata_queued_cmd *qc, int have_err);
+static void pdc_irq_clear(struct ata_port *ap);
+static int pdc_qc_issue_prot(struct ata_queued_cmd *qc);
 
 static Scsi_Host_Template pdc_sata_sht = {
 	.module			= THIS_MODULE,
@@ -112,11 +113,11 @@
 	.check_status		= ata_check_status_mmio,
 	.exec_command		= pdc_exec_command_mmio,
 	.phy_reset		= pdc_phy_reset,
-	.bmdma_setup            = pdc_dma_setup,
-	.bmdma_start            = pdc_dma_start,
 	.qc_prep		= pdc_qc_prep,
+	.qc_issue		= pdc_qc_issue_prot,
 	.eng_timeout		= pdc_eng_timeout,
 	.irq_handler		= pdc_interrupt,
+	.irq_clear		= pdc_irq_clear,
 	.scr_read		= pdc_sata_scr_read,
 	.scr_write		= pdc_sata_scr_write,
 	.port_start		= pdc_port_start,
@@ -378,6 +379,14 @@
         return handled;
 }
 
+static void pdc_irq_clear(struct ata_port *ap)
+{
+	struct ata_host_set *host_set = ap->host_set;
+	void *mmio = host_set->mmio_base;
+
+	readl(mmio + PDC_INT_SEQMASK);
+}
+
 static irqreturn_t pdc_interrupt (int irq, void *dev_instance, struct pt_regs *regs)
 {
 	struct ata_host_set *host_set = dev_instance;
@@ -431,13 +440,7 @@
 	return IRQ_RETVAL(handled);
 }
 
-static void pdc_dma_setup(struct ata_queued_cmd *qc)
-{
-	/* nothing for now.  later, we will call standard
-	 * code in libata-core for ATAPI here */
-}
-
-static void pdc_dma_start(struct ata_queued_cmd *qc)
+static inline void pdc_dma_start(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct pdc_port_priv *pp = ap->private_data;
@@ -455,17 +458,35 @@
 	readl((void *) ap->ioaddr.cmd_addr + PDC_PKT_SUBMIT); /* flush */
 }
 
+static int pdc_qc_issue_prot(struct ata_queued_cmd *qc)
+{
+	switch (qc->tf.protocol) {
+	case ATA_PROT_DMA:
+		pdc_dma_start(qc);
+		return 0;
+
+	case ATA_PROT_ATAPI_DMA:
+		BUG();
+		break;
+
+	default:
+		break;
+	}
+
+	return ata_qc_issue_prot(qc);
+}
+
 static void pdc_tf_load_mmio(struct ata_port *ap, struct ata_taskfile *tf)
 {
-	if (tf->protocol != ATA_PROT_DMA)
-		ata_tf_load_mmio(ap, tf);
+	WARN_ON (tf->protocol == ATA_PROT_DMA);
+	ata_tf_load_mmio(ap, tf);
 }
 
 
 static void pdc_exec_command_mmio(struct ata_port *ap, struct ata_taskfile *tf)
 {
-	if (tf->protocol != ATA_PROT_DMA)
-		ata_exec_command_mmio(ap, tf);
+	WARN_ON (tf->protocol == ATA_PROT_DMA);
+	ata_exec_command_mmio(ap, tf);
 }
 
 
diff -Nru a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c	2004-07-04 10:48:31 -04:00
+++ b/drivers/scsi/sata_sil.c	2004-07-04 10:48:31 -04:00
@@ -86,6 +86,7 @@
 	{ "ST360015AS",		SIL_QUIRK_MOD15WRITE },
 	{ "ST380023AS",		SIL_QUIRK_MOD15WRITE },
 	{ "ST3120023AS",	SIL_QUIRK_MOD15WRITE },
+	{ "ST3160023AS",	SIL_QUIRK_MOD15WRITE },
 	{ "ST340014ASL",	SIL_QUIRK_MOD15WRITE },
 	{ "ST360014ASL",	SIL_QUIRK_MOD15WRITE },
 	{ "ST380011ASL",	SIL_QUIRK_MOD15WRITE },
@@ -132,8 +133,10 @@
 	.bmdma_setup            = ata_bmdma_setup_mmio,
 	.bmdma_start            = ata_bmdma_start_mmio,
 	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= ata_eng_timeout,
 	.irq_handler		= ata_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= sil_scr_read,
 	.scr_write		= sil_scr_write,
 	.port_start		= ata_port_start,
diff -Nru a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
--- a/drivers/scsi/sata_sis.c	2004-07-04 10:48:31 -04:00
+++ b/drivers/scsi/sata_sis.c	2004-07-04 10:48:31 -04:00
@@ -101,8 +101,10 @@
 	.bmdma_setup            = ata_bmdma_setup_pio,
 	.bmdma_start            = ata_bmdma_start_pio,
 	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= ata_eng_timeout,
 	.irq_handler		= ata_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= sis_scr_read,
 	.scr_write		= sis_scr_write,
 	.port_start		= ata_port_start,
diff -Nru a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
--- a/drivers/scsi/sata_svw.c	2004-07-04 10:48:31 -04:00
+++ b/drivers/scsi/sata_svw.c	2004-07-04 10:48:31 -04:00
@@ -234,8 +234,10 @@
 	.bmdma_setup            = ata_bmdma_setup_mmio,
 	.bmdma_start            = ata_bmdma_start_mmio,
 	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= ata_eng_timeout,
 	.irq_handler		= ata_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= k2_sata_scr_read,
 	.scr_write		= k2_sata_scr_write,
 	.port_start		= ata_port_start,
diff -Nru a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
--- a/drivers/scsi/sata_sx4.c	2004-07-04 10:48:31 -04:00
+++ b/drivers/scsi/sata_sx4.c	2004-07-04 10:48:31 -04:00
@@ -171,6 +171,7 @@
 #endif
 static void pdc20621_put_to_dimm(struct ata_probe_ent *pe, 
 				 void *psource, u32 offset, u32 size);
+static void pdc20621_irq_clear(struct ata_port *ap);
 
 
 static Scsi_Host_Template pdc_sata_sht = {
@@ -201,8 +202,10 @@
 	.bmdma_setup            = pdc20621_dma_setup,
 	.bmdma_start            = pdc20621_dma_start,
 	.qc_prep		= pdc20621_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= pdc_eng_timeout,
 	.irq_handler		= pdc20621_interrupt,
+	.irq_clear		= pdc20621_irq_clear,
 	.port_start		= pdc_port_start,
 	.port_stop		= pdc_port_stop,
 	.host_stop		= pdc20621_host_stop,
@@ -446,7 +449,7 @@
 	unsigned int i, last, idx, total_len = 0, sgt_len;
 	u32 *buf = (u32 *) &pp->dimm_buf[PDC_DIMM_HEADER_SZ];
 
-	if (!(qc->flags & ATA_QCFLAG_SG))
+	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
 		return;
 
 	VPRINTK("ata%u: ENTER\n", ap->id);
@@ -700,6 +703,16 @@
 	}
 
 	return handled;
+}
+
+static void pdc20621_irq_clear(struct ata_port *ap)
+{
+	struct ata_host_set *host_set = ap->host_set;
+	void *mmio = host_set->mmio_base;
+
+	mmio += PDC_CHIP0_OFS;
+
+	readl(mmio + PDC_20621_SEQMASK);
 }
 
 static irqreturn_t pdc20621_interrupt (int irq, void *dev_instance, struct pt_regs *regs)
diff -Nru a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
--- a/drivers/scsi/sata_via.c	2004-07-04 10:48:31 -04:00
+++ b/drivers/scsi/sata_via.c	2004-07-04 10:48:31 -04:00
@@ -109,9 +109,12 @@
 	.bmdma_setup            = ata_bmdma_setup_pio,
 	.bmdma_start            = ata_bmdma_start_pio,
 	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
+
 	.eng_timeout		= ata_eng_timeout,
 
 	.irq_handler		= ata_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
 
 	.scr_read		= svia_scr_read,
 	.scr_write		= svia_scr_write,
diff -Nru a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
--- a/drivers/scsi/sata_vsc.c	2004-07-04 10:48:31 -04:00
+++ b/drivers/scsi/sata_vsc.c	2004-07-04 10:48:31 -04:00
@@ -216,8 +216,10 @@
 	.bmdma_setup            = ata_bmdma_setup_mmio,
 	.bmdma_start            = ata_bmdma_start_mmio,
 	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= ata_eng_timeout,
 	.irq_handler		= vsc_sata_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= vsc_sata_scr_read,
 	.scr_write		= vsc_sata_scr_write,
 	.port_start		= ata_port_start,
diff -Nru a/include/linux/ata.h b/include/linux/ata.h
--- a/include/linux/ata.h	2004-07-04 10:48:31 -04:00
+++ b/include/linux/ata.h	2004-07-04 10:48:31 -04:00
@@ -78,9 +78,11 @@
 	ATA_NIEN		= (1 << 1),	/* disable-irq flag */
 	ATA_LBA			= (1 << 6),	/* LBA28 selector */
 	ATA_DEV1		= (1 << 4),	/* Select Device 1 (slave) */
-	ATA_BUSY		= (1 << 7),	/* BSY status bit */
 	ATA_DEVICE_OBS		= (1 << 7) | (1 << 5), /* obs bits in dev reg */
 	ATA_DEVCTL_OBS		= (1 << 3),	/* obsolete bit in devctl reg */
+	ATA_BUSY		= (1 << 7),	/* BSY status bit */
+	ATA_DRDY		= (1 << 6),	/* device ready */
+	ATA_DF			= (1 << 5),	/* device fault */
 	ATA_DRQ			= (1 << 3),	/* data request i/o */
 	ATA_ERR			= (1 << 0),	/* have an error */
 	ATA_SRST		= (1 << 2),	/* software reset */
@@ -222,6 +224,12 @@
 {
 	return (tf->protocol == ATA_PROT_ATAPI) ||
 	       (tf->protocol == ATA_PROT_ATAPI_DMA);
+}
+
+static inline int ata_ok(u8 status)
+{
+	return ((status & (ATA_BUSY | ATA_DRDY | ATA_DF | ATA_DRQ | ATA_ERR))
+			== ATA_DRDY);
 }
 
 #endif /* __LINUX_ATA_H__ */
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	2004-07-04 10:48:31 -04:00
+++ b/include/linux/libata.h	2004-07-04 10:48:31 -04:00
@@ -112,7 +112,9 @@
 
 	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
 	ATA_QCFLAG_DMA		= (1 << 2), /* data delivered via DMA */
-	ATA_QCFLAG_SG		= (1 << 4), /* have s/g table? */
+	ATA_QCFLAG_SG		= (1 << 3), /* have s/g table? */
+	ATA_QCFLAG_SINGLE	= (1 << 4), /* no s/g, just a single buffer */
+	ATA_QCFLAG_DMAMAP	= ATA_QCFLAG_SG | ATA_QCFLAG_SINGLE,
 
 	/* various lengths of time */
 	ATA_TMOUT_EDD		= 5 * HZ,	/* hueristic */
@@ -158,7 +160,7 @@
 struct ata_queued_cmd;
 
 /* typedefs */
-typedef void (*ata_qc_cb_t) (struct ata_queued_cmd *qc, unsigned int flags);
+typedef int (*ata_qc_cb_t) (struct ata_queued_cmd *qc, u8 drv_stat);
 
 struct ata_ioports {
 	unsigned long		cmd_addr;
@@ -202,6 +204,7 @@
 	void			*mmio_base;
 	unsigned int		n_ports;
 	void			*private_data;
+	struct ata_port_operations *ops;
 	struct ata_port *	ports[0];
 };
 
@@ -215,16 +218,21 @@
 	unsigned long		flags;		/* ATA_QCFLAG_xxx */
 	unsigned int		tag;
 	unsigned int		n_elem;
+
+	int			pci_dma_dir;
+
 	unsigned int		nsect;
 	unsigned int		cursect;
 	unsigned int		cursg;
 	unsigned int		cursg_ofs;
+
 	struct ata_taskfile	tf;
 	struct scatterlist	sgent;
+	void			*buf_virt;
 
 	struct scatterlist	*sg;
 
-	ata_qc_cb_t		callback;
+	ata_qc_cb_t		complete_fn;
 
 	struct completion	*waiting;
 
@@ -311,10 +319,14 @@
 
 	void (*bmdma_setup) (struct ata_queued_cmd *qc);
 	void (*bmdma_start) (struct ata_queued_cmd *qc);
+
 	void (*qc_prep) (struct ata_queued_cmd *qc);
+	int (*qc_issue) (struct ata_queued_cmd *qc);
+
 	void (*eng_timeout) (struct ata_port *ap);
 
 	irqreturn_t (*irq_handler)(int, void *, struct pt_regs *);
+	void (*irq_clear) (struct ata_port *);
 
 	u32 (*scr_read) (struct ata_port *ap, unsigned int sc_reg);
 	void (*scr_write) (struct ata_port *ap, unsigned int sc_reg,
@@ -372,12 +384,18 @@
 extern void ata_port_stop (struct ata_port *ap);
 extern irqreturn_t ata_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 extern void ata_qc_prep(struct ata_queued_cmd *qc);
+extern int ata_qc_issue_prot(struct ata_queued_cmd *qc);
+extern void ata_sg_init_one(struct ata_queued_cmd *qc, void *buf,
+		unsigned int buflen);
+extern void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
+		 unsigned int n_elem);
 extern void ata_dev_id_string(struct ata_device *dev, unsigned char *s,
 			      unsigned int ofs, unsigned int len);
 extern void ata_bmdma_setup_mmio (struct ata_queued_cmd *qc);
 extern void ata_bmdma_start_mmio (struct ata_queued_cmd *qc);
 extern void ata_bmdma_setup_pio (struct ata_queued_cmd *qc);
 extern void ata_bmdma_start_pio (struct ata_queued_cmd *qc);
+extern void ata_bmdma_irq_clear(struct ata_port *ap);
 extern int pci_test_config_bits(struct pci_dev *pdev, struct pci_bits *bits);
 extern void ata_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat);
 extern void ata_eng_timeout(struct ata_port *ap);
@@ -480,6 +498,7 @@
 static inline u8 ata_irq_on(struct ata_port *ap)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
+	u8 tmp;
 
 	ap->ctl &= ~ATA_NIEN;
 	ap->last_ctl = ap->ctl;
@@ -488,7 +507,11 @@
 		writeb(ap->ctl, ioaddr->ctl_addr);
 	else
 		outb(ap->ctl, ioaddr->ctl_addr);
-	return ata_wait_idle(ap);
+	tmp = ata_wait_idle(ap);
+
+	ap->ops->irq_clear(ap);
+
+	return tmp;
 }
 
 static inline u8 ata_irq_ack(struct ata_port *ap, unsigned int chk_drq)
