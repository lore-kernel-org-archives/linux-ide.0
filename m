From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 8/18] [PATCH] libata-link: linkify reset
Date: Mon, 16 Oct 2006 07:54:40 +0900
Message-ID: <1160952880968-git-send-email-htejun@gmail.com>
References: <1160952879581-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:24502 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422932AbWJOWy4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Oct 2006 18:54:56 -0400
Received: by nf-out-0910.google.com with SMTP id c2so626640nfe
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 15:54:54 -0700 (PDT)
In-Reply-To: <1160952879581-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make reset methods and related functions deal with ata_link instead of
ata_port.

* ata_do_reset()
* ata_eh_reset()
* all prereset/reset/postreset methods and related functions

This patch introduces no behavior change.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c              |   30 +++++++++++--------
 drivers/ata/ata_generic.c       |    8 +++--
 drivers/ata/ata_piix.c          |   27 +++++++++--------
 drivers/ata/libata-core.c       |   62 +++++++++++++++++++--------------------
 drivers/ata/libata-eh.c         |   38 ++++++++++++------------
 drivers/ata/pata_ali.c          |   16 +++++-----
 drivers/ata/pata_amd.c          |   24 +++++++++------
 drivers/ata/pata_artop.c        |   12 ++++----
 drivers/ata/pata_atiixp.c       |    5 ++-
 drivers/ata/pata_cmd64x.c       |   11 ++++---
 drivers/ata/pata_cs5520.c       |    6 ++--
 drivers/ata/pata_cs5530.c       |    6 ++--
 drivers/ata/pata_cs5535.c       |    5 ++-
 drivers/ata/pata_cypress.c      |    6 ++--
 drivers/ata/pata_efar.c         |    7 +++-
 drivers/ata/pata_hpt366.c       |    5 ++-
 drivers/ata/pata_hpt37x.c       |   12 ++++----
 drivers/ata/pata_hpt3x2n.c      |    7 +++-
 drivers/ata/pata_hpt3x3.c       |    6 ++--
 drivers/ata/pata_it821x.c       |    8 +++--
 drivers/ata/pata_jmicron.c      |    9 +++---
 drivers/ata/pata_mpiix.c        |    5 ++-
 drivers/ata/pata_netcell.c      |    8 +++--
 drivers/ata/pata_ns87410.c      |    7 +++-
 drivers/ata/pata_oldpiix.c      |    7 +++-
 drivers/ata/pata_opti.c         |    7 +++-
 drivers/ata/pata_optidma.c      |    7 +++-
 drivers/ata/pata_pdc2027x.c     |   10 +++---
 drivers/ata/pata_pdc202xx_old.c |   13 ++++----
 drivers/ata/pata_radisys.c      |    8 +++--
 drivers/ata/pata_rz1000.c       |    8 +++--
 drivers/ata/pata_serverworks.c  |    8 +++--
 drivers/ata/pata_sil680.c       |   13 ++++----
 drivers/ata/pata_sis.c          |   21 ++++++++-----
 drivers/ata/pata_sl82c105.c     |    5 ++-
 drivers/ata/pata_triflex.c      |    7 +++-
 drivers/ata/pata_via.c          |    5 ++-
 drivers/ata/sata_nv.c           |    4 +--
 drivers/ata/sata_sil24.c        |   20 +++++++------
 drivers/ata/sata_via.c          |    5 ++-
 include/linux/libata.h          |   17 ++++++-----
 41 files changed, 267 insertions(+), 228 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 2888144..08611e2 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -733,8 +733,9 @@ static int ahci_clo(struct ata_port *ap)
 	return 0;
 }
 
