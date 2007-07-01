From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/16] libata-link: linkify reset
Date: Sun, 1 Jul 2007 19:05:59 +0900
Message-ID: <11832843594125-git-send-email-htejun@gmail.com>
References: <11832843581399-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:52533 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756108AbXGAKGJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 06:06:09 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1879699wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 03:06:09 -0700 (PDT)
In-Reply-To: <11832843581399-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

Make reset methods and related functions deal with ata_link instead of
ata_port.

* ata_do_reset()
* ata_eh_reset()
* all prereset/reset/postreset methods and related functions

This patch introduces no behavior change.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c          |   28 ++++++++++++++----------
 drivers/ata/ata_piix.c      |    7 +++--
 drivers/ata/libata-core.c   |   49 +++++++++++++++++++++----------------------
 drivers/ata/libata-eh.c     |   35 +++++++++++++++---------------
 drivers/ata/pata_amd.c      |   16 ++++++++------
 drivers/ata/pata_artop.c    |   12 ++++++----
 drivers/ata/pata_atiixp.c   |    5 ++-
 drivers/ata/pata_efar.c     |    7 +++--
 drivers/ata/pata_hpt37x.c   |   12 ++++++----
 drivers/ata/pata_hpt3x2n.c  |    7 +++--
 drivers/ata/pata_it8213.c   |    7 +++--
 drivers/ata/pata_jmicron.c  |    8 +++---
 drivers/ata/pata_marvell.c  |    7 +++--
 drivers/ata/pata_mpiix.c    |    5 ++-
 drivers/ata/pata_ns87410.c  |    7 +++--
 drivers/ata/pata_oldpiix.c  |    7 +++--
 drivers/ata/pata_opti.c     |    7 +++--
 drivers/ata/pata_optidma.c  |    7 +++--
 drivers/ata/pata_pdc2027x.c |    8 +++---
 drivers/ata/pata_sil680.c   |    7 +++--
 drivers/ata/pata_sis.c      |    7 +++--
 drivers/ata/pata_sl82c105.c |    7 +++--
 drivers/ata/pata_triflex.c  |    7 +++--
 drivers/ata/pata_via.c      |    5 ++-
 drivers/ata/sata_inic162x.c |   13 ++++++-----
 drivers/ata/sata_nv.c       |    4 +-
 drivers/ata/sata_sil24.c    |   20 +++++++++--------
 drivers/ata/sata_via.c      |    5 ++-
 include/linux/libata.h      |   19 ++++++++--------
 29 files changed, 182 insertions(+), 153 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 3e95976..df58a05 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -938,9 +938,10 @@ static int ahci_clo(struct ata_port *ap)
 	return 0;
 }
 
