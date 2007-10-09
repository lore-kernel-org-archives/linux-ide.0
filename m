From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/3] libata: use ata_exec_internal() for PMP register access
Date: Tue, 9 Oct 2007 15:06:48 +0900
Message-ID: <20071009060648.GN12186@htj.dyndns.org>
References: <20071009060544.GL12186@htj.dyndns.org> <20071009060610.GM12186@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:59385 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123AbXJIGG6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Oct 2007 02:06:58 -0400
Received: by rv-out-0910.google.com with SMTP id k20so961677rvb
        for <linux-ide@vger.kernel.org>; Mon, 08 Oct 2007 23:06:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20071009060610.GM12186@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

PMP registers used to be accessed with dedicated accessors ->pmp_read
and ->pmp_write.  During reset, those callbacks are called with the
port frozen so they should be able to run without depending on
interrupt delivery.  To achieve this, they were implemented polling.

However, as resetting the host port makes the PMP to isolate fan-out
ports until SError.X is cleared, resetting fan-out ports while port is
frozen doesn't buy much additional safety.

This patch updates libata PMP support such that PMP registers are
accessed using regular ata_exec_internal() mechanism and kills
->pmp_read/write() callbacks.  The following changes are made.

* PMP access helpers - sata_pmp_read_init_tf(), sata_pmp_read_val(),
  sata_pmp_write_init_tf() are folded into sata_pmp_read/write() which
  are now standalone PMP register access functions.

* sata_pmp_read/write() returns err_mask instead of rc.  This is
  consistent with other functions which issue internal commands and
  allows more detailed error reporting.

* ahci interrupt handler is modified to ignore BAD_PMP and
  spurious/illegal completion IRQs while reset is in progress.  These
  conditions are expected during reset.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c        |   48 +++--------
 drivers/ata/libata-core.c |    3 -
 drivers/ata/libata-eh.c   |   17 +++-
 drivers/ata/libata-pmp.c  |  209 ++++++++++++++++++++-------------------------
 drivers/ata/sata_sil24.c  |   30 -------
 include/linux/libata.h    |    8 --
 6 files changed, 118 insertions(+), 197 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index abfb72a..10bc3f6 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -239,8 +239,6 @@ static void ahci_freeze(struct ata_port *ap);
 static void ahci_thaw(struct ata_port *ap);
 static void ahci_pmp_attach(struct ata_port *ap);
 static void ahci_pmp_detach(struct ata_port *ap);
