From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/4] libata: add deadline support to prereset and reset methods
Date: Fri, 2 Feb 2007 16:50:52 +0900
Message-ID: <11704026523166-git-send-email-htejun@gmail.com>
References: <11704026511717-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.237]:64800 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423207AbXBBHvT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 02:51:19 -0500
Received: by wx-out-0506.google.com with SMTP id h31so819854wxd
        for <linux-ide@vger.kernel.org>; Thu, 01 Feb 2007 23:51:19 -0800 (PST)
In-Reply-To: <11704026511717-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, ric@emc.com, edmudama@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add @deadline to prereset and reset methods and make them honor it.
ata_wait_ready() which directly takes @deadline is implemented to be
used as the wait function.  This patch is in preparation for EH timing
improvements.

* ata_wait_ready() never does busy sleep.  It's only used from EH and
  no wait in EH is that urgent.  This function also prints 'be
  patient' message automatically after 5 secs of waiting if more than
  3 secs is remaining till deadline.

* ata_bus_post_reset() now fails with error code if any of its wait
  fails.  This is important because earlier reset tries will have
  shorter timeout than the spec requires.  If a device fails to
  respond before the short timeout, reset should be retried with
  longer timeout rather than silently ignoring the device.

  There are three behavior differences.

  1. Timeout is applied to both devices at once, not separately.  This
     is more consistent with what the spec says.

  2. When a device passes devchk but fails to become ready before
     deadline.  Previouly, post_reset would just succeed and let
     device classification remove the device.  New code fails the
     reset thus causing reset retry.  After a few times, EH will give
     up disabling the port.

  3. When slave device passes devchk but fails to become accessible
     (TF-wise) after reset.  Original code disables dev1 after 30s
     timeout and continues as if the device doesn't exist, while the
     patched code fails reset.  When this happens, new code fails
     reset on whole port rather than proceeding with only the primary
     device.

  If the failing device is suffering transient problems, new code
  retries reset which is a better behavior.  If the failing device is
  actually broken, the net effect is identical to it, but not to the
  other device sharing the channel.  In the previous code, reset would
  have succeeded after 30s thus detecting the working one.  In the new
  code, reset fails and whole port gets disabled.  IMO, it's a
  pathological case anyway (broken device sharing bus with working
  one) and doesn't really matter.

* ata_bus_softreset() is changed to return error code from
  ata_bus_post_reset().  It used to return 0 unconditionally.

* Spin up waiting is to be removed and not converted to honor
  deadline.

* To be on the safe side, deadline is set to 40s for the time being.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c              |   18 +++--
 drivers/ata/ata_generic.c       |    5 +-
 drivers/ata/ata_piix.c          |   12 ++--
 drivers/ata/libata-core.c       |  161 +++++++++++++++++++++++++++------------
 drivers/ata/libata-eh.c         |   10 +-
 drivers/ata/pata_ali.c          |   10 ++-
 drivers/ata/pata_amd.c          |   16 ++--
 drivers/ata/pata_artop.c        |    9 +-
 drivers/ata/pata_atiixp.c       |    4 +-
 drivers/ata/pata_cmd64x.c       |    8 +-
 drivers/ata/pata_cs5520.c       |    4 +-
 drivers/ata/pata_cs5530.c       |    4 +-
 drivers/ata/pata_cs5535.c       |    5 +-
 drivers/ata/pata_cypress.c      |    4 +-
 drivers/ata/pata_efar.c         |    5 +-
 drivers/ata/pata_hpt366.c       |    4 +-
 drivers/ata/pata_hpt37x.c       |    9 +-
 drivers/ata/pata_hpt3x2n.c      |    5 +-
 drivers/ata/pata_hpt3x3.c       |    4 +-
 drivers/ata/pata_it8213.c       |    5 +-
 drivers/ata/pata_it821x.c       |    5 +-
 drivers/ata/pata_jmicron.c      |    7 +-
 drivers/ata/pata_marvell.c      |    5 +-
 drivers/ata/pata_mpiix.c        |    4 +-
 drivers/ata/pata_netcell.c      |    5 +-
 drivers/ata/pata_ns87410.c      |    5 +-
 drivers/ata/pata_oldpiix.c      |    5 +-
 drivers/ata/pata_opti.c         |    5 +-
 drivers/ata/pata_optidma.c      |    5 +-
 drivers/ata/pata_pdc2027x.c     |    5 +-
 drivers/ata/pata_pdc202xx_old.c |    9 +-
 drivers/ata/pata_radisys.c      |    5 +-
 drivers/ata/pata_rz1000.c       |    5 +-
 drivers/ata/pata_serverworks.c  |    6 +-
 drivers/ata/pata_sil680.c       |   10 ++-
 drivers/ata/pata_sis.c          |   15 ++--
 drivers/ata/pata_sl82c105.c     |    5 +-
 drivers/ata/pata_triflex.c      |    5 +-
 drivers/ata/pata_via.c          |    5 +-
 drivers/ata/sata_inic162x.c     |   14 ++--
 drivers/ata/sata_nv.c           |    5 +-
 drivers/ata/sata_sil24.c        |   10 ++-
 drivers/ata/sata_via.c          |    9 +-
 include/linux/libata.h          |   24 ++++--
 44 files changed, 296 insertions(+), 184 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 1d8d377..8ae554c 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -771,7 +771,8 @@ static int ahci_clo(struct ata_port *ap)
 	return 0;
 }
 
