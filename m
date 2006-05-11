From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/14] libata-link: linkify PHY-related functions
Date: Fri, 12 May 2006 01:30:23 +0900
Message-ID: <11473650233110-git-send-email-htejun@gmail.com>
References: <11473650221713-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.234]:37003 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751804AbWEKQaa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:30:30 -0400
Received: by wr-out-0506.google.com with SMTP id i12so405467wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:30:29 -0700 (PDT)
In-Reply-To: <11473650221713-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make the following PHY-related functions to deal with ata_link instead
of ata_port.

* sata_print_link_status()
* ata_down_sata_spd_limit()
* ata_set_sata_spd_limit() and friends
* sata_link_debounce/resume()
* ata_scr_valid/read/write/write_flush()
* ata_link_on/offline()

This patch introduces no behavior change.

---

 drivers/scsi/ahci.c         |    6 +
 drivers/scsi/libata-bmdma.c |    2 
 drivers/scsi/libata-core.c  |  217 +++++++++++++++++++++++--------------------
 drivers/scsi/libata-eh.c    |   22 ++--
 drivers/scsi/libata.h       |    4 -
 drivers/scsi/sata_mv.c      |   14 +--
 drivers/scsi/sata_sil24.c   |   12 +-
 include/linux/libata.h      |   23 ++---
 8 files changed, 157 insertions(+), 143 deletions(-)