-static int ahci_pmp_read(struct ata_device *dev, int pmp, int reg, u32 *r_val);
-static int ahci_pmp_write(struct ata_device *dev, int pmp, int reg, u32 val);
 static void ahci_error_handler(struct ata_port *ap);
 static void ahci_vt8251_error_handler(struct ata_port *ap);
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc);
@@ -297,8 +295,6 @@ static const struct ata_port_operations ahci_ops = {
 
 	.pmp_attach		= ahci_pmp_attach,
 	.pmp_detach		= ahci_pmp_detach,
-	.pmp_read		= ahci_pmp_read,
-	.pmp_write		= ahci_pmp_write,
 
 #ifdef CONFIG_PM
 	.port_suspend		= ahci_port_suspend,
@@ -333,8 +329,6 @@ static const struct ata_port_operations ahci_vt8251_ops = {
 
 	.pmp_attach		= ahci_pmp_attach,
 	.pmp_detach		= ahci_pmp_detach,
-	.pmp_read		= ahci_pmp_read,
-	.pmp_write		= ahci_pmp_write,
 
 #ifdef CONFIG_PM
 	.port_suspend		= ahci_port_suspend,
@@ -1421,12 +1415,17 @@ static void ahci_port_intr(struct ata_port *ap)
 	struct ata_eh_info *ehi = &ap->link.eh_info;
 	struct ahci_port_priv *pp = ap->private_data;
 	struct ahci_host_priv *hpriv = ap->host->private_data;
+	int resetting = !!(ap->pflags & ATA_PFLAG_RESETTING);
 	u32 status, qc_active;
 	int rc, known_irq = 0;
 
 	status = readl(port_mmio + PORT_IRQ_STAT);
 	writel(status, port_mmio + PORT_IRQ_STAT);
 
+	/* ignore BAD_PMP while resetting */
+	if (unlikely(resetting))
+		status &= ~PORT_IRQ_BAD_PMP;
+
 	if (unlikely(status & PORT_IRQ_ERROR)) {
 		ahci_error_intr(ap, status);
 		return;
@@ -1464,6 +1463,13 @@ static void ahci_port_intr(struct ata_port *ap)
 		qc_active = readl(port_mmio + PORT_CMD_ISSUE);
 
 	rc = ata_qc_complete_multiple(ap, qc_active, NULL);
+
+	/* If resetting, spurious or invalid completions are expected,
+	 * return unconditionally.
+	 */
+	if (resetting)
+		return;
+
 	if (rc > 0)
 		return;
 	if (rc < 0) {
@@ -1701,36 +1707,6 @@ static void ahci_pmp_detach(struct ata_port *ap)
 	writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
 }
 
-static int ahci_pmp_read(struct ata_device *dev, int pmp, int reg, u32 *r_val)
-{
-	struct ata_port *ap = dev->link->ap;
-	struct ata_taskfile tf;
-	int rc;
-
-	ahci_kick_engine(ap, 0);
-
-	sata_pmp_read_init_tf(&tf, dev, pmp, reg);
-	rc = ahci_exec_polled_cmd(ap, SATA_PMP_CTRL_PORT, &tf, 1, 0,
-				  SATA_PMP_SCR_TIMEOUT);
-	if (rc == 0) {
-		ahci_tf_read(ap, &tf);
-		*r_val = sata_pmp_read_val(&tf);
-	}
-	return rc;
-}
-
-static int ahci_pmp_write(struct ata_device *dev, int pmp, int reg, u32 val)
-{
-	struct ata_port *ap = dev->link->ap;
-	struct ata_taskfile tf;
-
-	ahci_kick_engine(ap, 0);
-
-	sata_pmp_write_init_tf(&tf, dev, pmp, reg, val);
-	return ahci_exec_polled_cmd(ap, SATA_PMP_CTRL_PORT, &tf, 1, 0,
-				    SATA_PMP_SCR_TIMEOUT);
-}
-
 static int ahci_port_resume(struct ata_port *ap)
 {
 	ahci_power_up(ap);
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f80089e..c6fb926 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -7351,9 +7351,6 @@ EXPORT_SYMBOL_GPL(ata_pci_clear_simplex);
 #endif /* CONFIG_PCI */
 
 EXPORT_SYMBOL_GPL(sata_pmp_qc_defer_cmd_switch);
-EXPORT_SYMBOL_GPL(sata_pmp_read_init_tf);
-EXPORT_SYMBOL_GPL(sata_pmp_read_val);
-EXPORT_SYMBOL_GPL(sata_pmp_write_init_tf);
 EXPORT_SYMBOL_GPL(sata_pmp_std_prereset);
 EXPORT_SYMBOL_GPL(sata_pmp_std_hardreset);
 EXPORT_SYMBOL_GPL(sata_pmp_std_postreset);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 1f84e40..5a2b2af 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2557,7 +2557,11 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 
 	/* reset */
 	if (reset) {
-		ata_eh_freeze_port(ap);
+		/* if PMP is attached, this function only deals with
+		 * downstream links, port should stay thawed.
+		 */
+		if (!ap->nr_pmp_links)
+			ata_eh_freeze_port(ap);
 
 		ata_port_for_each_link(link, ap) {
 			struct ata_eh_context *ehc = &link->eh_context;
@@ -2575,7 +2579,8 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 			}
 		}
 
-		ata_eh_thaw_port(ap);
+		if (!ap->nr_pmp_links)
+			ata_eh_thaw_port(ap);
 	}
 
 	/* the rest */
@@ -2610,8 +2615,14 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 		if (ata_eh_handle_dev_fail(dev, rc))
 			nr_disabled_devs++;
 
-		if (ap->pflags & ATA_PFLAG_FROZEN)
+		if (ap->pflags & ATA_PFLAG_FROZEN) {
+			/* PMP reset requires working host port.
+			 * Can't retry if it's frozen.
+			 */
+			if (ap->nr_pmp_links)
+				goto out;
 			break;
+		}
 	}
 
 	if (nr_failed_devs) {
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 86ee4f6..19e5e5f 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -17,27 +17,35 @@
  *	@reg: register to read
  *	@r_val: resulting value
  *
- *	Wrapper around ap->ops->pmp_read to make it easier to call and
- *	nomarlize error return value.
+ *	Read PMP register.
  *
  *	LOCKING:
  *	Kernel thread context (may sleep).
  *
  *	RETURNS:
- *	0 on success, -errno on failure.
+ *	0 on success, AC_ERR_* mask on failure.
  */
-static int sata_pmp_read(struct ata_link *link, int reg, u32 *r_val)
+static unsigned int sata_pmp_read(struct ata_link *link, int reg, u32 *r_val)
 {
 	struct ata_port *ap = link->ap;
 	struct ata_device *pmp_dev = ap->link.device;
-	int rc;
-
-	might_sleep();
-
-	rc = ap->ops->pmp_read(pmp_dev, link->pmp, reg, r_val);
-	if (rc)
-		rc = -EIO;
-	return rc;
+	struct ata_taskfile tf;
+	unsigned int err_mask;
+
+	ata_tf_init(pmp_dev, &tf);
+	tf.command = ATA_CMD_PMP_READ;
+	tf.protocol = ATA_PROT_NODATA;
+	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	tf.feature = reg;
+	tf.device = link->pmp;
+
+	err_mask = ata_exec_internal(pmp_dev, &tf, NULL, DMA_NONE, NULL, 0,
+				     SATA_PMP_SCR_TIMEOUT);
+	if (err_mask)
+		return err_mask;
+
+	*r_val = tf.nsect | tf.lbal << 8 | tf.lbam << 16 | tf.lbah << 24;
+	return 0;
 }
 
 /**
@@ -46,27 +54,33 @@ static int sata_pmp_read(struct ata_link *link, int reg, u32 *r_val)
  *	@reg: register to write
  *	@r_val: value to write
  *
- *	Wrapper around ap->ops->pmp_write to make it easier to call
- *	and nomarlize error return value.
+ *	Write PMP register.
  *
  *	LOCKING:
  *	Kernel thread context (may sleep).
  *
  *	RETURNS:
- *	0 on success, -errno on failure.
+ *	0 on success, AC_ERR_* mask on failure.
  */
-static int sata_pmp_write(struct ata_link *link, int reg, u32 val)
+static unsigned int sata_pmp_write(struct ata_link *link, int reg, u32 val)
 {
 	struct ata_port *ap = link->ap;
 	struct ata_device *pmp_dev = ap->link.device;
-	int rc;
-
-	might_sleep();
-
-	rc = ap->ops->pmp_write(pmp_dev, link->pmp, reg, val);
-	if (rc)
-		rc = -EIO;
-	return rc;
+	struct ata_taskfile tf;
+
+	ata_tf_init(pmp_dev, &tf);
+	tf.command = ATA_CMD_PMP_WRITE;
+	tf.protocol = ATA_PROT_NODATA;
+	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	tf.feature = reg;
+	tf.device = link->pmp;
+	tf.nsect = val & 0xff;
+	tf.lbal = (val >> 8) & 0xff;
+	tf.lbam = (val >> 16) & 0xff;
+	tf.lbah = (val >> 24) & 0xff;
+
+	return ata_exec_internal(pmp_dev, &tf, NULL, DMA_NONE, NULL, 0,
+				 SATA_PMP_SCR_TIMEOUT);
 }
 
 /**
@@ -100,71 +114,6 @@ int sata_pmp_qc_defer_cmd_switch(struct ata_queued_cmd *qc)
 }
 
 /**
- *	sata_pmp_read_init_tf - initialize TF for PMP read
- *	@tf: taskfile to initialize
- *	@dev: PMP dev
- *	@pmp: port multiplier port number
- *	@reg: register to read
- *
- *	Initialize @tf for PMP read command.
- *
- *	LOCKING:
- *	None.
- */
-void sata_pmp_read_init_tf(struct ata_taskfile *tf,
-			   struct ata_device *dev, int pmp, int reg)
-{
-	ata_tf_init(dev, tf);
-	tf->command = ATA_CMD_PMP_READ;
-	tf->protocol = ATA_PROT_NODATA;
-	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
-	tf->feature = reg;
-	tf->device = pmp;
-}
-
-/**
- *	sata_pmp_read_val - extract PMP read result from TF
- *	@tf: target TF
- *
- *	Determine PMP read result from @tf.
- *
- *	LOCKING:
- *	None.
- */
-u32 sata_pmp_read_val(const struct ata_taskfile *tf)
-{
-	return tf->nsect | tf->lbal << 8 | tf->lbam << 16 | tf->lbah << 24;
-}
-
-/**
- *	sata_pmp_read_init_tf - initialize TF for PMP write
- *	@tf: taskfile to initialize
- *	@dev: PMP dev
- *	@pmp: port multiplier port number
- *	@reg: register to read
- *	@val: value to write
- *
- *	Initialize @tf for PMP write command.
- *
- *	LOCKING:
- *	None.
- */
-void sata_pmp_write_init_tf(struct ata_taskfile *tf,
-			    struct ata_device *dev, int pmp, int reg, u32 val)
-{
-	ata_tf_init(dev, tf);
-	tf->command = ATA_CMD_PMP_WRITE;
-	tf->protocol = ATA_PROT_NODATA;
-	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
-	tf->feature = reg;
-	tf->device = pmp;
-	tf->nsect = val & 0xff;
-	tf->lbal = (val >> 8) & 0xff;
-	tf->lbam = (val >> 16) & 0xff;
-	tf->lbah = (val >> 24) & 0xff;
-}
-
-/**
  *	sata_pmp_scr_read - read PSCR
  *	@link: ATA link to read PSCR for
  *	@reg: PSCR to read
@@ -181,10 +130,18 @@ void sata_pmp_write_init_tf(struct ata_taskfile *tf,
  */
 int sata_pmp_scr_read(struct ata_link *link, int reg, u32 *r_val)
 {
+	unsigned int err_mask;
+
 	if (reg > SATA_PMP_PSCR_CONTROL)
 		return -EINVAL;
 
-	return sata_pmp_read(link, reg, r_val);
+	err_mask = sata_pmp_read(link, reg, r_val);
+	if (err_mask) {
+		ata_link_printk(link, KERN_WARNING, "failed to read SCR %d "
+				"(Emask=0x%x)\n", reg, err_mask);
+		return -EIO;
+	}
+	return 0;
 }
 
 /**
@@ -204,10 +161,18 @@ int sata_pmp_scr_read(struct ata_link *link, int reg, u32 *r_val)
  */
 int sata_pmp_scr_write(struct ata_link *link, int reg, u32 val)
 {
+	unsigned int err_mask;
+
 	if (reg > SATA_PMP_PSCR_CONTROL)
 		return -EINVAL;
 
-	return sata_pmp_write(link, reg, val);
+	err_mask = sata_pmp_write(link, reg, val);
+	if (err_mask) {
+		ata_link_printk(link, KERN_WARNING, "failed to write SCR %d "
+				"(Emask=0x%x)\n", reg, err_mask);
+		return -EIO;
+	}
+	return 0;
 }
 
 /**
@@ -361,16 +326,17 @@ void sata_pmp_std_postreset(struct ata_link *link, unsigned int *class)
 static int sata_pmp_read_gscr(struct ata_device *dev, u32 *gscr)
 {
 	static const int gscr_to_read[] = { 0, 1, 2, 32, 33, 64, 96 };
-	int i, rc;
+	int i;
 
 	for (i = 0; i < ARRAY_SIZE(gscr_to_read); i++) {
 		int reg = gscr_to_read[i];
+		unsigned int err_mask;
 
-		rc = sata_pmp_read(dev->link, reg, &gscr[reg]);
-		if (rc) {
-			ata_dev_printk(dev, KERN_ERR, "failed to read "
-				       "PMP GSCR[%d] (errno=%d)\n", reg, rc);
-			return rc;
+		err_mask = sata_pmp_read(dev->link, reg, &gscr[reg]);
+		if (err_mask) {
+			ata_dev_printk(dev, KERN_ERR, "failed to read PMP "
+				"GSCR[%d] (Emask=0x%x)\n", reg, err_mask);
+			return -EIO;
 		}
 	}
 
@@ -392,6 +358,7 @@ static int sata_pmp_configure(struct ata_device *dev, int print_info)
 {
 	struct ata_port *ap = dev->link->ap;
 	u32 *gscr = dev->gscr;
+	unsigned int err_mask = 0;
 	const char *reason;
 	int nr_ports, rc;
 
@@ -408,8 +375,10 @@ static int sata_pmp_configure(struct ata_device *dev, int print_info)
 		dev->flags |= ATA_DFLAG_AN;
 
 	/* monitor SERR_PHYRDY_CHG on fan-out ports */
-	rc = sata_pmp_write(dev->link, SATA_PMP_GSCR_ERROR_EN, SERR_PHYRDY_CHG);
-	if (rc) {
+	err_mask = sata_pmp_write(dev->link, SATA_PMP_GSCR_ERROR_EN,
+				  SERR_PHYRDY_CHG);
+	if (err_mask) {
+		rc = -EIO;
 		reason = "failed to write GSCR_ERROR_EN";
 		goto fail;
 	}
@@ -418,9 +387,10 @@ static int sata_pmp_configure(struct ata_device *dev, int print_info)
 	if (gscr[SATA_PMP_GSCR_FEAT_EN] & SATA_PMP_FEAT_NOTIFY) {
 		gscr[SATA_PMP_GSCR_FEAT_EN] &= ~SATA_PMP_FEAT_NOTIFY;
 
-		rc = sata_pmp_write(dev->link, SATA_PMP_GSCR_FEAT_EN,
-				    gscr[SATA_PMP_GSCR_FEAT_EN]);
-		if (rc) {
+		err_mask = sata_pmp_write(dev->link, SATA_PMP_GSCR_FEAT_EN,
+					  gscr[SATA_PMP_GSCR_FEAT_EN]);
+		if (err_mask) {
+			rc = -EIO;
 			reason = "failed to write GSCR_FEAT_EN";
 			goto fail;
 		}
@@ -447,7 +417,8 @@ static int sata_pmp_configure(struct ata_device *dev, int print_info)
 
  fail:
 	ata_dev_printk(dev, KERN_ERR,
-		       "failed to configure Port Multiplier (%s)\n", reason);
+		       "failed to configure Port Multiplier (%s, Emask=0x%x)\n",
+		       reason, err_mask);
 	return rc;
 }
 
@@ -804,13 +775,14 @@ static int sata_pmp_revalidate(struct ata_device *dev, unsigned int new_class)
  */
 static int sata_pmp_revalidate_quick(struct ata_device *dev)
 {
+	unsigned int err_mask;
 	u32 prod_id;
-	int rc;
 
-	rc = sata_pmp_read(dev->link, SATA_PMP_GSCR_PROD_ID, &prod_id);
-	if (rc) {
-		ata_dev_printk(dev, KERN_ERR, "failed to read PMP product ID\n");
-		return rc;
+	err_mask = sata_pmp_read(dev->link, SATA_PMP_GSCR_PROD_ID, &prod_id);
+	if (err_mask) {
+		ata_dev_printk(dev, KERN_ERR, "failed to read PMP product ID "
+			       "(Emask=0x%x)\n", err_mask);
+		return -EIO;
 	}
 
 	if (prod_id != dev->gscr[SATA_PMP_GSCR_PROD_ID]) {
@@ -1041,6 +1013,7 @@ static int sata_pmp_eh_recover(struct ata_port *ap,
 	struct ata_eh_context *pmp_ehc = &pmp_link->eh_context;
 	struct ata_link *link;
 	struct ata_device *dev;
+	unsigned int err_mask;
 	u32 gscr_error, sntf;
 	int cnt, rc;
 
@@ -1099,20 +1072,22 @@ static int sata_pmp_eh_recover(struct ata_port *ap,
 	if (pmp_dev->flags & ATA_DFLAG_AN) {
 		pmp_dev->gscr[SATA_PMP_GSCR_FEAT_EN] |= SATA_PMP_FEAT_NOTIFY;
 
-		rc = sata_pmp_write(pmp_dev->link, SATA_PMP_GSCR_FEAT_EN,
-				    pmp_dev->gscr[SATA_PMP_GSCR_FEAT_EN]);
-		if (rc) {
-			ata_dev_printk(pmp_dev, KERN_ERR,
-				       "failed to write PMP_FEAT_EN\n");
+		err_mask = sata_pmp_write(pmp_dev->link, SATA_PMP_GSCR_FEAT_EN,
+					  pmp_dev->gscr[SATA_PMP_GSCR_FEAT_EN]);
+		if (err_mask) {
+			ata_dev_printk(pmp_dev, KERN_ERR, "failed to write "
+				       "PMP_FEAT_EN (Emask=0x%x)\n", err_mask);
+			rc = -EIO;
 			goto pmp_fail;
 		}
 	}
 
 	/* check GSCR_ERROR */
-	rc = sata_pmp_read(pmp_link, SATA_PMP_GSCR_ERROR, &gscr_error);
-	if (rc) {
-		ata_dev_printk(pmp_dev, KERN_ERR,
-			       "failed to read PMP_GSCR_ERROR\n");
+	err_mask = sata_pmp_read(pmp_link, SATA_PMP_GSCR_ERROR, &gscr_error);
+	if (err_mask) {
+		ata_dev_printk(pmp_dev, KERN_ERR, "failed to read "
+			       "PMP_GSCR_ERROR (Emask=0x%x)\n", err_mask);
+		rc = -EIO;
 		goto pmp_fail;
 	}
 
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 15b9a80..b061927 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -337,8 +337,6 @@ static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc);
 static void sil24_irq_clear(struct ata_port *ap);
 static void sil24_pmp_attach(struct ata_port *ap);
 static void sil24_pmp_detach(struct ata_port *ap);
-static int sil24_pmp_read(struct ata_device *dev, int pmp, int reg, u32 *r_val);
-static int sil24_pmp_write(struct ata_device *dev, int pmp, int reg, u32 val);
 static void sil24_freeze(struct ata_port *ap);
 static void sil24_thaw(struct ata_port *ap);
 static void sil24_error_handler(struct ata_port *ap);
@@ -411,8 +409,6 @@ static const struct ata_port_operations sil24_ops = {
 
 	.pmp_attach		= sil24_pmp_attach,
 	.pmp_detach		= sil24_pmp_detach,
-	.pmp_read		= sil24_pmp_read,
-	.pmp_write		= sil24_pmp_write,
 
 	.freeze			= sil24_freeze,
 	.thaw			= sil24_thaw,
@@ -928,32 +924,6 @@ static void sil24_pmp_detach(struct ata_port *ap)
 	sil24_config_pmp(ap, 0);
 }
 
-static int sil24_pmp_read(struct ata_device *dev, int pmp, int reg, u32 *r_val)
-{
-	struct ata_port *ap = dev->link->ap;
-	struct ata_taskfile tf;
-	int rc;
-
-	sata_pmp_read_init_tf(&tf, dev, pmp, reg);
-	rc = sil24_exec_polled_cmd(ap, SATA_PMP_CTRL_PORT, &tf, 1, 0,
-				   SATA_PMP_SCR_TIMEOUT);
-	if (rc == 0) {
-		sil24_read_tf(ap, 0, &tf);
-		*r_val = sata_pmp_read_val(&tf);
-	}
-	return rc;
-}
-
-static int sil24_pmp_write(struct ata_device *dev, int pmp, int reg, u32 val)
-{
-	struct ata_port *ap = dev->link->ap;
-	struct ata_taskfile tf;
-
-	sata_pmp_write_init_tf(&tf, dev, pmp, reg, val);
-	return sil24_exec_polled_cmd(ap, SATA_PMP_CTRL_PORT, &tf, 1, 0,
-				     SATA_PMP_SCR_TIMEOUT);
-}
-
 static int sil24_pmp_softreset(struct ata_link *link, unsigned int *class,
 			       unsigned long deadline)
 {
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 9f2da92..c1dd6f7 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -669,8 +669,6 @@ struct ata_port_operations {
 	/* port multiplier */
 	void (*pmp_attach) (struct ata_port *ap);
 	void (*pmp_detach) (struct ata_port *ap);
-	int (*pmp_read) (struct ata_device *dev, int pmp, int reg, u32 *r_val);
-	int (*pmp_write) (struct ata_device *dev, int pmp, int reg, u32 val);
 
 	/* Error handlers.  ->error_handler overrides ->eng_timeout and
 	 * indicates that new-style EH is in place.
@@ -955,12 +953,6 @@ extern unsigned long ata_pci_default_filter(struct ata_device *, unsigned long);
  * PMP
  */
 extern int sata_pmp_qc_defer_cmd_switch(struct ata_queued_cmd *qc);
-extern void sata_pmp_read_init_tf(struct ata_taskfile *tf,
-				  struct ata_device *dev, int pmp, int reg);
-extern u32 sata_pmp_read_val(const struct ata_taskfile *tf);
-extern void sata_pmp_write_init_tf(struct ata_taskfile *tf,
-				   struct ata_device *dev,
-				   int pmp, int reg, u32 val);
 extern int sata_pmp_std_prereset(struct ata_link *link, unsigned long deadline);
 extern int sata_pmp_std_hardreset(struct ata_link *link, unsigned int *class,
 				  unsigned long deadline);
-- 
1.5.0.3

