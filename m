From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/14] libata-link: linkify reset
Date: Fri, 12 May 2006 01:30:23 +0900
Message-ID: <11473650232818-git-send-email-htejun@gmail.com>
References: <11473650221713-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.228]:23435 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751698AbWEKQag (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:30:36 -0400
Received: by wr-out-0506.google.com with SMTP id 55so367439wri
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:30:36 -0700 (PDT)
In-Reply-To: <11473650221713-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make reset methods and related functions deal with ata_link instead of
ata_port.

* ata_eh_about_to_do()
* ata_do_reset()
* ata_eh_reset()
* all prereset/reset/postreset methods

This patch introduces no behavior change.

---

 drivers/scsi/ahci.c        |   31 ++++++++++++++++-----------
 drivers/scsi/ata_piix.c    |   14 +++++++-----
 drivers/scsi/libata-core.c |   36 +++++++++++++++++---------------
 drivers/scsi/libata-eh.c   |   50 ++++++++++++++++++++++----------------------
 drivers/scsi/sata_sil24.c  |   20 ++++++++++--------
 include/linux/libata.h     |   15 +++++++------
 6 files changed, 89 insertions(+), 77 deletions(-)

d3d6129dc940ccbb72c4bb834482456776342b84
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index d4420ac..3254cd2 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -562,19 +562,22 @@ static int ahci_clo(struct ata_port *ap)
 	return 0;
 }
 
-static int ahci_prereset(struct ata_port *ap)
+static int ahci_prereset(struct ata_link *link)
 {
+	struct ata_port *ap = link->ap;
+
 	if ((ap->flags & AHCI_FLAG_RESET_NEEDS_CLO) &&
 	    (ata_busy_wait(ap, ATA_BUSY, 1000) & ATA_BUSY)) {
 		/* ATA_BUSY hasn't cleared, so send a CLO */
 		ahci_clo(ap);
 	}
 
-	return ata_std_prereset(ap);
+	return ata_std_prereset(link);
 }
 