-static int ahci_softreset(struct ata_port *ap, unsigned int *class)
+static int ahci_softreset(struct ata_link *link, unsigned int *class)
 {
+	struct ata_port *ap = link->ap;
 	struct ahci_port_priv *pp = ap->private_data;
 	void __iomem *mmio = ap->host->mmio_base;
 	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
@@ -747,7 +748,7 @@ static int ahci_softreset(struct ata_por
 
 	DPRINTK("ENTER\n");
 
-	if (ata_link_offline(&ap->link)) {
+	if (ata_link_offline(link)) {
 		DPRINTK("PHY reports no device\n");
 		*class = ATA_DEV_NONE;
 		return 0;
@@ -776,7 +777,7 @@ static int ahci_softreset(struct ata_por
 	/* restart engine */
 	ahci_start_engine(port_mmio);
 
-	ata_tf_init(ap->link.device, &tf);
+	ata_tf_init(link->device, &tf);
 	fis = pp->cmd_tbl;
 
 	/* issue the first D2H Register FIS */
@@ -820,7 +821,7 @@ static int ahci_softreset(struct ata_por
 	msleep(150);
 
 	*class = ATA_DEV_NONE;
-	if (ata_link_online(&ap->link)) {
+	if (ata_link_online(link)) {
 		if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
 			rc = -EIO;
 			reason = "device not ready";
@@ -835,12 +836,13 @@ static int ahci_softreset(struct ata_por
  fail_restart:
 	ahci_start_engine(port_mmio);
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
@@ -853,15 +855,15 @@ static int ahci_hardreset(struct ata_por
 	ahci_stop_engine(port_mmio);
 
 	/* clear D2H reception area to properly wait for D2H FIS */
-	ata_tf_init(ap->link.device, &tf);
+	ata_tf_init(link->device, &tf);
 	tf.command = 0xff;
 	ata_tf_to_fis(&tf, d2h_fis, 0);
 
-	rc = sata_std_hardreset(ap, class);
+	rc = sata_std_hardreset(link, class);
 
 	ahci_start_engine(port_mmio);
 
-	if (rc == 0 && ata_link_online(&ap->link))
+	if (rc == 0 && ata_link_online(link))
 		*class = ahci_dev_classify(ap);
 	if (*class == ATA_DEV_UNKNOWN)
 		*class = ATA_DEV_NONE;
@@ -870,8 +872,9 @@ static int ahci_hardreset(struct ata_por
 	return rc;
 }
 
-static int ahci_vt8251_hardreset(struct ata_port *ap, unsigned int *class)
+static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class)
 {
+	struct ata_port *ap = link->ap;
 	void __iomem *mmio = ap->host->mmio_base;
 	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
 	int rc;
@@ -880,7 +883,7 @@ static int ahci_vt8251_hardreset(struct 
 
 	ahci_stop_engine(port_mmio);
 
-	rc = sata_port_hardreset(ap, sata_ehc_deb_timing(&ap->link.eh_context));
+	rc = sata_link_hardreset(link, sata_ehc_deb_timing(&link->eh_context));
 
 	/* vt8251 needs SError cleared for the port to operate */
 	ahci_scr_write(ap, SCR_ERROR, ahci_scr_read(ap, SCR_ERROR));
@@ -895,12 +898,13 @@ static int ahci_vt8251_hardreset(struct 
 	return rc ?: -EAGAIN;
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
diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index e060fee..05160bc 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -34,15 +34,15 @@ #define DRV_VERSION "0.2.7"
 
 /**
  *	generic_pre_reset		-	probe begin
- *	@ap: ATA port
+ *	@link: ATA link
  *
  *	Set up cable type and use generic probe init
  */
 
-static int generic_pre_reset(struct ata_port *ap)
+static int generic_pre_reset(struct ata_link *link)
 {
-	ap->cbl = ATA_CBL_PATA80;
-	return ata_std_prereset(ap);
+	link->ap->cbl = ATA_CBL_PATA80;
+	return ata_std_prereset(link);
 }
 
 
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index ffeaf65..fa7d79d 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -662,21 +662,22 @@ cbl40:
 
 /**
  *	piix_pata_prereset - prereset for PATA host controller
- *	@ap: Target port
+ *	@link: Target link
  *
  *
  *	LOCKING:
  *	None (inherited from caller).
  */
-static int piix_pata_prereset(struct ata_port *ap)
+static int piix_pata_prereset(struct ata_link *link)
 {
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
 	if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->port_no]))
 		return -ENOENT;
 		
 	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(link);
 }
 
 static void piix_pata_error_handler(struct ata_port *ap)
@@ -688,25 +689,26 @@ static void piix_pata_error_handler(stru
 
 /**
  *	ich_pata_prereset - prereset for PATA host controller
- *	@ap: Target port
+ *	@link: Target link
  *
  *
  *	LOCKING:
  *	None (inherited from caller).
  */
-static int ich_pata_prereset(struct ata_port *ap)
+static int ich_pata_prereset(struct ata_link *link)
 {
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
 	if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->port_no])) {
 		ata_port_printk(ap, KERN_INFO, "port disabled. ignoring.\n");
-		ap->link.eh_context.i.action &= ~ATA_EH_RESET_MASK;
+		link->eh_context.i.action &= ~ATA_EH_RESET_MASK;
 		return 0;
 	}
 
 	ich_pata_cbl_detect(ap);
 
-	return ata_std_prereset(ap);
+	return ata_std_prereset(link);
 }
 
 static void ich_pata_error_handler(struct ata_port *ap)
@@ -758,10 +760,10 @@ static unsigned int piix_sata_present_ma
 
 /**
  *	piix_sata_softreset - reset SATA host port via ATA SRST
- *	@ap: port to reset
+ *	@link: link to reset
  *	@classes: resulting classes of attached devices
  *
- *	Reset SATA host port via ATA SRST.  On controllers with
+ *	Reset SATA host link via ATA SRST.  On controllers with
  *	reliable PCS present bits, the bits are used to determine
  *	device presence.
  *
@@ -771,19 +773,20 @@ static unsigned int piix_sata_present_ma
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-static int piix_sata_softreset(struct ata_port *ap, unsigned int *classes)
+static int piix_sata_softreset(struct ata_link *link, unsigned int *classes)
 {
+	struct ata_port *ap = link->ap;
 	unsigned int present_mask;
 	struct ata_device *dev;
 	int rc;
 
 	present_mask = piix_sata_present_mask(ap);
 
-	rc = ata_std_softreset(ap, classes);
+	rc = ata_std_softreset(link, classes);
 	if (rc)
 		return rc;
 
-	ata_link_for_each_dev(dev, &ap->link) {
+	ata_link_for_each_dev(dev, link) {
 		if (!(present_mask & (1 << dev->devno)))
 			classes[dev->devno] = ATA_DEV_NONE;
 	}
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4f75d41..5293fe0 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2636,19 +2636,18 @@ int sata_link_resume(struct ata_link *li
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
 
@@ -2660,17 +2659,17 @@ static void ata_wait_spinup(struct ata_p
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
@@ -2678,9 +2677,9 @@ static void ata_wait_spinup(struct ata_p
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
@@ -2692,7 +2691,7 @@ int ata_std_prereset(struct ata_port *ap
 
 	if ((ehc->i.flags & ATA_EHI_HOTPLUGGED) &&
 	    (ap->flags & ATA_FLAG_SKIP_D2H_BSY))
-		ata_wait_spinup(ap);
+		ata_wait_spinup(link);
 
 	/* if we're about to do hardreset, nothing more to do */
 	if (ehc->i.action & ATA_EH_HARDRESET)
@@ -2703,7 +2702,7 @@ int ata_std_prereset(struct ata_port *ap
 		rc = sata_link_resume(link, timing);
 		if (rc && rc != -EOPNOTSUPP) {
 			/* phy resume failed */
-			ata_port_printk(ap, KERN_WARNING, "failed to resume "
+			ata_link_printk(link, KERN_WARNING, "failed to resume "
 					"link for reset (errno=%d)\n", rc);
 			return rc;
 		}
@@ -2720,7 +2719,7 @@ int ata_std_prereset(struct ata_port *ap
 
 /**
  *	ata_std_softreset - reset host port via ATA SRST
- *	@ap: port to reset
+ *	@link: ATA link to reset
  *	@classes: resulting classes of attached devices
  *
  *	Reset host port using ATA SRST.
@@ -2731,9 +2730,9 @@ int ata_std_prereset(struct ata_port *ap
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
@@ -2758,7 +2757,7 @@ int ata_std_softreset(struct ata_port *a
 	DPRINTK("about to softreset, devmask=%x\n", devmask);
 	err_mask = ata_bus_softreset(ap, devmask);
 	if (err_mask) {
-		ata_port_printk(ap, KERN_ERR, "SRST failed (err_mask=0x%x)\n",
+		ata_link_printk(link, KERN_ERR, "SRST failed (err_mask=0x%x)\n",
 				err_mask);
 		return -EIO;
 	}
@@ -2774,11 +2773,11 @@ int ata_std_softreset(struct ata_port *a
 }
 
 /**
- *	sata_port_hardreset - reset port via SATA phy reset
- *	@ap: port to reset
+ *	sata_link_hardreset - reset link via SATA phy reset
+ *	@link: link to reset
  *	@timing: timing parameters { interval, duratinon, timeout } in msec
  *
- *	SATA phy-reset host port using DET bits of SControl register.
+ *	SATA phy-reset @link using DET bits of SControl register.
  *
  *	LOCKING:
  *	Kernel thread context (may sleep)
@@ -2786,9 +2785,8 @@ int ata_std_softreset(struct ata_port *a
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int sata_port_hardreset(struct ata_port *ap, const unsigned long *timing)
+int sata_link_hardreset(struct ata_link *link, const unsigned long *timing)
 {
-	struct ata_link *link = &ap->link;
 	u32 scontrol;
 	int rc;
 
@@ -2834,7 +2832,7 @@ int sata_port_hardreset(struct ata_port 
 
 /**
  *	sata_std_hardreset - reset host port via SATA phy reset
- *	@ap: port to reset
+ *	@link: link to reset
  *	@class: resulting class of attached device
  *
  *	SATA phy-reset host port using DET bits of SControl register,
@@ -2846,18 +2844,18 @@ int sata_port_hardreset(struct ata_port 
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int sata_std_hardreset(struct ata_port *ap, unsigned int *class)
+int sata_std_hardreset(struct ata_link *link, unsigned int *class)
 {
-	struct ata_link *link = &ap->link;
+	struct ata_port *ap = link->ap;
 	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
 	int rc;
 
 	DPRINTK("ENTER\n");
 
 	/* do hardreset */
-	rc = sata_port_hardreset(ap, timing);
+	rc = sata_link_hardreset(link, timing);
 	if (rc) {
-		ata_port_printk(ap, KERN_ERR,
+		ata_link_printk(link, KERN_ERR,
 				"COMRESET failed (errno=%d)\n", rc);
 		return rc;
 	}
@@ -2885,7 +2883,7 @@ int sata_std_hardreset(struct ata_port *
 
 /**
  *	ata_std_postreset - standard postreset callback
- *	@ap: the target ata_port
+ *	@link: the target ata_link
  *	@classes: classes of attached devices
  *
  *	This function is invoked after a successful reset.  Note that
@@ -2895,9 +2893,9 @@ int sata_std_hardreset(struct ata_port *
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
@@ -6251,7 +6249,7 @@ EXPORT_SYMBOL_GPL(__sata_phy_reset);
 EXPORT_SYMBOL_GPL(ata_bus_reset);
 EXPORT_SYMBOL_GPL(ata_std_prereset);
 EXPORT_SYMBOL_GPL(ata_std_softreset);
-EXPORT_SYMBOL_GPL(sata_port_hardreset);
+EXPORT_SYMBOL_GPL(sata_link_hardreset);
 EXPORT_SYMBOL_GPL(sata_std_hardreset);
 EXPORT_SYMBOL_GPL(ata_std_postreset);
 EXPORT_SYMBOL_GPL(sata_std_hp_poll_activate);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 7c089d3..80f2fa0 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1470,16 +1470,16 @@ static void ata_eh_report(struct ata_por
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
 
@@ -1487,12 +1487,12 @@ static int ata_do_reset(struct ata_port 
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
@@ -1513,11 +1513,10 @@ static int ata_eh_followup_srst_needed(i
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
@@ -1542,13 +1541,14 @@ static int ata_eh_reset(struct ata_port 
 		ehc->i.action |= ATA_EH_HARDRESET;
 
 	if (prereset) {
-		rc = prereset(ap);
+		rc = prereset(link);
 		if (rc) {
 			if (rc == -ENOENT) {
-				ata_port_printk(ap, KERN_DEBUG, "port disabled. ignoring.\n");
+				ata_link_printk(link, KERN_DEBUG,
+						"link disabled. ignoring.\n");
 				ehc->i.action &= ~ATA_EH_RESET_MASK;
 			} else
-				ata_port_printk(ap, KERN_ERR,
+				ata_link_printk(link, KERN_ERR,
 					"prereset failed (errno=%d)\n", rc);
 			return rc;
 		}
@@ -1568,7 +1568,7 @@ static int ata_eh_reset(struct ata_port 
 
 	/* did prereset() screw up?  if so, fix up to avoid oopsing */
 	if (!reset) {
-		ata_port_printk(ap, KERN_ERR, "BUG: prereset() requested "
+		ata_link_printk(link, KERN_ERR, "BUG: prereset() requested "
 				"invalid reset type\n");
 		if (softreset)
 			reset = softreset;
@@ -1579,13 +1579,13 @@ static int ata_eh_reset(struct ata_port 
  retry:
 	/* shut up during boot probing */
 	if (verbose)
-		ata_port_printk(ap, KERN_INFO, "%s resetting port\n",
+		ata_link_printk(link, KERN_INFO, "%s resetting port\n",
 				reset == softreset ? "soft" : "hard");
 
 	/* mark that this EH session started with reset */
 	ehc->i.flags |= ATA_EHI_DID_RESET;
 
-	rc = ata_do_reset(ap, reset, classes);
+	rc = ata_do_reset(link, reset, classes);
 
 	did_followup_srst = 0;
 	if (reset == hardreset &&
@@ -1595,18 +1595,18 @@ static int ata_eh_reset(struct ata_port 
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
@@ -1623,7 +1623,7 @@ static int ata_eh_reset(struct ata_port 
 		} else
 			type = "hard";
 
-		ata_port_printk(ap, KERN_WARNING,
+		ata_link_printk(link, KERN_WARNING,
 				"%sreset failed, retrying in 5 secs\n", type);
 		ssleep(5);
 
@@ -1642,7 +1642,7 @@ static int ata_eh_reset(struct ata_port 
 			dev->pio_mode = XFER_PIO_0;
 
 		if (postreset)
-			postreset(ap, classes);
+			postreset(link, classes);
 
 		/* reset successful, schedule revalidation */
 		ata_eh_done(link, NULL, ehc->i.action & ATA_EH_RESET_MASK);
@@ -2029,7 +2029,7 @@ static int ata_eh_recover(struct ata_por
 	if (ehc->i.action & ATA_EH_RESET_MASK) {
 		ata_eh_freeze_port(ap);
 
-		rc = ata_eh_reset(ap, ata_port_nr_vacant(ap), prereset,
+		rc = ata_eh_reset(&ap->link, ata_port_nr_vacant(ap), prereset,
 				  softreset, hardreset, postreset);
 		if (rc) {
 			ata_port_printk(ap, KERN_ERR,
diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index 9860178..6a888c3 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -91,15 +91,15 @@ static int ali_c2_cable_detect(struct at
 
 /**
  *	ali_early_error_handler	-	reset for eary chip
- *	@ap: ATA port
+ *	@link: ATA link
  *
  *	Handle the reset callback for the later chips with cable detect
  */
 
-static int ali_c2_pre_reset(struct ata_port *ap)
+static int ali_c2_pre_reset(struct ata_link *link)
 {
-	ap->cbl = ali_c2_cable_detect(ap);
-	return ata_std_prereset(ap);
+	link->ap->cbl = ali_c2_cable_detect(link->ap);
+	return ata_std_prereset(link);
 }
 
 static void ali_c2_error_handler(struct ata_port *ap)
@@ -124,15 +124,15 @@ static int ali_early_cable_detect(struct
 
 /**
  *	ali_early_probe_init	-	reset for early chip
- *	@ap: ATA port
+ *	@link: ATA link
  *
  *	Handle the reset callback for the early (pre cable detect) chips.
  */
 
-static int ali_early_pre_reset(struct ata_port *ap)
+static int ali_early_pre_reset(struct ata_link *link)
 {
-	ap->cbl = ali_early_cable_detect(ap);
-	return ata_std_prereset(ap);
+	link->ap->cbl = ali_early_cable_detect(link->ap);
+	return ata_std_prereset(link);
 }
 
 static void ali_early_error_handler(struct ata_port *ap)
diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 29234c8..725dd15 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -119,14 +119,14 @@ static void timing_setup(struct ata_port
 }
 
 /**
- *	amd_probe_init		-	cable detection
- *	@ap: ATA port
+ *	amd_pre_reset		-	cable detection
+ *	@link: ATA link
  *
  *	Perform cable detection. The BIOS stores this in PCI config
  *	space for us.
  */
 
-static int amd_pre_reset(struct ata_port *ap)
+static int amd_pre_reset(struct ata_link *link)
 {
 	static const u32 bitmask[2] = {0x03, 0xC0};
 	static const struct pci_bits amd_enable_bits[] = {
@@ -134,6 +134,7 @@ static int amd_pre_reset(struct ata_port
 		{ 0x40, 1, 0x01, 0x01 }
 	};
 
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u8 ata66;
 
@@ -145,7 +146,7 @@ static int amd_pre_reset(struct ata_port
 		ap->cbl = ATA_CBL_PATA80;
 	else
 		ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(link);
 
 }
 
@@ -156,20 +157,22 @@ static void amd_error_handler(struct ata
 				      ata_std_postreset);
 }
 
-static int amd_early_pre_reset(struct ata_port *ap)
+static int amd_early_pre_reset(struct ata_link *link)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	static struct pci_bits amd_enable_bits[] = {
 		{ 0x40, 1, 0x02, 0x02 },
 		{ 0x40, 1, 0x01, 0x01 }
 	};
 
+	struct ata_port *ap = link->ap;
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+
 	if (!pci_test_config_bits(pdev, &amd_enable_bits[ap->port_no]))
 		return -ENOENT;
 
 	/* No host side cable detection */
 	ap->cbl = ATA_CBL_PATA80;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(link);
 
 }
 
@@ -240,19 +243,20 @@ static void amd133_set_dmamode(struct at
 
 /**
  *	nv_probe_init	-	cable detection
- *	@ap: ATA port
+ *	@link: ATA link
  *
  *	Perform cable detection. The BIOS stores this in PCI config
  *	space for us.
  */
 
-static int nv_pre_reset(struct ata_port *ap) {
+static int nv_pre_reset(struct ata_link *link) {
 	static const u8 bitmask[2] = {0x03, 0xC0};
 	static const struct pci_bits nv_enable_bits[] = {
 		{ 0x50, 1, 0x02, 0x02 },
 		{ 0x50, 1, 0x01, 0x01 }
 	};
 
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u8 ata66;
 	u16 udma;
@@ -272,7 +276,7 @@ static int nv_pre_reset(struct ata_port 
 	pci_read_config_word(pdev, 0x62 - 2 * ap->port_no, &udma);
 	if ((udma & 0xC4) == 0xC4 || (udma & 0xC400) == 0xC400)
 		ap->cbl = ATA_CBL_PATA80;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(link);
 }
 
 static void nv_error_handler(struct ata_port *ap)
diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index 690828e..fe06611 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -39,8 +39,9 @@ #define DRV_VERSION	"0.4.2"
 
 static int clock = 0;
 
-static int artop6210_pre_reset(struct ata_port *ap)
+static int artop6210_pre_reset(struct ata_link *link)
 {
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	const struct pci_bits artop_enable_bits[] = {
 		{ 0x4AU, 1U, 0x02UL, 0x02UL },	/* port 0 */
@@ -51,7 +52,7 @@ static int artop6210_pre_reset(struct at
 		return -ENOENT;
 
 	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(link);
 }
 
 /**
@@ -71,19 +72,20 @@ static void artop6210_error_handler(stru
 
 /**
  *	artop6260_pre_reset	-	check for 40/80 pin
- *	@ap: Port
+ *	@link: link
  *
  *	The ARTOP hardware reports the cable detect bits in register 0x49.
  *	Nothing complicated needed here.
  */
 
-static int artop6260_pre_reset(struct ata_port *ap)
+static int artop6260_pre_reset(struct ata_link *link)
 {
 	static const struct pci_bits artop_enable_bits[] = {
 		{ 0x4AU, 1U, 0x02UL, 0x02UL },	/* port 0 */
 		{ 0x4AU, 1U, 0x04UL, 0x04UL },	/* port 1 */
 	};
 
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u8 tmp;
 
@@ -96,7 +98,7 @@ static int artop6260_pre_reset(struct at
 		ap->cbl = ATA_CBL_PATA40;
 	else
 		ap->cbl = ATA_CBL_PATA80;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(link);
 }
 
 /**
diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index 1ce28d2..dbe5dbd 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -33,8 +33,9 @@ enum {
 	ATIIXP_IDE_UDMA_MODE 	= 0x56
 };
 
-static int atiixp_pre_reset(struct ata_port *ap)
+static int atiixp_pre_reset(struct ata_link *link)
 {
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	static struct pci_bits atiixp_enable_bits[] = {
 		{ 0x48, 1, 0x01, 0x00 },
@@ -45,7 +46,7 @@ static int atiixp_pre_reset(struct ata_p
 		return -ENOENT;
 
 	ap->cbl = ATA_CBL_PATA80;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(link);
 }
 
 static void atiixp_error_handler(struct ata_port *ap)
diff --git a/drivers/ata/pata_cmd64x.c b/drivers/ata/pata_cmd64x.c
index b9bbd1d..ec5a2b3 100644
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -75,14 +75,15 @@ enum {
 	DTPR1		= 0x7C
 };
 
-static int cmd64x_pre_reset(struct ata_port *ap)
+static int cmd64x_pre_reset(struct ata_link *link)
 {
-	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	link->ap->cbl = ATA_CBL_PATA40;
+	return ata_std_prereset(link);
 }
 
-static int cmd648_pre_reset(struct ata_port *ap)
+static int cmd648_pre_reset(struct ata_link *link)
 {
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u8 r;
 
@@ -93,7 +94,7 @@ static int cmd648_pre_reset(struct ata_p
 	else
 		ap->cbl = ATA_CBL_PATA40;
 
-	return ata_std_prereset(ap);
+	return ata_std_prereset(link);
 }
 
 static void cmd64x_error_handler(struct ata_port *ap)
diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index 2cd3c0f..b1020c0 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -140,10 +140,10 @@ static void cs5520_set_piomode(struct at
 }
 
 
-static int cs5520_pre_reset(struct ata_port *ap)
+static int cs5520_pre_reset(struct ata_link *link)
 {
-	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	link->ap->cbl = ATA_CBL_PATA40;
+	return ata_std_prereset(link);
 }
 
 static void cs5520_error_handler(struct ata_port *ap)
diff --git a/drivers/ata/pata_cs5530.c b/drivers/ata/pata_cs5530.c
index a07cc81..f88e20a 100644
--- a/drivers/ata/pata_cs5530.c
+++ b/drivers/ata/pata_cs5530.c
@@ -153,10 +153,10 @@ static unsigned int cs5530_qc_issue_prot
 	return ata_qc_issue_prot(qc);
 }
 
-static int cs5530_pre_reset(struct ata_port *ap)
+static int cs5530_pre_reset(struct ata_link *link)
 {
-	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	link->ap->cbl = ATA_CBL_PATA40;
+	return ata_std_prereset(link);
 }
 
 static void cs5530_error_handler(struct ata_port *ap)
diff --git a/drivers/ata/pata_cs5535.c b/drivers/ata/pata_cs5535.c
index f8def3f..f35b98a 100644
--- a/drivers/ata/pata_cs5535.c
+++ b/drivers/ata/pata_cs5535.c
@@ -77,9 +77,10 @@ #define CS5535_BAD_PIO(timings) ( (timin
  *	cable type.
  */
 
-static int cs5535_pre_reset(struct ata_port *ap)
+static int cs5535_pre_reset(struct ata_link *link)
 {
 	u8 cable;
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
 	pci_read_config_byte(pdev, CS5535_CABLE_DETECT, &cable);
@@ -87,7 +88,7 @@ static int cs5535_pre_reset(struct ata_p
 		ap->cbl = ATA_CBL_PATA80;
 	else
 		ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(link);
 }
 
 /**
diff --git a/drivers/ata/pata_cypress.c b/drivers/ata/pata_cypress.c
index 247b436..d9d4a4f 100644
--- a/drivers/ata/pata_cypress.c
+++ b/drivers/ata/pata_cypress.c
@@ -41,10 +41,10 @@ enum {
 	CY82_INDEX_TIMEOUT	= 0x32
 };
 
-static int cy82c693_pre_reset(struct ata_port *ap)
+static int cy82c693_pre_reset(struct ata_link *link)
 {
-	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	link->ap->cbl = ATA_CBL_PATA40;
+	return ata_std_prereset(link);
 }
 
 static void cy82c693_error_handler(struct ata_port *ap)
diff --git a/drivers/ata/pata_efar.c b/drivers/ata/pata_efar.c
index ef18c60..7223c88 100644
--- a/drivers/ata/pata_efar.c
+++ b/drivers/ata/pata_efar.c
@@ -26,19 +26,20 @@ #define DRV_VERSION	"0.4.2"
 
 /**
  *	efar_pre_reset	-	check for 40/80 pin
- *	@ap: Port
+ *	@link: ATA link
  *
  *	Perform cable detection for the EFAR ATA interface. This is
  *	different to the PIIX arrangement
  */
 
-static int efar_pre_reset(struct ata_port *ap)
+static int efar_pre_reset(struct ata_link *link)
 {
 	static const struct pci_bits efar_enable_bits[] = {
 		{ 0x41U, 1U, 0x80UL, 0x80UL },	/* port 0 */
 		{ 0x43U, 1U, 0x80UL, 0x80UL },	/* port 1 */
 	};
 
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u8 tmp;
 
@@ -50,7 +51,7 @@ static int efar_pre_reset(struct ata_por
 		ap->cbl = ATA_CBL_PATA40;
 	else
 		ap->cbl = ATA_CBL_PATA80;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(link);
 }
 
 /**
diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index 6d3e4c0..044745f 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -220,9 +220,10 @@ static u32 hpt36x_find_mode(struct ata_p
 	return 0xffffffffU;	/* silence compiler warning */
 }
 
-static int hpt36x_pre_reset(struct ata_port *ap)
+static int hpt36x_pre_reset(struct ata_link *link)
 {
 	u8 ata66;
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
 	pci_read_config_byte(pdev, 0x5A, &ata66);
@@ -230,7 +231,7 @@ static int hpt36x_pre_reset(struct ata_p
 		ap->cbl = ATA_CBL_PATA40;
 	else
 		ap->cbl = ATA_CBL_PATA80;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(link);
 }
 
 /**
diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
index 7350443..88fd6ec 100644
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -444,14 +444,15 @@ static unsigned long hpt370a_filter(cons
 
 /**
  *	hpt37x_pre_reset	-	reset the hpt37x bus
- *	@ap: ATA port to reset
+ *	@link: ATA link to reset
  *
  *	Perform the initial reset handling for the 370/372 and 374 func 0
  */
 
-static int hpt37x_pre_reset(struct ata_port *ap)
+static int hpt37x_pre_reset(struct ata_link *link)
 {
 	u8 scr2, ata66;
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
 	pci_read_config_byte(pdev, 0x5B, &scr2);
@@ -471,7 +472,7 @@ static int hpt37x_pre_reset(struct ata_p
 	pci_write_config_byte(pdev, 0x54, 0x37);
 	udelay(100);
 
-	return ata_std_prereset(ap);
+	return ata_std_prereset(link);
 }
 
 /**
@@ -486,11 +487,12 @@ static void hpt37x_error_handler(struct 
 	ata_bmdma_drive_eh(ap, hpt37x_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
 }
 
-static int hpt374_pre_reset(struct ata_port *ap)
+static int hpt374_pre_reset(struct ata_link *link)
 {
 	u16 mcr3, mcr6;
 	u8 ata66;
 
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	/* Do the extra channel work */
 	pci_read_config_word(pdev, 0x52, &mcr3);
@@ -515,7 +517,7 @@ static int hpt374_pre_reset(struct ata_p
 	pci_write_config_byte(pdev, 0x54, 0x37);
 	udelay(100);
 
-	return ata_std_prereset(ap);
+	return ata_std_prereset(link);
 }
 
 /**
diff --git a/drivers/ata/pata_hpt3x2n.c b/drivers/ata/pata_hpt3x2n.c
index 58cfb2b..389d6b1 100644
--- a/drivers/ata/pata_hpt3x2n.c
+++ b/drivers/ata/pata_hpt3x2n.c
@@ -116,15 +116,16 @@ static u32 hpt3x2n_find_mode(struct ata_
 
 /**
  *	hpt3x2n_pre_reset	-	reset the hpt3x2n bus
- *	@ap: ATA port to reset
+ *	@link: ATA link to reset
  *
  *	Perform the initial reset handling for the 3x2n series controllers.
  *	Reset the hardware and state machine, obtain the cable type.
  */
 
-static int hpt3xn_pre_reset(struct ata_port *ap)
+static int hpt3xn_pre_reset(struct ata_link *link)
 {
 	u8 scr2, ata66;
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
 	pci_read_config_byte(pdev, 0x5B, &scr2);
@@ -144,7 +145,7 @@ static int hpt3xn_pre_reset(struct ata_p
 	pci_write_config_byte(pdev, 0x54, 0x37);
 	udelay(100);
 
-	return ata_std_prereset(ap);
+	return ata_std_prereset(link);
 }
 
 /**
diff --git a/drivers/ata/pata_hpt3x3.c b/drivers/ata/pata_hpt3x3.c
index 3334d72..8dd6773 100644
--- a/drivers/ata/pata_hpt3x3.c
+++ b/drivers/ata/pata_hpt3x3.c
@@ -25,10 +25,10 @@ #include <linux/libata.h>
 #define DRV_NAME	"pata_hpt3x3"
 #define DRV_VERSION	"0.4.1"
 
-static int hpt3x3_probe_init(struct ata_port *ap)
+static int hpt3x3_probe_init(struct ata_link *link)
 {
-	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	link->ap->cbl = ATA_CBL_PATA40;
+	return ata_std_prereset(link);
 }
 
 /**
diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index 98fcd8a..9964c04 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -114,15 +114,15 @@ static int it8212_noraid;
 
 /**
  *	it821x_pre_reset	-	probe
- *	@ap: ATA port
+ *	@link: ATA link
  *
  *	Set the cable type
  */
 
-static int it821x_pre_reset(struct ata_port *ap)
+static int it821x_pre_reset(struct ata_link *link)
 {
-	ap->cbl = ATA_CBL_PATA80;
-	return ata_std_prereset(ap);
+	link->ap->cbl = ATA_CBL_PATA80;
+	return ata_std_prereset(link);
 }
 
 /**
diff --git a/drivers/ata/pata_jmicron.c b/drivers/ata/pata_jmicron.c
index 52a2bdf..b26a732 100644
--- a/drivers/ata/pata_jmicron.c
+++ b/drivers/ata/pata_jmicron.c
@@ -29,18 +29,19 @@ typedef enum {
 
 /**
  *	jmicron_pre_reset	-	check for 40/80 pin
- *	@ap: Port
+ *	@link: ATA link
  *
  *	Perform the PATA port setup we need.
-
+ *
  *	On the Jmicron 361/363 there is a single PATA port that can be mapped
  *	either as primary or secondary (or neither). We don't do any policy
  *	and setup here. We assume that has been done by init_one and the
  *	BIOS.
  */
 
-static int jmicron_pre_reset(struct ata_port *ap)
+static int jmicron_pre_reset(struct ata_link *link)
 {
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u32 control;
 	u32 control5;
@@ -102,7 +103,7 @@ static int jmicron_pre_reset(struct ata_
 		ap->cbl = ATA_CBL_SATA;
 		break;
 	}
-	return ata_std_prereset(ap);
+	return ata_std_prereset(link);
 }
 
 /**
diff --git a/drivers/ata/pata_mpiix.c b/drivers/ata/pata_mpiix.c
index 9dfe3e9..417b999 100644
--- a/drivers/ata/pata_mpiix.c
+++ b/drivers/ata/pata_mpiix.c
@@ -46,8 +46,9 @@ enum {
 	SECONDARY = (1 << 14)
 };
 
-static int mpiix_pre_reset(struct ata_port *ap)
+static int mpiix_pre_reset(struct ata_link *link)
 {
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	static const struct pci_bits mpiix_enable_bits[] = {
 		{ 0x6D, 1, 0x80, 0x80 },
@@ -57,7 +58,7 @@ static int mpiix_pre_reset(struct ata_po
 	if (!pci_test_config_bits(pdev, &mpiix_enable_bits[ap->port_no]))
 		return -ENOENT;
 	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(link);
 }
 
 /**
diff --git a/drivers/ata/pata_netcell.c b/drivers/ata/pata_netcell.c
index f5672de..8f02493 100644
--- a/drivers/ata/pata_netcell.c
+++ b/drivers/ata/pata_netcell.c
@@ -20,15 +20,15 @@ #define DRV_VERSION	"0.1.5"
 
 /**
  *	netcell_probe_init	-	check for 40/80 pin
- *	@ap: Port
+ *	@link: ATA link
  *
  *	Cables are handled by the RAID controller. Report 80 pin.
  */
 
-static int netcell_pre_reset(struct ata_port *ap)
+static int netcell_pre_reset(struct ata_link *link)
 {
-	ap->cbl = ATA_CBL_PATA80;
-	return ata_std_prereset(ap);
+	link->ap->cbl = ATA_CBL_PATA80;
+	return ata_std_prereset(link);
 }
 
 /**
diff --git a/drivers/ata/pata_ns87410.c b/drivers/ata/pata_ns87410.c
index 2a3dbee..d534c1a 100644
--- a/drivers/ata/pata_ns87410.c
+++ b/drivers/ata/pata_ns87410.c
@@ -32,13 +32,14 @@ #define DRV_VERSION "0.4.2"
 
 /**
  *	ns87410_pre_reset		-	probe begin
- *	@ap: ATA port
+ *	@link: ATA link
  *
  *	Set up cable type and use generic probe init
  */
 
-static int ns87410_pre_reset(struct ata_port *ap)
+static int ns87410_pre_reset(struct ata_link *link)
 {
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	static const struct pci_bits ns87410_enable_bits[] = {
 		{ 0x43, 1, 0x08, 0x08 },
@@ -48,7 +49,7 @@ static int ns87410_pre_reset(struct ata_
 	if (!pci_test_config_bits(pdev, &ns87410_enable_bits[ap->port_no]))
 		return -ENOENT;
 	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(link);
 }
 
 /**
diff --git a/drivers/ata/pata_oldpiix.c b/drivers/ata/pata_oldpiix.c
index fc947df..21d34cb 100644
--- a/drivers/ata/pata_oldpiix.c
+++ b/drivers/ata/pata_oldpiix.c
@@ -29,13 +29,14 @@ #define DRV_VERSION	"0.5.2"
 
 /**
  *	oldpiix_pre_reset		-	probe begin
- *	@ap: ATA port
+ *	@link: ATA link
  *
  *	Set up cable type and use generic probe init
  */
 
-static int oldpiix_pre_reset(struct ata_port *ap)
+static int oldpiix_pre_reset(struct ata_link *link)
 {
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	static const struct pci_bits oldpiix_enable_bits[] = {
 		{ 0x41U, 1U, 0x80UL, 0x80UL },	/* port 0 */
@@ -45,7 +46,7 @@ static int oldpiix_pre_reset(struct ata_
 	if (!pci_test_config_bits(pdev, &oldpiix_enable_bits[ap->port_no]))
 		return -ENOENT;
 	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(link);
 }
 
 /**
diff --git a/drivers/ata/pata_opti.c b/drivers/ata/pata_opti.c
index a7320ba..8d9a5dc 100644
--- a/drivers/ata/pata_opti.c
+++ b/drivers/ata/pata_opti.c
@@ -46,13 +46,14 @@ enum {
 
 /**
  *	opti_pre_reset		-	probe begin
- *	@ap: ATA port
+ *	@link: ATA link
  *
  *	Set up cable type and use generic probe init
  */
 
-static int opti_pre_reset(struct ata_port *ap)
+static int opti_pre_reset(struct ata_link *link)
 {
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	static const struct pci_bits opti_enable_bits[] = {
 		{ 0x45, 1, 0x80, 0x00 },
@@ -63,7 +64,7 @@ static int opti_pre_reset(struct ata_por
 		return -ENOENT;
 
 	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(link);
 }
 
 /**
diff --git a/drivers/ata/pata_optidma.c b/drivers/ata/pata_optidma.c
index c58c135..1c9a643 100644
--- a/drivers/ata/pata_optidma.c
+++ b/drivers/ata/pata_optidma.c
@@ -47,13 +47,14 @@ static int pci_clock;	/* 0 = 33 1 = 25 *
 
 /**
  *	optidma_pre_reset		-	probe begin
- *	@ap: ATA port
+ *	@link: ATA link
  *
  *	Set up cable type and use generic probe init
  */
 
-static int optidma_pre_reset(struct ata_port *ap)
+static int optidma_pre_reset(struct ata_link *link)
 {
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	static const struct pci_bits optidma_enable_bits = {
 		0x40, 1, 0x08, 0x00
@@ -63,7 +64,7 @@ static int optidma_pre_reset(struct ata_
 		return -ENOENT;
 
 	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(link);
 }
 
 /**
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index 6d60dbe..cecd573 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -301,7 +301,7 @@ static inline int pdc2027x_port_enabled(
 
 /**
  *	pdc2027x_prereset - prereset for PATA host controller
- *	@ap: Target port
+ *	@link: Target link
  *
  *	Probeinit including cable detection.
  *
@@ -309,13 +309,13 @@ static inline int pdc2027x_port_enabled(
  *	None (inherited from caller).
  */
 
-static int pdc2027x_prereset(struct ata_port *ap)
+static int pdc2027x_prereset(struct ata_link *link)
 {
 	/* Check whether port enabled */
-	if (!pdc2027x_port_enabled(ap))
+	if (!pdc2027x_port_enabled(link->ap))
 		return -ENOENT;
-	pdc2027x_cbl_detect(ap);
-	return ata_std_prereset(ap);
+	pdc2027x_cbl_detect(link->ap);
+	return ata_std_prereset(link);
 }
 
 /**
diff --git a/drivers/ata/pata_pdc202xx_old.c b/drivers/ata/pata_pdc202xx_old.c
index 5ba9eb2..6eed7d4 100644
--- a/drivers/ata/pata_pdc202xx_old.c
+++ b/drivers/ata/pata_pdc202xx_old.c
@@ -25,15 +25,15 @@ #define DRV_VERSION "0.2.1"
 
 /**
  *	pdc2024x_pre_reset		-	probe begin
- *	@ap: ATA port
+ *	@link: ATA link
  *
  *	Set up cable type and use generic probe init
  */
 
-static int pdc2024x_pre_reset(struct ata_port *ap)
+static int pdc2024x_pre_reset(struct ata_link *link)
 {
-	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	link->ap->cbl = ATA_CBL_PATA40;
+	return ata_std_prereset(link);
 }
 
 
@@ -43,8 +43,9 @@ static void pdc2024x_error_handler(struc
 }
 
 
-static int pdc2026x_pre_reset(struct ata_port *ap)
+static int pdc2026x_pre_reset(struct ata_link *link)
 {
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u16 cis;
 
@@ -54,7 +55,7 @@ static int pdc2026x_pre_reset(struct ata
 	else
 		ap->cbl = ATA_CBL_PATA40;
 
-	return ata_std_prereset(ap);
+	return ata_std_prereset(link);
 }
 
 static void pdc2026x_error_handler(struct ata_port *ap)
diff --git a/drivers/ata/pata_radisys.c b/drivers/ata/pata_radisys.c
index 1af83d7..c8c2774 100644
--- a/drivers/ata/pata_radisys.c
+++ b/drivers/ata/pata_radisys.c
@@ -28,15 +28,15 @@ #define DRV_VERSION	"0.4.1"
 
 /**
  *	radisys_probe_init		-	probe begin
- *	@ap: ATA port
+ *	@link: ATA link
  *
  *	Set up cable type and use generic probe init
  */
 
-static int radisys_pre_reset(struct ata_port *ap)
+static int radisys_pre_reset(struct ata_link *link)
 {
-	ap->cbl = ATA_CBL_PATA80;
-	return ata_std_prereset(ap);
+	link->ap->cbl = ATA_CBL_PATA80;
+	return ata_std_prereset(link);
 }
 
 
diff --git a/drivers/ata/pata_rz1000.c b/drivers/ata/pata_rz1000.c
index c231631..1b9f035 100644
--- a/drivers/ata/pata_rz1000.c
+++ b/drivers/ata/pata_rz1000.c
@@ -26,15 +26,15 @@ #define DRV_VERSION	"0.2.2"
 
 /**
  *	rz1000_prereset		-	probe begin
- *	@ap: ATA port
+ *	@link: ATA link
  *
  *	Set up cable type and use generics
  */
 
-static int rz1000_prereset(struct ata_port *ap)
+static int rz1000_prereset(struct ata_link *link)
 {
-	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	link->ap->cbl = ATA_CBL_PATA40;
+	return ata_std_prereset(link);
 }
 
 /**
diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
index 5bbf76e..84b05ef 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -138,13 +138,15 @@ static struct sv_cable_table cable_detec
 
 /**
  *	serverworks_pre_reset		-	cable detection
- *	@ap: ATA port
+ *	@link: ATA link
  *
  *	Perform cable detection according to the device and subvendor
  *	identifications
  */
 
-static int serverworks_pre_reset(struct ata_port *ap) {
+static int serverworks_pre_reset(struct ata_link *link)
+{
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	struct sv_cable_table *cb = cable_detect;
 
@@ -153,7 +155,7 @@ static int serverworks_pre_reset(struct 
 		    (cb->subvendor == pdev->subsystem_vendor ||
 		      cb->subvendor == PCI_ANY_ID)) {
 			ap->cbl = cb->cable_detect(ap);
-			return ata_std_prereset(ap);
+			return ata_std_prereset(link);
 		}
 		cb++;
 	}
diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index 4a2b72b..a96c042 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -91,21 +91,22 @@ static int sil680_cable_detect(struct at
 		return ATA_CBL_PATA40;
 }
 
-static int sil680_pre_reset(struct ata_port *ap)
+static int sil680_pre_reset(struct ata_link *link)
 {
-	ap->cbl = sil680_cable_detect(ap);
-	return ata_std_prereset(ap);
+	link->ap->cbl = sil680_cable_detect(link->ap);
+	return ata_std_prereset(link);
 }
 
 /**
  *	sil680_bus_reset	-	reset the SIL680 bus
- *	@ap: ATA port to reset
+ *	@link: ATA link to reset
  *
  *	Perform the SIL680 housekeeping when doing an ATA bus reset
  */
 
-static int sil680_bus_reset(struct ata_port *ap,unsigned int *classes)
+static int sil680_bus_reset(struct ata_link *link, unsigned int *classes)
 {
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	unsigned long addr = sil680_selreg(ap, 0);
 	u8 reset;
@@ -114,7 +115,7 @@ static int sil680_bus_reset(struct ata_p
 	pci_write_config_byte(pdev, addr, reset | 0x03);
 	udelay(25);
 	pci_write_config_byte(pdev, addr, reset);
-	return ata_std_softreset(ap, classes);
+	return ata_std_softreset(link, classes);
 }
 
 static void sil680_error_handler(struct ata_port *ap)
diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index 886e449..ce620c5 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -58,19 +58,20 @@ static int sis_port_base(struct ata_devi
 
 /**
  *	sis_133_pre_reset	-	check for 40/80 pin
- *	@ap: Port
+ *	@link: ATA link
  *
  *	Perform cable detection for the later UDMA133 capable
  *	SiS chipset.
  */
 
-static int sis_133_pre_reset(struct ata_port *ap)
+static int sis_133_pre_reset(struct ata_link *link)
 {
 	static const struct pci_bits sis_enable_bits[] = {
 		{ 0x4aU, 1U, 0x02UL, 0x02UL },	/* port 0 */
 		{ 0x4aU, 1U, 0x04UL, 0x04UL },	/* port 1 */
 	};
 
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u16 tmp;
 
@@ -84,7 +85,7 @@ static int sis_133_pre_reset(struct ata_
 	else
 		ap->cbl = ATA_CBL_PATA80;
 
-	return ata_std_prereset(ap);
+	return ata_std_prereset(link);
 }
 
 /**
@@ -103,19 +104,20 @@ static void sis_133_error_handler(struct
 
 /**
  *	sis_66_pre_reset	-	check for 40/80 pin
- *	@ap: Port
+ *	@link: ATA link
  *
  *	Perform cable detection on the UDMA66, UDMA100 and early UDMA133
  *	SiS IDE controllers.
  */
 
-static int sis_66_pre_reset(struct ata_port *ap)
+static int sis_66_pre_reset(struct ata_link *link)
 {
 	static const struct pci_bits sis_enable_bits[] = {
 		{ 0x4aU, 1U, 0x02UL, 0x02UL },	/* port 0 */
 		{ 0x4aU, 1U, 0x04UL, 0x04UL },	/* port 1 */
 	};
 
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u8 tmp;
 
@@ -132,7 +134,7 @@ static int sis_66_pre_reset(struct ata_p
 	else
 		ap->cbl = ATA_CBL_PATA80;
 
-	return ata_std_prereset(ap);
+	return ata_std_prereset(link);
 }
 
 /**
@@ -151,18 +153,19 @@ static void sis_66_error_handler(struct 
 
 /**
  *	sis_old_pre_reset		-	probe begin
- *	@ap: ATA port
+ *	@link: ATA link
  *
  *	Set up cable type and use generic probe init
  */
 
-static int sis_old_pre_reset(struct ata_port *ap)
+static int sis_old_pre_reset(struct ata_link *link)
 {
 	static const struct pci_bits sis_enable_bits[] = {
 		{ 0x4aU, 1U, 0x02UL, 0x02UL },	/* port 0 */
 		{ 0x4aU, 1U, 0x04UL, 0x04UL },	/* port 1 */
 	};
 
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
 	if (!pci_test_config_bits(pdev, &sis_enable_bits[ap->port_no])) {
@@ -171,7 +174,7 @@ static int sis_old_pre_reset(struct ata_
 		return 0;
 	}
 	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(link);
 }
 
 
diff --git a/drivers/ata/pata_sl82c105.c b/drivers/ata/pata_sl82c105.c
index 08a6dc8..30794d1 100644
--- a/drivers/ata/pata_sl82c105.c
+++ b/drivers/ata/pata_sl82c105.c
@@ -41,18 +41,19 @@ enum {
  *	Set up cable type and use generic probe init
  */
 
-static int sl82c105_pre_reset(struct ata_port *ap)
+static int sl82c105_pre_reset(struct ata_link *link)
 {
 	static const struct pci_bits sl82c105_enable_bits[] = {
 		{ 0x40, 1, 0x01, 0x01 },
 		{ 0x40, 1, 0x10, 0x10 }
 	};
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
 	if (ap->port_no && !pci_test_config_bits(pdev, &sl82c105_enable_bits[ap->port_no]))
 		return -ENOENT;
 	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(link);
 }
 
 
diff --git a/drivers/ata/pata_triflex.c b/drivers/ata/pata_triflex.c
index 9640f80..a8d7078 100644
--- a/drivers/ata/pata_triflex.c
+++ b/drivers/ata/pata_triflex.c
@@ -47,24 +47,25 @@ #define DRV_VERSION "0.2.5"
 
 /**
  *	triflex_prereset		-	probe begin
- *	@ap: ATA port
+ *	@link: ATA link
  *
  *	Set up cable type and use generic probe init
  */
 
-static int triflex_prereset(struct ata_port *ap)
+static int triflex_prereset(struct ata_link *link)
 {
 	static const struct pci_bits triflex_enable_bits[] = {
 		{ 0x80, 1, 0x01, 0x01 },
 		{ 0x80, 1, 0x02, 0x02 }
 	};
 
+	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
 	if (!pci_test_config_bits(pdev, &triflex_enable_bits[ap->port_no]))
 		return -ENOENT;
 	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(link);
 }
 
 
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index 1e7be9e..4fd6fee 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -143,8 +143,9 @@ static int via_cable_detect(struct ata_p
 		return ATA_CBL_PATA40;
 }
 
-static int via_pre_reset(struct ata_port *ap)
+static int via_pre_reset(struct ata_link *link)
 {
+	struct ata_port *ap = link->ap;
 	const struct via_isa_bridge *config = ap->host->private_data;
 
 	if (!(config->flags & VIA_NO_ENABLES)) {
@@ -163,7 +164,7 @@ static int via_pre_reset(struct ata_port
 		ap->cbl = via_cable_detect(ap);
 	else
 		ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(link);
 }
 
 
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index f5c22de..34a8b18 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -452,7 +452,7 @@ static void nv_ck804_thaw(struct ata_por
 	writeb(mask, mmio_base + NV_INT_ENABLE_CK804);
 }
 
-static int nv_hardreset(struct ata_port *ap, unsigned int *class)
+static int nv_hardreset(struct ata_link *link, unsigned int *class)
 {
 	unsigned int dummy;
 
@@ -460,7 +460,7 @@ static int nv_hardreset(struct ata_port 
 	 * some controllers.  Don't classify on hardreset.  For more
 	 * info, see http://bugme.osdl.org/show_bug.cgi?id=3352
 	 */
-	return sata_std_hardreset(ap, &dummy);
+	return sata_std_hardreset(link, &dummy);
 }
 
 static void nv_error_handler(struct ata_port *ap)
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 29de9bd..8d6651f 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -540,8 +540,9 @@ static int sil24_init_port(struct ata_po
 	return 0;
 }
 
-static int sil24_softreset(struct ata_port *ap, unsigned int *class)
+static int sil24_softreset(struct ata_link *link, unsigned int *class)
 {
+	struct ata_port *ap = link->ap;
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
 	struct sil24_port_priv *pp = ap->private_data;
 	struct sil24_prb *prb = &pp->cmd_block[0].ata.prb;
@@ -551,7 +552,7 @@ static int sil24_softreset(struct ata_po
 
 	DPRINTK("ENTER\n");
 
-	if (ata_link_offline(&ap->link)) {
+	if (ata_link_offline(link)) {
 		DPRINTK("PHY reports no device\n");
 		*class = ATA_DEV_NONE;
 		goto out;
@@ -596,22 +597,23 @@ static int sil24_softreset(struct ata_po
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
@@ -621,14 +623,14 @@ static int sil24_hardreset(struct ata_po
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
@@ -643,7 +645,7 @@ static int sil24_hardreset(struct ata_po
 	return -EAGAIN;
 
  err:
-	ata_port_printk(ap, KERN_ERR, "hardreset failed (%s)\n", reason);
+	ata_link_printk(link, KERN_ERR, "hardreset failed (%s)\n", reason);
 	return -EIO;
 }
 
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 6978bc8..02d2088 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -205,7 +205,7 @@ static void svia_scr_write (struct ata_p
 
 /**
  *	vt6420_prereset - prereset for vt6420
- *	@ap: target ATA port
+ *	@link: target ATA link
  *
  *	SCR registers on vt6420 are pieces of shit and may hang the
  *	whole machine completely if accessed with the wrong timing.
@@ -222,8 +222,9 @@ static void svia_scr_write (struct ata_p
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-static int vt6420_prereset(struct ata_port *ap)
+static int vt6420_prereset(struct ata_link *link)
 {
+	struct ata_port *ap = link->ap;
 	struct ata_eh_context *ehc = &ap->link.eh_context;
 	unsigned long timeout = jiffies + (HZ * 5);
 	u32 sstatus, scontrol;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 315ab6f..6241891 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -337,13 +337,14 @@ enum ata_completion_errors {
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
@@ -714,12 +715,12 @@ extern int sata_set_spd(struct ata_link 
 extern int sata_link_debounce(struct ata_link *link,
 			      const unsigned long *params);
 extern int sata_link_resume(struct ata_link *link, const unsigned long *params);
-extern int ata_std_prereset(struct ata_port *ap);
-extern int ata_std_softreset(struct ata_port *ap, unsigned int *classes);
-extern int sata_port_hardreset(struct ata_port *ap,
+extern int ata_std_prereset(struct ata_link *link);
+extern int ata_std_softreset(struct ata_link *link, unsigned int *classes);
+extern int sata_link_hardreset(struct ata_link *link,
 			       const unsigned long *timing);
-extern int sata_std_hardreset(struct ata_port *ap, unsigned int *class);
-extern void ata_std_postreset(struct ata_port *ap, unsigned int *classes);
+extern int sata_std_hardreset(struct ata_link *link, unsigned int *class);
+extern void ata_std_postreset(struct ata_link *link, unsigned int *classes);
 extern void sata_std_hp_poll_activate(struct ata_port *ap);
 extern int sata_std_hp_poll(struct ata_port *ap);
 extern int ata_dev_revalidate(struct ata_device *dev, int post_reset);
-- 
1.4.2.3