-static int ahci_softreset(struct ata_port *ap, unsigned int *class,
+static int ahci_softreset(struct ata_link *link, unsigned int *class,
 			  unsigned long deadline)
 {
+	struct ata_port *ap = link->ap;
 	struct ahci_port_priv *pp = ap->private_data;
 	void __iomem *port_mmio = ahci_port_base(ap);
 	const u32 cmd_fis_len = 5; /* five dwords */
@@ -952,7 +953,7 @@ static int ahci_softreset(struct ata_port *ap, unsigned int *class,
 
 	DPRINTK("ENTER\n");
 
-	if (ata_link_offline(&ap->link)) {
+	if (ata_link_offline(link)) {
 		DPRINTK("PHY reports no device\n");
 		*class = ATA_DEV_NONE;
 		return 0;
@@ -981,7 +982,7 @@ static int ahci_softreset(struct ata_port *ap, unsigned int *class,
 	/* restart engine */
 	ahci_start_engine(ap);
 
-	ata_tf_init(ap->link.device, &tf);
+	ata_tf_init(link->device, &tf);
 	fis = pp->cmd_tbl;
 
 	/* issue the first D2H Register FIS */
@@ -1038,13 +1039,14 @@ static int ahci_softreset(struct ata_port *ap, unsigned int *class,
  fail_restart:
 	ahci_start_engine(ap);
  fail:
-	ata_port_printk(ap, KERN_ERR, "softreset failed (%s)\n", reason);
+	ata_link_printk(link, KERN_ERR, "softreset failed (%s)\n", reason);
 	return rc;
 }
 
-static int ahci_hardreset(struct ata_port *ap, unsigned int *class,
+static int ahci_hardreset(struct ata_link *link, unsigned int *class,
 			  unsigned long deadline)
 {
+	struct ata_port *ap = link->ap;
 	struct ahci_port_priv *pp = ap->private_data;
 	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
 	struct ata_taskfile tf;
@@ -1055,15 +1057,15 @@ static int ahci_hardreset(struct ata_port *ap, unsigned int *class,
 	ahci_stop_engine(ap);
 
 	/* clear D2H reception area to properly wait for D2H FIS */
-	ata_tf_init(ap->link.device, &tf);
+	ata_tf_init(link->device, &tf);
 	tf.command = 0x80;
 	ata_tf_to_fis(&tf, d2h_fis, 0);
 
-	rc = sata_std_hardreset(ap, class, deadline);
+	rc = sata_std_hardreset(link, class, deadline);
 
 	ahci_start_engine(ap);
 
-	if (rc == 0 && ata_link_online(&ap->link))
+	if (rc == 0 && ata_link_online(link))
 		*class = ahci_dev_classify(ap);
 	if (*class == ATA_DEV_UNKNOWN)
 		*class = ATA_DEV_NONE;
@@ -1072,9 +1074,10 @@ static int ahci_hardreset(struct ata_port *ap, unsigned int *class,
 	return rc;
 }
 
-static int ahci_vt8251_hardreset(struct ata_port *ap, unsigned int *class,
+static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
 				 unsigned long deadline)
 {
+	struct ata_port *ap = link->ap;
 	u32 serror;
 	int rc;
 
@@ -1082,7 +1085,7 @@ static int ahci_vt8251_hardreset(struct ata_port *ap, unsigned int *class,
 
 	ahci_stop_engine(ap);
 
-	rc = sata_port_hardreset(ap, sata_ehc_deb_timing(&ap->link.eh_context),
+	rc = sata_link_hardreset(link, sata_ehc_deb_timing(&link->eh_context),
 				 deadline);
 
 	/* vt8251 needs SError cleared for the port to operate */
@@ -1099,12 +1102,13 @@ static int ahci_vt8251_hardreset(struct ata_port *ap, unsigned int *class,
 	return rc ?: -EAGAIN;
 }
 
-static void ahci_postreset(struct ata_port *ap, unsigned int *class)
+static void ahci_postreset(struct ata_link *link, unsigned int *class)
 {
+	struct ata_port *ap = link->ap;
 	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 new_tmp, tmp;
 
-	ata_std_postreset(ap, class);
+	ata_std_postreset(link, class);
 
 	/* Make sure port's ATAPI bit is set appropriately */
 	new_tmp = tmp = readl(port_mmio + PORT_CMD);
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 924e447..ede9274 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -620,19 +620,20 @@ static int ich_pata_cable_detect(struct ata_port *ap)
 
 /**
  *	piix_pata_prereset - prereset for PATA host controller
- *	@ap: Target port
+ *	@link: Target link
  *	@deadline: deadline jiffies for the operation
  *
  *	LOCKING:
  *	None (inherited from caller).
  */
-static int piix_pata_prereset(struct ata_port *ap, unsigned long deadline)
+static int piix_pata_prereset(struct ata_link *link, unsigned long deadline)
 {
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
 	if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->port_no]))
 		return -ENOENT;
-	return ata_std_prereset(ap, deadline);
+	return ata_std_prereset(link, deadline);
 }
 
 static void piix_pata_error_handler(struct ata_port *ap)
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9e39302..b8f7b65 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3332,10 +3332,10 @@ int sata_link_resume(struct ata_link *link, const unsigned long *params,
 
 /**
  *	ata_std_prereset - prepare for reset
- *	@ap: ATA port to be reset
+ *	@link: ATA link to be reset
  *	@deadline: deadline jiffies for the operation
  *
- *	@ap is about to be reset.  Initialize it.  Failure from
+ *	@link is about to be reset.  Initialize it.  Failure from
  *	prereset makes libata abort whole reset sequence and give up
  *	that port, so prereset should be best-effort.  It does its
  *	best to prepare for reset sequence but if things go wrong, it
@@ -3347,9 +3347,9 @@ int sata_link_resume(struct ata_link *link, const unsigned long *params,
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int ata_std_prereset(struct ata_port *ap, unsigned long deadline)
+int ata_std_prereset(struct ata_link *link, unsigned long deadline)
 {
-	struct ata_link *link = &ap->link;
+	struct ata_port *ap = link->ap;
 	struct ata_eh_context *ehc = &link->eh_context;
 	const unsigned long *timing = sata_ehc_deb_timing(ehc);
 	int rc;
@@ -3368,7 +3368,7 @@ int ata_std_prereset(struct ata_port *ap, unsigned long deadline)
 		rc = sata_link_resume(link, timing, deadline);
 		/* whine about phy resume failure but proceed */
 		if (rc && rc != -EOPNOTSUPP)
-			ata_port_printk(ap, KERN_WARNING, "failed to resume "
+			ata_link_printk(link, KERN_WARNING, "failed to resume "
 					"link for reset (errno=%d)\n", rc);
 	}
 
@@ -3378,7 +3378,7 @@ int ata_std_prereset(struct ata_port *ap, unsigned long deadline)
 	if (!(ap->flags & ATA_FLAG_SKIP_D2H_BSY) && !ata_link_offline(link)) {
 		rc = ata_wait_ready(ap, deadline);
 		if (rc && rc != -ENODEV) {
-			ata_port_printk(ap, KERN_WARNING, "device not ready "
+			ata_link_printk(link, KERN_WARNING, "device not ready "
 					"(errno=%d), forcing hardreset\n", rc);
 			ehc->i.action |= ATA_EH_HARDRESET;
 		}
@@ -3389,7 +3389,7 @@ int ata_std_prereset(struct ata_port *ap, unsigned long deadline)
 
 /**
  *	ata_std_softreset - reset host port via ATA SRST
- *	@ap: port to reset
+ *	@link: ATA link to reset
  *	@classes: resulting classes of attached devices
  *	@deadline: deadline jiffies for the operation
  *
@@ -3401,10 +3401,10 @@ int ata_std_prereset(struct ata_port *ap, unsigned long deadline)
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int ata_std_softreset(struct ata_port *ap, unsigned int *classes,
+int ata_std_softreset(struct ata_link *link, unsigned int *classes,
 		      unsigned long deadline)
 {
-	struct ata_link *link = &ap->link;
+	struct ata_port *ap = link->ap;
 	unsigned int slave_possible = ap->flags & ATA_FLAG_SLAVE_POSS;
 	unsigned int devmask = 0;
 	int rc;
@@ -3431,7 +3431,7 @@ int ata_std_softreset(struct ata_port *ap, unsigned int *classes,
 	rc = ata_bus_softreset(ap, devmask, deadline);
 	/* if link is occupied, -ENODEV too is an error */
 	if (rc && (rc != -ENODEV || sata_scr_valid(link))) {
-		ata_port_printk(ap, KERN_ERR, "SRST failed (errno=%d)\n", rc);
+		ata_link_printk(link, KERN_ERR, "SRST failed (errno=%d)\n", rc);
 		return rc;
 	}
 
@@ -3446,12 +3446,12 @@ int ata_std_softreset(struct ata_port *ap, unsigned int *classes,
 }
 
 /**
- *	sata_port_hardreset - reset port via SATA phy reset
- *	@ap: port to reset
+ *	sata_link_hardreset - reset link via SATA phy reset
+ *	@link: link to reset
  *	@timing: timing parameters { interval, duratinon, timeout } in msec
  *	@deadline: deadline jiffies for the operation
  *
- *	SATA phy-reset host port using DET bits of SControl register.
+ *	SATA phy-reset @link using DET bits of SControl register.
  *
  *	LOCKING:
  *	Kernel thread context (may sleep)
@@ -3459,10 +3459,9 @@ int ata_std_softreset(struct ata_port *ap, unsigned int *classes,
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int sata_port_hardreset(struct ata_port *ap, const unsigned long *timing,
+int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
 			unsigned long deadline)
 {
-	struct ata_link *link = &ap->link;
 	u32 scontrol;
 	int rc;
 
@@ -3508,7 +3507,7 @@ int sata_port_hardreset(struct ata_port *ap, const unsigned long *timing,
 
 /**
  *	sata_std_hardreset - reset host port via SATA phy reset
- *	@ap: port to reset
+ *	@link: link to reset
  *	@class: resulting class of attached device
  *	@deadline: deadline jiffies for the operation
  *
@@ -3521,19 +3520,19 @@ int sata_port_hardreset(struct ata_port *ap, const unsigned long *timing,
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int sata_std_hardreset(struct ata_port *ap, unsigned int *class,
+int sata_std_hardreset(struct ata_link *link, unsigned int *class,
 		       unsigned long deadline)
 {
-	struct ata_link *link = &ap->link;
+	struct ata_port *ap = link->ap;
 	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
 	int rc;
 
 	DPRINTK("ENTER\n");
 
 	/* do hardreset */
-	rc = sata_port_hardreset(ap, timing, deadline);
+	rc = sata_link_hardreset(link, timing, deadline);
 	if (rc) {
-		ata_port_printk(ap, KERN_ERR,
+		ata_link_printk(link, KERN_ERR,
 				"COMRESET failed (errno=%d)\n", rc);
 		return rc;
 	}
@@ -3551,7 +3550,7 @@ int sata_std_hardreset(struct ata_port *ap, unsigned int *class,
 	rc = ata_wait_ready(ap, deadline);
 	/* link occupied, -ENODEV too is an error */
 	if (rc) {
-		ata_port_printk(ap, KERN_ERR,
+		ata_link_printk(link, KERN_ERR,
 				"COMRESET failed (errno=%d)\n", rc);
 		return rc;
 	}
@@ -3566,7 +3565,7 @@ int sata_std_hardreset(struct ata_port *ap, unsigned int *class,
 
 /**
  *	ata_std_postreset - standard postreset callback
- *	@ap: the target ata_port
+ *	@link: the target ata_link
  *	@classes: classes of attached devices
  *
  *	This function is invoked after a successful reset.  Note that
@@ -3576,9 +3575,9 @@ int sata_std_hardreset(struct ata_port *ap, unsigned int *class,
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
@@ -6876,7 +6875,7 @@ EXPORT_SYMBOL_GPL(__sata_phy_reset);
 EXPORT_SYMBOL_GPL(ata_bus_reset);
 EXPORT_SYMBOL_GPL(ata_std_prereset);
 EXPORT_SYMBOL_GPL(ata_std_softreset);
-EXPORT_SYMBOL_GPL(sata_port_hardreset);
+EXPORT_SYMBOL_GPL(sata_link_hardreset);
 EXPORT_SYMBOL_GPL(sata_std_hardreset);
 EXPORT_SYMBOL_GPL(ata_std_postreset);
 EXPORT_SYMBOL_GPL(ata_dev_classify);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 6113d97..6cef201 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1672,16 +1672,16 @@ static void ata_eh_report(struct ata_port *ap)
 	}
 }
 
-static int ata_do_reset(struct ata_port *ap, ata_reset_fn_t reset,
+static int ata_do_reset(struct ata_link *link, ata_reset_fn_t reset,
 			unsigned int *classes, unsigned long deadline)
 {
 	struct ata_device *dev;
 	int rc;
 
-	ata_link_for_each_dev(dev, &ap->link)
+	ata_link_for_each_dev(dev, link)
 		classes[dev->devno] = ATA_DEV_UNKNOWN;
 
-	rc = reset(ap, classes, deadline);
+	rc = reset(link, classes, deadline);
 	if (rc)
 		return rc;
 
@@ -1689,12 +1689,12 @@ static int ata_do_reset(struct ata_port *ap, ata_reset_fn_t reset,
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
@@ -1715,11 +1715,10 @@ static int ata_eh_followup_srst_needed(int rc, int classify,
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
 	int verbose = !(ehc->i.flags & ATA_EHI_QUIET);
@@ -1745,10 +1744,10 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 		ehc->i.action |= ATA_EH_HARDRESET;
 
 	if (prereset) {
-		rc = prereset(ap, jiffies + ATA_EH_PRERESET_TIMEOUT);
+		rc = prereset(link, jiffies + ATA_EH_PRERESET_TIMEOUT);
 		if (rc) {
 			if (rc == -ENOENT) {
-				ata_port_printk(ap, KERN_DEBUG,
+				ata_link_printk(link, KERN_DEBUG,
 						"port disabled. ignoring.\n");
 				ehc->i.action &= ~ATA_EH_RESET_MASK;
 
@@ -1757,7 +1756,7 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 
 				rc = 0;
 			} else
-				ata_port_printk(ap, KERN_ERR,
+				ata_link_printk(link, KERN_ERR,
 					"prereset failed (errno=%d)\n", rc);
 			goto out;
 		}
@@ -1789,7 +1788,7 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 
 	/* shut up during boot probing */
 	if (verbose)
-		ata_port_printk(ap, KERN_INFO, "%s resetting port\n",
+		ata_link_printk(link, KERN_INFO, "%s resetting link\n",
 				reset == softreset ? "soft" : "hard");
 
 	/* mark that this EH session started with reset */
@@ -1798,7 +1797,7 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 	else
 		ehc->i.flags |= ATA_EHI_DID_SOFTRESET;
 
-	rc = ata_do_reset(ap, reset, classes, deadline);
+	rc = ata_do_reset(link, reset, classes, deadline);
 
 	if (reset == hardreset &&
 	    ata_eh_followup_srst_needed(rc, classify, classes)) {
@@ -1806,7 +1805,7 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 		reset = softreset;
 
 		if (!reset) {
-			ata_port_printk(ap, KERN_ERR,
+			ata_link_printk(link, KERN_ERR,
 					"follow-up softreset required "
 					"but no softreset avaliable\n");
 			rc = -EINVAL;
@@ -1814,11 +1813,11 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 		}
 
 		ata_eh_about_to_do(link, NULL, ATA_EH_RESET_MASK);
-		rc = ata_do_reset(ap, reset, classes, deadline);
+		rc = ata_do_reset(link, reset, classes, deadline);
 
 		if (rc == 0 && classify &&
 		    classes[0] == ATA_DEV_UNKNOWN) {
-			ata_port_printk(ap, KERN_ERR,
+			ata_link_printk(link, KERN_ERR,
 					"classification failed\n");
 			rc = -EINVAL;
 			goto out;
@@ -1831,7 +1830,7 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 		if (time_before(now, deadline)) {
 			unsigned long delta = deadline - jiffies;
 
-			ata_port_printk(ap, KERN_WARNING, "reset failed "
+			ata_link_printk(link, KERN_WARNING, "reset failed "
 				"(errno=%d), retrying in %u secs\n",
 				rc, (jiffies_to_msecs(delta) + 999) / 1000);
 
@@ -1860,7 +1859,7 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 			link->sata_spd = (sstatus >> 4) & 0xf;
 
 		if (postreset)
-			postreset(ap, classes);
+			postreset(link, classes);
 
 		/* reset successful, schedule revalidation */
 		ata_eh_done(link, NULL, ehc->i.action & ATA_EH_RESET_MASK);
@@ -2137,7 +2136,7 @@ static int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 	if (ehc->i.action & ATA_EH_RESET_MASK) {
 		ata_eh_freeze_port(ap);
 
-		rc = ata_eh_reset(ap, ata_port_nr_vacant(ap), prereset,
+		rc = ata_eh_reset(&ap->link, ata_port_nr_vacant(ap), prereset,
 				  softreset, hardreset, postreset);
 		if (rc) {
 			ata_port_printk(ap, KERN_ERR,
diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 533bcc9..706eb63 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -119,27 +119,28 @@ static void timing_setup(struct ata_port *ap, struct ata_device *adev, int offse
 }
 
 /**
- *	amd_probe_init		-	perform reset handling
- *	@ap: ATA port
+ *	amd_pre_reset		-	perform reset handling
+ *	@link: ATA link
  *	@deadline: deadline jiffies for the operation
  *
  *	Reset sequence checking enable bits to see which ports are
  *	active.
  */
 
-static int amd_pre_reset(struct ata_port *ap, unsigned long deadline)
+static int amd_pre_reset(struct ata_link *link, unsigned long deadline)
 {
 	static const struct pci_bits amd_enable_bits[] = {
 		{ 0x40, 1, 0x02, 0x02 },
 		{ 0x40, 1, 0x01, 0x01 }
 	};
 
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
 	if (!pci_test_config_bits(pdev, &amd_enable_bits[ap->port_no]))
 		return -ENOENT;
 
-	return ata_std_prereset(ap, deadline);
+	return ata_std_prereset(link, deadline);
 }
 
 static void amd_error_handler(struct ata_port *ap)
@@ -221,25 +222,26 @@ static void amd133_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 
 /**
  *	nv_probe_init	-	cable detection
- *	@ap: ATA port
+ *	@lin: ATA link
  *
  *	Perform cable detection. The BIOS stores this in PCI config
  *	space for us.
  */
 
-static int nv_pre_reset(struct ata_port *ap, unsigned long deadline)
+static int nv_pre_reset(struct ata_link *link, unsigned long deadline)
 {
 	static const struct pci_bits nv_enable_bits[] = {
 		{ 0x50, 1, 0x02, 0x02 },
 		{ 0x50, 1, 0x01, 0x01 }
 	};
 
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
 	if (!pci_test_config_bits(pdev, &nv_enable_bits[ap->port_no]))
 		return -ENOENT;
 
-	return ata_std_prereset(ap, deadline);
+	return ata_std_prereset(link, deadline);
 }
 
 static void nv_error_handler(struct ata_port *ap)
diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index ce589d9..5b4b5ef 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -39,8 +39,9 @@
 
 static int clock = 0;
 
-static int artop6210_pre_reset(struct ata_port *ap, unsigned long deadline)
+static int artop6210_pre_reset(struct ata_link *link, unsigned long deadline)
 {
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	const struct pci_bits artop_enable_bits[] = {
 		{ 0x4AU, 1U, 0x02UL, 0x02UL },	/* port 0 */
@@ -50,7 +51,7 @@ static int artop6210_pre_reset(struct ata_port *ap, unsigned long deadline)
 	if (!pci_test_config_bits(pdev, &artop_enable_bits[ap->port_no]))
 		return -ENOENT;
 
-	return ata_std_prereset(ap, deadline);
+	return ata_std_prereset(link, deadline);
 }
 
 /**
@@ -70,27 +71,28 @@ static void artop6210_error_handler(struct ata_port *ap)
 
 /**
  *	artop6260_pre_reset	-	check for 40/80 pin
- *	@ap: Port
+ *	@link: link
  *	@deadline: deadline jiffies for the operation
  *
  *	The ARTOP hardware reports the cable detect bits in register 0x49.
  *	Nothing complicated needed here.
  */
 
-static int artop6260_pre_reset(struct ata_port *ap, unsigned long deadline)
+static int artop6260_pre_reset(struct ata_link *link, unsigned long deadline)
 {
 	static const struct pci_bits artop_enable_bits[] = {
 		{ 0x4AU, 1U, 0x02UL, 0x02UL },	/* port 0 */
 		{ 0x4AU, 1U, 0x04UL, 0x04UL },	/* port 1 */
 	};
 
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
 	/* Odd numbered device ids are the units with enable bits (the -R cards) */
 	if (pdev->device % 1 && !pci_test_config_bits(pdev, &artop_enable_bits[ap->port_no]))
 		return -ENOENT;
 
-	return ata_std_prereset(ap, deadline);
+	return ata_std_prereset(link, deadline);
 }
 
 /**
diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index 80509be..2d4ce07 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -33,8 +33,9 @@ enum {
 	ATIIXP_IDE_UDMA_MODE 	= 0x56
 };
 
-static int atiixp_pre_reset(struct ata_port *ap, unsigned long deadline)
+static int atiixp_pre_reset(struct ata_link *link, unsigned long deadline)
 {
+	struct ata_port *ap = link->ap;
 	static const struct pci_bits atiixp_enable_bits[] = {
 		{ 0x48, 1, 0x01, 0x00 },
 		{ 0x48, 1, 0x08, 0x00 }
@@ -44,7 +45,7 @@ static int atiixp_pre_reset(struct ata_port *ap, unsigned long deadline)
 	if (!pci_test_config_bits(pdev, &atiixp_enable_bits[ap->port_no]))
 		return -ENOENT;
 
-	return ata_std_prereset(ap, deadline);
+	return ata_std_prereset(link, deadline);
 }
 
 static void atiixp_error_handler(struct ata_port *ap)
diff --git a/drivers/ata/pata_efar.c b/drivers/ata/pata_efar.c
index c8ba59c..9f6fae6 100644
--- a/drivers/ata/pata_efar.c
+++ b/drivers/ata/pata_efar.c
@@ -26,25 +26,26 @@
 
 /**
  *	efar_pre_reset	-	Enable bits
- *	@ap: Port
+ *	@link: ATA link
  *	@deadline: deadline jiffies for the operation
  *
  *	Perform cable detection for the EFAR ATA interface. This is
  *	different to the PIIX arrangement
  */
 
-static int efar_pre_reset(struct ata_port *ap, unsigned long deadline)
+static int efar_pre_reset(struct ata_link *link, unsigned long deadline)
 {
 	static const struct pci_bits efar_enable_bits[] = {
 		{ 0x41U, 1U, 0x80UL, 0x80UL },	/* port 0 */
 		{ 0x43U, 1U, 0x80UL, 0x80UL },	/* port 1 */
 	};
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
 	if (!pci_test_config_bits(pdev, &efar_enable_bits[ap->port_no]))
 		return -ENOENT;
 
-	return ata_std_prereset(ap, deadline);
+	return ata_std_prereset(link, deadline);
 }
 
 /**
diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
index d2278fd..5cb262c 100644
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -306,15 +306,16 @@ static unsigned long hpt370a_filter(struct ata_device *adev, unsigned long mask)
 
 /**
  *	hpt37x_pre_reset	-	reset the hpt37x bus
- *	@ap: ATA port to reset
+ *	@link: ATA link to reset
  *	@deadline: deadline jiffies for the operation
  *
  *	Perform the initial reset handling for the 370/372 and 374 func 0
  */
 
-static int hpt37x_pre_reset(struct ata_port *ap, unsigned long deadline)
+static int hpt37x_pre_reset(struct ata_link *link, unsigned long deadline)
 {
 	u8 scr2, ata66;
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	static const struct pci_bits hpt37x_enable_bits[] = {
 		{ 0x50, 1, 0x04, 0x04 },
@@ -339,7 +340,7 @@ static int hpt37x_pre_reset(struct ata_port *ap, unsigned long deadline)
 	pci_write_config_byte(pdev, 0x50 + 4 * ap->port_no, 0x37);
 	udelay(100);
 
-	return ata_std_prereset(ap, deadline);
+	return ata_std_prereset(link, deadline);
 }
 
 /**
@@ -354,7 +355,7 @@ static void hpt37x_error_handler(struct ata_port *ap)
 	ata_bmdma_drive_eh(ap, hpt37x_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
 }
 
-static int hpt374_pre_reset(struct ata_port *ap, unsigned long deadline)
+static int hpt374_pre_reset(struct ata_link *link, unsigned long deadline)
 {
 	static const struct pci_bits hpt37x_enable_bits[] = {
 		{ 0x50, 1, 0x04, 0x04 },
@@ -362,6 +363,7 @@ static int hpt374_pre_reset(struct ata_port *ap, unsigned long deadline)
 	};
 	u16 mcr3, mcr6;
 	u8 ata66;
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
 	if (!pci_test_config_bits(pdev, &hpt37x_enable_bits[ap->port_no]))
@@ -389,7 +391,7 @@ static int hpt374_pre_reset(struct ata_port *ap, unsigned long deadline)
 	pci_write_config_byte(pdev, 0x50 + 4 * ap->port_no, 0x37);
 	udelay(100);
 
-	return ata_std_prereset(ap, deadline);
+	return ata_std_prereset(link, deadline);
 }
 
 /**
diff --git a/drivers/ata/pata_hpt3x2n.c b/drivers/ata/pata_hpt3x2n.c
index 809d338..49486f6 100644
--- a/drivers/ata/pata_hpt3x2n.c
+++ b/drivers/ata/pata_hpt3x2n.c
@@ -141,21 +141,22 @@ static int hpt3x2n_cable_detect(struct ata_port *ap)
 
 /**
  *	hpt3x2n_pre_reset	-	reset the hpt3x2n bus
- *	@ap: ATA port to reset
+ *	@link: ATA link to reset
  *	@deadline: deadline jiffies for the operation
  *
  *	Perform the initial reset handling for the 3x2n series controllers.
  *	Reset the hardware and state machine,
  */
 
-static int hpt3xn_pre_reset(struct ata_port *ap, unsigned long deadline)
+static int hpt3xn_pre_reset(struct ata_link *link, unsigned long deadline)
 {
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	/* Reset the state machine */
 	pci_write_config_byte(pdev, 0x50 + 4 * ap->port_no, 0x37);
 	udelay(100);
 
-	return ata_std_prereset(ap, deadline);
+	return ata_std_prereset(link, deadline);
 }
 
 /**
diff --git a/drivers/ata/pata_it8213.c b/drivers/ata/pata_it8213.c
index 41fb08b..11e96e4 100644
--- a/drivers/ata/pata_it8213.c
+++ b/drivers/ata/pata_it8213.c
@@ -23,23 +23,24 @@
 
 /**
  *	it8213_pre_reset	-	check for 40/80 pin
- *	@ap: Port
+ *	@link: link
  *	@deadline: deadline jiffies for the operation
  *
  *	Filter out ports by the enable bits before doing the normal reset
  *	and probe.
  */
 
-static int it8213_pre_reset(struct ata_port *ap, unsigned long deadline)
+static int it8213_pre_reset(struct ata_link *link, unsigned long deadline)
 {
 	static const struct pci_bits it8213_enable_bits[] = {
 		{ 0x41U, 1U, 0x80UL, 0x80UL },	/* port 0 */
 	};
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	if (!pci_test_config_bits(pdev, &it8213_enable_bits[ap->port_no]))
 		return -ENOENT;
 
-	return ata_std_prereset(ap, deadline);
+	return ata_std_prereset(link, deadline);
 }
 
 /**
diff --git a/drivers/ata/pata_jmicron.c b/drivers/ata/pata_jmicron.c
index 1a6c4db..108b8f7 100644
--- a/drivers/ata/pata_jmicron.c
+++ b/drivers/ata/pata_jmicron.c
@@ -29,7 +29,7 @@ typedef enum {
 
 /**
  *	jmicron_pre_reset	-	check for 40/80 pin
- *	@ap: Port
+ *	@link: ATA link
  *	@deadline: deadline jiffies for the operation
  *
  *	Perform the PATA port setup we need.
@@ -39,9 +39,9 @@ typedef enum {
  *	and setup here. We assume that has been done by init_one and the
  *	BIOS.
  */
-
-static int jmicron_pre_reset(struct ata_port *ap, unsigned long deadline)
+static int jmicron_pre_reset(struct ata_link *link, unsigned long deadline)
 {
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u32 control;
 	u32 control5;
@@ -103,7 +103,7 @@ static int jmicron_pre_reset(struct ata_port *ap, unsigned long deadline)
 		ap->cbl = ATA_CBL_SATA;
 		break;
 	}
-	return ata_std_prereset(ap, deadline);
+	return ata_std_prereset(link, deadline);
 }
 
 /**
diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
index 73f1e4b..01a76d7 100644
--- a/drivers/ata/pata_marvell.c
+++ b/drivers/ata/pata_marvell.c
@@ -24,14 +24,15 @@
 
 /**
  *	marvell_pre_reset	-	check for 40/80 pin
- *	@ap: Port
+ *	@link: link
  *	@deadline: deadline jiffies for the operation
  *
  *	Perform the PATA port setup we need.
  */
 
-static int marvell_pre_reset(struct ata_port *ap, unsigned long deadline)
+static int marvell_pre_reset(struct ata_link *link, unsigned long deadline)
 {
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u32 devices;
 	void __iomem *barp;
@@ -54,7 +55,7 @@ static int marvell_pre_reset(struct ata_port *ap, unsigned long deadline)
 	    (!(devices & 0x10)))	/* PATA enable ? */
 		return -ENOENT;
 
-	return ata_std_prereset(ap, deadline);
+	return ata_std_prereset(link, deadline);
 }
 
 static int marvell_cable_detect(struct ata_port *ap)
diff --git a/drivers/ata/pata_mpiix.c b/drivers/ata/pata_mpiix.c
index 4ea4283..36c964b 100644
--- a/drivers/ata/pata_mpiix.c
+++ b/drivers/ata/pata_mpiix.c
@@ -46,15 +46,16 @@ enum {
 	SECONDARY = (1 << 14)
 };
 
-static int mpiix_pre_reset(struct ata_port *ap, unsigned long deadline)
+static int mpiix_pre_reset(struct ata_link *link, unsigned long deadline)
 {
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	static const struct pci_bits mpiix_enable_bits = { 0x6D, 1, 0x80, 0x80 };
 
 	if (!pci_test_config_bits(pdev, &mpiix_enable_bits))
 		return -ENOENT;
 
-	return ata_std_prereset(ap, deadline);
+	return ata_std_prereset(link, deadline);
 }
 
 /**
diff --git a/drivers/ata/pata_ns87410.c b/drivers/ata/pata_ns87410.c
index 2f5d714..65a2177 100644
--- a/drivers/ata/pata_ns87410.c
+++ b/drivers/ata/pata_ns87410.c
@@ -32,14 +32,15 @@
 
 /**
  *	ns87410_pre_reset		-	probe begin
- *	@ap: ATA port
+ *	@link: ATA link
  *	@deadline: deadline jiffies for the operation
  *
  *	Check enabled ports
  */
 
-static int ns87410_pre_reset(struct ata_port *ap, unsigned long deadline)
+static int ns87410_pre_reset(struct ata_link *link, unsigned long deadline)
 {
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	static const struct pci_bits ns87410_enable_bits[] = {
 		{ 0x43, 1, 0x08, 0x08 },
@@ -49,7 +50,7 @@ static int ns87410_pre_reset(struct ata_port *ap, unsigned long deadline)
 	if (!pci_test_config_bits(pdev, &ns87410_enable_bits[ap->port_no]))
 		return -ENOENT;
 
-	return ata_std_prereset(ap, deadline);
+	return ata_std_prereset(link, deadline);
 }
 
 /**
diff --git a/drivers/ata/pata_oldpiix.c b/drivers/ata/pata_oldpiix.c
index 091a70a..5b2c86f 100644
--- a/drivers/ata/pata_oldpiix.c
+++ b/drivers/ata/pata_oldpiix.c
@@ -29,14 +29,15 @@
 
 /**
  *	oldpiix_pre_reset		-	probe begin
- *	@ap: ATA port
+ *	@link: ATA link
  *	@deadline: deadline jiffies for the operation
  *
  *	Set up cable type and use generic probe init
  */
 
-static int oldpiix_pre_reset(struct ata_port *ap, unsigned long deadline)
+static int oldpiix_pre_reset(struct ata_link *link, unsigned long deadline)
 {
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	static const struct pci_bits oldpiix_enable_bits[] = {
 		{ 0x41U, 1U, 0x80UL, 0x80UL },	/* port 0 */
@@ -46,7 +47,7 @@ static int oldpiix_pre_reset(struct ata_port *ap, unsigned long deadline)
 	if (!pci_test_config_bits(pdev, &oldpiix_enable_bits[ap->port_no]))
 		return -ENOENT;
 
-	return ata_std_prereset(ap, deadline);
+	return ata_std_prereset(link, deadline);
 }
 
 /**
diff --git a/drivers/ata/pata_opti.c b/drivers/ata/pata_opti.c
index 458bf67..5770c77 100644
--- a/drivers/ata/pata_opti.c
+++ b/drivers/ata/pata_opti.c
@@ -46,14 +46,15 @@ enum {
 
 /**
  *	opti_pre_reset		-	probe begin
- *	@ap: ATA port
+ *	@link: ATA link
  *	@deadline: deadline jiffies for the operation
  *
  *	Set up cable type and use generic probe init
  */
 
-static int opti_pre_reset(struct ata_port *ap, unsigned long deadline)
+static int opti_pre_reset(struct ata_link *link, unsigned long deadline)
 {
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	static const struct pci_bits opti_enable_bits[] = {
 		{ 0x45, 1, 0x80, 0x00 },
@@ -63,7 +64,7 @@ static int opti_pre_reset(struct ata_port *ap, unsigned long deadline)
 	if (!pci_test_config_bits(pdev, &opti_enable_bits[ap->port_no]))
 		return -ENOENT;
 
-	return ata_std_prereset(ap, deadline);
+	return ata_std_prereset(link, deadline);
 }
 
 /**
diff --git a/drivers/ata/pata_optidma.c b/drivers/ata/pata_optidma.c
index f8234d7..39fcba8 100644
--- a/drivers/ata/pata_optidma.c
+++ b/drivers/ata/pata_optidma.c
@@ -47,14 +47,15 @@ static int pci_clock;	/* 0 = 33 1 = 25 */
 
 /**
  *	optidma_pre_reset		-	probe begin
- *	@ap: ATA port
+ *	@link: ATA link
  *	@deadline: deadline jiffies for the operation
  *
  *	Set up cable type and use generic probe init
  */
 
-static int optidma_pre_reset(struct ata_port *ap, unsigned long deadline)
+static int optidma_pre_reset(struct ata_link *link, unsigned long deadline)
 {
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	static const struct pci_bits optidma_enable_bits = {
 		0x40, 1, 0x08, 0x00
@@ -63,7 +64,7 @@ static int optidma_pre_reset(struct ata_port *ap, unsigned long deadline)
 	if (ap->port_no && !pci_test_config_bits(pdev, &optidma_enable_bits))
 		return -ENOENT;
 
-	return ata_std_prereset(ap, deadline);
+	return ata_std_prereset(link, deadline);
 }
 
 /**
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index 9bff859..62c3457 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -300,7 +300,7 @@ static inline int pdc2027x_port_enabled(struct ata_port *ap)
 
 /**
  *	pdc2027x_prereset - prereset for PATA host controller
- *	@ap: Target port
+ *	@link: Target link
  *	@deadline: deadline jiffies for the operation
  *
  *	Probeinit including cable detection.
@@ -309,12 +309,12 @@ static inline int pdc2027x_port_enabled(struct ata_port *ap)
  *	None (inherited from caller).
  */
 
-static int pdc2027x_prereset(struct ata_port *ap, unsigned long deadline)
+static int pdc2027x_prereset(struct ata_link *link, unsigned long deadline)
 {
 	/* Check whether port enabled */
-	if (!pdc2027x_port_enabled(ap))
+	if (!pdc2027x_port_enabled(link->ap))
 		return -ENOENT;
-	return ata_std_prereset(ap, deadline);
+	return ata_std_prereset(link, deadline);
 }
 
 /**
diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index 9b645c5..c3a3527 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -95,15 +95,16 @@ static int sil680_cable_detect(struct ata_port *ap) {
 
 /**
  *	sil680_bus_reset	-	reset the SIL680 bus
- *	@ap: ATA port to reset
+ *	@link: ATA link to reset
  *	@deadline: deadline jiffies for the operation
  *
  *	Perform the SIL680 housekeeping when doing an ATA bus reset
  */
 
-static int sil680_bus_reset(struct ata_port *ap,unsigned int *classes,
+static int sil680_bus_reset(struct ata_link *link, unsigned int *classes,
 			    unsigned long deadline)
 {
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	unsigned long addr = sil680_selreg(ap, 0);
 	u8 reset;
@@ -112,7 +113,7 @@ static int sil680_bus_reset(struct ata_port *ap,unsigned int *classes,
 	pci_write_config_byte(pdev, addr, reset | 0x03);
 	udelay(25);
 	pci_write_config_byte(pdev, addr, reset);
-	return ata_std_softreset(ap, classes, deadline);
+	return ata_std_softreset(link, classes, deadline);
 }
 
 static void sil680_error_handler(struct ata_port *ap)
diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index 956c6cc..7f6911e 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -131,25 +131,26 @@ static int sis_66_cable_detect(struct ata_port *ap)
 
 /**
  *	sis_pre_reset		-	probe begin
- *	@ap: ATA port
+ *	@link: ATA link
  *	@deadline: deadline jiffies for the operation
  *
  *	Set up cable type and use generic probe init
  */
 
-static int sis_pre_reset(struct ata_port *ap, unsigned long deadline)
+static int sis_pre_reset(struct ata_link *link, unsigned long deadline)
 {
 	static const struct pci_bits sis_enable_bits[] = {
 		{ 0x4aU, 1U, 0x02UL, 0x02UL },	/* port 0 */
 		{ 0x4aU, 1U, 0x04UL, 0x04UL },	/* port 1 */
 	};
 
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
 	if (!pci_test_config_bits(pdev, &sis_enable_bits[ap->port_no]))
 		return -ENOENT;
 
-	return ata_std_prereset(ap, deadline);
+	return ata_std_prereset(link, deadline);
 }
 
 
diff --git a/drivers/ata/pata_sl82c105.c b/drivers/ata/pata_sl82c105.c
index bde7341..896dff0 100644
--- a/drivers/ata/pata_sl82c105.c
+++ b/drivers/ata/pata_sl82c105.c
@@ -43,23 +43,24 @@ enum {
 
 /**
  *	sl82c105_pre_reset		-	probe begin
- *	@ap: ATA port
+ *	@link: ATA link
  *	@deadline: deadline jiffies for the operation
  *
  *	Set up cable type and use generic probe init
  */
 
-static int sl82c105_pre_reset(struct ata_port *ap, unsigned long deadline)
+static int sl82c105_pre_reset(struct ata_link *link, unsigned long deadline)
 {
 	static const struct pci_bits sl82c105_enable_bits[] = {
 		{ 0x40, 1, 0x01, 0x01 },
 		{ 0x40, 1, 0x10, 0x10 }
 	};
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
 	if (ap->port_no && !pci_test_config_bits(pdev, &sl82c105_enable_bits[ap->port_no]))
 		return -ENOENT;
-	return ata_std_prereset(ap, deadline);
+	return ata_std_prereset(link, deadline);
 }
 
 
diff --git a/drivers/ata/pata_triflex.c b/drivers/ata/pata_triflex.c
index af21f44..bc4b6f6 100644
--- a/drivers/ata/pata_triflex.c
+++ b/drivers/ata/pata_triflex.c
@@ -47,25 +47,26 @@
 
 /**
  *	triflex_prereset		-	probe begin
- *	@ap: ATA port
+ *	@link: ATA link
  *	@deadline: deadline jiffies for the operation
  *
  *	Set up cable type and use generic probe init
  */
 
-static int triflex_prereset(struct ata_port *ap, unsigned long deadline)
+static int triflex_prereset(struct ata_link *link, unsigned long deadline)
 {
 	static const struct pci_bits triflex_enable_bits[] = {
 		{ 0x80, 1, 0x01, 0x01 },
 		{ 0x80, 1, 0x02, 0x02 }
 	};
 
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
 	if (!pci_test_config_bits(pdev, &triflex_enable_bits[ap->port_no]))
 		return -ENOENT;
 
-	return ata_std_prereset(ap, deadline);
+	return ata_std_prereset(link, deadline);
 }
 
 
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index 63eca29..de73f5d 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -183,8 +183,9 @@ static int via_cable_detect(struct ata_port *ap) {
 	return ATA_CBL_PATA40;
 }
 
-static int via_pre_reset(struct ata_port *ap, unsigned long deadline)
+static int via_pre_reset(struct ata_link *link, unsigned long deadline)
 {
+	struct ata_port *ap = link->ap;
 	const struct via_isa_bridge *config = ap->host->private_data;
 
 	if (!(config->flags & VIA_NO_ENABLES)) {
@@ -197,7 +198,7 @@ static int via_pre_reset(struct ata_port *ap, unsigned long deadline)
 			return -ENOENT;
 	}
 
-	return ata_std_prereset(ap, deadline);
+	return ata_std_prereset(link, deadline);
 }
 
 
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index 374e87b..31d0366 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -417,12 +417,13 @@ static void inic_thaw(struct ata_port *ap)
  * SRST and SControl hardreset don't give valid signature on this
  * controller.  Only controller specific hardreset mechanism works.
  */
-static int inic_hardreset(struct ata_port *ap, unsigned int *class,
+static int inic_hardreset(struct ata_link *link, unsigned int *class,
 			  unsigned long deadline)
 {
+	struct ata_port *ap = link->ap;
 	void __iomem *port_base = inic_port_base(ap);
 	void __iomem *idma_ctl = port_base + PORT_IDMA_CTL;
-	const unsigned long *timing = sata_ehc_deb_timing(&ap->link.eh_context);
+	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
 	u16 val;
 	int rc;
 
@@ -435,15 +436,15 @@ static int inic_hardreset(struct ata_port *ap, unsigned int *class,
 	msleep(1);
 	writew(val & ~IDMA_CTL_RST_ATA, idma_ctl);
 
-	rc = sata_link_resume(&ap->link, timing, deadline);
+	rc = sata_link_resume(link, timing, deadline);
 	if (rc) {
-		ata_port_printk(ap, KERN_WARNING, "failed to resume "
+		ata_link_printk(link, KERN_WARNING, "failed to resume "
 				"link after reset (errno=%d)\n", rc);
 		return rc;
 	}
 
 	*class = ATA_DEV_NONE;
-	if (ata_link_online(&ap->link)) {
+	if (ata_link_online(link)) {
 		struct ata_taskfile tf;
 
 		/* wait a while before checking status */
@@ -452,7 +453,7 @@ static int inic_hardreset(struct ata_port *ap, unsigned int *class,
 		rc = ata_wait_ready(ap, deadline);
 		/* link occupied, -ENODEV too is an error */
 		if (rc) {
-			ata_port_printk(ap, KERN_WARNING, "device not ready "
+			ata_link_printk(link, KERN_WARNING, "device not ready "
 					"after hardreset (errno=%d)\n", rc);
 			return rc;
 		}
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 3108720..6acdfdd 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -1457,7 +1457,7 @@ static void nv_ck804_thaw(struct ata_port *ap)
 	writeb(mask, mmio_base + NV_INT_ENABLE_CK804);
 }
 
-static int nv_hardreset(struct ata_port *ap, unsigned int *class,
+static int nv_hardreset(struct ata_link *link, unsigned int *class,
 			unsigned long deadline)
 {
 	unsigned int dummy;
@@ -1466,7 +1466,7 @@ static int nv_hardreset(struct ata_port *ap, unsigned int *class,
 	 * some controllers.  Don't classify on hardreset.  For more
 	 * info, see http://bugme.osdl.org/show_bug.cgi?id=3352
 	 */
-	return sata_std_hardreset(ap, &dummy, deadline);
+	return sata_std_hardreset(link, &dummy, deadline);
 }
 
 static void nv_error_handler(struct ata_port *ap)
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 495b13a..e92d119 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -536,9 +536,10 @@ static int sil24_init_port(struct ata_port *ap)
 	return 0;
 }
 
-static int sil24_softreset(struct ata_port *ap, unsigned int *class,
+static int sil24_softreset(struct ata_link *link, unsigned int *class,
 			   unsigned long deadline)
 {
+	struct ata_port *ap = link->ap;
 	void __iomem *port = ap->ioaddr.cmd_addr;
 	struct sil24_port_priv *pp = ap->private_data;
 	struct sil24_prb *prb = &pp->cmd_block[0].ata.prb;
@@ -548,7 +549,7 @@ static int sil24_softreset(struct ata_port *ap, unsigned int *class,
 
 	DPRINTK("ENTER\n");
 
-	if (ata_link_offline(&ap->link)) {
+	if (ata_link_offline(link)) {
 		DPRINTK("PHY reports no device\n");
 		*class = ATA_DEV_NONE;
 		goto out;
@@ -593,23 +594,24 @@ static int sil24_softreset(struct ata_port *ap, unsigned int *class,
 	return 0;
 
  err:
-	ata_port_printk(ap, KERN_ERR, "softreset failed (%s)\n", reason);
+	ata_link_printk(link, KERN_ERR, "softreset failed (%s)\n", reason);
 	return -EIO;
 }
 
-static int sil24_hardreset(struct ata_port *ap, unsigned int *class,
+static int sil24_hardreset(struct ata_link *link, unsigned int *class,
 			   unsigned long deadline)
 {
+	struct ata_port *ap = link->ap;
 	void __iomem *port = ap->ioaddr.cmd_addr;
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
@@ -619,14 +621,14 @@ static int sil24_hardreset(struct ata_port *ap, unsigned int *class,
 	/* SStatus oscillates between zero and valid status after
 	 * DEV_RST, debounce it.
 	 */
-	rc = sata_link_debounce(&ap->link, sata_deb_timing_long, deadline);
+	rc = sata_link_debounce(link, sata_deb_timing_long, deadline);
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
@@ -641,7 +643,7 @@ static int sil24_hardreset(struct ata_port *ap, unsigned int *class,
 	return -EAGAIN;
 
  err:
-	ata_port_printk(ap, KERN_ERR, "hardreset failed (%s)\n", reason);
+	ata_link_printk(link, KERN_ERR, "hardreset failed (%s)\n", reason);
 	return -EIO;
 }
 
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 9f5bc49..f57388e 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -276,7 +276,7 @@ static void svia_noop_freeze(struct ata_port *ap)
 
 /**
  *	vt6420_prereset - prereset for vt6420
- *	@ap: target ATA port
+ *	@link: target ATA link
  *	@deadline: deadline jiffies for the operation
  *
  *	SCR registers on vt6420 are pieces of shit and may hang the
@@ -294,8 +294,9 @@ static void svia_noop_freeze(struct ata_port *ap)
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-static int vt6420_prereset(struct ata_port *ap, unsigned long deadline)
+static int vt6420_prereset(struct ata_link *link, unsigned long deadline)
 {
+	struct ata_port *ap = link->ap;
 	struct ata_eh_context *ehc = &ap->link.eh_context;
 	unsigned long timeout = jiffies + (HZ * 5);
 	u32 sstatus, scontrol;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 693ce22..159cbf5 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -330,14 +330,15 @@ enum ata_completion_errors {
 struct scsi_device;
 struct ata_port_operations;
 struct ata_port;
+struct ata_link;
 struct ata_queued_cmd;
 
 /* typedefs */
 typedef void (*ata_qc_cb_t) (struct ata_queued_cmd *qc);
-typedef int (*ata_prereset_fn_t)(struct ata_port *ap, unsigned long deadline);
-typedef int (*ata_reset_fn_t)(struct ata_port *ap, unsigned int *classes,
+typedef int (*ata_prereset_fn_t)(struct ata_link *link, unsigned long deadline);
+typedef int (*ata_reset_fn_t)(struct ata_link *link, unsigned int *classes,
 			      unsigned long deadline);
-typedef void (*ata_postreset_fn_t)(struct ata_port *ap, unsigned int *classes);
+typedef void (*ata_postreset_fn_t)(struct ata_link *link, unsigned int *classes);
 
 struct ata_ioports {
 	void __iomem		*cmd_addr;
@@ -702,14 +703,14 @@ extern int sata_link_debounce(struct ata_link *link,
 			const unsigned long *params, unsigned long deadline);
 extern int sata_link_resume(struct ata_link *link, const unsigned long *params,
 			    unsigned long deadline);
-extern int ata_std_prereset(struct ata_port *ap, unsigned long deadline);
-extern int ata_std_softreset(struct ata_port *ap, unsigned int *classes,
+extern int ata_std_prereset(struct ata_link *link, unsigned long deadline);
+extern int ata_std_softreset(struct ata_link *link, unsigned int *classes,
 			     unsigned long deadline);
-extern int sata_port_hardreset(struct ata_port *ap, const unsigned long *timing,
-			       unsigned long deadline);
-extern int sata_std_hardreset(struct ata_port *ap, unsigned int *class,
+extern int sata_link_hardreset(struct ata_link *link,
+			const unsigned long *timing, unsigned long deadline);
+extern int sata_std_hardreset(struct ata_link *link, unsigned int *class,
 			      unsigned long deadline);
-extern void ata_std_postreset(struct ata_port *ap, unsigned int *classes);
+extern void ata_std_postreset(struct ata_link *link, unsigned int *classes);
 extern void ata_port_disable(struct ata_port *);
 extern void ata_std_ports(struct ata_ioports *ioaddr);
 #ifdef CONFIG_PCI
-- 
1.5.0.3