-static int ahci_softreset(struct ata_port *ap, unsigned int *class)
+static int ahci_softreset(struct ata_link *link, unsigned int *class)
 {
+	struct ata_port *ap = link->ap;
 	struct ahci_port_priv *pp = ap->private_data;
 	void __iomem *mmio = ap->host_set->mmio_base;
 	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
@@ -587,7 +590,7 @@ static int ahci_softreset(struct ata_por
 
 	DPRINTK("ENTER\n");
 
-	if (ata_link_offline(&ap->link)) {
+	if (ata_link_offline(link)) {
 		DPRINTK("PHY reports no device\n");
 		*class = ATA_DEV_NONE;
 		return 0;
@@ -617,7 +620,7 @@ static int ahci_softreset(struct ata_por
 	/* restart engine */
 	ahci_start_engine(ap);
 
-	ata_tf_init(ap->link.device, &tf);
+	ata_tf_init(link->device, &tf);
 	fis = pp->cmd_tbl;
 
 	/* issue the first D2H Register FIS */
@@ -661,7 +664,7 @@ static int ahci_softreset(struct ata_por
 	msleep(150);
 
 	*class = ATA_DEV_NONE;
-	if (ata_link_online(&ap->link)) {
+	if (ata_link_online(link)) {
 		if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
 			rc = -EIO;
 			reason = "device not ready";
@@ -676,21 +679,22 @@ static int ahci_softreset(struct ata_por
  fail_restart:
 	ahci_start_engine(ap);
  fail:
-	ata_port_printk(ap, KERN_ERR, "softreset failed (%s)\n", reason);
+	ata_link_printk(link, KERN_ERR, "softreset failed (%s)\n", reason);
 	return rc;
 }
 
-static int ahci_hardreset(struct ata_port *ap, unsigned int *class)
+static int ahci_hardreset(struct ata_link *link, unsigned int *class)
 {
+	struct ata_port *ap = link->ap;
 	int rc;
 
 	DPRINTK("ENTER\n");
 
 	ahci_stop_engine(ap);
-	rc = sata_std_hardreset(ap, class);
+	rc = sata_std_hardreset(link, class);
 	ahci_start_engine(ap);
 
-	if (rc == 0 && ata_link_online(&ap->link))
+	if (rc == 0 && ata_link_online(link))
 		*class = ahci_dev_classify(ap);
 	if (*class == ATA_DEV_UNKNOWN)
 		*class = ATA_DEV_NONE;
@@ -699,17 +703,18 @@ static int ahci_hardreset(struct ata_por
 	return rc;
 }
 
-static void ahci_postreset(struct ata_port *ap, unsigned int *class)
+static void ahci_postreset(struct ata_link *link, unsigned int *class)
 {
+	struct ata_port *ap = link->ap;
 	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
 	unsigned long flags;
 	u32 new_tmp, tmp;
 
-	ata_std_postreset(ap, class);
+	ata_std_postreset(link, class);
 
 	/* clear stored SError */
 	spin_lock_irqsave(&ap->host_set->lock, flags);
-	ap->link.eh_info.serror = 0;
+	link->eh_info.serror = 0;
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
 	/* Make sure port's ATAPI bit is set appropriately */
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 47d3fec..11c44ec 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -458,15 +458,16 @@ cbl40:
 
 /**
  *	piix_pata_prereset - prereset for PATA host controller
- *	@ap: Target port
+ *	@link: Target link
  *
  *	Prereset including cable detection.
  *
  *	LOCKING:
  *	None (inherited from caller).
  */
-static int piix_pata_prereset(struct ata_port *ap)
+static int piix_pata_prereset(struct ata_link *link)
 {
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 
 	if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->hard_port_no])) {
@@ -476,7 +477,7 @@ static int piix_pata_prereset(struct ata
 
 	piix_pata_cbl_detect(ap);
 
-	return ata_std_prereset(ap);
+	return ata_std_prereset(link);
 }
 
 static void piix_pata_error_handler(struct ata_port *ap)
@@ -487,7 +488,7 @@ static void piix_pata_error_handler(stru
 
 /**
  *	piix_sata_prereset - prereset for SATA host controller
- *	@ap: Target port
+ *	@link: Target link
  *
  *	Reads and configures SATA PCI device's PCI config register
  *	Port Configuration and Status (PCS) to determine port and
@@ -500,8 +501,9 @@ static void piix_pata_error_handler(stru
  *	RETURNS:
  *	0 if device is present, -ENODEV otherwise.
  */
-static int piix_sata_prereset(struct ata_port *ap)
+static int piix_sata_prereset(struct ata_link *link)
 {
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	const unsigned int *map = ap->host_set->private_data;
 	int base = 2 * ap->hard_port_no;
@@ -547,7 +549,7 @@ static int piix_sata_prereset(struct ata
 		return -ENODEV;
 	}
 
-	return ata_std_prereset(ap);
+	return ata_std_prereset(link);
 }
 
 static void piix_sata_error_handler(struct ata_port *ap)
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 9680359..6dc370f 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2521,9 +2521,9 @@ int sata_link_resume(struct ata_link *li
 
 /**
  *	ata_std_prereset - prepare for reset
- *	@ap: ATA port to be reset
+ *	@link: ATA link to be reset
  *
- *	@ap is about to be reset.  Initialize it.
+ *	@link is about to be reset.  Initialize it.
  *
  *	LOCKING:
  *	Kernel thread context (may sleep)
@@ -2531,20 +2531,21 @@ int sata_link_resume(struct ata_link *li
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int ata_std_prereset(struct ata_port *ap)
+int ata_std_prereset(struct ata_link *link)
 {
+	struct ata_port *ap = link->ap;
 	int boot_probe = ap->flags & ATA_FLAG_LOADING;
 	int rc;
 
 	/* if we're about to do hardreset, don't bother */
-	if (ap->link.eh_context.i.action & ATA_EH_HARDRESET)
+	if (link->eh_context.i.action & ATA_EH_HARDRESET)
 		return 0;
 
 	/* resume link */
-	rc = sata_link_resume(&ap->link, boot_probe);
+	rc = sata_link_resume(link, boot_probe);
 	if (rc && rc != -EOPNOTSUPP) {
 		/* phy resume failed, whine but continue */
-		ata_port_printk(ap, KERN_WARNING, "failed to resume link "
+		ata_link_printk(link, KERN_WARNING, "failed to resume link "
 				"for reset (errno=%d)\n", rc);
 	}
 
@@ -2554,7 +2555,7 @@ int ata_std_prereset(struct ata_port *ap
 	 * cases.  As we wait for !BSY after resets, this should be
 	 * safe.
 	 */
-	if (boot_probe && !ata_link_offline(&ap->link))
+	if (boot_probe && !ata_link_offline(link))
 		ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
 
 	return 0;
@@ -2562,7 +2563,7 @@ int ata_std_prereset(struct ata_port *ap
 
 /**
  *	ata_std_softreset - reset host port via ATA SRST
- *	@ap: port to reset
+ *	@link: ATA link to reset
  *	@classes: resulting classes of attached devices
  *
  *	Reset host port using ATA SRST.
@@ -2573,15 +2574,16 @@ int ata_std_prereset(struct ata_port *ap
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int ata_std_softreset(struct ata_port *ap, unsigned int *classes)
+int ata_std_softreset(struct ata_link *link, unsigned int *classes)
 {
+	struct ata_port *ap = link->ap;
 	unsigned int slave_possible = ap->flags & ATA_FLAG_SLAVE_POSS;
 	unsigned int devmask = 0, err_mask;
 	u8 err;
 
 	DPRINTK("ENTER\n");
 
-	if (ata_link_offline(&ap->link)) {
+	if (ata_link_offline(link)) {
 		classes[0] = ATA_DEV_NONE;
 		goto out;
 	}
@@ -2599,7 +2601,7 @@ int ata_std_softreset(struct ata_port *a
 	DPRINTK("about to softreset, devmask=%x\n", devmask);
 	err_mask = ata_bus_softreset(ap, devmask);
 	if (err_mask) {
-		ata_port_printk(ap, KERN_ERR, "SRST failed (err_mask=0x%x)\n",
+		ata_link_printk(link, KERN_ERR, "SRST failed (err_mask=0x%x)\n",
 				err_mask);
 		return -EIO;
 	}
@@ -2616,7 +2618,7 @@ int ata_std_softreset(struct ata_port *a
 
 /**
  *	sata_std_hardreset - reset host port via SATA phy reset
- *	@ap: port to reset
+ *	@link: link to reset
  *	@class: resulting class of attached device
  *
  *	SATA phy-reset host port using DET bits of SControl register.
@@ -2627,9 +2629,9 @@ int ata_std_softreset(struct ata_port *a
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int sata_std_hardreset(struct ata_port *ap, unsigned int *class)
+int sata_std_hardreset(struct ata_link *link, unsigned int *class)
 {
-	struct ata_link *link = &ap->link;
+	struct ata_port *ap = link->ap;
 	u32 scontrol;
 	int rc;
 
@@ -2692,7 +2694,7 @@ int sata_std_hardreset(struct ata_port *
 
 /**
  *	ata_std_postreset - standard postreset callback
- *	@ap: the target ata_port
+ *	@link: the target ata_link
  *	@classes: classes of attached devices
  *
  *	This function is invoked after a successful reset.  Note that
@@ -2702,9 +2704,9 @@ int sata_std_hardreset(struct ata_port *
  *	LOCKING:
  *	Kernel thread context (may sleep)
  */
-void ata_std_postreset(struct ata_port *ap, unsigned int *classes)
+void ata_std_postreset(struct ata_link *link, unsigned int *classes)
 {
-	struct ata_link *link = &ap->link;
+	struct ata_port *ap = link->ap;
 	u32 serror;
 
 	DPRINTK("ENTER\n");
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 7ade712..7e5a03a 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -673,22 +673,23 @@ static void ata_eh_detach_dev(struct ata
 
 /**
  *	ata_eh_about_to_do - about to perform eh_action
- *	@ap: target ATA port
+ *	@link: target ATA link
  *	@action: action about to be performed
  *
  *	Called just before performing EH actions to clear related bits
- *	in @ap->eh_info such that eh actions are not unnecessarily
+ *	in @link->eh_info such that eh actions are not unnecessarily
  *	repeated.
  *
  *	LOCKING:
  *	None.
  */
-static void ata_eh_about_to_do(struct ata_port *ap, unsigned int action)
+static void ata_eh_about_to_do(struct ata_link *link, unsigned int action)
 {
+	struct ata_port *ap = link->ap;
 	unsigned long flags;
 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
-	ap->link.eh_info.action &= ~action;
+	link->eh_info.action &= ~action;
 	ap->flags |= ATA_FLAG_RECOVERED;
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 }
@@ -1324,16 +1325,16 @@ static void ata_eh_report(struct ata_por
 	}
 }
 
-static int ata_do_reset(struct ata_port *ap, ata_reset_fn_t reset,
+static int ata_do_reset(struct ata_link *link, ata_reset_fn_t reset,
 			unsigned int *classes)
 {
 	struct ata_device *dev;
 	int rc;
 
-	ata_link_for_each_dev(dev, &ap->link)
+	ata_link_for_each_dev(dev, link)
 		classes[dev->devno] = ATA_DEV_UNKNOWN;
 
-	rc = reset(ap, classes);
+	rc = reset(link, classes);
 	if (rc)
 		return rc;
 
@@ -1341,12 +1342,12 @@ static int ata_do_reset(struct ata_port 
 	 * is complete and convert all ATA_DEV_UNKNOWN to
 	 * ATA_DEV_NONE.
 	 */
-	ata_link_for_each_dev(dev, &ap->link)
+	ata_link_for_each_dev(dev, link)
 		if (classes[dev->devno] != ATA_DEV_UNKNOWN)
 			break;
 
 	if (dev)
-		ata_link_for_each_dev(dev, &ap->link)
+		ata_link_for_each_dev(dev, link)
 			if (classes[dev->devno] == ATA_DEV_UNKNOWN)
 				classes[dev->devno] = ATA_DEV_NONE;
 
@@ -1365,15 +1366,14 @@ static int ata_eh_followup_srst_needed(i
 	return 0;
 }
 
-static int ata_eh_reset(struct ata_port *ap, int classify,
+static int ata_eh_reset(struct ata_link *link, int classify,
 			ata_prereset_fn_t prereset, ata_reset_fn_t softreset,
 			ata_reset_fn_t hardreset, ata_postreset_fn_t postreset)
 {
-	struct ata_link *link = &ap->link;
 	struct ata_eh_context *ehc = &link->eh_context;
 	unsigned int *classes = ehc->classes;
 	int tries = ATA_EH_RESET_TRIES;
-	int verbose = !(ap->flags & ATA_FLAG_LOADING);
+	int verbose = !(link->ap->flags & ATA_FLAG_LOADING);
 	unsigned int action;
 	ata_reset_fn_t reset;
 	int did_followup_srst, rc;
@@ -1394,7 +1394,7 @@ static int ata_eh_reset(struct ata_port 
 	}
 
 	if (prereset) {
-		rc = prereset(ap);
+		rc = prereset(link);
 
 		/* prereset can short-circuit resetting by returning
 		 * -ENODEV.
@@ -1407,7 +1407,7 @@ static int ata_eh_reset(struct ata_port 
 		}
 
 		if (rc) {
-			ata_port_printk(ap, KERN_ERR,
+			ata_link_printk(link, KERN_ERR,
 					"prereset failed (errno=%d)\n", rc);
 			return rc;
 		}
@@ -1416,14 +1416,14 @@ static int ata_eh_reset(struct ata_port 
  retry:
 	/* shut up during boot probing */
 	if (verbose)
-		ata_port_printk(ap, KERN_INFO, "%s resetting port\n",
+		ata_link_printk(link, KERN_INFO, "%s resetting port\n",
 				reset == softreset ? "soft" : "hard");
 
 	/* reset */
-	ata_eh_about_to_do(ap, ATA_EH_RESET_MASK);
+	ata_eh_about_to_do(link, ATA_EH_RESET_MASK);
 	ehc->flags |= ATA_EHC_DID_RESET;
 
-	rc = ata_do_reset(ap, reset, classes);
+	rc = ata_do_reset(link, reset, classes);
 
 	did_followup_srst = 0;
 	if (reset == hardreset &&
@@ -1433,18 +1433,18 @@ static int ata_eh_reset(struct ata_port 
 		reset = softreset;
 
 		if (!reset) {
-			ata_port_printk(ap, KERN_ERR,
+			ata_link_printk(link, KERN_ERR,
 					"follow-up softreset required "
 					"but no softreset avaliable\n");
 			return -EINVAL;
 		}
 
-		ata_eh_about_to_do(ap, ATA_EH_RESET_MASK);
-		rc = ata_do_reset(ap, reset, classes);
+		ata_eh_about_to_do(link, ATA_EH_RESET_MASK);
+		rc = ata_do_reset(link, reset, classes);
 
 		if (rc == 0 && classify &&
 		    classes[0] == ATA_DEV_UNKNOWN) {
-			ata_port_printk(ap, KERN_ERR,
+			ata_link_printk(link, KERN_ERR,
 					"classification failed\n");
 			return -EINVAL;
 		}
@@ -1461,7 +1461,7 @@ static int ata_eh_reset(struct ata_port 
 		} else
 			type = "hard";
 
-		ata_port_printk(ap, KERN_WARNING,
+		ata_link_printk(link, KERN_WARNING,
 				"%sreset failed, retrying in 5 secs\n", type);
 		ssleep(5);
 
@@ -1474,7 +1474,7 @@ static int ata_eh_reset(struct ata_port 
 
 	if (rc == 0) {
 		if (postreset)
-			postreset(ap, classes);
+			postreset(link, classes);
 
 		/* reset successful, schedule revalidation */
 		ehc->i.dev = NULL;
@@ -1503,7 +1503,7 @@ static int ata_eh_revalidate_and_attach(
 				break;
 			}
 
-			ata_eh_about_to_do(ap, ATA_EH_REVALIDATE);
+			ata_eh_about_to_do(&ap->link, ATA_EH_REVALIDATE);
 			rc = ata_dev_revalidate(dev,
 						ehc->flags & ATA_EHC_DID_RESET);
 			if (rc)
@@ -1641,7 +1641,7 @@ static int ata_eh_recover(struct ata_por
 	if (ehc->i.action & ATA_EH_RESET_MASK) {
 		ata_eh_freeze_port(ap);
 
-		rc = ata_eh_reset(ap, ata_port_nr_vacant(ap), prereset,
+		rc = ata_eh_reset(&ap->link, ata_port_nr_vacant(ap), prereset,
 				  softreset, hardreset, postreset);
 		if (rc) {
 			ata_port_printk(ap, KERN_ERR,
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 51fceac..103e5d3 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -509,8 +509,9 @@ static int sil24_init_port(struct ata_po
 	return 0;
 }
 
-static int sil24_softreset(struct ata_port *ap, unsigned int *class)
+static int sil24_softreset(struct ata_link *link, unsigned int *class)
 {
+	struct ata_port *ap = link->ap;
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
 	struct sil24_port_priv *pp = ap->private_data;
 	struct sil24_prb *prb = &pp->cmd_block[0].ata.prb;
@@ -521,7 +522,7 @@ static int sil24_softreset(struct ata_po
 
 	DPRINTK("ENTER\n");
 
-	if (ata_link_offline(&ap->link)) {
+	if (ata_link_offline(link)) {
 		DPRINTK("PHY reports no device\n");
 		*class = ATA_DEV_NONE;
 		goto out;
@@ -566,22 +567,23 @@ static int sil24_softreset(struct ata_po
 	return 0;
 
  err:
-	ata_port_printk(ap, KERN_ERR, "softreset failed (%s)\n", reason);
+	ata_link_printk(link, KERN_ERR, "softreset failed (%s)\n", reason);
 	return -EIO;
 }
 
-static int sil24_hardreset(struct ata_port *ap, unsigned int *class)
+static int sil24_hardreset(struct ata_link *link, unsigned int *class)
 {
+	struct ata_port *ap = link->ap;
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
 	const char *reason;
 	int tout_msec, rc;
 	u32 tmp;
 
 	/* sil24 does the right thing(tm) without any protection */
-	ata_set_sata_spd(&ap->link);
+	ata_set_sata_spd(link);
 
 	tout_msec = 100;
-	if (ata_link_online(&ap->link))
+	if (ata_link_online(link))
 		tout_msec = 5000;
 
 	writel(PORT_CS_DEV_RST, port + PORT_CTRL_STAT);
@@ -591,7 +593,7 @@ static int sil24_hardreset(struct ata_po
 	/* SStatus oscillates between zero and valid status after
 	 * DEV_RST, debounce it.
 	 */
-	rc = sata_link_debounce(&ap->link, ATA_DEBOUNCE_INTERVAL,
+	rc = sata_link_debounce(link, ATA_DEBOUNCE_INTERVAL,
 				ATA_DEBOUNCE_DURATION, ATA_DEBOUNCE_TIMEOUT);
 	if (rc) {
 		reason = "PHY debouncing failed";
@@ -599,7 +601,7 @@ static int sil24_hardreset(struct ata_po
 	}
 
 	if (tmp & PORT_CS_DEV_RST) {
-		if (ata_link_offline(&ap->link))
+		if (ata_link_offline(link))
 			return 0;
 		reason = "link not ready";
 		goto err;
@@ -614,7 +616,7 @@ static int sil24_hardreset(struct ata_po
 	return -EAGAIN;
 
  err:
-	ata_port_printk(ap, KERN_ERR, "hardreset failed (%s)\n", reason);
+	ata_link_printk(link, KERN_ERR, "hardreset failed (%s)\n", reason);
 	return -EIO;
 }
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 67a9054..61fddbf 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -292,13 +292,14 @@ enum ata_completion_errors {
 struct scsi_device;
 struct ata_port_operations;
 struct ata_port;
+struct ata_link;
 struct ata_queued_cmd;
 
 /* typedefs */
 typedef void (*ata_qc_cb_t) (struct ata_queued_cmd *qc);
-typedef int (*ata_prereset_fn_t)(struct ata_port *ap);
-typedef int (*ata_reset_fn_t)(struct ata_port *ap, unsigned int *classes);
-typedef void (*ata_postreset_fn_t)(struct ata_port *ap, unsigned int *classes);
+typedef int (*ata_prereset_fn_t)(struct ata_link *link);
+typedef int (*ata_reset_fn_t)(struct ata_link *link, unsigned int *classes);
+typedef void (*ata_postreset_fn_t)(struct ata_link *link, unsigned int *classes);
 
 struct ata_ioports {
 	unsigned long		cmd_addr;
@@ -622,10 +623,10 @@ extern int sata_link_debounce(struct ata
 			      unsigned long duration_msec,
 			      unsigned long timeout_msec);
 extern int sata_link_resume(struct ata_link *link, int quick);
-extern int ata_std_prereset(struct ata_port *ap);
-extern int ata_std_softreset(struct ata_port *ap, unsigned int *classes);
-extern int sata_std_hardreset(struct ata_port *ap, unsigned int *class);
-extern void ata_std_postreset(struct ata_port *ap, unsigned int *classes);
+extern int ata_std_prereset(struct ata_link *link);
+extern int ata_std_softreset(struct ata_link *link, unsigned int *classes);
+extern int sata_std_hardreset(struct ata_link *link, unsigned int *class);
+extern void ata_std_postreset(struct ata_link *link, unsigned int *classes);
 extern int ata_dev_revalidate(struct ata_device *dev, int post_reset);
 extern void ata_port_disable(struct ata_port *);
 extern void ata_std_ports(struct ata_ioports *ioaddr);
-- 
1.2.4