-static int ahci_softreset(struct ata_port *ap, unsigned int *class)
+static int ahci_softreset(struct ata_port *ap, unsigned int *class,
+			  unsigned long deadline)
 {
 	struct ahci_port_priv *pp = ap->private_data;
 	void __iomem *mmio = ap->host->iomap[AHCI_PCI_BAR];
@@ -859,8 +860,8 @@ static int ahci_softreset(struct ata_port *ap, unsigned int *class)
 
 	*class = ATA_DEV_NONE;
 	if (ata_port_online(ap)) {
-		if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
-			rc = -EIO;
+		rc = ata_wait_ready(ap, deadline);
+		if (rc && rc != -ENODEV) {
 			reason = "device not ready";
 			goto fail;
 		}
@@ -877,7 +878,8 @@ static int ahci_softreset(struct ata_port *ap, unsigned int *class)
 	return rc;
 }
 
-static int ahci_hardreset(struct ata_port *ap, unsigned int *class)
+static int ahci_hardreset(struct ata_port *ap, unsigned int *class,
+			  unsigned long deadline)
 {
 	struct ahci_port_priv *pp = ap->private_data;
 	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
@@ -895,7 +897,7 @@ static int ahci_hardreset(struct ata_port *ap, unsigned int *class)
 	tf.command = 0x80;
 	ata_tf_to_fis(&tf, d2h_fis, 0);
 
-	rc = sata_std_hardreset(ap, class);
+	rc = sata_std_hardreset(ap, class, deadline);
 
 	ahci_start_engine(port_mmio);
 
@@ -908,7 +910,8 @@ static int ahci_hardreset(struct ata_port *ap, unsigned int *class)
 	return rc;
 }
 
-static int ahci_vt8251_hardreset(struct ata_port *ap, unsigned int *class)
+static int ahci_vt8251_hardreset(struct ata_port *ap, unsigned int *class,
+				 unsigned long deadline)
 {
 	void __iomem *mmio = ap->host->iomap[AHCI_PCI_BAR];
 	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
@@ -918,7 +921,8 @@ static int ahci_vt8251_hardreset(struct ata_port *ap, unsigned int *class)
 
 	ahci_stop_engine(port_mmio);
 
-	rc = sata_port_hardreset(ap, sata_ehc_deb_timing(&ap->eh_context));
+	rc = sata_port_hardreset(ap, sata_ehc_deb_timing(&ap->eh_context),
+				 deadline);
 
 	/* vt8251 needs SError cleared for the port to operate */
 	ahci_scr_write(ap, SCR_ERROR, ahci_scr_read(ap, SCR_ERROR));
diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index c79887f..30ea591 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -35,14 +35,15 @@
 /**
  *	generic_pre_reset		-	probe begin
  *	@ap: ATA port
+ *	@deadline: deadline jiffies for the operation
  *
  *	Set up cable type and use generic probe init
  */
 
-static int generic_pre_reset(struct ata_port *ap)
+static int generic_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	ap->cbl = ATA_CBL_PATA80;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 37fe6c2..4cde465 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -626,12 +626,12 @@ cbl40:
 /**
  *	piix_pata_prereset - prereset for PATA host controller
  *	@ap: Target port
- *
+ *	@deadline: deadline jiffies for the operation
  *
  *	LOCKING:
  *	None (inherited from caller).
  */
-static int piix_pata_prereset(struct ata_port *ap)
+static int piix_pata_prereset(struct ata_port *ap, unsigned long deadline)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
@@ -639,7 +639,7 @@ static int piix_pata_prereset(struct ata_port *ap)
 		return -ENOENT;
 
 	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 static void piix_pata_error_handler(struct ata_port *ap)
@@ -652,12 +652,12 @@ static void piix_pata_error_handler(struct ata_port *ap)
 /**
  *	ich_pata_prereset - prereset for PATA host controller
  *	@ap: Target port
- *
+ *	@deadline: deadline jiffies for the operation
  *
  *	LOCKING:
  *	None (inherited from caller).
  */
-static int ich_pata_prereset(struct ata_port *ap)
+static int ich_pata_prereset(struct ata_port *ap, unsigned long deadline)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
@@ -669,7 +669,7 @@ static int ich_pata_prereset(struct ata_port *ap)
 
 	ich_pata_cbl_detect(ap);
 
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 static void ich_pata_error_handler(struct ata_port *ap)
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 651ab4b..540698c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2568,23 +2568,68 @@ int ata_busy_sleep(struct ata_port *ap,
 	return 0;
 }
 
-static void ata_bus_post_reset(struct ata_port *ap, unsigned int devmask)
+/**
+ *	ata_wait_ready - sleep until BSY clears, or timeout
+ *	@ap: port containing status register to be polled
+ *	@deadline: deadline jiffies for the operation
+ *
+ *	Sleep until ATA Status register bit BSY clears, or timeout
+ *	occurs.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int ata_wait_ready(struct ata_port *ap, unsigned long deadline)
+{
+	unsigned long start = jiffies;
+	int warned = 0;
+
+	while (1) {
+		u8 status = ata_chk_status(ap);
+		unsigned long now = jiffies;
+
+		if (!(status & ATA_BUSY))
+			return 0;
+		if (status == 0xff)
+			return -ENODEV;
+		if (time_after(now, deadline))
+			return -EBUSY;
+
+		if (!warned && time_after(now, start + 5 * HZ) &&
+		    (deadline - now > 3 * HZ)) {
+			ata_port_printk(ap, KERN_WARNING,
+				"port is slow to respond, please be patient "
+				"(Status 0x%x)\n", status);
+			warned = 1;
+		}
+
+		msleep(50);
+	}
+}
+
+static int ata_bus_post_reset(struct ata_port *ap, unsigned int devmask,
+			      unsigned long deadline)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	unsigned int dev0 = devmask & (1 << 0);
 	unsigned int dev1 = devmask & (1 << 1);
-	unsigned long timeout;
+	int rc;
 
 	/* if device 0 was found in ata_devchk, wait for its
 	 * BSY bit to clear
 	 */
-	if (dev0)
-		ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
+	if (dev0) {
+		rc = ata_wait_ready(ap, deadline);
+		if (rc && rc != -ENODEV)
+			return rc;
+	}
 
 	/* if device 1 was found in ata_devchk, wait for
 	 * register access, then wait for BSY to clear
 	 */
-	timeout = jiffies + ATA_TMOUT_BOOT;
 	while (dev1) {
 		u8 nsect, lbal;
 
@@ -2593,14 +2638,15 @@ static void ata_bus_post_reset(struct ata_port *ap, unsigned int devmask)
 		lbal = ioread8(ioaddr->lbal_addr);
 		if ((nsect == 1) && (lbal == 1))
 			break;
-		if (time_after(jiffies, timeout)) {
-			dev1 = 0;
-			break;
-		}
+		if (time_after(jiffies, deadline))
+			return -EBUSY;
 		msleep(50);	/* give drive a breather */
 	}
-	if (dev1)
-		ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
+	if (dev1) {
+		rc = ata_wait_ready(ap, deadline);
+		if (rc && rc != -ENODEV)
+			return rc;
+	}
 
 	/* is all this really necessary? */
 	ap->ops->dev_select(ap, 0);
@@ -2608,10 +2654,12 @@ static void ata_bus_post_reset(struct ata_port *ap, unsigned int devmask)
 		ap->ops->dev_select(ap, 1);
 	if (dev0)
 		ap->ops->dev_select(ap, 0);
+
+	return 0;
 }
 
-static unsigned int ata_bus_softreset(struct ata_port *ap,
-				      unsigned int devmask)
+static int ata_bus_softreset(struct ata_port *ap, unsigned int devmask,
+			     unsigned long deadline)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
@@ -2643,9 +2691,7 @@ static unsigned int ata_bus_softreset(struct ata_port *ap,
 	if (ata_check_status(ap) == 0xFF)
 		return 0;
 
-	ata_bus_post_reset(ap, devmask);
-
-	return 0;
+	return ata_bus_post_reset(ap, devmask, deadline);
 }
 
 /**
@@ -2696,7 +2742,7 @@ void ata_bus_reset(struct ata_port *ap)
 
 	/* issue bus reset */
 	if (ap->flags & ATA_FLAG_SRST)
-		if (ata_bus_softreset(ap, devmask))
+		if (ata_bus_softreset(ap, devmask, jiffies + 40 * HZ))
 			goto err_out;
 
 	/*
@@ -2740,29 +2786,37 @@ err_out:
  *	sata_phy_debounce - debounce SATA phy status
  *	@ap: ATA port to debounce SATA phy status for
  *	@params: timing parameters { interval, duratinon, timeout } in msec
+ *	@deadline: deadline jiffies for the operation
  *
  *	Make sure SStatus of @ap reaches stable state, determined by
  *	holding the same value where DET is not 1 for @duration polled
  *	every @interval, before @timeout.  Timeout constraints the
- *	beginning of the stable state.  Because, after hot unplugging,
- *	DET gets stuck at 1 on some controllers, this functions waits
+ *	beginning of the stable state.  Because DET gets stuck at 1 on
+ *	some controllers after hot unplugging, this functions waits
  *	until timeout then returns 0 if DET is stable at 1.
  *
+ *	@timeout is further limited by @deadline.  The sooner of the
+ *	two is used.
+ *
  *	LOCKING:
  *	Kernel thread context (may sleep)
  *
  *	RETURNS:
  *	0 on success, -errno on failure.
  */
-int sata_phy_debounce(struct ata_port *ap, const unsigned long *params)
+int sata_phy_debounce(struct ata_port *ap, const unsigned long *params,
+		      unsigned long deadline)
 {
 	unsigned long interval_msec = params[0];
-	unsigned long duration = params[1] * HZ / 1000;
-	unsigned long timeout = jiffies + params[2] * HZ / 1000;
-	unsigned long last_jiffies;
+	unsigned long duration = msecs_to_jiffies(params[1]);
+	unsigned long last_jiffies, t;
 	u32 last, cur;
 	int rc;
 
+	t = jiffies + msecs_to_jiffies(params[2]);
+	if (time_before(t, deadline))
+		deadline = t;
+
 	if ((rc = sata_scr_read(ap, SCR_STATUS, &cur)))
 		return rc;
 	cur &= 0xf;
@@ -2778,7 +2832,7 @@ int sata_phy_debounce(struct ata_port *ap, const unsigned long *params)
 
 		/* DET stable? */
 		if (cur == last) {
-			if (cur == 1 && time_before(jiffies, timeout))
+			if (cur == 1 && time_before(jiffies, deadline))
 				continue;
 			if (time_after(jiffies, last_jiffies + duration))
 				return 0;
@@ -2789,8 +2843,8 @@ int sata_phy_debounce(struct ata_port *ap, const unsigned long *params)
 		last = cur;
 		last_jiffies = jiffies;
 
-		/* check timeout */
-		if (time_after(jiffies, timeout))
+		/* check deadline */
+		if (time_after(jiffies, deadline))
 			return -EBUSY;
 	}
 }
@@ -2799,6 +2853,7 @@ int sata_phy_debounce(struct ata_port *ap, const unsigned long *params)
  *	sata_phy_resume - resume SATA phy
  *	@ap: ATA port to resume SATA phy for
  *	@params: timing parameters { interval, duratinon, timeout } in msec
+ *	@deadline: deadline jiffies for the operation
  *
  *	Resume SATA phy of @ap and debounce it.
  *
@@ -2808,7 +2863,8 @@ int sata_phy_debounce(struct ata_port *ap, const unsigned long *params)
  *	RETURNS:
  *	0 on success, -errno on failure.
  */
-int sata_phy_resume(struct ata_port *ap, const unsigned long *params)
+int sata_phy_resume(struct ata_port *ap, const unsigned long *params,
+		    unsigned long deadline)
 {
 	u32 scontrol;
 	int rc;
@@ -2826,10 +2882,10 @@ int sata_phy_resume(struct ata_port *ap, const unsigned long *params)
 	 */
 	msleep(200);
 
-	return sata_phy_debounce(ap, params);
+	return sata_phy_debounce(ap, params, deadline);
 }
 
-static void ata_wait_spinup(struct ata_port *ap)
+static void ata_wait_spinup(struct ata_port *ap, unsigned long deadline)
 {
 	struct ata_eh_context *ehc = &ap->eh_context;
 	unsigned long end, secs;
@@ -2837,7 +2893,7 @@ static void ata_wait_spinup(struct ata_port *ap)
 
 	/* first, debounce phy if SATA */
 	if (ap->cbl == ATA_CBL_SATA) {
-		rc = sata_phy_debounce(ap, sata_deb_timing_hotplug);
+		rc = sata_phy_debounce(ap, sata_deb_timing_hotplug, deadline);
 
 		/* if debounced successfully and offline, no need to wait */
 		if ((rc == 0 || rc == -EOPNOTSUPP) && ata_port_offline(ap))
@@ -2861,6 +2917,7 @@ static void ata_wait_spinup(struct ata_port *ap)
 /**
  *	ata_std_prereset - prepare for reset
  *	@ap: ATA port to be reset
+ *	@deadline: deadline jiffies for the operation
  *
  *	@ap is about to be reset.  Initialize it.
  *
@@ -2870,7 +2927,7 @@ static void ata_wait_spinup(struct ata_port *ap)
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int ata_std_prereset(struct ata_port *ap)
+int ata_std_prereset(struct ata_port *ap, unsigned long deadline)
 {
 	struct ata_eh_context *ehc = &ap->eh_context;
 	const unsigned long *timing = sata_ehc_deb_timing(ehc);
@@ -2883,7 +2940,7 @@ int ata_std_prereset(struct ata_port *ap)
 
 	if ((ehc->i.flags & ATA_EHI_HOTPLUGGED) &&
 	    (ap->flags & ATA_FLAG_SKIP_D2H_BSY))
-		ata_wait_spinup(ap);
+		ata_wait_spinup(ap, deadline);
 
 	/* if we're about to do hardreset, nothing more to do */
 	if (ehc->i.action & ATA_EH_HARDRESET)
@@ -2891,7 +2948,7 @@ int ata_std_prereset(struct ata_port *ap)
 
 	/* if SATA, resume phy */
 	if (ap->cbl == ATA_CBL_SATA) {
-		rc = sata_phy_resume(ap, timing);
+		rc = sata_phy_resume(ap, timing, deadline);
 		if (rc && rc != -EOPNOTSUPP) {
 			/* phy resume failed */
 			ata_port_printk(ap, KERN_WARNING, "failed to resume "
@@ -2904,7 +2961,7 @@ int ata_std_prereset(struct ata_port *ap)
 	 * Reg FIS and we don't know that no device is attached.
 	 */
 	if (!(ap->flags & ATA_FLAG_SKIP_D2H_BSY) && !ata_port_offline(ap))
-		ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
+		ata_wait_ready(ap, deadline);
 
 	return 0;
 }
@@ -2913,6 +2970,7 @@ int ata_std_prereset(struct ata_port *ap)
  *	ata_std_softreset - reset host port via ATA SRST
  *	@ap: port to reset
  *	@classes: resulting classes of attached devices
+ *	@deadline: deadline jiffies for the operation
  *
  *	Reset host port using ATA SRST.
  *
@@ -2922,10 +2980,12 @@ int ata_std_prereset(struct ata_port *ap)
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int ata_std_softreset(struct ata_port *ap, unsigned int *classes)
+int ata_std_softreset(struct ata_port *ap, unsigned int *classes,
+		      unsigned long deadline)
 {
 	unsigned int slave_possible = ap->flags & ATA_FLAG_SLAVE_POSS;
-	unsigned int devmask = 0, err_mask;
+	unsigned int devmask = 0;
+	int rc;
 	u8 err;
 
 	DPRINTK("ENTER\n");
@@ -2946,11 +3006,10 @@ int ata_std_softreset(struct ata_port *ap, unsigned int *classes)
 
 	/* issue bus reset */
 	DPRINTK("about to softreset, devmask=%x\n", devmask);
-	err_mask = ata_bus_softreset(ap, devmask);
-	if (err_mask) {
-		ata_port_printk(ap, KERN_ERR, "SRST failed (err_mask=0x%x)\n",
-				err_mask);
-		return -EIO;
+	rc = ata_bus_softreset(ap, devmask, deadline);
+	if (rc) {
+		ata_port_printk(ap, KERN_ERR, "SRST failed (errno=%d)\n", rc);
+		return rc;
 	}
 
 	/* determine by signature whether we have ATA or ATAPI devices */
@@ -2967,6 +3026,7 @@ int ata_std_softreset(struct ata_port *ap, unsigned int *classes)
  *	sata_port_hardreset - reset port via SATA phy reset
  *	@ap: port to reset
  *	@timing: timing parameters { interval, duratinon, timeout } in msec
+ *	@deadline: deadline jiffies for the operation
  *
  *	SATA phy-reset host port using DET bits of SControl register.
  *
@@ -2976,7 +3036,8 @@ int ata_std_softreset(struct ata_port *ap, unsigned int *classes)
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int sata_port_hardreset(struct ata_port *ap, const unsigned long *timing)
+int sata_port_hardreset(struct ata_port *ap, const unsigned long *timing,
+			unsigned long deadline)
 {
 	u32 scontrol;
 	int rc;
@@ -3015,7 +3076,7 @@ int sata_port_hardreset(struct ata_port *ap, const unsigned long *timing)
 	msleep(1);
 
 	/* bring phy back */
-	rc = sata_phy_resume(ap, timing);
+	rc = sata_phy_resume(ap, timing, deadline);
  out:
 	DPRINTK("EXIT, rc=%d\n", rc);
 	return rc;
@@ -3025,6 +3086,7 @@ int sata_port_hardreset(struct ata_port *ap, const unsigned long *timing)
  *	sata_std_hardreset - reset host port via SATA phy reset
  *	@ap: port to reset
  *	@class: resulting class of attached device
+ *	@deadline: deadline jiffies for the operation
  *
  *	SATA phy-reset host port using DET bits of SControl register,
  *	wait for !BSY and classify the attached device.
@@ -3035,7 +3097,8 @@ int sata_port_hardreset(struct ata_port *ap, const unsigned long *timing)
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int sata_std_hardreset(struct ata_port *ap, unsigned int *class)
+int sata_std_hardreset(struct ata_port *ap, unsigned int *class,
+		       unsigned long deadline)
 {
 	const unsigned long *timing = sata_ehc_deb_timing(&ap->eh_context);
 	int rc;
@@ -3043,7 +3106,7 @@ int sata_std_hardreset(struct ata_port *ap, unsigned int *class)
 	DPRINTK("ENTER\n");
 
 	/* do hardreset */
-	rc = sata_port_hardreset(ap, timing);
+	rc = sata_port_hardreset(ap, timing, deadline);
 	if (rc) {
 		ata_port_printk(ap, KERN_ERR,
 				"COMRESET failed (errno=%d)\n", rc);
@@ -3060,10 +3123,11 @@ int sata_std_hardreset(struct ata_port *ap, unsigned int *class)
 	/* wait a while before checking status, see SRST for more info */
 	msleep(150);
 
-	if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
+	rc = ata_wait_ready(ap, deadline);
+	if (rc && rc != -ENODEV) {
 		ata_port_printk(ap, KERN_ERR,
-				"COMRESET failed (device not ready)\n");
-		return -EIO;
+				"COMRESET failed (errno=%d)\n", rc);
+		return rc;
 	}
 
 	ap->ops->dev_select(ap, 0);	/* probably unnecessary */
@@ -6268,6 +6332,7 @@ EXPORT_SYMBOL_GPL(ata_port_disable);
 EXPORT_SYMBOL_GPL(ata_ratelimit);
 EXPORT_SYMBOL_GPL(ata_wait_register);
 EXPORT_SYMBOL_GPL(ata_busy_sleep);
+EXPORT_SYMBOL_GPL(ata_wait_ready);
 EXPORT_SYMBOL_GPL(ata_port_queue_task);
 EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
 EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 3173862..7118995 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1531,14 +1531,14 @@ static void ata_eh_report(struct ata_port *ap)
 }
 
 static int ata_do_reset(struct ata_port *ap, ata_reset_fn_t reset,
-			unsigned int *classes)
+			unsigned int *classes, unsigned long deadline)
 {
 	int i, rc;
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
 		classes[i] = ATA_DEV_UNKNOWN;
 
-	rc = reset(ap, classes);
+	rc = reset(ap, classes, deadline);
 	if (rc)
 		return rc;
 
@@ -1597,7 +1597,7 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 		ehc->i.action |= ATA_EH_HARDRESET;
 
 	if (prereset) {
-		rc = prereset(ap);
+		rc = prereset(ap, jiffies + 40 * HZ);
 		if (rc) {
 			if (rc == -ENOENT) {
 				ata_port_printk(ap, KERN_DEBUG, "port disabled. ignoring.\n");
@@ -1640,7 +1640,7 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 	/* mark that this EH session started with reset */
 	ehc->i.flags |= ATA_EHI_DID_RESET;
 
-	rc = ata_do_reset(ap, reset, classes);
+	rc = ata_do_reset(ap, reset, classes, jiffies + 40 * HZ);
 
 	did_followup_srst = 0;
 	if (reset == hardreset &&
@@ -1657,7 +1657,7 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 		}
 
 		ata_eh_about_to_do(ap, NULL, ATA_EH_RESET_MASK);
-		rc = ata_do_reset(ap, reset, classes);
+		rc = ata_do_reset(ap, reset, classes, jiffies + 40 * HZ);
 
 		if (rc == 0 && classify &&
 		    classes[0] == ATA_DEV_UNKNOWN) {
diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index dffa1f5..0ab04ae 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -92,14 +92,15 @@ static int ali_c2_cable_detect(struct ata_port *ap)
 /**
  *	ali_early_error_handler	-	reset for eary chip
  *	@ap: ATA port
+ *	@deadline: deadline jiffies for the operation
  *
  *	Handle the reset callback for the later chips with cable detect
  */
 
-static int ali_c2_pre_reset(struct ata_port *ap)
+static int ali_c2_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	ap->cbl = ali_c2_cable_detect(ap);
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 static void ali_c2_error_handler(struct ata_port *ap)
@@ -125,14 +126,15 @@ static int ali_early_cable_detect(struct ata_port *ap)
 /**
  *	ali_early_probe_init	-	reset for early chip
  *	@ap: ATA port
+ *	@deadline: deadline jiffies for the operation
  *
  *	Handle the reset callback for the early (pre cable detect) chips.
  */
 
-static int ali_early_pre_reset(struct ata_port *ap)
+static int ali_early_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	ap->cbl = ali_early_cable_detect(ap);
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 static void ali_early_error_handler(struct ata_port *ap)
diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index ed0e4f6..04d158e 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -121,12 +121,13 @@ static void timing_setup(struct ata_port *ap, struct ata_device *adev, int offse
 /**
  *	amd_probe_init		-	cable detection
  *	@ap: ATA port
+ *	@deadline: deadline jiffies for the operation
  *
  *	Perform cable detection. The BIOS stores this in PCI config
  *	space for us.
  */
 
-static int amd_pre_reset(struct ata_port *ap)
+static int amd_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	static const u32 bitmask[2] = {0x03, 0xC0};
 	static const struct pci_bits amd_enable_bits[] = {
@@ -145,7 +146,7 @@ static int amd_pre_reset(struct ata_port *ap)
 		ap->cbl = ATA_CBL_PATA80;
 	else
 		ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 
 }
 
@@ -156,7 +157,7 @@ static void amd_error_handler(struct ata_port *ap)
 				      ata_std_postreset);
 }
 
-static int amd_early_pre_reset(struct ata_port *ap)
+static int amd_early_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	static struct pci_bits amd_enable_bits[] = {
@@ -169,8 +170,7 @@ static int amd_early_pre_reset(struct ata_port *ap)
 
 	/* No host side cable detection */
 	ap->cbl = ATA_CBL_PATA80;
-	return ata_std_prereset(ap);
-
+	return ata_std_prereset(ap, deadline);
 }
 
 static void amd_early_error_handler(struct ata_port *ap)
@@ -241,12 +241,14 @@ static void amd133_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 /**
  *	nv_probe_init	-	cable detection
  *	@ap: ATA port
+ *	@deadline: deadline jiffies for the operation
  *
  *	Perform cable detection. The BIOS stores this in PCI config
  *	space for us.
  */
 
-static int nv_pre_reset(struct ata_port *ap) {
+static int nv_pre_reset(struct ata_port *ap, unsigned long deadline)
+{
 	static const u8 bitmask[2] = {0x03, 0xC0};
 	static const struct pci_bits nv_enable_bits[] = {
 		{ 0x50, 1, 0x02, 0x02 },
@@ -272,7 +274,7 @@ static int nv_pre_reset(struct ata_port *ap) {
 	pci_read_config_word(pdev, 0x62 - 2 * ap->port_no, &udma);
 	if ((udma & 0xC4) == 0xC4 || (udma & 0xC400) == 0xC400)
 		ap->cbl = ATA_CBL_PATA80;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 static void nv_error_handler(struct ata_port *ap)
diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index ace5a98..0051304 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -39,7 +39,7 @@
 
 static int clock = 0;
 
-static int artop6210_pre_reset(struct ata_port *ap)
+static int artop6210_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	const struct pci_bits artop_enable_bits[] = {
@@ -51,7 +51,7 @@ static int artop6210_pre_reset(struct ata_port *ap)
 		return -ENOENT;
 
 	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 /**
@@ -72,12 +72,13 @@ static void artop6210_error_handler(struct ata_port *ap)
 /**
  *	artop6260_pre_reset	-	check for 40/80 pin
  *	@ap: Port
+ *	@deadline: deadline jiffies for the operation
  *
  *	The ARTOP hardware reports the cable detect bits in register 0x49.
  *	Nothing complicated needed here.
  */
 
-static int artop6260_pre_reset(struct ata_port *ap)
+static int artop6260_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	static const struct pci_bits artop_enable_bits[] = {
 		{ 0x4AU, 1U, 0x02UL, 0x02UL },	/* port 0 */
@@ -96,7 +97,7 @@ static int artop6260_pre_reset(struct ata_port *ap)
 		ap->cbl = ATA_CBL_PATA40;
 	else
 		ap->cbl = ATA_CBL_PATA80;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 /**
diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index ea5846d..890a377 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -33,7 +33,7 @@ enum {
 	ATIIXP_IDE_UDMA_MODE 	= 0x56
 };
 
-static int atiixp_pre_reset(struct ata_port *ap)
+static int atiixp_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	static struct pci_bits atiixp_enable_bits[] = {
@@ -45,7 +45,7 @@ static int atiixp_pre_reset(struct ata_port *ap)
 		return -ENOENT;
 
 	ap->cbl = ATA_CBL_PATA80;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 static void atiixp_error_handler(struct ata_port *ap)
diff --git a/drivers/ata/pata_cmd64x.c b/drivers/ata/pata_cmd64x.c
index 3a75978..1714c20 100644
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -75,13 +75,13 @@ enum {
 	DTPR1		= 0x7C
 };
 
-static int cmd64x_pre_reset(struct ata_port *ap)
+static int cmd64x_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
-static int cmd648_pre_reset(struct ata_port *ap)
+static int cmd648_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u8 r;
@@ -93,7 +93,7 @@ static int cmd648_pre_reset(struct ata_port *ap)
 	else
 		ap->cbl = ATA_CBL_PATA40;
 
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 static void cmd64x_error_handler(struct ata_port *ap)
diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index 801a00e..1b30055 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -140,10 +140,10 @@ static void cs5520_set_piomode(struct ata_port *ap, struct ata_device *adev)
 }
 
 
-static int cs5520_pre_reset(struct ata_port *ap)
+static int cs5520_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 static void cs5520_error_handler(struct ata_port *ap)
diff --git a/drivers/ata/pata_cs5530.c b/drivers/ata/pata_cs5530.c
index b9fd538..743b3e9 100644
--- a/drivers/ata/pata_cs5530.c
+++ b/drivers/ata/pata_cs5530.c
@@ -160,10 +160,10 @@ static unsigned int cs5530_qc_issue_prot(struct ata_queued_cmd *qc)
 	return ata_qc_issue_prot(qc);
 }
 
-static int cs5530_pre_reset(struct ata_port *ap)
+static int cs5530_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 static void cs5530_error_handler(struct ata_port *ap)
diff --git a/drivers/ata/pata_cs5535.c b/drivers/ata/pata_cs5535.c
index 500f863..86f1f0a 100644
--- a/drivers/ata/pata_cs5535.c
+++ b/drivers/ata/pata_cs5535.c
@@ -72,12 +72,13 @@
 /**
  *	cs5535_pre_reset	-	detect cable type
  *	@ap: Port to detect on
+ *	@deadline: deadline jiffies for the operation
  *
  *	Perform cable detection for ATA66 capable cable. Return a libata
  *	cable type.
  */
 
-static int cs5535_pre_reset(struct ata_port *ap)
+static int cs5535_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	u8 cable;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
@@ -87,7 +88,7 @@ static int cs5535_pre_reset(struct ata_port *ap)
 		ap->cbl = ATA_CBL_PATA80;
 	else
 		ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 /**
diff --git a/drivers/ata/pata_cypress.c b/drivers/ata/pata_cypress.c
index 4ca103d..c727903 100644
--- a/drivers/ata/pata_cypress.c
+++ b/drivers/ata/pata_cypress.c
@@ -41,10 +41,10 @@ enum {
 	CY82_INDEX_TIMEOUT	= 0x32
 };
 
-static int cy82c693_pre_reset(struct ata_port *ap)
+static int cy82c693_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 static void cy82c693_error_handler(struct ata_port *ap)
diff --git a/drivers/ata/pata_efar.c b/drivers/ata/pata_efar.c
index a112dac..7e6d583 100644
--- a/drivers/ata/pata_efar.c
+++ b/drivers/ata/pata_efar.c
@@ -27,12 +27,13 @@
 /**
  *	efar_pre_reset	-	check for 40/80 pin
  *	@ap: Port
+ *	@deadline: deadline jiffies for the operation
  *
  *	Perform cable detection for the EFAR ATA interface. This is
  *	different to the PIIX arrangement
  */
 
-static int efar_pre_reset(struct ata_port *ap)
+static int efar_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	static const struct pci_bits efar_enable_bits[] = {
 		{ 0x41U, 1U, 0x80UL, 0x80UL },	/* port 0 */
@@ -50,7 +51,7 @@ static int efar_pre_reset(struct ata_port *ap)
 		ap->cbl = ATA_CBL_PATA40;
 	else
 		ap->cbl = ATA_CBL_PATA80;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 /**
diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index 819d7a3..b13fc22 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -210,7 +210,7 @@ static u32 hpt36x_find_mode(struct ata_port *ap, int speed)
 	return 0xffffffffU;	/* silence compiler warning */
 }
 
-static int hpt36x_pre_reset(struct ata_port *ap)
+static int hpt36x_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	static const struct pci_bits hpt36x_enable_bits[] = {
 		{ 0x50, 1, 0x04, 0x04 },
@@ -228,7 +228,7 @@ static int hpt36x_pre_reset(struct ata_port *ap)
 		ap->cbl = ATA_CBL_PATA40;
 	else
 		ap->cbl = ATA_CBL_PATA80;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 /**
diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
index c6d8774..5d78414 100644
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -434,11 +434,12 @@ static unsigned long hpt370a_filter(const struct ata_port *ap, struct ata_device
 /**
  *	hpt37x_pre_reset	-	reset the hpt37x bus
  *	@ap: ATA port to reset
+ *	@deadline: deadline jiffies for the operation
  *
  *	Perform the initial reset handling for the 370/372 and 374 func 0
  */
 
-static int hpt37x_pre_reset(struct ata_port *ap)
+static int hpt37x_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	u8 scr2, ata66;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
@@ -466,7 +467,7 @@ static int hpt37x_pre_reset(struct ata_port *ap)
 	pci_write_config_byte(pdev, 0x54, 0x37);
 	udelay(100);
 
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 /**
@@ -481,7 +482,7 @@ static void hpt37x_error_handler(struct ata_port *ap)
 	ata_bmdma_drive_eh(ap, hpt37x_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
 }
 
-static int hpt374_pre_reset(struct ata_port *ap)
+static int hpt374_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	static const struct pci_bits hpt37x_enable_bits[] = {
 		{ 0x50, 1, 0x04, 0x04 },
@@ -517,7 +518,7 @@ static int hpt374_pre_reset(struct ata_port *ap)
 	pci_write_config_byte(pdev, 0x54, 0x37);
 	udelay(100);
 
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 /**
diff --git a/drivers/ata/pata_hpt3x2n.c b/drivers/ata/pata_hpt3x2n.c
index b56dc4a..3fc4b25 100644
--- a/drivers/ata/pata_hpt3x2n.c
+++ b/drivers/ata/pata_hpt3x2n.c
@@ -117,12 +117,13 @@ static u32 hpt3x2n_find_mode(struct ata_port *ap, int speed)
 /**
  *	hpt3x2n_pre_reset	-	reset the hpt3x2n bus
  *	@ap: ATA port to reset
+ *	@deadline: deadline jiffies for the operation
  *
  *	Perform the initial reset handling for the 3x2n series controllers.
  *	Reset the hardware and state machine, obtain the cable type.
  */
 
-static int hpt3xn_pre_reset(struct ata_port *ap)
+static int hpt3xn_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	u8 scr2, ata66;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
@@ -144,7 +145,7 @@ static int hpt3xn_pre_reset(struct ata_port *ap)
 	pci_write_config_byte(pdev, 0x54, 0x37);
 	udelay(100);
 
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 /**
diff --git a/drivers/ata/pata_hpt3x3.c b/drivers/ata/pata_hpt3x3.c
index 46fc417..4cb1042 100644
--- a/drivers/ata/pata_hpt3x3.c
+++ b/drivers/ata/pata_hpt3x3.c
@@ -25,10 +25,10 @@
 #define DRV_NAME	"pata_hpt3x3"
 #define DRV_VERSION	"0.4.2"
 
-static int hpt3x3_probe_init(struct ata_port *ap)
+static int hpt3x3_probe_init(struct ata_port *ap, unsigned long deadline)
 {
 	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 /**
diff --git a/drivers/ata/pata_it8213.c b/drivers/ata/pata_it8213.c
index ec12831..57ff2cd 100644
--- a/drivers/ata/pata_it8213.c
+++ b/drivers/ata/pata_it8213.c
@@ -24,12 +24,13 @@
 /**
  *	it8213_pre_reset	-	check for 40/80 pin
  *	@ap: Port
+ *	@deadline: deadline jiffies for the operation
  *
  *	Perform cable detection for the 8213 ATA interface. This is
  *	different to the PIIX arrangement
  */
 
-static int it8213_pre_reset(struct ata_port *ap)
+static int it8213_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	static const struct pci_bits it8213_enable_bits[] = {
 		{ 0x41U, 1U, 0x80UL, 0x80UL },	/* port 0 */
@@ -46,7 +47,7 @@ static int it8213_pre_reset(struct ata_port *ap)
 		ap->cbl = ATA_CBL_PATA40;
 	else
 		ap->cbl = ATA_CBL_PATA80;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 /**
diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index e8a6e7d..e8f239f 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -115,14 +115,15 @@ static int it8212_noraid;
 /**
  *	it821x_pre_reset	-	probe
  *	@ap: ATA port
+ *	@deadline: deadline jiffies for the operation
  *
  *	Set the cable type
  */
 
-static int it821x_pre_reset(struct ata_port *ap)
+static int it821x_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	ap->cbl = ATA_CBL_PATA80;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 /**
diff --git a/drivers/ata/pata_jmicron.c b/drivers/ata/pata_jmicron.c
index 2d406a7..2a42ca8 100644
--- a/drivers/ata/pata_jmicron.c
+++ b/drivers/ata/pata_jmicron.c
@@ -30,16 +30,17 @@ typedef enum {
 /**
  *	jmicron_pre_reset	-	check for 40/80 pin
  *	@ap: Port
+ *	@deadline: deadline jiffies for the operation
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
+static int jmicron_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u32 control;
@@ -102,7 +103,7 @@ static int jmicron_pre_reset(struct ata_port *ap)
 		ap->cbl = ATA_CBL_SATA;
 		break;
 	}
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 /**
diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
index 586cbb7..29bb2f6 100644
--- a/drivers/ata/pata_marvell.c
+++ b/drivers/ata/pata_marvell.c
@@ -25,11 +25,12 @@
 /**
  *	marvell_pre_reset	-	check for 40/80 pin
  *	@ap: Port
+ *	@deadline: deadline jiffies for the operation
  *
  *	Perform the PATA port setup we need.
  */
 
-static int marvell_pre_reset(struct ata_port *ap)
+static int marvell_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u32 devices;
@@ -67,7 +68,7 @@ static int marvell_pre_reset(struct ata_port *ap)
 		ap->cbl = ATA_CBL_SATA;
 		break;
 	}
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 /**
diff --git a/drivers/ata/pata_mpiix.c b/drivers/ata/pata_mpiix.c
index 9837faf..dce049f 100644
--- a/drivers/ata/pata_mpiix.c
+++ b/drivers/ata/pata_mpiix.c
@@ -46,7 +46,7 @@ enum {
 	SECONDARY = (1 << 14)
 };
 
-static int mpiix_pre_reset(struct ata_port *ap)
+static int mpiix_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	static const struct pci_bits mpiix_enable_bits[] = {
@@ -57,7 +57,7 @@ static int mpiix_pre_reset(struct ata_port *ap)
 	if (!pci_test_config_bits(pdev, &mpiix_enable_bits[ap->port_no]))
 		return -ENOENT;
 	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 /**
diff --git a/drivers/ata/pata_netcell.c b/drivers/ata/pata_netcell.c
index 23365a0..a1ba4d7 100644
--- a/drivers/ata/pata_netcell.c
+++ b/drivers/ata/pata_netcell.c
@@ -21,14 +21,15 @@
 /**
  *	netcell_probe_init	-	check for 40/80 pin
  *	@ap: Port
+ *	@deadline: deadline jiffies for the operation
  *
  *	Cables are handled by the RAID controller. Report 80 pin.
  */
 
-static int netcell_pre_reset(struct ata_port *ap)
+static int netcell_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	ap->cbl = ATA_CBL_PATA80;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 /**
diff --git a/drivers/ata/pata_ns87410.c b/drivers/ata/pata_ns87410.c
index 95c4e0b..3f89cdf 100644
--- a/drivers/ata/pata_ns87410.c
+++ b/drivers/ata/pata_ns87410.c
@@ -33,11 +33,12 @@
 /**
  *	ns87410_pre_reset		-	probe begin
  *	@ap: ATA port
+ *	@deadline: deadline jiffies for the operation
  *
  *	Set up cable type and use generic probe init
  */
 
-static int ns87410_pre_reset(struct ata_port *ap)
+static int ns87410_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	static const struct pci_bits ns87410_enable_bits[] = {
@@ -48,7 +49,7 @@ static int ns87410_pre_reset(struct ata_port *ap)
 	if (!pci_test_config_bits(pdev, &ns87410_enable_bits[ap->port_no]))
 		return -ENOENT;
 	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 /**
diff --git a/drivers/ata/pata_oldpiix.c b/drivers/ata/pata_oldpiix.c
index 95d570a..803ae55 100644
--- a/drivers/ata/pata_oldpiix.c
+++ b/drivers/ata/pata_oldpiix.c
@@ -30,11 +30,12 @@
 /**
  *	oldpiix_pre_reset		-	probe begin
  *	@ap: ATA port
+ *	@deadline: deadline jiffies for the operation
  *
  *	Set up cable type and use generic probe init
  */
 
-static int oldpiix_pre_reset(struct ata_port *ap)
+static int oldpiix_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	static const struct pci_bits oldpiix_enable_bits[] = {
@@ -45,7 +46,7 @@ static int oldpiix_pre_reset(struct ata_port *ap)
 	if (!pci_test_config_bits(pdev, &oldpiix_enable_bits[ap->port_no]))
 		return -ENOENT;
 	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 /**
diff --git a/drivers/ata/pata_opti.c b/drivers/ata/pata_opti.c
index e763026..a009ee5 100644
--- a/drivers/ata/pata_opti.c
+++ b/drivers/ata/pata_opti.c
@@ -47,11 +47,12 @@ enum {
 /**
  *	opti_pre_reset		-	probe begin
  *	@ap: ATA port
+ *	@deadline: deadline jiffies for the operation
  *
  *	Set up cable type and use generic probe init
  */
 
-static int opti_pre_reset(struct ata_port *ap)
+static int opti_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	static const struct pci_bits opti_enable_bits[] = {
@@ -63,7 +64,7 @@ static int opti_pre_reset(struct ata_port *ap)
 		return -ENOENT;
 
 	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 /**
diff --git a/drivers/ata/pata_optidma.c b/drivers/ata/pata_optidma.c
index 067fca1..1d49344 100644
--- a/drivers/ata/pata_optidma.c
+++ b/drivers/ata/pata_optidma.c
@@ -48,11 +48,12 @@ static int pci_clock;	/* 0 = 33 1 = 25 */
 /**
  *	optidma_pre_reset		-	probe begin
  *	@ap: ATA port
+ *	@deadline: deadline jiffies for the operation
  *
  *	Set up cable type and use generic probe init
  */
 
-static int optidma_pre_reset(struct ata_port *ap)
+static int optidma_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	static const struct pci_bits optidma_enable_bits = {
@@ -63,7 +64,7 @@ static int optidma_pre_reset(struct ata_port *ap)
 		return -ENOENT;
 
 	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 /**
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index 2ff91bb..1626e71 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -298,6 +298,7 @@ static inline int pdc2027x_port_enabled(struct ata_port *ap)
 /**
  *	pdc2027x_prereset - prereset for PATA host controller
  *	@ap: Target port
+ *	@deadline: deadline jiffies for the operation
  *
  *	Probeinit including cable detection.
  *
@@ -305,13 +306,13 @@ static inline int pdc2027x_port_enabled(struct ata_port *ap)
  *	None (inherited from caller).
  */
 
-static int pdc2027x_prereset(struct ata_port *ap)
+static int pdc2027x_prereset(struct ata_port *ap, unsigned long deadline)
 {
 	/* Check whether port enabled */
 	if (!pdc2027x_port_enabled(ap))
 		return -ENOENT;
 	pdc2027x_cbl_detect(ap);
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 /**
diff --git a/drivers/ata/pata_pdc202xx_old.c b/drivers/ata/pata_pdc202xx_old.c
index 7e194d8..e7549af 100644
--- a/drivers/ata/pata_pdc202xx_old.c
+++ b/drivers/ata/pata_pdc202xx_old.c
@@ -26,14 +26,15 @@
 /**
  *	pdc2024x_pre_reset		-	probe begin
  *	@ap: ATA port
+ *	@deadline: deadline jiffies for the operation
  *
  *	Set up cable type and use generic probe init
  */
 
-static int pdc2024x_pre_reset(struct ata_port *ap)
+static int pdc2024x_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 
@@ -43,7 +44,7 @@ static void pdc2024x_error_handler(struct ata_port *ap)
 }
 
 
-static int pdc2026x_pre_reset(struct ata_port *ap)
+static int pdc2026x_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u16 cis;
@@ -54,7 +55,7 @@ static int pdc2026x_pre_reset(struct ata_port *ap)
 	else
 		ap->cbl = ATA_CBL_PATA40;
 
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 static void pdc2026x_error_handler(struct ata_port *ap)
diff --git a/drivers/ata/pata_radisys.c b/drivers/ata/pata_radisys.c
index a391bd2..4024700 100644
--- a/drivers/ata/pata_radisys.c
+++ b/drivers/ata/pata_radisys.c
@@ -29,14 +29,15 @@
 /**
  *	radisys_probe_init		-	probe begin
  *	@ap: ATA port
+ *	@deadline: deadline jiffies for the operation
  *
  *	Set up cable type and use generic probe init
  */
 
-static int radisys_pre_reset(struct ata_port *ap)
+static int radisys_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	ap->cbl = ATA_CBL_PATA80;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 
diff --git a/drivers/ata/pata_rz1000.c b/drivers/ata/pata_rz1000.c
index 4a4d2e5..ef6ea93 100644
--- a/drivers/ata/pata_rz1000.c
+++ b/drivers/ata/pata_rz1000.c
@@ -27,14 +27,15 @@
 /**
  *	rz1000_prereset		-	probe begin
  *	@ap: ATA port
+ *	@deadline: deadline jiffies for the operation
  *
  *	Set up cable type and use generics
  */
 
-static int rz1000_prereset(struct ata_port *ap)
+static int rz1000_prereset(struct ata_port *ap, unsigned long deadline)
 {
 	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 /**
diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
index c41a1d3..bd016e8 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -139,12 +139,14 @@ static struct sv_cable_table cable_detect[] = {
 /**
  *	serverworks_pre_reset		-	cable detection
  *	@ap: ATA port
+ *	@deadline: deadline jiffies for the operation
  *
  *	Perform cable detection according to the device and subvendor
  *	identifications
  */
 
-static int serverworks_pre_reset(struct ata_port *ap) {
+static int serverworks_pre_reset(struct ata_port *ap, unsigned long deadline)
+{
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	struct sv_cable_table *cb = cable_detect;
 
@@ -153,7 +155,7 @@ static int serverworks_pre_reset(struct ata_port *ap) {
 		    (cb->subvendor == pdev->subsystem_vendor ||
 		      cb->subvendor == PCI_ANY_ID)) {
 			ap->cbl = cb->cable_detect(ap);
-			return ata_std_prereset(ap);
+			return ata_std_prereset(ap, deadline);
 		}
 		cb++;
 	}
diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index 992e225..6339ce8 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -91,20 +91,22 @@ static int sil680_cable_detect(struct ata_port *ap) {
 		return ATA_CBL_PATA40;
 }
 
-static int sil680_pre_reset(struct ata_port *ap)
+static int sil680_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	ap->cbl = sil680_cable_detect(ap);
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 /**
  *	sil680_bus_reset	-	reset the SIL680 bus
  *	@ap: ATA port to reset
+ *	@deadline: deadline jiffies for the operation
  *
  *	Perform the SIL680 housekeeping when doing an ATA bus reset
  */
 
-static int sil680_bus_reset(struct ata_port *ap,unsigned int *classes)
+static int sil680_bus_reset(struct ata_port *ap,unsigned int *classes,
+			    unsigned long deadline)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	unsigned long addr = sil680_selreg(ap, 0);
@@ -114,7 +116,7 @@ static int sil680_bus_reset(struct ata_port *ap,unsigned int *classes)
 	pci_write_config_byte(pdev, addr, reset | 0x03);
 	udelay(25);
 	pci_write_config_byte(pdev, addr, reset);
-	return ata_std_softreset(ap, classes);
+	return ata_std_softreset(ap, classes, deadline);
 }
 
 static void sil680_error_handler(struct ata_port *ap)
diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index c82d75b..0de9a0f 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -89,12 +89,13 @@ static int sis_port_base(struct ata_device *adev)
 /**
  *	sis_133_pre_reset	-	check for 40/80 pin
  *	@ap: Port
+ *	@deadline: deadline jiffies for the operation
  *
  *	Perform cable detection for the later UDMA133 capable
  *	SiS chipset.
  */
 
-static int sis_133_pre_reset(struct ata_port *ap)
+static int sis_133_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	static const struct pci_bits sis_enable_bits[] = {
 		{ 0x4aU, 1U, 0x02UL, 0x02UL },	/* port 0 */
@@ -114,7 +115,7 @@ static int sis_133_pre_reset(struct ata_port *ap)
 	else
 		ap->cbl = ATA_CBL_PATA80;
 
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 /**
@@ -134,12 +135,13 @@ static void sis_133_error_handler(struct ata_port *ap)
 /**
  *	sis_66_pre_reset	-	check for 40/80 pin
  *	@ap: Port
+ *	@deadline: deadline jiffies for the operation
  *
  *	Perform cable detection on the UDMA66, UDMA100 and early UDMA133
  *	SiS IDE controllers.
  */
 
-static int sis_66_pre_reset(struct ata_port *ap)
+static int sis_66_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	static const struct pci_bits sis_enable_bits[] = {
 		{ 0x4aU, 1U, 0x02UL, 0x02UL },	/* port 0 */
@@ -162,7 +164,7 @@ static int sis_66_pre_reset(struct ata_port *ap)
 	else
 		ap->cbl = ATA_CBL_PATA80;
 
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 /**
@@ -182,11 +184,12 @@ static void sis_66_error_handler(struct ata_port *ap)
 /**
  *	sis_old_pre_reset		-	probe begin
  *	@ap: ATA port
+ *	@deadline: deadline jiffies for the operation
  *
  *	Set up cable type and use generic probe init
  */
 
-static int sis_old_pre_reset(struct ata_port *ap)
+static int sis_old_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	static const struct pci_bits sis_enable_bits[] = {
 		{ 0x4aU, 1U, 0x02UL, 0x02UL },	/* port 0 */
@@ -201,7 +204,7 @@ static int sis_old_pre_reset(struct ata_port *ap)
 		return 0;
 	}
 	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 
diff --git a/drivers/ata/pata_sl82c105.c b/drivers/ata/pata_sl82c105.c
index c7770f8..3d80d2c 100644
--- a/drivers/ata/pata_sl82c105.c
+++ b/drivers/ata/pata_sl82c105.c
@@ -37,11 +37,12 @@ enum {
 /**
  *	sl82c105_pre_reset		-	probe begin
  *	@ap: ATA port
+ *	@deadline: deadline jiffies for the operation
  *
  *	Set up cable type and use generic probe init
  */
 
-static int sl82c105_pre_reset(struct ata_port *ap)
+static int sl82c105_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	static const struct pci_bits sl82c105_enable_bits[] = {
 		{ 0x40, 1, 0x01, 0x01 },
@@ -52,7 +53,7 @@ static int sl82c105_pre_reset(struct ata_port *ap)
 	if (ap->port_no && !pci_test_config_bits(pdev, &sl82c105_enable_bits[ap->port_no]))
 		return -ENOENT;
 	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 
diff --git a/drivers/ata/pata_triflex.c b/drivers/ata/pata_triflex.c
index 60f2eea..2da5ba6 100644
--- a/drivers/ata/pata_triflex.c
+++ b/drivers/ata/pata_triflex.c
@@ -48,11 +48,12 @@
 /**
  *	triflex_prereset		-	probe begin
  *	@ap: ATA port
+ *	@deadline: deadline jiffies for the operation
  *
  *	Set up cable type and use generic probe init
  */
 
-static int triflex_prereset(struct ata_port *ap)
+static int triflex_prereset(struct ata_port *ap, unsigned long deadline)
 {
 	static const struct pci_bits triflex_enable_bits[] = {
 		{ 0x80, 1, 0x01, 0x01 },
@@ -64,7 +65,7 @@ static int triflex_prereset(struct ata_port *ap)
 	if (!pci_test_config_bits(pdev, &triflex_enable_bits[ap->port_no]))
 		return -ENOENT;
 	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index ebf76eb..c041fb3 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -146,7 +146,7 @@ static int via_cable_detect(struct ata_port *ap) {
 		return ATA_CBL_PATA40;
 }
 
-static int via_pre_reset(struct ata_port *ap)
+static int via_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	const struct via_isa_bridge *config = ap->host->private_data;
 
@@ -170,8 +170,7 @@ static int via_pre_reset(struct ata_port *ap)
 	else
 		ap->cbl = ATA_CBL_PATA_UNK;
 		
-
-	return ata_std_prereset(ap);
+	return ata_std_prereset(ap, deadline);
 }
 
 
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index fad2bd3..dde369f 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -418,7 +418,8 @@ static void inic_thaw(struct ata_port *ap)
  * SRST and SControl hardreset don't give valid signature on this
  * controller.  Only controller specific hardreset mechanism works.
  */
-static int inic_hardreset(struct ata_port *ap, unsigned int *class)
+static int inic_hardreset(struct ata_port *ap, unsigned int *class,
+			  unsigned long deadline)
 {
 	void __iomem *port_base = inic_port_base(ap);
 	void __iomem *idma_ctl = port_base + PORT_IDMA_CTL;
@@ -435,7 +436,7 @@ static int inic_hardreset(struct ata_port *ap, unsigned int *class)
 	msleep(1);
 	writew(val & ~IDMA_CTL_RST_ATA, idma_ctl);
 
-	rc = sata_phy_resume(ap, timing);
+	rc = sata_phy_resume(ap, timing, deadline);
 	if (rc) {
 		ata_port_printk(ap, KERN_WARNING, "failed to resume "
 				"link after reset (errno=%d)\n", rc);
@@ -449,10 +450,11 @@ static int inic_hardreset(struct ata_port *ap, unsigned int *class)
 		/* wait a while before checking status */
 		msleep(150);
 
-		if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
-			ata_port_printk(ap, KERN_WARNING,
-					"device busy after hardreset\n");
-			return -EIO;
+		rc = ata_wait_ready(ap, deadline);
+		if (rc && rc != -ENODEV) {
+			ata_port_printk(ap, KERN_WARNING, "device not ready "
+					"after hardreset (errno=%d)\n", rc);
+			return rc;
 		}
 
 		ata_tf_read(ap, &tf);
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index b9ef6f5..c68f3e6 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -1339,7 +1339,8 @@ static void nv_ck804_thaw(struct ata_port *ap)
 	writeb(mask, mmio_base + NV_INT_ENABLE_CK804);
 }
 
-static int nv_hardreset(struct ata_port *ap, unsigned int *class)
+static int nv_hardreset(struct ata_port *ap, unsigned int *class,
+			unsigned long deadline)
 {
 	unsigned int dummy;
 
@@ -1347,7 +1348,7 @@ static int nv_hardreset(struct ata_port *ap, unsigned int *class)
 	 * some controllers.  Don't classify on hardreset.  For more
 	 * info, see http://bugme.osdl.org/show_bug.cgi?id=3352
 	 */
-	return sata_std_hardreset(ap, &dummy);
+	return sata_std_hardreset(ap, &dummy, deadline);
 }
 
 static void nv_error_handler(struct ata_port *ap)
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 9dcf11e..e1a64d5 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -534,7 +534,8 @@ static int sil24_init_port(struct ata_port *ap)
 	return 0;
 }
 
-static int sil24_softreset(struct ata_port *ap, unsigned int *class)
+static int sil24_softreset(struct ata_port *ap, unsigned int *class,
+			   unsigned long deadline)
 {
 	void __iomem *port = ap->ioaddr.cmd_addr;
 	struct sil24_port_priv *pp = ap->private_data;
@@ -566,7 +567,7 @@ static int sil24_softreset(struct ata_port *ap, unsigned int *class)
 
 	mask = (PORT_IRQ_COMPLETE | PORT_IRQ_ERROR) << PORT_IRQ_RAW_SHIFT;
 	irq_stat = ata_wait_register(port + PORT_IRQ_STAT, mask, 0x0,
-				     100, ATA_TMOUT_BOOT / HZ * 1000);
+				     100, jiffies_to_msecs(deadline - jiffies));
 
 	writel(irq_stat, port + PORT_IRQ_STAT); /* clear IRQs */
 	irq_stat >>= PORT_IRQ_RAW_SHIFT;
@@ -594,7 +595,8 @@ static int sil24_softreset(struct ata_port *ap, unsigned int *class)
 	return -EIO;
 }
 
-static int sil24_hardreset(struct ata_port *ap, unsigned int *class)
+static int sil24_hardreset(struct ata_port *ap, unsigned int *class,
+			   unsigned long deadline)
 {
 	void __iomem *port = ap->ioaddr.cmd_addr;
 	const char *reason;
@@ -615,7 +617,7 @@ static int sil24_hardreset(struct ata_port *ap, unsigned int *class)
 	/* SStatus oscillates between zero and valid status after
 	 * DEV_RST, debounce it.
 	 */
-	rc = sata_phy_debounce(ap, sata_deb_timing_long);
+	rc = sata_phy_debounce(ap, sata_deb_timing_long, deadline);
 	if (rc) {
 		reason = "PHY debouncing failed";
 		goto err;
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 6b55819..9e37bbb 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -252,6 +252,7 @@ static void svia_noop_freeze(struct ata_port *ap)
 /**
  *	vt6420_prereset - prereset for vt6420
  *	@ap: target ATA port
+ *	@deadline: deadline jiffies for the operation
  *
  *	SCR registers on vt6420 are pieces of shit and may hang the
  *	whole machine completely if accessed with the wrong timing.
@@ -268,7 +269,7 @@ static void svia_noop_freeze(struct ata_port *ap)
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-static int vt6420_prereset(struct ata_port *ap)
+static int vt6420_prereset(struct ata_port *ap, unsigned long deadline)
 {
 	struct ata_eh_context *ehc = &ap->eh_context;
 	unsigned long timeout = jiffies + (HZ * 5);
@@ -313,7 +314,7 @@ static int vt6420_prereset(struct ata_port *ap)
 
  skip_scr:
 	/* wait for !BSY */
-	ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
+	ata_wait_ready(ap, deadline);
 
 	return 0;
 }
@@ -324,7 +325,7 @@ static void vt6420_error_handler(struct ata_port *ap)
 				  NULL, ata_std_postreset);
 }
 
-static int vt6421_pata_prereset(struct ata_port *ap)
+static int vt6421_pata_prereset(struct ata_port *ap, unsigned long deadline)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u8 tmp;
@@ -343,7 +344,7 @@ static void vt6421_pata_error_handler(struct ata_port *ap)
 				  NULL, ata_std_postreset);
 }
 
-static int vt6421_sata_prereset(struct ata_port *ap)
+static int vt6421_sata_prereset(struct ata_port *ap, unsigned long deadline)
 {
 	ap->cbl = ATA_CBL_SATA;
 	return 0;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 1b3963f..9b1ddaf 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -343,8 +343,9 @@ struct ata_queued_cmd;
 
 /* typedefs */
 typedef void (*ata_qc_cb_t) (struct ata_queued_cmd *qc);
-typedef int (*ata_prereset_fn_t)(struct ata_port *ap);
-typedef int (*ata_reset_fn_t)(struct ata_port *ap, unsigned int *classes);
+typedef int (*ata_prereset_fn_t)(struct ata_port *ap, unsigned long deadline);
+typedef int (*ata_reset_fn_t)(struct ata_port *ap, unsigned int *classes,
+			      unsigned long deadline);
 typedef void (*ata_postreset_fn_t)(struct ata_port *ap, unsigned int *classes);
 
 struct ata_ioports {
@@ -699,13 +700,17 @@ extern void __sata_phy_reset(struct ata_port *ap);
 extern void sata_phy_reset(struct ata_port *ap);
 extern void ata_bus_reset(struct ata_port *ap);
 extern int sata_set_spd(struct ata_port *ap);
-extern int sata_phy_debounce(struct ata_port *ap, const unsigned long *param);
-extern int sata_phy_resume(struct ata_port *ap, const unsigned long *param);
-extern int ata_std_prereset(struct ata_port *ap);
-extern int ata_std_softreset(struct ata_port *ap, unsigned int *classes);
-extern int sata_port_hardreset(struct ata_port *ap,
-			       const unsigned long *timing);
-extern int sata_std_hardreset(struct ata_port *ap, unsigned int *class);
+extern int sata_phy_debounce(struct ata_port *ap, const unsigned long *param,
+			     unsigned long deadline);
+extern int sata_phy_resume(struct ata_port *ap, const unsigned long *param,
+			   unsigned long deadline);
+extern int ata_std_prereset(struct ata_port *ap, unsigned long deadline);
+extern int ata_std_softreset(struct ata_port *ap, unsigned int *classes,
+			     unsigned long deadline);
+extern int sata_port_hardreset(struct ata_port *ap, const unsigned long *timing,
+			       unsigned long deadline);
+extern int sata_std_hardreset(struct ata_port *ap, unsigned int *class,
+			      unsigned long deadline);
 extern void ata_std_postreset(struct ata_port *ap, unsigned int *classes);
 extern void ata_port_disable(struct ata_port *);
 extern void ata_std_ports(struct ata_ioports *ioaddr);
@@ -749,6 +754,7 @@ extern void ata_host_resume(struct ata_host *host);
 extern int ata_ratelimit(void);
 extern int ata_busy_sleep(struct ata_port *ap,
 			  unsigned long timeout_pat, unsigned long timeout);
+extern int ata_wait_ready(struct ata_port *ap, unsigned long deadline);
 extern void ata_port_queue_task(struct ata_port *ap, work_func_t fn,
 				void *data, unsigned long delay);
 extern u32 ata_wait_register(void __iomem *reg, u32 mask, u32 val,
-- 
1.4.4.4


