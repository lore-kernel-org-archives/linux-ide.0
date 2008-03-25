From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/27] libata: rename SFF port ops
Date: Tue, 25 Mar 2008 22:16:46 +0900
Message-ID: <12064510271486-git-send-email-htejun@gmail.com>
References: <1206451025926-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.177]:23934 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754961AbYCYNRm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 09:17:42 -0400
Received: by el-out-1112.google.com with SMTP id v27so1723842ele.17
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 06:17:41 -0700 (PDT)
In-Reply-To: <1206451025926-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, James.Bottomley@HansenPartnership.com, brking@us.ibm.com, ashish.kalra@freescale.com, leoli@freescale.com
Cc: Tejun Heo <htejun@gmail.com>

Add sff_ prefix to SFF specific port ops.

This rename is in preparation of separating SFF support out of libata
core layer.  This patch strictly renames ops and doesn't introduce any
behavior difference.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c            |    6 +-
 drivers/ata/libata-core.c     |   18 +++---
 drivers/ata/libata-scsi.c     |    2 +-
 drivers/ata/libata-sff.c      |  109 +++++++++++++++++++++--------------------
 drivers/ata/pata_bf54x.c      |   20 ++++----
 drivers/ata/pata_cmd640.c     |    2 +-
 drivers/ata/pata_icside.c     |    4 +-
 drivers/ata/pata_it821x.c     |    2 +-
 drivers/ata/pata_ixp4xx_cf.c  |    2 +-
 drivers/ata/pata_legacy.c     |   14 +++---
 drivers/ata/pata_mpc52xx.c    |    2 +-
 drivers/ata/pata_ninja32.c    |    2 +-
 drivers/ata/pata_ns87415.c    |    8 ++--
 drivers/ata/pata_pcmcia.c     |    4 +-
 drivers/ata/pata_platform.c   |    2 +-
 drivers/ata/pata_qdi.c        |    2 +-
 drivers/ata/pata_rb500_cf.c   |    4 +-
 drivers/ata/pata_scc.c        |   42 ++++++++--------
 drivers/ata/pata_via.c        |    2 +-
 drivers/ata/pata_winbond.c    |    2 +-
 drivers/ata/sata_fsl.c        |    6 +-
 drivers/ata/sata_inic162x.c   |   12 ++--
 drivers/ata/sata_nv.c         |   20 ++++----
 drivers/ata/sata_promise.c    |    6 +-
 drivers/ata/sata_sil.c        |    6 +-
 drivers/ata/sata_sil24.c      |    6 +-
 drivers/ata/sata_svw.c        |   10 ++--
 drivers/ata/sata_sx4.c        |   16 +++---
 drivers/ata/sata_via.c        |    2 +-
 drivers/ata/sata_vsc.c        |    6 +-
 drivers/scsi/ipr.c            |    8 ++--
 drivers/scsi/libsas/sas_ata.c |    8 ++--
 include/linux/libata.h        |   25 +++++-----
 33 files changed, 192 insertions(+), 188 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 771509c..c5e4501 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -292,10 +292,10 @@ static struct scsi_host_template ahci_sht = {
 static struct ata_port_operations ahci_ops = {
 	.inherits		= &sata_pmp_port_ops,
 
-	.check_status		= ahci_check_status,
-	.check_altstatus	= ahci_check_status,
+	.sff_check_status	= ahci_check_status,
+	.sff_check_altstatus	= ahci_check_status,
 
-	.tf_read		= ahci_tf_read,
+	.sff_tf_read		= ahci_tf_read,
 	.qc_defer		= sata_pmp_qc_defer_cmd_switch,
 	.qc_prep		= ahci_qc_prep,
 	.qc_issue		= ahci_qc_issue,
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 60859bb..ce204fb 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -74,7 +74,7 @@ const unsigned long sata_deb_timing_hotplug[]		= {  25,  500, 2000 };
 const unsigned long sata_deb_timing_long[]		= { 100, 2000, 5000 };
 
 const struct ata_port_operations ata_base_port_ops = {
-	.irq_clear		= ata_noop_irq_clear,
+	.sff_irq_clear		= ata_noop_irq_clear,
 	.prereset		= ata_sff_prereset,
 	.hardreset		= sata_sff_hardreset,
 	.postreset		= ata_sff_postreset,
@@ -85,7 +85,7 @@ const struct ata_port_operations sata_port_ops = {
 	.inherits		= &ata_base_port_ops,
 
 	.qc_defer		= ata_std_qc_defer,
-	.dev_select		= ata_noop_dev_select,
+	.sff_dev_select		= ata_noop_dev_select,
 };
 
 const struct ata_port_operations sata_pmp_port_ops = {
@@ -3525,9 +3525,9 @@ void ata_sff_postreset(struct ata_link *link, unsigned int *classes)
 
 	/* is double-select really necessary? */
 	if (classes[0] != ATA_DEV_NONE)
-		ap->ops->dev_select(ap, 1);
+		ap->ops->sff_dev_select(ap, 1);
 	if (classes[1] != ATA_DEV_NONE)
-		ap->ops->dev_select(ap, 0);
+		ap->ops->sff_dev_select(ap, 0);
 
 	/* bail out if no device is present */
 	if (classes[0] == ATA_DEV_NONE && classes[1] == ATA_DEV_NONE) {
@@ -4338,7 +4338,7 @@ static void fill_result_tf(struct ata_queued_cmd *qc)
 	struct ata_port *ap = qc->ap;
 
 	qc->result_tf.flags = qc->tf.flags;
-	ap->ops->tf_read(ap, &qc->result_tf);
+	ap->ops->sff_tf_read(ap, &qc->result_tf);
 }
 
 static void ata_verify_xfer(struct ata_queued_cmd *qc)
@@ -5997,16 +5997,16 @@ static unsigned int ata_dummy_qc_issue(struct ata_queued_cmd *qc)
 }
 
 struct ata_port_operations ata_dummy_port_ops = {
-	.check_status		= ata_dummy_check_status,
-	.check_altstatus	= ata_dummy_check_status,
-	.dev_select		= ata_noop_dev_select,
+	.sff_check_status	= ata_dummy_check_status,
+	.sff_check_altstatus	= ata_dummy_check_status,
+	.sff_dev_select		= ata_noop_dev_select,
 	.qc_prep		= ata_noop_qc_prep,
 	.qc_issue		= ata_dummy_qc_issue,
 	.freeze			= ata_dummy_noret,
 	.thaw			= ata_dummy_noret,
 	.error_handler		= ata_dummy_noret,
 	.post_internal_cmd	= ata_dummy_qc_noret,
-	.irq_clear		= ata_dummy_noret,
+	.sff_irq_clear		= ata_dummy_noret,
 	.port_start		= ata_dummy_ret0,
 	.port_stop		= ata_dummy_noret,
 };
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 798ba5e..f8be928 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2393,7 +2393,7 @@ static void atapi_request_sense(struct ata_queued_cmd *qc)
 	/* FIXME: is this needed? */
 	memset(cmd->sense_buffer, 0, SCSI_SENSE_BUFFERSIZE);
 
-	ap->ops->tf_read(ap, &qc->tf);
+	ap->ops->sff_tf_read(ap, &qc->tf);
 
 	/* fill these in, for the case where they are -not- overwritten */
 	cmd->sense_buffer[0] = 0x70;
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 8544321..04024a5 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -51,13 +51,13 @@ const struct ata_port_operations ata_sff_port_ops = {
 	.error_handler		= ata_sff_error_handler,
 	.post_internal_cmd	= ata_sff_post_internal_cmd,
 
-	.dev_select		= ata_sff_dev_select,
-	.check_status		= ata_sff_check_status,
-	.tf_load		= ata_sff_tf_load,
-	.tf_read		= ata_sff_tf_read,
-	.exec_command		= ata_sff_exec_command,
-	.data_xfer		= ata_sff_data_xfer,
-	.irq_on			= ata_sff_irq_on,
+	.sff_dev_select		= ata_sff_dev_select,
+	.sff_check_status	= ata_sff_check_status,
+	.sff_tf_load		= ata_sff_tf_load,
+	.sff_tf_read		= ata_sff_tf_read,
+	.sff_exec_command	= ata_sff_exec_command,
+	.sff_data_xfer		= ata_sff_data_xfer,
+	.sff_irq_on		= ata_sff_irq_on,
 
 	.port_start		= ata_sff_port_start,
 };
@@ -71,7 +71,7 @@ const struct ata_port_operations ata_bmdma_port_ops = {
 	.bmdma_start		= ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
 	.bmdma_status		= ata_bmdma_status,
-	.irq_clear		= ata_sff_irq_clear,
+	.sff_irq_clear		= ata_sff_irq_clear,
 };
 
 /**
@@ -245,8 +245,8 @@ u8 ata_sff_check_status(struct ata_port *ap)
  */
 u8 ata_sff_altstatus(struct ata_port *ap)
 {
-	if (ap->ops->check_altstatus)
-		return ap->ops->check_altstatus(ap);
+	if (ap->ops->sff_check_altstatus)
+		return ap->ops->sff_check_altstatus(ap);
 
 	return ioread8(ap->ioaddr.altstatus_addr);
 }
@@ -290,7 +290,7 @@ int ata_sff_busy_sleep(struct ata_port *ap,
 	while (status != 0xff && (status & ATA_BUSY) &&
 	       time_before(jiffies, timeout)) {
 		msleep(50);
-		status = ap->ops->check_status(ap);
+		status = ap->ops->sff_check_status(ap);
 	}
 
 	if (status == 0xff)
@@ -326,7 +326,7 @@ int ata_sff_wait_ready(struct ata_port *ap, unsigned long deadline)
 	int warned = 0;
 
 	while (1) {
-		u8 status = ap->ops->check_status(ap);
+		u8 status = ap->ops->sff_check_status(ap);
 		unsigned long now = jiffies;
 
 		if (!(status & ATA_BUSY))
@@ -403,7 +403,7 @@ void ata_dev_select(struct ata_port *ap, unsigned int device,
 	if (wait)
 		ata_wait_idle(ap);
 
-	ap->ops->dev_select(ap, device);
+	ap->ops->sff_dev_select(ap, device);
 
 	if (wait) {
 		if (can_sleep && ap->link.device[device].class == ATA_DEV_ATAPI)
@@ -434,7 +434,7 @@ u8 ata_sff_irq_on(struct ata_port *ap)
 		iowrite8(ap->ctl, ioaddr->ctl_addr);
 	tmp = ata_wait_idle(ap);
 
-	ap->ops->irq_clear(ap);
+	ap->ops->sff_irq_clear(ap);
 
 	return tmp;
 }
@@ -593,8 +593,8 @@ void ata_sff_exec_command(struct ata_port *ap, const struct ata_taskfile *tf)
 static inline void ata_tf_to_host(struct ata_port *ap,
 				  const struct ata_taskfile *tf)
 {
-	ap->ops->tf_load(ap, tf);
-	ap->ops->exec_command(ap, tf);
+	ap->ops->sff_tf_load(ap, tf);
+	ap->ops->sff_exec_command(ap, tf);
 }
 
 /**
@@ -709,13 +709,15 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
 		buf = kmap_atomic(page, KM_IRQ0);
 
 		/* do the actual data transfer */
-		ap->ops->data_xfer(qc->dev, buf + offset, qc->sect_size, do_write);
+		ap->ops->sff_data_xfer(qc->dev, buf + offset, qc->sect_size,
+				       do_write);
 
 		kunmap_atomic(buf, KM_IRQ0);
 		local_irq_restore(flags);
 	} else {
 		buf = page_address(page);
-		ap->ops->data_xfer(qc->dev, buf + offset, qc->sect_size, do_write);
+		ap->ops->sff_data_xfer(qc->dev, buf + offset, qc->sect_size,
+				       do_write);
 	}
 
 	qc->curbytes += qc->sect_size;
@@ -772,7 +774,7 @@ static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
 	DPRINTK("send cdb\n");
 	WARN_ON(qc->dev->cdb_len < 12);
 
-	ap->ops->data_xfer(qc->dev, qc->cdb, qc->dev->cdb_len, 1);
+	ap->ops->sff_data_xfer(qc->dev, qc->cdb, qc->dev->cdb_len, 1);
 	ata_sff_altstatus(ap); /* flush */
 
 	switch (qc->tf.protocol) {
@@ -844,13 +846,13 @@ next_sg:
 		buf = kmap_atomic(page, KM_IRQ0);
 
 		/* do the actual data transfer */
-		consumed = ap->ops->data_xfer(dev,  buf + offset, count, rw);
+		consumed = ap->ops->sff_data_xfer(dev,  buf + offset, count, rw);
 
 		kunmap_atomic(buf, KM_IRQ0);
 		local_irq_restore(flags);
 	} else {
 		buf = page_address(page);
-		consumed = ap->ops->data_xfer(dev,  buf + offset, count, rw);
+		consumed = ap->ops->sff_data_xfer(dev,  buf + offset, count, rw);
 	}
 
 	bytes -= min(bytes, consumed);
@@ -893,7 +895,7 @@ static void atapi_pio_bytes(struct ata_queued_cmd *qc)
 	 * error, qc->result_tf is later overwritten by ata_qc_complete().
 	 * So, the correctness of qc->result_tf is not affected.
 	 */
-	ap->ops->tf_read(ap, &qc->result_tf);
+	ap->ops->sff_tf_read(ap, &qc->result_tf);
 	ireason = qc->result_tf.nsect;
 	bc_lo = qc->result_tf.lbam;
 	bc_hi = qc->result_tf.lbah;
@@ -979,7 +981,7 @@ static void ata_hsm_qc_complete(struct ata_queued_cmd *qc, int in_wq)
 			qc = ata_qc_from_tag(ap, qc->tag);
 			if (qc) {
 				if (likely(!(qc->err_mask & AC_ERR_HSM))) {
-					ap->ops->irq_on(ap);
+					ap->ops->sff_irq_on(ap);
 					ata_qc_complete(qc);
 				} else
 					ata_port_freeze(ap);
@@ -995,7 +997,7 @@ static void ata_hsm_qc_complete(struct ata_queued_cmd *qc, int in_wq)
 	} else {
 		if (in_wq) {
 			spin_lock_irqsave(ap->lock, flags);
-			ap->ops->irq_on(ap);
+			ap->ops->sff_irq_on(ap);
 			ata_qc_complete(qc);
 			spin_unlock_irqrestore(ap->lock, flags);
 		} else
@@ -1345,7 +1347,7 @@ unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
 	case ATA_PROT_DMA:
 		WARN_ON(qc->tf.flags & ATA_TFLAG_POLLING);
 
-		ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
+		ap->ops->sff_tf_load(ap, &qc->tf);  /* load tf registers */
 		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
 		ap->ops->bmdma_start(qc);	    /* initiate bmdma */
 		ap->hsm_task_state = HSM_ST_LAST;
@@ -1397,7 +1399,7 @@ unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
 	case ATAPI_PROT_DMA:
 		WARN_ON(qc->tf.flags & ATA_TFLAG_POLLING);
 
-		ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
+		ap->ops->sff_tf_load(ap, &qc->tf);  /* load tf registers */
 		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
 		ap->hsm_task_state = HSM_ST_FIRST;
 
@@ -1486,12 +1488,12 @@ inline unsigned int ata_sff_host_intr(struct ata_port *ap,
 		goto idle_irq;
 
 	/* check main status, clearing INTRQ */
-	status = ap->ops->check_status(ap);
+	status = ap->ops->sff_check_status(ap);
 	if (unlikely(status & ATA_BUSY))
 		goto idle_irq;
 
 	/* ack bmdma irq events */
-	ap->ops->irq_clear(ap);
+	ap->ops->sff_irq_clear(ap);
 
 	ata_sff_hsm_move(ap, qc, status, 0);
 
@@ -1506,8 +1508,8 @@ idle_irq:
 
 #ifdef ATA_IRQ_TRAP
 	if ((ap->stats.idle_irq % 1000) == 0) {
-		ap->ops->check_status(ap);
-		ap->ops->irq_clear(ap);
+		ap->ops->sff_check_status(ap);
+		ap->ops->sff_irq_clear(ap);
 		ata_port_printk(ap, KERN_WARNING, "irq trap\n");
 		return 1;
 	}
@@ -1582,9 +1584,9 @@ void ata_sff_freeze(struct ata_port *ap)
 	 * ATA_NIEN manipulation.  Also, many controllers fail to mask
 	 * previously pending IRQ on ATA_NIEN assertion.  Clear it.
 	 */
-	ap->ops->check_status(ap);
+	ap->ops->sff_check_status(ap);
 
-	ap->ops->irq_clear(ap);
+	ap->ops->sff_irq_clear(ap);
 }
 
 /**
@@ -1599,9 +1601,9 @@ void ata_sff_freeze(struct ata_port *ap)
 void ata_sff_thaw(struct ata_port *ap)
 {
 	/* clear & re-enable interrupts */
-	ap->ops->check_status(ap);
-	ap->ops->irq_clear(ap);
-	ap->ops->irq_on(ap);
+	ap->ops->sff_check_status(ap);
+	ap->ops->sff_irq_clear(ap);
+	ap->ops->sff_irq_on(ap);
 }
 
 /**
@@ -1626,7 +1628,7 @@ static unsigned int ata_devchk(struct ata_port *ap, unsigned int device)
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	u8 nsect, lbal;
 
-	ap->ops->dev_select(ap, device);
+	ap->ops->sff_dev_select(ap, device);
 
 	iowrite8(0x55, ioaddr->nsect_addr);
 	iowrite8(0xaa, ioaddr->lbal_addr);
@@ -1675,11 +1677,11 @@ unsigned int ata_sff_dev_classify(struct ata_device *dev, int present,
 	unsigned int class;
 	u8 err;
 
-	ap->ops->dev_select(ap, dev->devno);
+	ap->ops->sff_dev_select(ap, dev->devno);
 
 	memset(&tf, 0, sizeof(tf));
 
-	ap->ops->tf_read(ap, &tf);
+	ap->ops->sff_tf_read(ap, &tf);
 	err = tf.feature;
 	if (r_err)
 		*r_err = err;
@@ -1709,7 +1711,8 @@ unsigned int ata_sff_dev_classify(struct ata_device *dev, int present,
 			class = ATA_DEV_ATA;
 		else
 			class = ATA_DEV_NONE;
-	} else if ((class == ATA_DEV_ATA) && (ap->ops->check_status(ap) == 0))
+	} else if ((class == ATA_DEV_ATA) &&
+		   (ap->ops->sff_check_status(ap) == 0))
 		class = ATA_DEV_NONE;
 
 	return class;
@@ -1741,7 +1744,7 @@ static int ata_bus_post_reset(struct ata_port *ap, unsigned int devmask,
 	if (dev1) {
 		int i;
 
-		ap->ops->dev_select(ap, 1);
+		ap->ops->sff_dev_select(ap, 1);
 
 		/* Wait for register access.  Some ATAPI devices fail
 		 * to set nsect/lbal after reset, so don't waste too
@@ -1766,11 +1769,11 @@ static int ata_bus_post_reset(struct ata_port *ap, unsigned int devmask,
 	}
 
 	/* is all this really necessary? */
-	ap->ops->dev_select(ap, 0);
+	ap->ops->sff_dev_select(ap, 0);
 	if (dev1)
-		ap->ops->dev_select(ap, 1);
+		ap->ops->sff_dev_select(ap, 1);
 	if (dev0)
-		ap->ops->dev_select(ap, 0);
+		ap->ops->sff_dev_select(ap, 0);
 
 	return ret;
 }
@@ -1820,7 +1823,7 @@ void ata_sff_wait_after_reset(struct ata_port *ap, unsigned long deadline)
 	 */
 	if (ap->flags & ATA_FLAG_SATA) {
 		while (1) {
-			u8 status = ap->ops->check_status(ap);
+			u8 status = ap->ops->sff_check_status(ap);
 
 			if (status != 0xff || time_after(jiffies, deadline))
 				return;
@@ -1851,7 +1854,7 @@ static int ata_bus_softreset(struct ata_port *ap, unsigned int devmask,
 	 * the bus shows 0xFF because the odd clown forgets the D7
 	 * pulldown resistor.
 	 */
-	if (ap->ops->check_status(ap) == 0xFF)
+	if (ap->ops->sff_check_status(ap) == 0xFF)
 		return -ENODEV;
 
 	return ata_bus_post_reset(ap, devmask, deadline);
@@ -1894,7 +1897,7 @@ int ata_sff_softreset(struct ata_link *link, unsigned int *classes,
 		devmask |= (1 << 1);
 
 	/* select device 0 again */
-	ap->ops->dev_select(ap, 0);
+	ap->ops->sff_dev_select(ap, 0);
 
 	/* issue bus reset */
 	DPRINTK("about to softreset, devmask=%x\n", devmask);
@@ -1977,7 +1980,7 @@ int sata_sff_hardreset(struct ata_link *link, unsigned int *class,
 		return rc;
 	}
 
-	ap->ops->dev_select(ap, 0);	/* probably unnecessary */
+	ap->ops->sff_dev_select(ap, 0);	/* probably unnecessary */
 
 	*class = ata_sff_dev_classify(link->device, 1, NULL);
 
@@ -2035,8 +2038,8 @@ void ata_sff_error_handler(struct ata_port *ap)
 	}
 
 	ata_sff_altstatus(ap);
-	ap->ops->check_status(ap);
-	ap->ops->irq_clear(ap);
+	ap->ops->sff_check_status(ap);
+	ap->ops->sff_irq_clear(ap);
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
@@ -2153,7 +2156,7 @@ void ata_bmdma_setup(struct ata_queued_cmd *qc)
 	iowrite8(dmactl, ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 
 	/* issue r/w command */
-	ap->ops->exec_command(ap, &qc->tf);
+	ap->ops->sff_exec_command(ap, &qc->tf);
 }
 
 /**
@@ -2277,7 +2280,7 @@ void ata_bus_reset(struct ata_port *ap)
 		devmask |= (1 << 1);
 
 	/* select device 0 again */
-	ap->ops->dev_select(ap, 0);
+	ap->ops->sff_dev_select(ap, 0);
 
 	/* issue bus reset */
 	if (ap->flags & ATA_FLAG_SRST) {
@@ -2295,9 +2298,9 @@ void ata_bus_reset(struct ata_port *ap)
 
 	/* is double-select really necessary? */
 	if (device[1].class != ATA_DEV_NONE)
-		ap->ops->dev_select(ap, 1);
+		ap->ops->sff_dev_select(ap, 1);
 	if (device[0].class != ATA_DEV_NONE)
-		ap->ops->dev_select(ap, 0);
+		ap->ops->sff_dev_select(ap, 0);
 
 	/* if no devices were detected, disable this port */
 	if ((device[0].class == ATA_DEV_NONE) &&
diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
index c854e88..d98bd74 100644
--- a/drivers/ata/pata_bf54x.c
+++ b/drivers/ata/pata_bf54x.c
@@ -1264,7 +1264,7 @@ static void bfin_freeze(struct ata_port *ap)
 	 * ATA_NIEN manipulation.  Also, many controllers fail to mask
 	 * previously pending IRQ on ATA_NIEN assertion.  Clear it.
 	 */
-	ap->ops->check_status(ap);
+	ap->ops->sff_check_status(ap);
 
 	bfin_irq_clear(ap);
 }
@@ -1357,18 +1357,18 @@ static const struct ata_port_operations bfin_pata_ops = {
 	.set_piomode		= bfin_set_piomode,
 	.set_dmamode		= bfin_set_dmamode,
 
-	.tf_load		= bfin_tf_load,
-	.tf_read		= bfin_tf_read,
-	.exec_command		= bfin_exec_command,
-	.check_status		= bfin_check_status,
-	.check_altstatus	= bfin_check_altstatus,
-	.dev_select		= bfin_dev_select,
+	.sff_tf_load		= bfin_tf_load,
+	.sff_tf_read		= bfin_tf_read,
+	.sff_exec_command	= bfin_exec_command,
+	.sff_check_status	= bfin_check_status,
+	.sff_check_altstatus	= bfin_check_altstatus,
+	.sff_dev_select		= bfin_dev_select,
 
 	.bmdma_setup		= bfin_bmdma_setup,
 	.bmdma_start		= bfin_bmdma_start,
 	.bmdma_stop		= bfin_bmdma_stop,
 	.bmdma_status		= bfin_bmdma_status,
-	.data_xfer		= bfin_data_xfer,
+	.sff_data_xfer		= bfin_data_xfer,
 
 	.qc_prep		= ata_noop_qc_prep,
 
@@ -1378,8 +1378,8 @@ static const struct ata_port_operations bfin_pata_ops = {
 	.postreset		= bfin_postreset,
 	.post_internal_cmd	= bfin_bmdma_stop,
 
-	.irq_clear		= bfin_irq_clear,
-	.irq_on			= bfin_irq_on,
+	.sff_irq_clear		= bfin_irq_clear,
+	.sff_irq_on		= bfin_irq_on,
 
 	.port_start		= bfin_port_start,
 	.port_stop		= bfin_port_stop,
diff --git a/drivers/ata/pata_cmd640.c b/drivers/ata/pata_cmd640.c
index a907cf4..2de30b9 100644
--- a/drivers/ata/pata_cmd640.c
+++ b/drivers/ata/pata_cmd640.c
@@ -172,7 +172,7 @@ static struct scsi_host_template cmd640_sht = {
 static struct ata_port_operations cmd640_port_ops = {
 	.inherits	= &ata_bmdma_port_ops,
 	/* In theory xfer_noirq is not needed once we kill the prefetcher */
-	.data_xfer	= ata_sff_data_xfer_noirq,
+	.sff_data_xfer	= ata_sff_data_xfer_noirq,
 	.qc_issue	= cmd640_qc_issue,
 	.cable_detect	= ata_cable_40wire,
 	.set_piomode	= cmd640_set_piomode,
diff --git a/drivers/ata/pata_icside.c b/drivers/ata/pata_icside.c
index 52de9f9..1713843 100644
--- a/drivers/ata/pata_icside.c
+++ b/drivers/ata/pata_icside.c
@@ -250,7 +250,7 @@ static void pata_icside_bmdma_setup(struct ata_queued_cmd *qc)
 	set_dma_mode(state->dma, write ? DMA_MODE_WRITE : DMA_MODE_READ);
 
 	/* issue r/w command */
-	ap->ops->exec_command(ap, &qc->tf);
+	ap->ops->sff_exec_command(ap, &qc->tf);
 }
 
 static void pata_icside_bmdma_start(struct ata_queued_cmd *qc)
@@ -336,7 +336,7 @@ static struct ata_port_operations pata_icside_port_ops = {
 	.inherits		= &ata_sff_port_ops,
 	/* no need to build any PRD tables for DMA */
 	.qc_prep		= ata_noop_qc_prep,
-	.data_xfer		= ata_sff_data_xfer_noirq,
+	.sff_data_xfer		= ata_sff_data_xfer_noirq,
 	.bmdma_setup		= pata_icside_bmdma_setup,
 	.bmdma_start		= pata_icside_bmdma_start,
 	.bmdma_stop		= pata_icside_bmdma_stop,
diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index 88e37cf..e108169 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -652,7 +652,7 @@ static struct ata_port_operations it821x_passthru_port_ops = {
 	.inherits	= &ata_bmdma_port_ops,
 
 	.check_atapi_dma= it821x_check_atapi_dma,
-	.dev_select 	= it821x_passthru_dev_select,
+	.sff_dev_select	= it821x_passthru_dev_select,
 	.bmdma_start 	= it821x_passthru_bmdma_start,
 	.bmdma_stop	= it821x_passthru_bmdma_stop,
 	.qc_issue	= it821x_passthru_qc_issue,
diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index 283a8fb..8a175f2 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -93,7 +93,7 @@ static struct scsi_host_template ixp4xx_sht = {
 
 static struct ata_port_operations ixp4xx_port_ops = {
 	.inherits		= &ata_sff_port_ops,
-	.data_xfer		= ixp4xx_mmio_data_xfer,
+	.sff_data_xfer		= ixp4xx_mmio_data_xfer,
 	.cable_detect		= ata_cable_40wire,
 	.set_mode		= ixp4xx_set_mode,
 };
diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index f13f10a..7af4b29 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -226,12 +226,12 @@ static const struct ata_port_operations legacy_base_port_ops = {
 
 static struct ata_port_operations simple_port_ops = {
 	.inherits	= &legacy_base_port_ops,
-	.data_xfer	= ata_sff_data_xfer_noirq,
+	.sff_data_xfer	= ata_sff_data_xfer_noirq,
 };
 
 static struct ata_port_operations legacy_port_ops = {
 	.inherits	= &legacy_base_port_ops,
-	.data_xfer	= ata_sff_data_xfer_noirq,
+	.sff_data_xfer	= ata_sff_data_xfer_noirq,
 	.set_mode	= legacy_set_mode,
 };
 
@@ -325,7 +325,7 @@ static unsigned int pdc_data_xfer_vlb(struct ata_device *dev,
 static struct ata_port_operations pdc20230_port_ops = {
 	.inherits	= &legacy_base_port_ops,
 	.set_piomode	= pdc20230_set_piomode,
-	.data_xfer	= pdc_data_xfer_vlb,
+	.sff_data_xfer	= pdc_data_xfer_vlb,
 };
 
 /*
@@ -775,19 +775,19 @@ static struct ata_port_operations qdi6500_port_ops = {
 	.inherits	= &legacy_base_port_ops,
 	.set_piomode	= qdi6500_set_piomode,
 	.qc_issue	= qdi_qc_issue,
-	.data_xfer	= vlb32_data_xfer,
+	.sff_data_xfer	= vlb32_data_xfer,
 };
 
 static struct ata_port_operations qdi6580_port_ops = {
 	.inherits	= &legacy_base_port_ops,
 	.set_piomode	= qdi6580_set_piomode,
-	.data_xfer	= vlb32_data_xfer,
+	.sff_data_xfer	= vlb32_data_xfer,
 };
 
 static struct ata_port_operations qdi6580dp_port_ops = {
 	.inherits	= &legacy_base_port_ops,
 	.set_piomode	= qdi6580dp_set_piomode,
-	.data_xfer	= vlb32_data_xfer,
+	.sff_data_xfer	= vlb32_data_xfer,
 };
 
 static DEFINE_SPINLOCK(winbond_lock);
@@ -858,7 +858,7 @@ static int winbond_port(struct platform_device *dev,
 static struct ata_port_operations winbond_port_ops = {
 	.inherits	= &legacy_base_port_ops,
 	.set_piomode	= winbond_set_piomode,
-	.data_xfer	= vlb32_data_xfer,
+	.sff_data_xfer	= vlb32_data_xfer,
 };
 
 static struct legacy_controller controllers[] = {
diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index 5d1d32a..bc79df6 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -261,7 +261,7 @@ static struct scsi_host_template mpc52xx_ata_sht = {
 
 static struct ata_port_operations mpc52xx_ata_port_ops = {
 	.inherits		= &ata_sff_port_ops,
-	.dev_select		= mpc52xx_ata_dev_select,
+	.sff_dev_select		= mpc52xx_ata_dev_select,
 	.cable_detect		= ata_cable_40wire,
 	.set_piomode		= mpc52xx_ata_set_piomode,
 	.post_internal_cmd	= ATA_OP_NULL,
diff --git a/drivers/ata/pata_ninja32.c b/drivers/ata/pata_ninja32.c
index c9c0ea6..565e67c 100644
--- a/drivers/ata/pata_ninja32.c
+++ b/drivers/ata/pata_ninja32.c
@@ -84,7 +84,7 @@ static struct scsi_host_template ninja32_sht = {
 
 static struct ata_port_operations ninja32_port_ops = {
 	.inherits	= &ata_bmdma_port_ops,
-	.dev_select 	= ninja32_dev_select,
+	.sff_dev_select = ninja32_dev_select,
 	.cable_detect	= ata_cable_40wire,
 	.set_piomode	= ninja32_set_piomode,
 };
diff --git a/drivers/ata/pata_ns87415.c b/drivers/ata/pata_ns87415.c
index 03a52ce..ae92b00 100644
--- a/drivers/ata/pata_ns87415.c
+++ b/drivers/ata/pata_ns87415.c
@@ -138,7 +138,7 @@ static void ns87415_bmdma_setup(struct ata_queued_cmd *qc)
 		dmactl |= ATA_DMA_WR;
 	iowrite8(dmactl, ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 	/* issue r/w command */
-	ap->ops->exec_command(ap, &qc->tf);
+	ap->ops->sff_exec_command(ap, &qc->tf);
 }
 
 /**
@@ -306,7 +306,7 @@ static struct ata_port_operations ns87415_pata_ops = {
 	.bmdma_setup		= ns87415_bmdma_setup,
 	.bmdma_start		= ns87415_bmdma_start,
 	.bmdma_stop		= ns87415_bmdma_stop,
-	.irq_clear		= ns87415_irq_clear,
+	.sff_irq_clear		= ns87415_irq_clear,
 
 	.cable_detect		= ata_cable_40wire,
 	.set_piomode		= ns87415_set_piomode,
@@ -315,8 +315,8 @@ static struct ata_port_operations ns87415_pata_ops = {
 #if defined(CONFIG_SUPERIO)
 static struct ata_port_operations ns87560_pata_ops = {
 	.inherits		= &ns87415_pata_ops,
-	.tf_read		= ns87560_tf_read,
-	.check_status		= ns87560_check_status,
+	.sff_tf_read		= ns87560_tf_read,
+	.sff_check_status	= ns87560_check_status,
 	.bmdma_status		= ns87560_bmdma_status,
 };
 #endif
diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
index 2e206c5..3d39f9d 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -133,14 +133,14 @@ static struct scsi_host_template pcmcia_sht = {
 
 static struct ata_port_operations pcmcia_port_ops = {
 	.inherits	= &ata_sff_port_ops,
-	.data_xfer	= ata_sff_data_xfer_noirq,
+	.sff_data_xfer	= ata_sff_data_xfer_noirq,
 	.cable_detect	= ata_cable_40wire,
 	.set_mode	= pcmcia_set_mode,
 };
 
 static struct ata_port_operations pcmcia_8bit_port_ops = {
 	.inherits	= &ata_sff_port_ops,
-	.data_xfer	= ata_data_xfer_8bit,
+	.sff_data_xfer	= ata_data_xfer_8bit,
 	.cable_detect	= ata_cable_40wire,
 	.set_mode	= pcmcia_set_mode_8bit,
 };
diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index 1edfc13..6527c56 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -52,7 +52,7 @@ static struct scsi_host_template pata_platform_sht = {
 
 static struct ata_port_operations pata_platform_port_ops = {
 	.inherits		= &ata_sff_port_ops,
-	.data_xfer		= ata_sff_data_xfer_noirq,
+	.sff_data_xfer		= ata_sff_data_xfer_noirq,
 	.cable_detect		= ata_cable_unknown,
 	.set_mode		= pata_platform_set_mode,
 	.port_start		= ATA_OP_NULL,
diff --git a/drivers/ata/pata_qdi.c b/drivers/ata/pata_qdi.c
index 0d81dd5..bf45cf0 100644
--- a/drivers/ata/pata_qdi.c
+++ b/drivers/ata/pata_qdi.c
@@ -160,7 +160,7 @@ static struct scsi_host_template qdi_sht = {
 static struct ata_port_operations qdi6500_port_ops = {
 	.inherits	= &ata_sff_port_ops,
 	.qc_issue	= qdi_qc_issue,
-	.data_xfer	= qdi_data_xfer,
+	.sff_data_xfer	= qdi_data_xfer,
 	.cable_detect	= ata_cable_40wire,
 	.set_piomode	= qdi6500_set_piomode,
 };
diff --git a/drivers/ata/pata_rb500_cf.c b/drivers/ata/pata_rb500_cf.c
index 5b23d79..800ae46 100644
--- a/drivers/ata/pata_rb500_cf.c
+++ b/drivers/ata/pata_rb500_cf.c
@@ -119,8 +119,8 @@ static irqreturn_t rb500_pata_irq_handler(int irq, void *dev_instance)
 
 static struct ata_port_operations rb500_pata_port_ops = {
 	.inherits		= &ata_sff_port_ops,
-	.exec_command		= rb500_pata_exec_command,
-	.data_xfer		= rb500_pata_data_xfer,
+	.sff_exec_command	= rb500_pata_exec_command,
+	.sff_data_xfer		= rb500_pata_data_xfer,
 	.freeze			= rb500_pata_freeze,
 	.thaw			= rb500_pata_thaw,
 };
diff --git a/drivers/ata/pata_scc.c b/drivers/ata/pata_scc.c
index 65c341a..97c9ae6 100644
--- a/drivers/ata/pata_scc.c
+++ b/drivers/ata/pata_scc.c
@@ -441,7 +441,7 @@ static void scc_bmdma_setup (struct ata_queued_cmd *qc)
 	out_be32(mmio + SCC_DMA_CMD, dmactl);
 
 	/* issue r/w command */
-	ap->ops->exec_command(ap, &qc->tf);
+	ap->ops->sff_exec_command(ap, &qc->tf);
 }
 
 /**
@@ -476,7 +476,7 @@ static unsigned int scc_devchk (struct ata_port *ap,
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	u8 nsect, lbal;
 
-	ap->ops->dev_select(ap, device);
+	ap->ops->sff_dev_select(ap, device);
 
 	out_be32(ioaddr->nsect_addr, 0x55);
 	out_be32(ioaddr->lbal_addr, 0xaa);
@@ -525,7 +525,7 @@ static int scc_bus_post_reset(struct ata_port *ap, unsigned int devmask,
 	while (dev1) {
 		u8 nsect, lbal;
 
-		ap->ops->dev_select(ap, 1);
+		ap->ops->sff_dev_select(ap, 1);
 		nsect = in_be32(ioaddr->nsect_addr);
 		lbal = in_be32(ioaddr->lbal_addr);
 		if ((nsect == 1) && (lbal == 1))
@@ -541,11 +541,11 @@ static int scc_bus_post_reset(struct ata_port *ap, unsigned int devmask,
 	}
 
 	/* is all this really necessary? */
-	ap->ops->dev_select(ap, 0);
+	ap->ops->sff_dev_select(ap, 0);
 	if (dev1)
-		ap->ops->dev_select(ap, 1);
+		ap->ops->sff_dev_select(ap, 1);
 	if (dev0)
-		ap->ops->dev_select(ap, 0);
+		ap->ops->sff_dev_select(ap, 0);
 
 	return 0;
 }
@@ -616,7 +616,7 @@ static int scc_softreset(struct ata_link *link, unsigned int *classes,
 		devmask |= (1 << 1);
 
 	/* select device 0 again */
-	ap->ops->dev_select(ap, 0);
+	ap->ops->sff_dev_select(ap, 0);
 
 	/* issue bus reset */
 	DPRINTK("about to softreset, devmask=%x\n", devmask);
@@ -829,7 +829,7 @@ static u8 scc_irq_on (struct ata_port *ap)
 	out_be32(ioaddr->ctl_addr, ap->ctl);
 	tmp = ata_wait_idle(ap);
 
-	ap->ops->irq_clear(ap);
+	ap->ops->sff_irq_clear(ap);
 
 	return tmp;
 }
@@ -854,9 +854,9 @@ static void scc_freeze (struct ata_port *ap)
 	 * ATA_NIEN manipulation.  Also, many controllers fail to mask
 	 * previously pending IRQ on ATA_NIEN assertion.  Clear it.
 	 */
-	ap->ops->check_status(ap);
+	ap->ops->sff_check_status(ap);
 
-	ap->ops->irq_clear(ap);
+	ap->ops->sff_irq_clear(ap);
 }
 
 /**
@@ -887,9 +887,9 @@ static void scc_postreset(struct ata_link *link, unsigned int *classes)
 
 	/* is double-select really necessary? */
 	if (classes[0] != ATA_DEV_NONE)
-		ap->ops->dev_select(ap, 1);
+		ap->ops->sff_dev_select(ap, 1);
 	if (classes[1] != ATA_DEV_NONE)
-		ap->ops->dev_select(ap, 0);
+		ap->ops->sff_dev_select(ap, 0);
 
 	/* bail out if no device is present */
 	if (classes[0] == ATA_DEV_NONE && classes[1] == ATA_DEV_NONE) {
@@ -967,18 +967,18 @@ static const struct ata_port_operations scc_pata_ops = {
 	.set_dmamode		= scc_set_dmamode,
 	.mode_filter		= scc_mode_filter,
 
-	.tf_load		= scc_tf_load,
-	.tf_read		= scc_tf_read,
-	.exec_command		= scc_exec_command,
-	.check_status		= scc_check_status,
-	.check_altstatus	= scc_check_altstatus,
-	.dev_select		= scc_dev_select,
+	.sff_tf_load		= scc_tf_load,
+	.sff_tf_read		= scc_tf_read,
+	.sff_exec_command	= scc_exec_command,
+	.sff_check_status	= scc_check_status,
+	.sff_check_altstatus	= scc_check_altstatus,
+	.sff_dev_select		= scc_dev_select,
 
 	.bmdma_setup		= scc_bmdma_setup,
 	.bmdma_start		= scc_bmdma_start,
 	.bmdma_stop		= scc_bmdma_stop,
 	.bmdma_status		= scc_bmdma_status,
-	.data_xfer		= scc_data_xfer,
+	.sff_data_xfer		= scc_data_xfer,
 
 	.freeze			= scc_freeze,
 	.prereset		= scc_pata_prereset,
@@ -986,8 +986,8 @@ static const struct ata_port_operations scc_pata_ops = {
 	.postreset		= scc_postreset,
 	.post_internal_cmd	= scc_bmdma_stop,
 
-	.irq_clear		= scc_irq_clear,
-	.irq_on			= scc_irq_on,
+	.sff_irq_clear		= scc_irq_clear,
+	.sff_irq_on		= scc_irq_on,
 
 	.port_start		= scc_port_start,
 	.port_stop		= scc_port_stop,
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index 4b85f84..d484074 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -336,7 +336,7 @@ static struct ata_port_operations via_port_ops = {
 
 static struct ata_port_operations via_port_ops_noirq = {
 	.inherits	= &via_port_ops,
-	.data_xfer	= ata_sff_data_xfer_noirq,
+	.sff_data_xfer	= ata_sff_data_xfer_noirq,
 };
 
 /**
diff --git a/drivers/ata/pata_winbond.c b/drivers/ata/pata_winbond.c
index cc18231..6e52a35 100644
--- a/drivers/ata/pata_winbond.c
+++ b/drivers/ata/pata_winbond.c
@@ -127,7 +127,7 @@ static struct scsi_host_template winbond_sht = {
 
 static struct ata_port_operations winbond_port_ops = {
 	.inherits	= &ata_sff_port_ops,
-	.data_xfer	= winbond_data_xfer,
+	.sff_data_xfer	= winbond_data_xfer,
 	.cable_detect	= ata_cable_40wire,
 	.set_piomode	= winbond_set_piomode,
 };
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index ad064df..1996050 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1190,10 +1190,10 @@ static struct scsi_host_template sata_fsl_sht = {
 static const struct ata_port_operations sata_fsl_ops = {
 	.inherits = &sata_port_ops,
 
-	.check_status = sata_fsl_check_status,
-	.check_altstatus = sata_fsl_check_status,
+	.sff_check_status = sata_fsl_check_status,
+	.sff_check_altstatus = sata_fsl_check_status,
 
-	.tf_read = sata_fsl_tf_read,
+	.sff_tf_read = sata_fsl_tf_read,
 
 	.qc_prep = sata_fsl_qc_prep,
 	.qc_issue = sata_fsl_qc_issue,
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index 6e6fca4..0b5a736 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -222,7 +222,7 @@ static void inic_bmdma_setup(struct ata_queued_cmd *qc)
 	writeb(pp->cached_prdctl, port_base + PORT_PRD_CTL);
 
 	/* issue r/w command */
-	ap->ops->exec_command(ap, &qc->tf);
+	ap->ops->sff_exec_command(ap, &qc->tf);
 }
 
 static void inic_bmdma_start(struct ata_queued_cmd *qc)
@@ -267,14 +267,14 @@ static void inic_host_intr(struct ata_port *ap)
 			ata_qc_from_tag(ap, ap->link.active_tag);
 
 		if (unlikely(!qc || (qc->tf.flags & ATA_TFLAG_POLLING))) {
-			ap->ops->check_status(ap); /* clear ATA interrupt */
+			ap->ops->sff_check_status(ap); /* clear ATA interrupt */
 			return;
 		}
 
 		if (likely(ata_sff_host_intr(ap, qc)))
 			return;
 
-		ap->ops->check_status(ap); /* clear ATA interrupt */
+		ap->ops->sff_check_status(ap); /* clear ATA interrupt */
 		ata_port_printk(ap, KERN_WARNING, "unhandled "
 				"interrupt, irq_stat=%x\n", irq_stat);
 		return;
@@ -351,7 +351,7 @@ static unsigned int inic_qc_issue(struct ata_queued_cmd *qc)
 	 */
 	if (unlikely(qc->tf.command == ATA_CMD_ID_ATA ||
 		     qc->tf.command == ATA_CMD_ID_ATAPI)) {
-		u8 stat = ap->ops->check_status(ap);
+		u8 stat = ap->ops->sff_check_status(ap);
 		if (stat == 0x7f || stat == 0xff)
 			return AC_ERR_HSM;
 	}
@@ -365,7 +365,7 @@ static void inic_freeze(struct ata_port *ap)
 
 	__inic_set_pirq_mask(ap, PIRQ_MASK_FREEZE);
 
-	ap->ops->check_status(ap);
+	ap->ops->sff_check_status(ap);
 	writeb(0xff, port_base + PORT_IRQ_STAT);
 
 	readb(port_base + PORT_IRQ_STAT); /* flush */
@@ -375,7 +375,7 @@ static void inic_thaw(struct ata_port *ap)
 {
 	void __iomem *port_base = inic_port_base(ap);
 
-	ap->ops->check_status(ap);
+	ap->ops->sff_check_status(ap);
 	writeb(0xff, port_base + PORT_IRQ_STAT);
 
 	__inic_set_pirq_mask(ap, PIRQ_MASK_OTHER);
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index c30f267..043b590 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -429,11 +429,11 @@ static struct ata_port_operations nv_adma_ops = {
 	.inherits		= &nv_generic_ops,
 
 	.check_atapi_dma	= nv_adma_check_atapi_dma,
-	.tf_read		= nv_adma_tf_read,
+	.sff_tf_read		= nv_adma_tf_read,
 	.qc_defer		= ata_std_qc_defer,
 	.qc_prep		= nv_adma_qc_prep,
 	.qc_issue		= nv_adma_qc_issue,
-	.irq_clear		= nv_adma_irq_clear,
+	.sff_irq_clear		= nv_adma_irq_clear,
 
 	.freeze			= nv_adma_freeze,
 	.thaw			= nv_adma_thaw,
@@ -1440,7 +1440,7 @@ static irqreturn_t nv_generic_interrupt(int irq, void *dev_instance)
 			else
 				// No request pending?  Clear interrupt status
 				// anyway, in case there's one pending.
-				ap->ops->check_status(ap);
+				ap->ops->sff_check_status(ap);
 		}
 
 	}
@@ -1739,7 +1739,7 @@ static void nv_swncq_ncq_stop(struct ata_port *ap)
 		pp->dhfis_bits, pp->dmafis_bits, pp->sdbfis_bits);
 
 	ata_port_printk(ap, KERN_ERR, "ATA_REG 0x%X ERR_REG 0x%X\n",
-			ap->ops->check_status(ap),
+			ap->ops->sff_check_status(ap),
 			ioread8(ap->ioaddr.error_addr));
 
 	sactive = readl(pp->sactive_block);
@@ -1765,7 +1765,7 @@ static void nv_swncq_ncq_stop(struct ata_port *ap)
 	}
 
 	nv_swncq_pp_reinit(ap);
-	ap->ops->irq_clear(ap);
+	ap->ops->sff_irq_clear(ap);
 	__ata_bmdma_stop(ap);
 	nv_swncq_irq_clear(ap, 0xffff);
 }
@@ -1987,8 +1987,8 @@ static unsigned int nv_swncq_issue_atacmd(struct ata_port *ap,
 	pp->dmafis_bits &= ~(1 << qc->tag);
 	pp->qc_active |= (0x1 << qc->tag);
 
-	ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
-	ap->ops->exec_command(ap, &qc->tf);
+	ap->ops->sff_tf_load(ap, &qc->tf);	 /* load tf registers */
+	ap->ops->sff_exec_command(ap, &qc->tf);
 
 	DPRINTK("Issued tag %u\n", qc->tag);
 
@@ -2060,7 +2060,7 @@ static int nv_swncq_sdbfis(struct ata_port *ap)
 		return -EINVAL;
 	}
 
-	ap->ops->irq_clear(ap);
+	ap->ops->sff_irq_clear(ap);
 	__ata_bmdma_stop(ap);
 
 	sactive = readl(pp->sactive_block);
@@ -2182,7 +2182,7 @@ static void nv_swncq_host_interrupt(struct ata_port *ap, u16 fis)
 	u8 ata_stat;
 	int rc = 0;
 
-	ata_stat = ap->ops->check_status(ap);
+	ata_stat = ap->ops->sff_check_status(ap);
 	nv_swncq_irq_clear(ap, fis);
 	if (!fis)
 		return;
@@ -2245,7 +2245,7 @@ static void nv_swncq_host_interrupt(struct ata_port *ap, u16 fis)
 
 		if (!(fis & NV_SWNCQ_IRQ_DMASETUP) &&
 		    !(pp->ncq_flags & ncq_saw_dmas)) {
-			ata_stat = ap->ops->check_status(ap);
+			ata_stat = ap->ops->sff_check_status(ap);
 			if (ata_stat & ATA_BUSY)
 				goto irq_exit;
 
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index 74d033a..f7d3f89 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -162,12 +162,12 @@ static struct scsi_host_template pdc_ata_sht = {
 static const struct ata_port_operations pdc_common_ops = {
 	.inherits		= &ata_sff_port_ops,
 
-	.tf_load		= pdc_tf_load_mmio,
-	.exec_command		= pdc_exec_command_mmio,
+	.sff_tf_load		= pdc_tf_load_mmio,
+	.sff_exec_command	= pdc_exec_command_mmio,
 	.check_atapi_dma	= pdc_check_atapi_dma,
 	.qc_prep		= pdc_qc_prep,
 	.qc_issue		= pdc_qc_issue,
-	.irq_clear		= pdc_irq_clear,
+	.sff_irq_clear		= pdc_irq_clear,
 
 	.post_internal_cmd	= pdc_post_internal_cmd,
 	.error_handler		= pdc_error_handler,
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 987313b..88bf421 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -369,7 +369,7 @@ static void sil_host_intr(struct ata_port *ap, u32 bmdma2)
 
 	if (unlikely(!qc || (qc->tf.flags & ATA_TFLAG_POLLING))) {
 		/* this sometimes happens, just clear IRQ */
-		ap->ops->check_status(ap);
+		ap->ops->sff_check_status(ap);
 		return;
 	}
 
@@ -405,7 +405,7 @@ static void sil_host_intr(struct ata_port *ap, u32 bmdma2)
 	}
 
 	/* check main status, clearing INTRQ */
-	status = ap->ops->check_status(ap);
+	status = ap->ops->sff_check_status(ap);
 	if (unlikely(status & ATA_BUSY))
 		goto err_hsm;
 
@@ -480,7 +480,7 @@ static void sil_thaw(struct ata_port *ap)
 	u32 tmp;
 
 	/* clear IRQ */
-	ap->ops->check_status(ap);
+	ap->ops->sff_check_status(ap);
 	ata_sff_irq_clear(ap);
 
 	/* turn on SATA IRQ if supported */
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 67df1d7..b83851f 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -401,9 +401,9 @@ static struct scsi_host_template sil24_sht = {
 static struct ata_port_operations sil24_ops = {
 	.inherits		= &sata_pmp_port_ops,
 
-	.check_status		= sil24_check_status,
-	.check_altstatus	= sil24_check_status,
-	.tf_read		= sil24_tf_read,
+	.sff_check_status	= sil24_check_status,
+	.sff_check_altstatus	= sil24_check_status,
+	.sff_tf_read		= sil24_tf_read,
 	.qc_defer		= sil24_qc_defer,
 	.qc_prep		= sil24_qc_prep,
 	.qc_issue		= sil24_qc_issue,
diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index 8686d0f..92691cd 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -233,7 +233,7 @@ static void k2_bmdma_setup_mmio(struct ata_queued_cmd *qc)
 
 	/* issue r/w command if this is not a ATA DMA command*/
 	if (qc->tf.protocol != ATA_PROT_DMA)
-		ap->ops->exec_command(ap, &qc->tf);
+		ap->ops->sff_exec_command(ap, &qc->tf);
 }
 
 /**
@@ -269,7 +269,7 @@ static void k2_bmdma_start_mmio(struct ata_queued_cmd *qc)
 	   and the start command. */
 	/* issue r/w command if the access is to ATA*/
 	if (qc->tf.protocol == ATA_PROT_DMA)
-		ap->ops->exec_command(ap, &qc->tf);
+		ap->ops->sff_exec_command(ap, &qc->tf);
 }
 
 
@@ -336,9 +336,9 @@ static struct scsi_host_template k2_sata_sht = {
 
 static struct ata_port_operations k2_sata_ops = {
 	.inherits		= &ata_bmdma_port_ops,
-	.tf_load		= k2_sata_tf_load,
-	.tf_read		= k2_sata_tf_read,
-	.check_status		= k2_stat_check_status,
+	.sff_tf_load		= k2_sata_tf_load,
+	.sff_tf_read		= k2_sata_tf_read,
+	.sff_check_status	= k2_stat_check_status,
 	.check_atapi_dma	= k2_sata_check_atapi_dma,
 	.bmdma_setup		= k2_bmdma_setup_mmio,
 	.bmdma_start		= k2_bmdma_start_mmio,
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index c6b4a62..6e90be0 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -243,18 +243,18 @@ static struct scsi_host_template pdc_sata_sht = {
 
 /* TODO: inherit from base port_ops after converting to new EH */
 static struct ata_port_operations pdc_20621_ops = {
-	.tf_load		= pdc_tf_load_mmio,
-	.tf_read		= ata_sff_tf_read,
-	.check_status		= ata_sff_check_status,
-	.exec_command		= pdc_exec_command_mmio,
-	.dev_select		= ata_sff_dev_select,
+	.sff_tf_load		= pdc_tf_load_mmio,
+	.sff_tf_read		= ata_sff_tf_read,
+	.sff_check_status	= ata_sff_check_status,
+	.sff_exec_command	= pdc_exec_command_mmio,
+	.sff_dev_select		= ata_sff_dev_select,
 	.phy_reset		= pdc_20621_phy_reset,
 	.qc_prep		= pdc20621_qc_prep,
 	.qc_issue		= pdc20621_qc_issue,
-	.data_xfer		= ata_sff_data_xfer,
+	.sff_data_xfer		= ata_sff_data_xfer,
 	.eng_timeout		= pdc_eng_timeout,
-	.irq_clear		= pdc20621_irq_clear,
-	.irq_on			= ata_sff_irq_on,
+	.sff_irq_clear		= pdc20621_irq_clear,
+	.sff_irq_on		= ata_sff_irq_on,
 	.port_start		= pdc_port_start,
 };
 
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 9323bc2..e5df376 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -173,7 +173,7 @@ static void svia_noop_freeze(struct ata_port *ap)
 	/* Some VIA controllers choke if ATA_NIEN is manipulated in
 	 * certain way.  Leave it alone and just clear pending IRQ.
 	 */
-	ap->ops->check_status(ap);
+	ap->ops->sff_check_status(ap);
 	ata_sff_irq_clear(ap);
 }
 
diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index 2c3c769..f3d635c 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -251,7 +251,7 @@ static void vsc_port_intr(u8 port_status, struct ata_port *ap)
 	 * simply clear the interrupt
 	 */
 	if (unlikely(!handled))
-		ap->ops->check_status(ap);
+		ap->ops->sff_check_status(ap);
 }
 
 /*
@@ -306,8 +306,8 @@ static struct scsi_host_template vsc_sata_sht = {
 
 static struct ata_port_operations vsc_sata_ops = {
 	.inherits		= &ata_bmdma_port_ops,
-	.tf_load		= vsc_sata_tf_load,
-	.tf_read		= vsc_sata_tf_read,
+	.sff_tf_load		= vsc_sata_tf_load,
+	.sff_tf_read		= vsc_sata_tf_read,
 	.freeze			= vsc_freeze,
 	.thaw			= vsc_thaw,
 	.scr_read		= vsc_sata_scr_read,
diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 79fd243..5bddae1 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -5271,13 +5271,13 @@ static u8 ipr_ata_check_altstatus(struct ata_port *ap)
 }
 
 static struct ata_port_operations ipr_sata_ops = {
-	.check_status = ipr_ata_check_status,
-	.check_altstatus = ipr_ata_check_altstatus,
-	.dev_select = ata_noop_dev_select,
+	.sff_check_status = ipr_ata_check_status,
+	.sff_check_altstatus = ipr_ata_check_altstatus,
+	.sff_dev_select = ata_noop_dev_select,
 	.phy_reset = ipr_ata_phy_reset,
 	.hardreset = ipr_sata_reset,
 	.post_internal_cmd = ipr_ata_post_internal,
-	.tf_read = ipr_tf_read,
+	.sff_tf_read = ipr_tf_read,
 	.qc_prep = ata_noop_qc_prep,
 	.qc_issue = ipr_qc_issue,
 	.port_start = ata_sas_port_start,
diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index b0e5ac3..a1664b8 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -348,12 +348,12 @@ static int sas_ata_scr_read(struct ata_port *ap, unsigned int sc_reg_in,
 }
 
 static struct ata_port_operations sas_sata_ops = {
-	.check_status		= sas_ata_check_status,
-	.check_altstatus	= sas_ata_check_status,
-	.dev_select		= ata_noop_dev_select,
+	.sff_check_status	= sas_ata_check_status,
+	.sff_check_altstatus	= sas_ata_check_status,
+	.sff_dev_select		= ata_noop_dev_select,
 	.phy_reset		= sas_ata_phy_reset,
 	.post_internal_cmd	= sas_ata_post_internal,
-	.tf_read		= sas_ata_tf_read,
+	.sff_tf_read		= sas_ata_tf_read,
 	.qc_prep		= ata_noop_qc_prep,
 	.qc_issue		= sas_ata_qc_issue,
 	.port_start		= ata_sas_port_start,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 8ac1e13..defeadb 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -741,17 +741,18 @@ struct ata_port_operations {
 	/*
 	 * SFF / taskfile oriented ops
 	 */
-	void (*dev_select)(struct ata_port *ap, unsigned int device);
-	u8   (*check_status)(struct ata_port *ap);
-	u8   (*check_altstatus)(struct ata_port *ap);
-	void (*tf_load)(struct ata_port *ap, const struct ata_taskfile *tf);
-	void (*tf_read)(struct ata_port *ap, struct ata_taskfile *tf);
-	void (*exec_command)(struct ata_port *ap, const struct ata_taskfile *tf);
-	unsigned int (*data_xfer)(struct ata_device *dev, unsigned char *buf,
-				  unsigned int buflen, int rw);
-	u8   (*irq_on)(struct ata_port *);
-
-	void (*irq_clear)(struct ata_port *);
+	void (*sff_dev_select)(struct ata_port *ap, unsigned int device);
+	u8   (*sff_check_status)(struct ata_port *ap);
+	u8   (*sff_check_altstatus)(struct ata_port *ap);
+	void (*sff_tf_load)(struct ata_port *ap, const struct ata_taskfile *tf);
+	void (*sff_tf_read)(struct ata_port *ap, struct ata_taskfile *tf);
+	void (*sff_exec_command)(struct ata_port *ap,
+				 const struct ata_taskfile *tf);
+	unsigned int (*sff_data_xfer)(struct ata_device *dev,
+			unsigned char *buf, unsigned int buflen, int rw);
+	u8   (*sff_irq_on)(struct ata_port *);
+	void (*sff_irq_clear)(struct ata_port *);
+
 	void (*bmdma_setup)(struct ata_queued_cmd *qc);
 	void (*bmdma_start)(struct ata_queued_cmd *qc);
 	void (*bmdma_stop)(struct ata_queued_cmd *qc);
@@ -1456,7 +1457,7 @@ static inline u8 ata_sff_busy_wait(struct ata_port *ap, unsigned int bits,
 
 	do {
 		udelay(10);
-		status = ap->ops->check_status(ap);
+		status = ap->ops->sff_check_status(ap);
 		max--;
 	} while (status != 0xff && (status & bits) && (max > 0));
 
-- 
1.5.2.4

