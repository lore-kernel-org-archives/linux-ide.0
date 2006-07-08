From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/17] libata-link: linkify reset
Date: Sat, 8 Jul 2006 14:45:36 +0900
Message-ID: <11523375361183-git-send-email-htejun@gmail.com>
References: <11523375353473-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.228]:41839 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932525AbWGHFox (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 01:44:53 -0400
Received: by wr-out-0506.google.com with SMTP id 36so1484119wra
        for <linux-ide@vger.kernel.org>; Fri, 07 Jul 2006 22:44:52 -0700 (PDT)
In-Reply-To: <11523375353473-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make reset methods and related functions deal with ata_link instead of
ata_port.

* ata_do_reset()
* ata_eh_reset()
* all prereset/reset/postreset methods and related functions

This patch introduces no behavior change.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c        |   31 +++++++++++++++++------------
 drivers/scsi/ata_piix.c    |   14 +++++++------
 drivers/scsi/libata-core.c |   47 ++++++++++++++++++++++----------------------
 drivers/scsi/libata-eh.c   |   35 ++++++++++++++++-----------------
 drivers/scsi/sata_nv.c     |    4 ++--
 drivers/scsi/sata_sil24.c  |   20 ++++++++++---------
 include/linux/libata.h     |   15 +++++++-------
 7 files changed, 87 insertions(+), 79 deletions(-)

f341ec269e499b6634b5de2fa0ee61bf69f246fd
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index d105cd1..f41db5d 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -596,19 +596,22 @@ static int ahci_clo(struct ata_port *ap)
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
@@ -621,7 +624,7 @@ static int ahci_softreset(struct ata_por
 
 	DPRINTK("ENTER\n");
 
-	if (ata_link_offline(&ap->link)) {
+	if (ata_link_offline(link)) {
 		DPRINTK("PHY reports no device\n");
 		*class = ATA_DEV_NONE;
 		return 0;
@@ -651,7 +654,7 @@ static int ahci_softreset(struct ata_por
 	/* restart engine */
 	ahci_start_engine(ap);
 
-	ata_tf_init(ap->link.device, &tf);
+	ata_tf_init(link->device, &tf);
 	fis = pp->cmd_tbl;
 
 	/* issue the first D2H Register FIS */
@@ -695,7 +698,7 @@ static int ahci_softreset(struct ata_por
 	msleep(150);
 
 	*class = ATA_DEV_NONE;
-	if (ata_link_online(&ap->link)) {
+	if (ata_link_online(link)) {
 		if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
 			rc = -EIO;
 			reason = "device not ready";
@@ -710,12 +713,13 @@ static int ahci_softreset(struct ata_por
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
 	struct ahci_port_priv *pp = ap->private_data;
 	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
 	struct ata_taskfile tf;
@@ -726,15 +730,15 @@ static int ahci_hardreset(struct ata_por
 	ahci_stop_engine(ap);
 
 	/* clear D2H reception area to properly wait for D2H FIS */
-	ata_tf_init(ap->link.device, &tf);
+	ata_tf_init(link->device, &tf);
 	tf.command = 0xff;
 	ata_tf_to_fis(&tf, d2h_fis, 0);
 
-	rc = sata_std_hardreset(ap, class);
+	rc = sata_std_hardreset(link, class);
 
 	ahci_start_engine(ap);
 
-	if (rc == 0 && ata_link_online(&ap->link))
+	if (rc == 0 && ata_link_online(link))
 		*class = ahci_dev_classify(ap);
 	if (*class == ATA_DEV_UNKNOWN)
 		*class = ATA_DEV_NONE;
@@ -743,12 +747,13 @@ static int ahci_hardreset(struct ata_por
 	return rc;
 }
 
-static void ahci_postreset(struct ata_port *ap, unsigned int *class)
+static void ahci_postreset(struct ata_link *link, unsigned int *class)
 {
+	struct ata_port *ap = link->ap;
 	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
 	u32 new_tmp, tmp;
 
-	ata_std_postreset(ap, class);
+	ata_std_postreset(link, class);
 
 	/* Make sure port's ATAPI bit is set appropriately */
 	new_tmp = tmp = readl(port_mmio + PORT_CMD);
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 9e24049..790dcf6 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -462,15 +462,16 @@ cbl40:
 
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
@@ -481,7 +482,7 @@ static int piix_pata_prereset(struct ata
 
 	piix_pata_cbl_detect(ap);
 
-	return ata_std_prereset(ap);
+	return ata_std_prereset(link);
 }
 
 static void piix_pata_error_handler(struct ata_port *ap)
@@ -492,7 +493,7 @@ static void piix_pata_error_handler(stru
 
 /**
  *	piix_sata_prereset - prereset for SATA host controller
- *	@ap: Target port
+ *	@link: Target link
  *
  *	Reads and configures SATA PCI device's PCI config register
  *	Port Configuration and Status (PCS) to determine port and
@@ -505,8 +506,9 @@ static void piix_pata_error_handler(stru
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
@@ -553,7 +555,7 @@ static int piix_sata_prereset(struct ata
 		return 0;
 	}
 
-	return ata_std_prereset(ap);
+	return ata_std_prereset(link);
 }
 
 static void piix_sata_error_handler(struct ata_port *ap)
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 2326843..9f6b905 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2576,19 +2576,18 @@ int sata_link_resume(struct ata_link *li
 	return sata_link_debounce(link, params);
 }
 
-static void ata_wait_spinup(struct ata_port *ap)
+static void ata_wait_spinup(struct ata_link *link)
 {
-	struct ata_eh_context *ehc = &ap->link.eh_context;
+	struct ata_eh_context *ehc = &link->eh_context;
 	unsigned long end, secs;
 	int rc;
 
 	/* first, debounce phy if SATA */
-	if (ap->cbl == ATA_CBL_SATA) {
-		rc = sata_link_debounce(&ap->link, sata_deb_timing_hotplug);
+	if (link->ap->cbl == ATA_CBL_SATA) {
+		rc = sata_link_debounce(link, sata_deb_timing_hotplug);
 
 		/* if debounced successfully and offline, no need to wait */
-		if ((rc == 0 || rc == -EOPNOTSUPP) &&
-		    ata_link_offline(&ap->link))
+		if ((rc == 0 || rc == -EOPNOTSUPP) && ata_link_offline(link))
 			return;
 	}
 
@@ -2600,17 +2599,17 @@ static void ata_wait_spinup(struct ata_p
 		return;
 
 	if (secs > 5)
-		ata_port_printk(ap, KERN_INFO, "waiting for device to spin up "
-				"(%lu secs)\n", secs);
+		ata_link_printk(link, KERN_INFO, "waiting for device to "
+				"spin up (%lu secs)\n", secs);
 
 	schedule_timeout_uninterruptible(end - jiffies);
 }
 
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
@@ -2618,9 +2617,9 @@ static void ata_wait_spinup(struct ata_p
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int ata_std_prereset(struct ata_port *ap)
+int ata_std_prereset(struct ata_link *link)
 {
-	struct ata_link *link = &ap->link;
+	struct ata_port *ap = link->ap;
 	struct ata_eh_context *ehc = &link->eh_context;
 	const unsigned long *timing = sata_ehc_deb_timing(ehc);
 	int rc;
@@ -2632,7 +2631,7 @@ int ata_std_prereset(struct ata_port *ap
 
 	if ((ehc->i.flags & ATA_EHI_HOTPLUGGED) &&
 	    (ap->flags & ATA_FLAG_SKIP_D2H_BSY))
-		ata_wait_spinup(ap);
+		ata_wait_spinup(link);
 
 	/* if we're about to do hardreset, nothing more to do */
 	if (ehc->i.action & ATA_EH_HARDRESET)
@@ -2643,7 +2642,7 @@ int ata_std_prereset(struct ata_port *ap
 		rc = sata_link_resume(link, timing);
 		if (rc && rc != -EOPNOTSUPP) {
 			/* phy resume failed */
-			ata_port_printk(ap, KERN_WARNING, "failed to resume "
+			ata_link_printk(link, KERN_WARNING, "failed to resume "
 					"link for reset (errno=%d)\n", rc);
 			return rc;
 		}
@@ -2660,7 +2659,7 @@ int ata_std_prereset(struct ata_port *ap
 
 /**
  *	ata_std_softreset - reset host port via ATA SRST
- *	@ap: port to reset
+ *	@link: ATA link to reset
  *	@classes: resulting classes of attached devices
  *
  *	Reset host port using ATA SRST.
@@ -2671,9 +2670,9 @@ int ata_std_prereset(struct ata_port *ap
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int ata_std_softreset(struct ata_port *ap, unsigned int *classes)
+int ata_std_softreset(struct ata_link *link, unsigned int *classes)
 {
-	struct ata_link *link = &ap->link;
+	struct ata_port *ap = link->ap;
 	unsigned int slave_possible = ap->flags & ATA_FLAG_SLAVE_POSS;
 	unsigned int devmask = 0, err_mask;
 	u8 err;
@@ -2698,7 +2697,7 @@ int ata_std_softreset(struct ata_port *a
 	DPRINTK("about to softreset, devmask=%x\n", devmask);
 	err_mask = ata_bus_softreset(ap, devmask);
 	if (err_mask) {
-		ata_port_printk(ap, KERN_ERR, "SRST failed (err_mask=0x%x)\n",
+		ata_link_printk(link, KERN_ERR, "SRST failed (err_mask=0x%x)\n",
 				err_mask);
 		return -EIO;
 	}
@@ -2715,7 +2714,7 @@ int ata_std_softreset(struct ata_port *a
 
 /**
  *	sata_std_hardreset - reset host port via SATA phy reset
- *	@ap: port to reset
+ *	@link: link to reset
  *	@class: resulting class of attached device
  *
  *	SATA phy-reset host port using DET bits of SControl register.
@@ -2726,9 +2725,9 @@ int ata_std_softreset(struct ata_port *a
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int sata_std_hardreset(struct ata_port *ap, unsigned int *class)
+int sata_std_hardreset(struct ata_link *link, unsigned int *class)
 {
-	struct ata_link *link = &ap->link;
+	struct ata_port *ap = link->ap;
 	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
 	u32 scontrol;
 	int rc;
@@ -2792,7 +2791,7 @@ int sata_std_hardreset(struct ata_port *
 
 /**
  *	ata_std_postreset - standard postreset callback
- *	@ap: the target ata_port
+ *	@link: the target ata_link
  *	@classes: classes of attached devices
  *
  *	This function is invoked after a successful reset.  Note that
@@ -2802,9 +2801,9 @@ int sata_std_hardreset(struct ata_port *
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
index 62c75d4..5475e2f 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1456,16 +1456,16 @@ static void ata_eh_report(struct ata_por
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
 
@@ -1473,12 +1473,12 @@ static int ata_do_reset(struct ata_port 
 	 * is complete and convert all ATA_DEV_UNKNOWN to
 	 * ATA_DEV_NONE.
 	 */
-	ata_link_for_each_dev(dev, &ap->link)
+	ata_link_for_each_dev(dev, link)
 		if (classes[dev->devno] != ATA_DEV_UNKNOWN)
 			break;
 
 	if (dev) {
-		ata_link_for_each_dev(dev, &ap->link) {
+		ata_link_for_each_dev(dev, link) {
 			if (classes[dev->devno] == ATA_DEV_UNKNOWN)
 				classes[dev->devno] = ATA_DEV_NONE;
 		}
@@ -1499,11 +1499,10 @@ static int ata_eh_followup_srst_needed(i
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
@@ -1525,9 +1524,9 @@ static int ata_eh_reset(struct ata_port 
 		ehc->i.action |= ATA_EH_HARDRESET;
 
 	if (prereset) {
-		rc = prereset(ap);
+		rc = prereset(link);
 		if (rc) {
-			ata_port_printk(ap, KERN_ERR,
+			ata_link_printk(link, KERN_ERR,
 					"prereset failed (errno=%d)\n", rc);
 			return rc;
 		}
@@ -1547,7 +1546,7 @@ static int ata_eh_reset(struct ata_port 
 
 	/* did prereset() screw up?  if so, fix up to avoid oopsing */
 	if (!reset) {
-		ata_port_printk(ap, KERN_ERR, "BUG: prereset() requested "
+		ata_link_printk(link, KERN_ERR, "BUG: prereset() requested "
 				"invalid reset type\n");
 		if (softreset)
 			reset = softreset;
@@ -1558,14 +1557,14 @@ static int ata_eh_reset(struct ata_port 
  retry:
 	/* shut up during boot probing */
 	if (verbose)
-		ata_port_printk(ap, KERN_INFO, "%s resetting port\n",
+		ata_link_printk(link, KERN_INFO, "%s resetting port\n",
 				reset == softreset ? "soft" : "hard");
 
 	/* reset */
 	ata_eh_about_to_do(link, NULL, ATA_EH_RESET_MASK);
 	ehc->i.flags |= ATA_EHI_DID_RESET;
 
-	rc = ata_do_reset(ap, reset, classes);
+	rc = ata_do_reset(link, reset, classes);
 
 	did_followup_srst = 0;
 	if (reset == hardreset &&
@@ -1575,18 +1574,18 @@ static int ata_eh_reset(struct ata_port 
 		reset = softreset;
 
 		if (!reset) {
-			ata_port_printk(ap, KERN_ERR,
+			ata_link_printk(link, KERN_ERR,
 					"follow-up softreset required "
 					"but no softreset avaliable\n");
 			return -EINVAL;
 		}
 
 		ata_eh_about_to_do(link, NULL, ATA_EH_RESET_MASK);
-		rc = ata_do_reset(ap, reset, classes);
+		rc = ata_do_reset(link, reset, classes);
 
 		if (rc == 0 && classify &&
 		    classes[0] == ATA_DEV_UNKNOWN) {
-			ata_port_printk(ap, KERN_ERR,
+			ata_link_printk(link, KERN_ERR,
 					"classification failed\n");
 			return -EINVAL;
 		}
@@ -1603,7 +1602,7 @@ static int ata_eh_reset(struct ata_port 
 		} else
 			type = "hard";
 
-		ata_port_printk(ap, KERN_WARNING,
+		ata_link_printk(link, KERN_WARNING,
 				"%sreset failed, retrying in 5 secs\n", type);
 		ssleep(5);
 
@@ -1622,7 +1621,7 @@ static int ata_eh_reset(struct ata_port 
 			dev->pio_mode = XFER_PIO_0;
 
 		if (postreset)
-			postreset(ap, classes);
+			postreset(link, classes);
 
 		/* reset successful, schedule revalidation */
 		ata_eh_done(link, NULL, ATA_EH_RESET_MASK);
@@ -2008,7 +2007,7 @@ static int ata_eh_recover(struct ata_por
 	if (ehc->i.action & ATA_EH_RESET_MASK) {
 		ata_eh_freeze_port(ap);
 
-		rc = ata_eh_reset(ap, ata_port_nr_vacant(ap), prereset,
+		rc = ata_eh_reset(&ap->link, ata_port_nr_vacant(ap), prereset,
 				  softreset, hardreset, postreset);
 		if (rc) {
 			ata_port_printk(ap, KERN_ERR,
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index 6659faa..929b567 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -471,7 +471,7 @@ static void nv_ck804_thaw(struct ata_por
 	writeb(mask, mmio_base + NV_INT_ENABLE_CK804);
 }
 
-static int nv_hardreset(struct ata_port *ap, unsigned int *class)
+static int nv_hardreset(struct ata_link *link, unsigned int *class)
 {
 	unsigned int dummy;
 
@@ -479,7 +479,7 @@ static int nv_hardreset(struct ata_port 
 	 * some controllers.  Don't classify on hardreset.  For more
 	 * info, see http://bugme.osdl.org/show_bug.cgi?id=3352
 	 */
-	return sata_std_hardreset(ap, &dummy);
+	return sata_std_hardreset(link, &dummy);
 }
 
 static void nv_error_handler(struct ata_port *ap)
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index be98dc3..b2b8d13 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -535,8 +535,9 @@ static int sil24_init_port(struct ata_po
 	return 0;
 }
 
-static int sil24_softreset(struct ata_port *ap, unsigned int *class)
+static int sil24_softreset(struct ata_link *link, unsigned int *class)
 {
+	struct ata_port *ap = link->ap;
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
 	struct sil24_port_priv *pp = ap->private_data;
 	struct sil24_prb *prb = &pp->cmd_block[0].ata.prb;
@@ -546,7 +547,7 @@ static int sil24_softreset(struct ata_po
 
 	DPRINTK("ENTER\n");
 
-	if (ata_link_offline(&ap->link)) {
+	if (ata_link_offline(link)) {
 		DPRINTK("PHY reports no device\n");
 		*class = ATA_DEV_NONE;
 		goto out;
@@ -591,22 +592,23 @@ static int sil24_softreset(struct ata_po
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
-	sata_set_spd(&ap->link);
+	sata_set_spd(link);
 
 	tout_msec = 100;
-	if (ata_link_online(&ap->link))
+	if (ata_link_online(link))
 		tout_msec = 5000;
 
 	writel(PORT_CS_DEV_RST, port + PORT_CTRL_STAT);
@@ -616,14 +618,14 @@ static int sil24_hardreset(struct ata_po
 	/* SStatus oscillates between zero and valid status after
 	 * DEV_RST, debounce it.
 	 */
-	rc = sata_link_debounce(&ap->link, sata_deb_timing_long);
+	rc = sata_link_debounce(link, sata_deb_timing_long);
 	if (rc) {
 		reason = "PHY debouncing failed";
 		goto err;
 	}
 
 	if (tmp & PORT_CS_DEV_RST) {
-		if (ata_link_offline(&ap->link))
+		if (ata_link_offline(link))
 			return 0;
 		reason = "link not ready";
 		goto err;
@@ -638,7 +640,7 @@ static int sil24_hardreset(struct ata_po
 	return -EAGAIN;
 
  err:
-	ata_port_printk(ap, KERN_ERR, "hardreset failed (%s)\n", reason);
+	ata_link_printk(link, KERN_ERR, "hardreset failed (%s)\n", reason);
 	return -EIO;
 }
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 8dfafc6..506f72d 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -316,13 +316,14 @@ enum ata_completion_errors {
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
@@ -680,10 +681,10 @@ extern int sata_set_spd(struct ata_link 
 extern int sata_link_debounce(struct ata_link *link,
 			      const unsigned long *params);
 extern int sata_link_resume(struct ata_link *link, const unsigned long *params);
-extern int ata_std_prereset(struct ata_port *ap);
-extern int ata_std_softreset(struct ata_port *ap, unsigned int *classes);
-extern int sata_std_hardreset(struct ata_port *ap, unsigned int *class);
-extern void ata_std_postreset(struct ata_port *ap, unsigned int *classes);
+extern int ata_std_prereset(struct ata_link *link);
+extern int ata_std_softreset(struct ata_link *link, unsigned int *classes);
+extern int sata_std_hardreset(struct ata_link *link, unsigned int *class);
+extern void ata_std_postreset(struct ata_link *link, unsigned int *classes);
 extern void sata_std_hp_poll_activate(struct ata_port *ap);
 extern int sata_std_hp_poll(struct ata_port *ap);
 extern int ata_dev_revalidate(struct ata_device *dev, int post_reset);
-- 
1.3.2