e99ffedfb16c0fae395568f367561a930118e4d1
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index e3b4fd5..d4420ac 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -587,7 +587,7 @@ static int ahci_softreset(struct ata_por
 
 	DPRINTK("ENTER\n");
 
-	if (ata_port_offline(ap)) {
+	if (ata_link_offline(&ap->link)) {
 		DPRINTK("PHY reports no device\n");
 		*class = ATA_DEV_NONE;
 		return 0;
@@ -661,7 +661,7 @@ static int ahci_softreset(struct ata_por
 	msleep(150);
 
 	*class = ATA_DEV_NONE;
-	if (ata_port_online(ap)) {
+	if (ata_link_online(&ap->link)) {
 		if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
 			rc = -EIO;
 			reason = "device not ready";
@@ -690,7 +690,7 @@ static int ahci_hardreset(struct ata_por
 	rc = sata_std_hardreset(ap, class);
 	ahci_start_engine(ap);
 
-	if (rc == 0 && ata_port_online(ap))
+	if (rc == 0 && ata_link_online(&ap->link))
 		*class = ahci_dev_classify(ap);
 	if (*class == ATA_DEV_UNKNOWN)
 		*class = ATA_DEV_NONE;
diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
index b3a4642..7805f79 100644
--- a/drivers/scsi/libata-bmdma.c
+++ b/drivers/scsi/libata-bmdma.c
@@ -778,7 +778,7 @@ void ata_bmdma_error_handler(struct ata_
 	ata_reset_fn_t hardreset;
 
 	hardreset = NULL;
-	if (ata_scr_valid(ap))
+	if (ata_scr_valid(&ap->link))
 		hardreset = sata_std_hardreset;
 
 	ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset, hardreset,
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 501a752..9680359 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1548,7 +1548,7 @@ static int ata_bus_probe(struct ata_port
 		tries[dev->devno] = 0;
 		break;
 	case -EIO:
-		ata_down_sata_spd_limit(ap);
+		ata_down_sata_spd_limit(&ap->link);
 		/* fall through */
 	default:
 		tries[dev->devno]--;
@@ -1583,28 +1583,28 @@ void ata_port_probe(struct ata_port *ap)
 
 /**
  *	sata_print_link_status - Print SATA link status
- *	@ap: SATA port to printk link status about
+ *	@link: SATA link to printk link status about
  *
  *	This function prints link speed and status of a SATA link.
  *
  *	LOCKING:
  *	None.
  */
-static void sata_print_link_status(struct ata_port *ap)
+static void sata_print_link_status(struct ata_link *link)
 {
 	u32 sstatus, scontrol, tmp;
 
-	if (ata_scr_read(ap, SCR_STATUS, &sstatus))
+	if (ata_scr_read(link, SCR_STATUS, &sstatus))
 		return;
-	ata_scr_read(ap, SCR_CONTROL, &scontrol);
+	ata_scr_read(link, SCR_CONTROL, &scontrol);
 
-	if (ata_port_online(ap)) {
+	if (ata_link_online(link)) {
 		tmp = (sstatus >> 4) & 0xf;
-		ata_port_printk(ap, KERN_INFO,
+		ata_link_printk(link, KERN_INFO,
 				"SATA link up %s (SStatus %X SControl %X)\n",
 				sata_spd_string(tmp), sstatus, scontrol);
 	} else {
-		ata_port_printk(ap, KERN_INFO,
+		ata_link_printk(link, KERN_INFO,
 				"SATA link down (SStatus %X SControl %X)\n",
 				sstatus, scontrol);
 	}
@@ -1624,32 +1624,33 @@ static void sata_print_link_status(struc
  */
 void __sata_phy_reset(struct ata_port *ap)
 {
-	u32 sstatus;
+	struct ata_link *link = &ap->link;
 	unsigned long timeout = jiffies + (HZ * 5);
+	u32 sstatus;
 
 	if (ap->flags & ATA_FLAG_SATA_RESET) {
 		/* issue phy wake/reset */
-		ata_scr_write_flush(ap, SCR_CONTROL, 0x301);
+		ata_scr_write_flush(link, SCR_CONTROL, 0x301);
 		/* Couldn't find anything in SATA I/II specs, but
 		 * AHCI-1.1 10.4.2 says at least 1 ms. */
 		mdelay(1);
 	}
 	/* phy wake/clear reset */
-	ata_scr_write_flush(ap, SCR_CONTROL, 0x300);
+	ata_scr_write_flush(link, SCR_CONTROL, 0x300);
 
 	/* wait for phy to become ready, if necessary */
 	do {
 		msleep(200);
-		ata_scr_read(ap, SCR_STATUS, &sstatus);
+		ata_scr_read(link, SCR_STATUS, &sstatus);
 		if ((sstatus & 0xf) != 1)
 			break;
 	} while (time_before(jiffies, timeout));
 
 	/* print link status */
-	sata_print_link_status(ap);
+	sata_print_link_status(link);
 
 	/* TODO: phy layer with polling, timeouts, etc. */
-	if (!ata_port_offline(ap))
+	if (!ata_link_offline(link))
 		ata_port_probe(ap);
 	else
 		ata_port_disable(ap);
@@ -1723,9 +1724,9 @@ void ata_port_disable(struct ata_port *a
 
 /**
  *	ata_down_sata_spd_limit - adjust SATA spd limit downward
- *	@ap: Port to adjust SATA spd limit for
+ *	@link: Link to adjust SATA spd limit for
  *
- *	Adjust SATA spd limit of @ap downward.  Note that this
+ *	Adjust SATA spd limit of @link downward.  Note that this
  *	function only adjusts the limit.  The change must be applied
  *	using ata_set_sata_spd().
  *
@@ -1735,16 +1736,16 @@ void ata_port_disable(struct ata_port *a
  *	RETURNS:
  *	0 on success, negative errno on failure
  */
-int ata_down_sata_spd_limit(struct ata_port *ap)
+int ata_down_sata_spd_limit(struct ata_link *link)
 {
 	u32 sstatus, spd, mask;
 	int rc, highbit;
 
-	rc = ata_scr_read(ap, SCR_STATUS, &sstatus);
+	rc = ata_scr_read(link, SCR_STATUS, &sstatus);
 	if (rc)
 		return rc;
 
-	mask = ap->link.sata_spd_limit;
+	mask = link->sata_spd_limit;
 	if (mask <= 1)
 		return -EINVAL;
 	highbit = fls(mask) - 1;
@@ -1758,22 +1759,22 @@ int ata_down_sata_spd_limit(struct ata_p
 	if (!mask)
 		return -EINVAL;
 
-	ap->link.sata_spd_limit = mask;
+	link->sata_spd_limit = mask;
 
-	ata_port_printk(ap, KERN_WARNING, "limiting SATA link speed to %s\n",
+	ata_link_printk(link, KERN_WARNING, "limiting SATA link speed to %s\n",
 			sata_spd_string(fls(mask)));
 
 	return 0;
 }
 
-static int __ata_set_sata_spd_needed(struct ata_port *ap, u32 *scontrol)
+static int __ata_set_sata_spd_needed(struct ata_link *link, u32 *scontrol)
 {
 	u32 spd, limit;
 
-	if (ap->link.sata_spd_limit == UINT_MAX)
+	if (link->sata_spd_limit == UINT_MAX)
 		limit = 0;
 	else
-		limit = fls(ap->link.sata_spd_limit);
+		limit = fls(link->sata_spd_limit);
 
 	spd = (*scontrol >> 4) & 0xf;
 	*scontrol = (*scontrol & ~0xf0) | ((limit & 0xf) << 4);
@@ -1783,10 +1784,10 @@ static int __ata_set_sata_spd_needed(str
 
 /**
  *	ata_set_sata_spd_needed - is SATA spd configuration needed
- *	@ap: Port in question
+ *	@link: Link in question
  *
  *	Test whether the spd limit in SControl matches
- *	@ap->link.sata_spd_limit.  This function is used to determine
+ *	@link->sata_spd_limit.  This function is used to determine
  *	whether hardreset is necessary to apply SATA spd
  *	configuration.
  *
@@ -1796,21 +1797,21 @@ static int __ata_set_sata_spd_needed(str
  *	RETURNS:
  *	1 if SATA spd configuration is needed, 0 otherwise.
  */
-int ata_set_sata_spd_needed(struct ata_port *ap)
+int ata_set_sata_spd_needed(struct ata_link *link)
 {
 	u32 scontrol;
 
-	if (ata_scr_read(ap, SCR_CONTROL, &scontrol))
+	if (ata_scr_read(link, SCR_CONTROL, &scontrol))
 		return 0;
 
-	return __ata_set_sata_spd_needed(ap, &scontrol);
+	return __ata_set_sata_spd_needed(link, &scontrol);
 }
 
 /**
  *	ata_set_sata_spd - set SATA spd according to spd limit
- *	@ap: Port to set SATA spd for
+ *	@link: Link to set SATA spd for
  *
- *	Set SATA spd of @ap according to sata_spd_limit.
+ *	Set SATA spd of @link according to sata_spd_limit.
  *
  *	LOCKING:
  *	Inherited from caller.
@@ -1819,18 +1820,18 @@ int ata_set_sata_spd_needed(struct ata_p
  *	0 if spd doesn't need to be changed, 1 if spd has been
  *	changed.  Negative errno if SCR registers are inaccessible.
  */
-int ata_set_sata_spd(struct ata_port *ap)
+int ata_set_sata_spd(struct ata_link *link)
 {
 	u32 scontrol;
 	int rc;
 
-	if ((rc = ata_scr_read(ap, SCR_CONTROL, &scontrol)))
+	if ((rc = ata_scr_read(link, SCR_CONTROL, &scontrol)))
 		return rc;
 
-	if (!__ata_set_sata_spd_needed(ap, &scontrol))
+	if (!__ata_set_sata_spd_needed(link, &scontrol))
 		return 0;
 
-	if ((rc = ata_scr_write(ap, SCR_CONTROL, scontrol)))
+	if ((rc = ata_scr_write(link, SCR_CONTROL, scontrol)))
 		return rc;
 	return 1;
 }
@@ -2422,13 +2423,13 @@ err_out:
 }
 
 /**
- *	sata_phy_debounce - debounce SATA phy status
- *	@ap: ATA port to debounce SATA phy status for
+ *	sata_link_debounce - debounce SATA phy status
+ *	@link: ATA link to debounce SATA phy status for
  *	@interval_msec: polling interval in millisecs
  *	@duration_msec: debounce duration in millisecs
  *	@timeout_msec: timeout in millisecs
  *
- *	Make sure SStatus of @ap reaches stable state, determined by
+ *	Make sure SStatus of @link reaches stable state, determined by
  *	holding the same value where DET is not 1 for @duration_msec
  *	polled every @interval_msec, before @timeout_msec.  Timeout
  *	constraints the beginning of the stable state.  Because, after
@@ -2442,8 +2443,8 @@ err_out:
  *	RETURNS:
  *	0 on success, -errno on failure.
  */
-int sata_phy_debounce(struct ata_port *ap, unsigned long interval_msec,
-		      unsigned long duration_msec, unsigned long timeout_msec)
+int sata_link_debounce(struct ata_link *link, unsigned long interval_msec,
+		       unsigned long duration_msec, unsigned long timeout_msec)
 {
 	unsigned long duration = duration_msec * HZ / 1000;
 	unsigned long timeout = jiffies + timeout_msec * HZ / 1000;
@@ -2451,7 +2452,7 @@ int sata_phy_debounce(struct ata_port *a
 	u32 last, cur;
 	int rc;
 
-	if ((rc = ata_scr_read(ap, SCR_STATUS, &cur)))
+	if ((rc = ata_scr_read(link, SCR_STATUS, &cur)))
 		return rc;
 	cur &= 0xf;
 
@@ -2460,7 +2461,7 @@ int sata_phy_debounce(struct ata_port *a
 
 	while (1) {
 		msleep(interval_msec);
-		if ((rc = ata_scr_read(ap, SCR_STATUS, &cur)))
+		if ((rc = ata_scr_read(link, SCR_STATUS, &cur)))
 			return rc;
 		cur &= 0xf;
 
@@ -2484,10 +2485,10 @@ int sata_phy_debounce(struct ata_port *a
 }
 
 /**
- *	sata_phy_resume - resume SATA phy
- *	@ap: ATA port to resume SATA phy for
+ *	sata_link_resume - resume SATA link
+ *	@link: ATA link to resume SATA
  *
- *	Resume SATA phy of @ap and debounce it.
+ *	Resume SATA phy of @link and debounce it.
  *
  *	LOCKING:
  *	Kernel thread context (may sleep)
@@ -2495,27 +2496,27 @@ int sata_phy_debounce(struct ata_port *a
  *	RETURNS:
  *	0 on success, -errno on failure.
  */
-int sata_phy_resume(struct ata_port *ap, int quick)
+int sata_link_resume(struct ata_link *link, int quick)
 {
 	u32 scontrol;
 	int rc;
 
-	if ((rc = ata_scr_read(ap, SCR_CONTROL, &scontrol)))
+	if ((rc = ata_scr_read(link, SCR_CONTROL, &scontrol)))
 		return rc;
 
 	scontrol = (scontrol & 0x0f0) | 0x300;
 
-	if ((rc = ata_scr_write(ap, SCR_CONTROL, scontrol)))
+	if ((rc = ata_scr_write(link, SCR_CONTROL, scontrol)))
 		return rc;
 
 	if (quick)
-		return sata_phy_debounce(ap, ATA_DEBOUNCE_QUICK_INTERVAL,
-					 ATA_DEBOUNCE_QUICK_DURATION,
-					 ATA_DEBOUNCE_QUICK_TIMEOUT);
+		return sata_link_debounce(link, ATA_DEBOUNCE_QUICK_INTERVAL,
+					  ATA_DEBOUNCE_QUICK_DURATION,
+					  ATA_DEBOUNCE_QUICK_TIMEOUT);
 	else
-		return sata_phy_debounce(ap, ATA_DEBOUNCE_INTERVAL,
-					 ATA_DEBOUNCE_DURATION,
-					 ATA_DEBOUNCE_TIMEOUT);
+		return sata_link_debounce(link, ATA_DEBOUNCE_INTERVAL,
+					  ATA_DEBOUNCE_DURATION,
+					  ATA_DEBOUNCE_TIMEOUT);
 }
 
 /**
@@ -2539,8 +2540,8 @@ int ata_std_prereset(struct ata_port *ap
 	if (ap->link.eh_context.i.action & ATA_EH_HARDRESET)
 		return 0;
 
-	/* resume port */
-	rc = sata_phy_resume(ap, boot_probe);
+	/* resume link */
+	rc = sata_link_resume(&ap->link, boot_probe);
 	if (rc && rc != -EOPNOTSUPP) {
 		/* phy resume failed, whine but continue */
 		ata_port_printk(ap, KERN_WARNING, "failed to resume link "
@@ -2553,7 +2554,7 @@ int ata_std_prereset(struct ata_port *ap
 	 * cases.  As we wait for !BSY after resets, this should be
 	 * safe.
 	 */
-	if (boot_probe && !ata_port_offline(ap))
+	if (boot_probe && !ata_link_offline(&ap->link))
 		ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
 
 	return 0;
@@ -2580,7 +2581,7 @@ int ata_std_softreset(struct ata_port *a
 
 	DPRINTK("ENTER\n");
 
-	if (ata_port_offline(ap)) {
+	if (ata_link_offline(&ap->link)) {
 		classes[0] = ATA_DEV_NONE;
 		goto out;
 	}
@@ -2628,35 +2629,36 @@ int ata_std_softreset(struct ata_port *a
  */
 int sata_std_hardreset(struct ata_port *ap, unsigned int *class)
 {
+	struct ata_link *link = &ap->link;
 	u32 scontrol;
 	int rc;
 
 	DPRINTK("ENTER\n");
 
-	if (ata_set_sata_spd_needed(ap)) {
+	if (ata_set_sata_spd_needed(link)) {
 		/* SATA spec says nothing about how to reconfigure
 		 * spd.  To be on the safe side, turn off phy during
 		 * reconfiguration.  This works for at least ICH7 AHCI
 		 * and Sil3124.
 		 */
-		if ((rc = ata_scr_read(ap, SCR_CONTROL, &scontrol)))
+		if ((rc = ata_scr_read(link, SCR_CONTROL, &scontrol)))
 			return rc;
 
 		scontrol = (scontrol & 0x0f0) | 0x302;
 
-		if ((rc = ata_scr_write(ap, SCR_CONTROL, scontrol)))
+		if ((rc = ata_scr_write(link, SCR_CONTROL, scontrol)))
 			return rc;
 
-		ata_set_sata_spd(ap);
+		ata_set_sata_spd(link);
 	}
 
 	/* issue phy wake/reset */
-	if ((rc = ata_scr_read(ap, SCR_CONTROL, &scontrol)))
+	if ((rc = ata_scr_read(link, SCR_CONTROL, &scontrol)))
 		return rc;
 
 	scontrol = (scontrol & 0x0f0) | 0x301;
 
-	if ((rc = ata_scr_write_flush(ap, SCR_CONTROL, scontrol)))
+	if ((rc = ata_scr_write_flush(link, SCR_CONTROL, scontrol)))
 		return rc;
 
 	/* Couldn't find anything in SATA I/II specs, but AHCI-1.1
@@ -2665,17 +2667,17 @@ int sata_std_hardreset(struct ata_port *
 	msleep(1);
 
 	/* bring phy back */
-	sata_phy_resume(ap, 0);
+	sata_link_resume(link, 0);
 
 	/* TODO: phy layer with polling, timeouts, etc. */
-	if (ata_port_offline(ap)) {
+	if (ata_link_offline(link)) {
 		*class = ATA_DEV_NONE;
 		DPRINTK("EXIT, link offline\n");
 		return 0;
 	}
 
 	if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
-		ata_port_printk(ap, KERN_ERR,
+		ata_link_printk(link, KERN_ERR,
 				"COMRESET failed (device not ready)\n");
 		return -EIO;
 	}
@@ -2702,16 +2704,17 @@ int sata_std_hardreset(struct ata_port *
  */
 void ata_std_postreset(struct ata_port *ap, unsigned int *classes)
 {
+	struct ata_link *link = &ap->link;
 	u32 serror;
 
 	DPRINTK("ENTER\n");
 
 	/* print link status */
-	sata_print_link_status(ap);
+	sata_print_link_status(link);
 
 	/* clear SError */
-	if (ata_scr_read(ap, SCR_ERROR, &serror) == 0)
-		ata_scr_write(ap, SCR_ERROR, serror);
+	if (ata_scr_read(link, SCR_ERROR, &serror) == 0)
+		ata_scr_write(link, SCR_ERROR, serror);
 
 	/* re-enable interrupts */
 	if (!ap->ops->error_handler) {
@@ -4730,9 +4733,9 @@ irqreturn_t ata_interrupt (int irq, void
 
 /**
  *	ata_scr_valid - test whether SCRs are accessible
- *	@ap: ATA port to test SCR accessibility for
+ *	@link: ATA link to test SCR accessibility for
  *
- *	Test whether SCRs are accessible for @ap.
+ *	Test whether SCRs are accessible for @link.
  *
  *	LOCKING:
  *	None.
@@ -4740,18 +4743,20 @@ irqreturn_t ata_interrupt (int irq, void
  *	RETURNS:
  *	1 if SCRs are accessible, 0 otherwise.
  */
-int ata_scr_valid(struct ata_port *ap)
+int ata_scr_valid(struct ata_link *link)
 {
+	struct ata_port *ap = link->ap;
+
 	return ap->cbl == ATA_CBL_SATA && ap->ops->scr_read;
 }
 
 /**
  *	ata_scr_read - read SCR register of the specified port
- *	@ap: ATA port to read SCR for
+ *	@link: ATA link to read SCR for
  *	@reg: SCR to read
  *	@val: Place to store read value
  *
- *	Read SCR register @reg of @ap into *@val.  This function is
+ *	Read SCR register @reg of @link into *@val.  This function is
  *	guaranteed to succeed if the cable type of the port is SATA
  *	and the port implements ->scr_read.
  *
@@ -4761,9 +4766,11 @@ int ata_scr_valid(struct ata_port *ap)
  *	RETURNS:
  *	0 on success, negative errno on failure.
  */
-int ata_scr_read(struct ata_port *ap, int reg, u32 *val)
+int ata_scr_read(struct ata_link *link, int reg, u32 *val)
 {
-	if (ata_scr_valid(ap)) {
+	struct ata_port *ap = link->ap;
+
+	if (ata_scr_valid(link)) {
 		*val = ap->ops->scr_read(ap, reg);
 		return 0;
 	}
@@ -4772,11 +4779,11 @@ int ata_scr_read(struct ata_port *ap, in
 
 /**
  *	ata_scr_write - write SCR register of the specified port
- *	@ap: ATA port to write SCR for
+ *	@link: ATA link to write SCR for
  *	@reg: SCR to write
  *	@val: value to write
  *
- *	Write @val to SCR register @reg of @ap.  This function is
+ *	Write @val to SCR register @reg of @link.  This function is
  *	guaranteed to succeed if the cable type of the port is SATA
  *	and the port implements ->scr_read.
  *
@@ -4786,9 +4793,11 @@ int ata_scr_read(struct ata_port *ap, in
  *	RETURNS:
  *	0 on success, negative errno on failure.
  */
-int ata_scr_write(struct ata_port *ap, int reg, u32 val)
+int ata_scr_write(struct ata_link *link, int reg, u32 val)
 {
-	if (ata_scr_valid(ap)) {
+	struct ata_port *ap = link->ap;
+
+	if (ata_scr_valid(link)) {
 		ap->ops->scr_write(ap, reg, val);
 		return 0;
 	}
@@ -4797,7 +4806,7 @@ int ata_scr_write(struct ata_port *ap, i
 
 /**
  *	ata_scr_write_flush - write SCR register of the specified port and flush
- *	@ap: ATA port to write SCR for
+ *	@link: ATA link to write SCR for
  *	@reg: SCR to write
  *	@val: value to write
  *
@@ -4810,9 +4819,11 @@ int ata_scr_write(struct ata_port *ap, i
  *	RETURNS:
  *	0 on success, negative errno on failure.
  */
-int ata_scr_write_flush(struct ata_port *ap, int reg, u32 val)
+int ata_scr_write_flush(struct ata_link *link, int reg, u32 val)
 {
-	if (ata_scr_valid(ap)) {
+	struct ata_port *ap = link->ap;
+
+	if (ata_scr_valid(link)) {
 		ap->ops->scr_write(ap, reg, val);
 		ap->ops->scr_read(ap, reg);
 		return 0;
@@ -4821,12 +4832,12 @@ int ata_scr_write_flush(struct ata_port 
 }
 
 /**
- *	ata_port_online - test whether the given port is online
- *	@ap: ATA port to test
+ *	ata_link_online - test whether the given link is online
+ *	@link: ATA link to test
  *
- *	Test whether @ap is online.  Note that this function returns 0
- *	if online status of @ap cannot be obtained, so
- *	ata_port_online(ap) != !ata_port_offline(ap).
+ *	Test whether @link is online.  Note that this function returns
+ *	0 if online status of @link cannot be obtained, so
+ *	ata_link_online(link) != !ata_link_offline(link).
  *
  *	LOCKING:
  *	None.
@@ -4834,22 +4845,22 @@ int ata_scr_write_flush(struct ata_port 
  *	RETURNS:
  *	1 if the port online status is available and online.
  */
-int ata_port_online(struct ata_port *ap)
+int ata_link_online(struct ata_link *link)
 {
 	u32 sstatus;
 
-	if (!ata_scr_read(ap, SCR_STATUS, &sstatus) && (sstatus & 0xf) == 0x3)
+	if (!ata_scr_read(link, SCR_STATUS, &sstatus) && (sstatus & 0xf) == 0x3)
 		return 1;
 	return 0;
 }
 
 /**
- *	ata_port_offline - test whether the given port is offline
- *	@ap: ATA port to test
+ *	ata_link_offline - test whether the given link is offline
+ *	@link: ATA link to test
  *
- *	Test whether @ap is offline.  Note that this function returns
- *	0 if offline status of @ap cannot be obtained, so
- *	ata_port_online(ap) != !ata_port_offline(ap).
+ *	Test whether @link is offline.  Note that this function returns
+ *	0 if offline status of @link cannot be obtained, so
+ *	ata_link_online(link) != !ata_link_offline(link).
  *
  *	LOCKING:
  *	None.
@@ -4857,11 +4868,11 @@ int ata_port_online(struct ata_port *ap)
  *	RETURNS:
  *	1 if the port offline status is available and offline.
  */
-int ata_port_offline(struct ata_port *ap)
+int ata_link_offline(struct ata_link *link)
 {
 	u32 sstatus;
 
-	if (!ata_scr_read(ap, SCR_STATUS, &sstatus) && (sstatus & 0xf) != 0x3)
+	if (!ata_scr_read(link, SCR_STATUS, &sstatus) && (sstatus & 0xf) != 0x3)
 		return 1;
 	return 0;
 }
@@ -5296,7 +5307,7 @@ int ata_device_add(const struct ata_prob
 		ap = host_set->ports[i];
 
 		/* init sata_spd_limit to the current value */
-		if (ata_scr_read(ap, SCR_CONTROL, &scontrol) == 0) {
+		if (ata_scr_read(&ap->link, SCR_CONTROL, &scontrol) == 0) {
 			int spd = (scontrol >> 4) & 0xf;
 			ap->link.hw_sata_spd_limit &= (1 << spd) - 1;
 		}
@@ -5748,8 +5759,8 @@ EXPORT_SYMBOL_GPL(ata_set_sata_spd);
 EXPORT_SYMBOL_GPL(sata_phy_reset);
 EXPORT_SYMBOL_GPL(__sata_phy_reset);
 EXPORT_SYMBOL_GPL(ata_bus_reset);
-EXPORT_SYMBOL_GPL(sata_phy_debounce);
-EXPORT_SYMBOL_GPL(sata_phy_resume);
+EXPORT_SYMBOL_GPL(sata_link_debounce);
+EXPORT_SYMBOL_GPL(sata_link_resume);
 EXPORT_SYMBOL_GPL(ata_std_prereset);
 EXPORT_SYMBOL_GPL(ata_std_softreset);
 EXPORT_SYMBOL_GPL(sata_std_hardreset);
@@ -5773,8 +5784,8 @@ EXPORT_SYMBOL_GPL(ata_scr_valid);
 EXPORT_SYMBOL_GPL(ata_scr_read);
 EXPORT_SYMBOL_GPL(ata_scr_write);
 EXPORT_SYMBOL_GPL(ata_scr_write_flush);
-EXPORT_SYMBOL_GPL(ata_port_online);
-EXPORT_SYMBOL_GPL(ata_port_offline);
+EXPORT_SYMBOL_GPL(ata_link_online);
+EXPORT_SYMBOL_GPL(ata_link_offline);
 EXPORT_SYMBOL_GPL(ata_id_string);
 EXPORT_SYMBOL_GPL(ata_id_c_string);
 EXPORT_SYMBOL_GPL(ata_scsi_simulate);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 4026886..7ade712 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1154,7 +1154,7 @@ static int ata_eh_speed_down(struct ata_
 		return 0;
 
 	/* speed down SATA link speed if possible */
-	if (ata_down_sata_spd_limit(dev->link->ap) == 0)
+	if (ata_down_sata_spd_limit(dev->link) == 0)
 		return ATA_EH_HARDRESET;
 
 	/* lower transfer mode */
@@ -1179,7 +1179,8 @@ static int ata_eh_speed_down(struct ata_
  */
 static void ata_eh_autopsy(struct ata_port *ap)
 {
-	struct ata_eh_context *ehc = &ap->link.eh_context;
+	struct ata_link *link = &ap->link;
+	struct ata_eh_context *ehc = &link->eh_context;
 	unsigned int action = ehc->i.action;
 	struct ata_device *failed_dev = NULL;
 	unsigned int all_err_mask = 0;
@@ -1190,7 +1191,7 @@ static void ata_eh_autopsy(struct ata_po
 	DPRINTK("ENTER\n");
 
 	/* obtain and analyze SError */
-	rc = ata_scr_read(ap, SCR_ERROR, &serror);
+	rc = ata_scr_read(link, SCR_ERROR, &serror);
 	if (rc == 0) {
 		ehc->i.serror |= serror;
 		ata_eh_analyze_serror(ap);
@@ -1368,7 +1369,8 @@ static int ata_eh_reset(struct ata_port 
 			ata_prereset_fn_t prereset, ata_reset_fn_t softreset,
 			ata_reset_fn_t hardreset, ata_postreset_fn_t postreset)
 {
-	struct ata_eh_context *ehc = &ap->link.eh_context;
+	struct ata_link *link = &ap->link;
+	struct ata_eh_context *ehc = &link->eh_context;
 	unsigned int *classes = ehc->classes;
 	int tries = ATA_EH_RESET_TRIES;
 	int verbose = !(ap->flags & ATA_FLAG_LOADING);
@@ -1382,7 +1384,7 @@ static int ata_eh_reset(struct ata_port 
 	 */
 	action = ehc->i.action;
 	ehc->i.action &= ~ATA_EH_RESET_MASK;
-	if (softreset && (!hardreset || (!ata_set_sata_spd_needed(ap) &&
+	if (softreset && (!hardreset || (!ata_set_sata_spd_needed(link) &&
 					 !(action & ATA_EH_HARDRESET)))) {
 		ehc->i.action |= ATA_EH_SOFTRESET;
 		reset = softreset;
@@ -1399,7 +1401,7 @@ static int ata_eh_reset(struct ata_port 
 		 */
 		if (rc == -ENODEV) {
 			struct ata_device *dev;
-			ata_link_for_each_dev(dev, &ap->link)
+			ata_link_for_each_dev(dev, link)
 				classes[dev->devno] = ATA_DEV_NONE;
 			return 0;
 		}
@@ -1464,7 +1466,7 @@ static int ata_eh_reset(struct ata_port 
 		ssleep(5);
 
 		if (reset == hardreset)
-			ata_down_sata_spd_limit(ap);
+			ata_down_sata_spd_limit(link);
 		if (hardreset)
 			reset = hardreset;
 		goto retry;
@@ -1496,7 +1498,7 @@ static int ata_eh_revalidate_and_attach(
 	ata_link_for_each_dev(dev, &ap->link) {
 		if (ehc->i.action & ATA_EH_REVALIDATE && ata_dev_enabled(dev) &&
 		    (!ehc->i.dev || ehc->i.dev == dev)) {
-			if (ata_port_offline(ap)) {
+			if (ata_link_offline(dev->link)) {
 				rc = -EIO;
 				break;
 			}
@@ -1675,7 +1677,7 @@ static int ata_eh_recover(struct ata_por
 		ehc->tries[dev->devno] = 0;
 		break;
 	case -EIO:
-		ata_down_sata_spd_limit(ap);
+		ata_down_sata_spd_limit(&ap->link);
 	default:
 		ehc->tries[dev->devno]--;
 		if (down_xfermask &&
@@ -1688,7 +1690,7 @@ static int ata_eh_recover(struct ata_por
 		ata_dev_disable(dev);
 
 		/* detach if offline */
-		if (ata_port_offline(ap))
+		if (ata_link_offline(&ap->link))
 			ata_eh_detach_dev(dev);
 
 		/* probe if requested */
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index aee6552..bd2e399 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -53,8 +53,8 @@ extern unsigned ata_exec_internal(struct
 extern int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 			   int post_reset, u16 *id);
 extern int ata_dev_configure(struct ata_device *dev, int print_info);
-extern int ata_down_sata_spd_limit(struct ata_port *ap);
-extern int ata_set_sata_spd_needed(struct ata_port *ap);
+extern int ata_down_sata_spd_limit(struct ata_link *link);
+extern int ata_set_sata_spd_needed(struct ata_link *link);
 extern int ata_down_xfermask_limit(struct ata_device *dev, int force_pio0);
 extern int ata_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index af4b1f8..1979fee 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -1310,8 +1310,8 @@ static void mv_err_intr(struct ata_port 
 	edma_err_cause = readl(port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
 
 	if (EDMA_ERR_SERR & edma_err_cause) {
-		ata_scr_read(ap, SCR_ERROR, &serr);
-		ata_scr_write_flush(ap, SCR_ERROR, serr);
+		ata_scr_read(&ap->link, SCR_ERROR, &serr);
+		ata_scr_write_flush(&ap->link, SCR_ERROR, serr);
 	}
 	if (EDMA_ERR_SELF_DIS & edma_err_cause) {
 		struct mv_port_priv *pp	= ap->private_data;
@@ -1935,15 +1935,15 @@ static void __mv_phy_reset(struct ata_po
 
 	/* Issue COMRESET via SControl */
 comreset_retry:
-	ata_scr_write_flush(ap, SCR_CONTROL, 0x301);
+	ata_scr_write_flush(&ap->link, SCR_CONTROL, 0x301);
 	__msleep(1, can_sleep);
 
-	ata_scr_write_flush(ap, SCR_CONTROL, 0x300);
+	ata_scr_write_flush(&ap->link, SCR_CONTROL, 0x300);
 	__msleep(20, can_sleep);
 
 	timeout = jiffies + msecs_to_jiffies(200);
 	do {
-		ata_scr_read(ap, SCR_STATUS, &sstatus);
+		ata_scr_read(&ap->link, SCR_STATUS, &sstatus);
 		sstatus &= 0x3;
 		if ((sstatus == 3) || (sstatus == 0))
 			break;
@@ -1961,10 +1961,10 @@ comreset_retry:
 		"SCtrl 0x%08x\n", mv_scr_read(ap, SCR_STATUS),
 		mv_scr_read(ap, SCR_ERROR), mv_scr_read(ap, SCR_CONTROL));
 
-	if (ata_port_online(ap)) {
+	if (ata_link_online(&ap->link)) {
 		ata_port_probe(ap);
 	} else {
-		ata_scr_read(ap, SCR_STATUS, &sstatus);
+		ata_scr_read(&ap->link, SCR_STATUS, &sstatus);
 		ata_port_printk(ap, KERN_INFO,
 				"no device found (phy stat %08x)\n", sstatus);
 		ata_port_disable(ap);
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 6e0b74b..51fceac 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -521,7 +521,7 @@ static int sil24_softreset(struct ata_po
 
 	DPRINTK("ENTER\n");
 
-	if (ata_port_offline(ap)) {
+	if (ata_link_offline(&ap->link)) {
 		DPRINTK("PHY reports no device\n");
 		*class = ATA_DEV_NONE;
 		goto out;
@@ -578,10 +578,10 @@ static int sil24_hardreset(struct ata_po
 	u32 tmp;
 
 	/* sil24 does the right thing(tm) without any protection */
-	ata_set_sata_spd(ap);
+	ata_set_sata_spd(&ap->link);
 
 	tout_msec = 100;
-	if (ata_port_online(ap))
+	if (ata_link_online(&ap->link))
 		tout_msec = 5000;
 
 	writel(PORT_CS_DEV_RST, port + PORT_CTRL_STAT);
@@ -591,15 +591,15 @@ static int sil24_hardreset(struct ata_po
 	/* SStatus oscillates between zero and valid status after
 	 * DEV_RST, debounce it.
 	 */
-	rc = sata_phy_debounce(ap, ATA_DEBOUNCE_INTERVAL,
-			       ATA_DEBOUNCE_DURATION, ATA_DEBOUNCE_TIMEOUT);
+	rc = sata_link_debounce(&ap->link, ATA_DEBOUNCE_INTERVAL,
+				ATA_DEBOUNCE_DURATION, ATA_DEBOUNCE_TIMEOUT);
 	if (rc) {
 		reason = "PHY debouncing failed";
 		goto err;
 	}
 
 	if (tmp & PORT_CS_DEV_RST) {
-		if (ata_port_offline(ap))
+		if (ata_link_offline(&ap->link))
 			return 0;
 		reason = "link not ready";
 		goto err;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index c7c904f..67a9054 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -616,11 +616,12 @@ extern void ata_port_probe(struct ata_po
 extern void __sata_phy_reset(struct ata_port *ap);
 extern void sata_phy_reset(struct ata_port *ap);
 extern void ata_bus_reset(struct ata_port *ap);
-extern int ata_set_sata_spd(struct ata_port *ap);
-extern int sata_phy_debounce(struct ata_port *ap, unsigned long interval_msec,
-			     unsigned long duration_msec,
-			     unsigned long timeout_msec);
-extern int sata_phy_resume(struct ata_port *ap, int quick);
+extern int ata_set_sata_spd(struct ata_link *link);
+extern int sata_link_debounce(struct ata_link *link,
+			      unsigned long interval_msec,
+			      unsigned long duration_msec,
+			      unsigned long timeout_msec);
+extern int sata_link_resume(struct ata_link *link, int quick);
 extern int ata_std_prereset(struct ata_port *ap);
 extern int ata_std_softreset(struct ata_port *ap, unsigned int *classes);
 extern int sata_std_hardreset(struct ata_port *ap, unsigned int *class);
@@ -644,12 +645,12 @@ extern int ata_scsi_ioctl(struct scsi_de
 extern int ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *));
 extern int ata_scsi_release(struct Scsi_Host *host);
 extern unsigned int ata_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
-extern int ata_scr_valid(struct ata_port *ap);
-extern int ata_scr_read(struct ata_port *ap, int reg, u32 *val);
-extern int ata_scr_write(struct ata_port *ap, int reg, u32 val);
-extern int ata_scr_write_flush(struct ata_port *ap, int reg, u32 val);
-extern int ata_port_online(struct ata_port *ap);
-extern int ata_port_offline(struct ata_port *ap);
+extern int ata_scr_valid(struct ata_link *link);
+extern int ata_scr_read(struct ata_link *link, int reg, u32 *val);
+extern int ata_scr_write(struct ata_link *link, int reg, u32 val);
+extern int ata_scr_write_flush(struct ata_link *link, int reg, u32 val);
+extern int ata_link_online(struct ata_link *link);
+extern int ata_link_offline(struct ata_link *link);
 extern int ata_scsi_device_resume(struct scsi_device *);
 extern int ata_scsi_device_suspend(struct scsi_device *, pm_message_t state);
 extern int ata_device_resume(struct ata_device *);
-- 
1.2.4


