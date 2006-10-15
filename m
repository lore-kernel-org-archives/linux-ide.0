From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 6/18] [PATCH] libata-link: linkify PHY-related functions
Date: Mon, 16 Oct 2006 07:54:40 +0900
Message-ID: <11609528802350-git-send-email-htejun@gmail.com>
References: <1160952879581-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:63863 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422930AbWJOWyx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Oct 2006 18:54:53 -0400
Received: by py-out-1112.google.com with SMTP id n25so2072152pyg
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 15:54:53 -0700 (PDT)
In-Reply-To: <1160952879581-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make the following PHY-related functions to deal with ata_link instead
of ata_port.

* sata_print_link_status()
* sata_down_spd_limit()
* ata_set_sata_spd_limit() and friends
* sata_link_debounce/resume()
* sata_scr_valid/read/write/write_flush()
* ata_link_on/offline()

This patch introduces no behavior change.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c        |    6 +
 drivers/ata/libata-core.c |  231 ++++++++++++++++++++++++---------------------
 drivers/ata/libata-eh.c   |   24 +++--
 drivers/ata/libata-sff.c  |    2 
 drivers/ata/libata.h      |    4 -
 drivers/ata/sata_mv.c     |   14 +--
 drivers/ata/sata_sil24.c  |   10 +-
 include/linux/libata.h    |   19 ++--
 8 files changed, 166 insertions(+), 144 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 1494c04..2888144 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -747,7 +747,7 @@ static int ahci_softreset(struct ata_por
 
 	DPRINTK("ENTER\n");
 
-	if (ata_port_offline(ap)) {
+	if (ata_link_offline(&ap->link)) {
 		DPRINTK("PHY reports no device\n");
 		*class = ATA_DEV_NONE;
 		return 0;
@@ -820,7 +820,7 @@ static int ahci_softreset(struct ata_por
 	msleep(150);
 
 	*class = ATA_DEV_NONE;
-	if (ata_port_online(ap)) {
+	if (ata_link_online(&ap->link)) {
 		if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
 			rc = -EIO;
 			reason = "device not ready";
@@ -861,7 +861,7 @@ static int ahci_hardreset(struct ata_por
 
 	ahci_start_engine(port_mmio);
 
-	if (rc == 0 && ata_port_online(ap))
+	if (rc == 0 && ata_link_online(&ap->link))
 		*class = ahci_dev_classify(ap);
 	if (*class == ATA_DEV_UNKNOWN)
 		*class = ATA_DEV_NONE;
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 580317c..4f75d41 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1661,7 +1661,7 @@ int ata_bus_probe(struct ata_port *ap)
 		tries[dev->devno] = 0;
 		break;
 	case -EIO:
-		sata_down_spd_limit(ap);
+		sata_down_spd_limit(&ap->link);
 		/* fall through */
 	default:
 		tries[dev->devno]--;
@@ -1696,28 +1696,28 @@ void ata_port_probe(struct ata_port *ap)
 
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
 
-	if (sata_scr_read(ap, SCR_STATUS, &sstatus))
+	if (sata_scr_read(link, SCR_STATUS, &sstatus))
 		return;
-	sata_scr_read(ap, SCR_CONTROL, &scontrol);
+	sata_scr_read(link, SCR_CONTROL, &scontrol);
 
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
@@ -1737,32 +1737,33 @@ static void sata_print_link_status(struc
  */
 void __sata_phy_reset(struct ata_port *ap)
 {
-	u32 sstatus;
+	struct ata_link *link = &ap->link;
 	unsigned long timeout = jiffies + (HZ * 5);
+	u32 sstatus;
 
 	if (ap->flags & ATA_FLAG_SATA_RESET) {
 		/* issue phy wake/reset */
-		sata_scr_write_flush(ap, SCR_CONTROL, 0x301);
+		sata_scr_write_flush(link, SCR_CONTROL, 0x301);
 		/* Couldn't find anything in SATA I/II specs, but
 		 * AHCI-1.1 10.4.2 says at least 1 ms. */
 		mdelay(1);
 	}
 	/* phy wake/clear reset */
-	sata_scr_write_flush(ap, SCR_CONTROL, 0x300);
+	sata_scr_write_flush(link, SCR_CONTROL, 0x300);
 
 	/* wait for phy to become ready, if necessary */
 	do {
 		msleep(200);
-		sata_scr_read(ap, SCR_STATUS, &sstatus);
+		sata_scr_read(link, SCR_STATUS, &sstatus);
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
@@ -1836,9 +1837,9 @@ void ata_port_disable(struct ata_port *a
 
 /**
  *	sata_down_spd_limit - adjust SATA spd limit downward
- *	@ap: Port to adjust SATA spd limit for
+ *	@link: Link to adjust SATA spd limit for
  *
- *	Adjust SATA spd limit of @ap downward.  Note that this
+ *	Adjust SATA spd limit of @link downward.  Note that this
  *	function only adjusts the limit.  The change must be applied
  *	using sata_set_spd().
  *
@@ -1848,16 +1849,16 @@ void ata_port_disable(struct ata_port *a
  *	RETURNS:
  *	0 on success, negative errno on failure
  */
-int sata_down_spd_limit(struct ata_port *ap)
+int sata_down_spd_limit(struct ata_link *link)
 {
 	u32 sstatus, spd, mask;
 	int rc, highbit;
 
-	rc = sata_scr_read(ap, SCR_STATUS, &sstatus);
+	rc = sata_scr_read(link, SCR_STATUS, &sstatus);
 	if (rc)
 		return rc;
 
-	mask = ap->link.sata_spd_limit;
+	mask = link->sata_spd_limit;
 	if (mask <= 1)
 		return -EINVAL;
 	highbit = fls(mask) - 1;
@@ -1871,22 +1872,22 @@ int sata_down_spd_limit(struct ata_port 
 	if (!mask)
 		return -EINVAL;
 
-	ap->link.sata_spd_limit = mask;
+	link->sata_spd_limit = mask;
 
-	ata_port_printk(ap, KERN_WARNING, "limiting SATA link speed to %s\n",
+	ata_link_printk(link, KERN_WARNING, "limiting SATA link speed to %s\n",
 			sata_spd_string(fls(mask)));
 
 	return 0;
 }
 
-static int __sata_set_spd_needed(struct ata_port *ap, u32 *scontrol)
+static int __sata_set_spd_needed(struct ata_link *link, u32 *scontrol)
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
@@ -1896,10 +1897,10 @@ static int __sata_set_spd_needed(struct 
 
 /**
  *	sata_set_spd_needed - is SATA spd configuration needed
- *	@ap: Port in question
+ *	@link: Link in question
  *
  *	Test whether the spd limit in SControl matches
- *	@ap->link.sata_spd_limit.  This function is used to determine
+ *	@link->sata_spd_limit.  This function is used to determine
  *	whether hardreset is necessary to apply SATA spd
  *	configuration.
  *
@@ -1909,21 +1910,21 @@ static int __sata_set_spd_needed(struct 
  *	RETURNS:
  *	1 if SATA spd configuration is needed, 0 otherwise.
  */
-int sata_set_spd_needed(struct ata_port *ap)
+int sata_set_spd_needed(struct ata_link *link)
 {
 	u32 scontrol;
 
-	if (sata_scr_read(ap, SCR_CONTROL, &scontrol))
+	if (sata_scr_read(link, SCR_CONTROL, &scontrol))
 		return 0;
 
-	return __sata_set_spd_needed(ap, &scontrol);
+	return __sata_set_spd_needed(link, &scontrol);
 }
 
 /**
  *	sata_set_spd - set SATA spd according to spd limit
- *	@ap: Port to set SATA spd for
+ *	@link: Link to set SATA spd for
  *
- *	Set SATA spd of @ap according to sata_spd_limit.
+ *	Set SATA spd of @link according to sata_spd_limit.
  *
  *	LOCKING:
  *	Inherited from caller.
@@ -1932,18 +1933,18 @@ int sata_set_spd_needed(struct ata_port 
  *	0 if spd doesn't need to be changed, 1 if spd has been
  *	changed.  Negative errno if SCR registers are inaccessible.
  */
-int sata_set_spd(struct ata_port *ap)
+int sata_set_spd(struct ata_link *link)
 {
 	u32 scontrol;
 	int rc;
 
-	if ((rc = sata_scr_read(ap, SCR_CONTROL, &scontrol)))
+	if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
 		return rc;
 
-	if (!__sata_set_spd_needed(ap, &scontrol))
+	if (!__sata_set_spd_needed(link, &scontrol))
 		return 0;
 
-	if ((rc = sata_scr_write(ap, SCR_CONTROL, scontrol)))
+	if ((rc = sata_scr_write(link, SCR_CONTROL, scontrol)))
 		return rc;
 
 	return 1;
@@ -2543,11 +2544,11 @@ err_out:
 }
 
 /**
- *	sata_phy_debounce - debounce SATA phy status
- *	@ap: ATA port to debounce SATA phy status for
+ *	sata_link_debounce - debounce SATA phy status
+ *	@link: ATA link to debounce SATA phy status for
  *	@params: timing parameters { interval, duratinon, timeout } in msec
  *
- *	Make sure SStatus of @ap reaches stable state, determined by
+ *	Make sure SStatus of @link reaches stable state, determined by
  *	holding the same value where DET is not 1 for @duration polled
  *	every @interval, before @timeout.  Timeout constraints the
  *	beginning of the stable state.  Because, after hot unplugging,
@@ -2560,7 +2561,7 @@ err_out:
  *	RETURNS:
  *	0 on success, -errno on failure.
  */
-int sata_phy_debounce(struct ata_port *ap, const unsigned long *params)
+int sata_link_debounce(struct ata_link *link, const unsigned long *params)
 {
 	unsigned long interval_msec = params[0];
 	unsigned long duration = params[1] * HZ / 1000;
@@ -2569,7 +2570,7 @@ int sata_phy_debounce(struct ata_port *a
 	u32 last, cur;
 	int rc;
 
-	if ((rc = sata_scr_read(ap, SCR_STATUS, &cur)))
+	if ((rc = sata_scr_read(link, SCR_STATUS, &cur)))
 		return rc;
 	cur &= 0xf;
 
@@ -2578,7 +2579,7 @@ int sata_phy_debounce(struct ata_port *a
 
 	while (1) {
 		msleep(interval_msec);
-		if ((rc = sata_scr_read(ap, SCR_STATUS, &cur)))
+		if ((rc = sata_scr_read(link, SCR_STATUS, &cur)))
 			return rc;
 		cur &= 0xf;
 
@@ -2602,11 +2603,11 @@ int sata_phy_debounce(struct ata_port *a
 }
 
 /**
- *	sata_phy_resume - resume SATA phy
- *	@ap: ATA port to resume SATA phy for
+ *	sata_link_resume - resume SATA link
+ *	@link: ATA link to resume SATA
  *	@params: timing parameters { interval, duratinon, timeout } in msec
  *
- *	Resume SATA phy of @ap and debounce it.
+ *	Resume SATA phy @link and debounce it.
  *
  *	LOCKING:
  *	Kernel thread context (may sleep)
@@ -2614,17 +2615,17 @@ int sata_phy_debounce(struct ata_port *a
  *	RETURNS:
  *	0 on success, -errno on failure.
  */
-int sata_phy_resume(struct ata_port *ap, const unsigned long *params)
+int sata_link_resume(struct ata_link *link, const unsigned long *params)
 {
 	u32 scontrol;
 	int rc;
 
-	if ((rc = sata_scr_read(ap, SCR_CONTROL, &scontrol)))
+	if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
 		return rc;
 
 	scontrol = (scontrol & 0x0f0) | 0x300;
 
-	if ((rc = sata_scr_write(ap, SCR_CONTROL, scontrol)))
+	if ((rc = sata_scr_write(link, SCR_CONTROL, scontrol)))
 		return rc;
 
 	/* Some PHYs react badly if SStatus is pounded immediately
@@ -2632,7 +2633,7 @@ int sata_phy_resume(struct ata_port *ap,
 	 */
 	msleep(200);
 
-	return sata_phy_debounce(ap, params);
+	return sata_link_debounce(link, params);
 }
 
 static void ata_wait_spinup(struct ata_port *ap)
@@ -2643,10 +2644,11 @@ static void ata_wait_spinup(struct ata_p
 
 	/* first, debounce phy if SATA */
 	if (ap->cbl == ATA_CBL_SATA) {
-		rc = sata_phy_debounce(ap, sata_deb_timing_hotplug);
+		rc = sata_link_debounce(&ap->link, sata_deb_timing_hotplug);
 
 		/* if debounced successfully and offline, no need to wait */
-		if ((rc == 0 || rc == -EOPNOTSUPP) && ata_port_offline(ap))
+		if ((rc == 0 || rc == -EOPNOTSUPP) &&
+		    ata_link_offline(&ap->link))
 			return;
 	}
 
@@ -2678,7 +2680,8 @@ static void ata_wait_spinup(struct ata_p
  */
 int ata_std_prereset(struct ata_port *ap)
 {
-	struct ata_eh_context *ehc = &ap->link.eh_context;
+	struct ata_link *link = &ap->link;
+	struct ata_eh_context *ehc = &link->eh_context;
 	const unsigned long *timing = sata_ehc_deb_timing(ehc);
 	int rc;
 
@@ -2695,9 +2698,9 @@ int ata_std_prereset(struct ata_port *ap
 	if (ehc->i.action & ATA_EH_HARDRESET)
 		return 0;
 
-	/* if SATA, resume phy */
+	/* if SATA, resume link */
 	if (ap->cbl == ATA_CBL_SATA) {
-		rc = sata_phy_resume(ap, timing);
+		rc = sata_link_resume(link, timing);
 		if (rc && rc != -EOPNOTSUPP) {
 			/* phy resume failed */
 			ata_port_printk(ap, KERN_WARNING, "failed to resume "
@@ -2709,7 +2712,7 @@ int ata_std_prereset(struct ata_port *ap
 	/* Wait for !BSY if the controller can wait for the first D2H
 	 * Reg FIS and we don't know that no device is attached.
 	 */
-	if (!(ap->flags & ATA_FLAG_SKIP_D2H_BSY) && !ata_port_offline(ap))
+	if (!(ap->flags & ATA_FLAG_SKIP_D2H_BSY) && !ata_link_offline(link))
 		ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
 
 	return 0;
@@ -2730,13 +2733,14 @@ int ata_std_prereset(struct ata_port *ap
  */
 int ata_std_softreset(struct ata_port *ap, unsigned int *classes)
 {
+	struct ata_link *link = &ap->link;
 	unsigned int slave_possible = ap->flags & ATA_FLAG_SLAVE_POSS;
 	unsigned int devmask = 0, err_mask;
 	u8 err;
 
 	DPRINTK("ENTER\n");
 
-	if (ata_port_offline(ap)) {
+	if (ata_link_offline(link)) {
 		classes[0] = ATA_DEV_NONE;
 		goto out;
 	}
@@ -2784,35 +2788,36 @@ int ata_std_softreset(struct ata_port *a
  */
 int sata_port_hardreset(struct ata_port *ap, const unsigned long *timing)
 {
+	struct ata_link *link = &ap->link;
 	u32 scontrol;
 	int rc;
 
 	DPRINTK("ENTER\n");
 
-	if (sata_set_spd_needed(ap)) {
+	if (sata_set_spd_needed(link)) {
 		/* SATA spec says nothing about how to reconfigure
 		 * spd.  To be on the safe side, turn off phy during
 		 * reconfiguration.  This works for at least ICH7 AHCI
 		 * and Sil3124.
 		 */
-		if ((rc = sata_scr_read(ap, SCR_CONTROL, &scontrol)))
+		if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
 			goto out;
 
 		scontrol = (scontrol & 0x0f0) | 0x304;
 
-		if ((rc = sata_scr_write(ap, SCR_CONTROL, scontrol)))
+		if ((rc = sata_scr_write(link, SCR_CONTROL, scontrol)))
 			goto out;
 
-		sata_set_spd(ap);
+		sata_set_spd(link);
 	}
 
 	/* issue phy wake/reset */
-	if ((rc = sata_scr_read(ap, SCR_CONTROL, &scontrol)))
+	if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
 		goto out;
 
 	scontrol = (scontrol & 0x0f0) | 0x301;
 
-	if ((rc = sata_scr_write_flush(ap, SCR_CONTROL, scontrol)))
+	if ((rc = sata_scr_write_flush(link, SCR_CONTROL, scontrol)))
 		goto out;
 
 	/* Couldn't find anything in SATA I/II specs, but AHCI-1.1
@@ -2820,8 +2825,8 @@ int sata_port_hardreset(struct ata_port 
 	 */
 	msleep(1);
 
-	/* bring phy back */
-	rc = sata_phy_resume(ap, timing);
+	/* bring link back */
+	rc = sata_link_resume(link, timing);
  out:
 	DPRINTK("EXIT, rc=%d\n", rc);
 	return rc;
@@ -2843,7 +2848,8 @@ int sata_port_hardreset(struct ata_port 
  */
 int sata_std_hardreset(struct ata_port *ap, unsigned int *class)
 {
-	const unsigned long *timing = sata_ehc_deb_timing(&ap->link.eh_context);
+	struct ata_link *link = &ap->link;
+	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
 	int rc;
 
 	DPRINTK("ENTER\n");
@@ -2857,7 +2863,7 @@ int sata_std_hardreset(struct ata_port *
 	}
 
 	/* TODO: phy layer with polling, timeouts, etc. */
-	if (ata_port_offline(ap)) {
+	if (ata_link_offline(link)) {
 		*class = ATA_DEV_NONE;
 		DPRINTK("EXIT, link offline\n");
 		return 0;
@@ -2891,16 +2897,17 @@ int sata_std_hardreset(struct ata_port *
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
-	if (sata_scr_read(ap, SCR_ERROR, &serror) == 0)
-		sata_scr_write(ap, SCR_ERROR, serror);
+	if (sata_scr_read(link, SCR_ERROR, &serror) == 0)
+		sata_scr_write(link, SCR_ERROR, serror);
 
 	/* re-enable interrupts */
 	if (!ap->ops->error_handler) {
@@ -2943,12 +2950,13 @@ void ata_std_postreset(struct ata_port *
  */
 void sata_std_hp_poll_activate(struct ata_port *ap)
 {
+	struct ata_link *link = &ap->link;
 	u32 serror;
 
-	sata_scr_read(ap, SCR_ERROR, &serror);
+	sata_scr_read(link, SCR_ERROR, &serror);
 	serror &= SERR_PHYRDY_CHG | SERR_DEV_XCHG;
 	if (serror)
-		sata_scr_write(ap, SCR_ERROR, serror);
+		sata_scr_write(link, SCR_ERROR, serror);
 
 	ap->hp_poll_data = 0;
 }
@@ -2970,10 +2978,11 @@ void sata_std_hp_poll_activate(struct at
 int sata_std_hp_poll(struct ata_port *ap)
 {
 	unsigned long state = (unsigned long)ap->hp_poll_data;
+	struct ata_link *link = &ap->link;
 	u32 serror;
 	int rc = 0;
 
-	sata_scr_read(ap, SCR_ERROR, &serror);
+	sata_scr_read(link, SCR_ERROR, &serror);
 	serror &= SERR_PHYRDY_CHG | SERR_DEV_XCHG;
 
 	switch (state) {
@@ -2984,7 +2993,7 @@ int sata_std_hp_poll(struct ata_port *ap
 			 * hotplug event till hotplug event stays
 			 * quiescent for one full polling interval.
 			 */
-			sata_scr_write(ap, SCR_ERROR, serror);
+			sata_scr_write(link, SCR_ERROR, serror);
 			state = 1;
 		}
 		break;
@@ -2993,7 +3002,7 @@ int sata_std_hp_poll(struct ata_port *ap
 		if (!serror)
 			rc = 1;
 		else
-			sata_scr_write(ap, SCR_ERROR, serror);
+			sata_scr_write(link, SCR_ERROR, serror);
 		break;
 	}
 
@@ -5008,9 +5017,9 @@ irqreturn_t ata_interrupt (int irq, void
 
 /**
  *	sata_scr_valid - test whether SCRs are accessible
- *	@ap: ATA port to test SCR accessibility for
+ *	@link: ATA link to test SCR accessibility for
  *
- *	Test whether SCRs are accessible for @ap.
+ *	Test whether SCRs are accessible for @link.
  *
  *	LOCKING:
  *	None.
@@ -5018,18 +5027,20 @@ irqreturn_t ata_interrupt (int irq, void
  *	RETURNS:
  *	1 if SCRs are accessible, 0 otherwise.
  */
-int sata_scr_valid(struct ata_port *ap)
+int sata_scr_valid(struct ata_link *link)
 {
+	struct ata_port *ap = link->ap;
+
 	return ap->cbl == ATA_CBL_SATA && ap->ops->scr_read;
 }
 
 /**
  *	sata_scr_read - read SCR register of the specified port
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
@@ -5039,9 +5050,11 @@ int sata_scr_valid(struct ata_port *ap)
  *	RETURNS:
  *	0 on success, negative errno on failure.
  */
-int sata_scr_read(struct ata_port *ap, int reg, u32 *val)
+int sata_scr_read(struct ata_link *link, int reg, u32 *val)
 {
-	if (sata_scr_valid(ap)) {
+	struct ata_port *ap = link->ap;
+
+	if (sata_scr_valid(link)) {
 		*val = ap->ops->scr_read(ap, reg);
 		return 0;
 	}
@@ -5050,11 +5063,11 @@ int sata_scr_read(struct ata_port *ap, i
 
 /**
  *	sata_scr_write - write SCR register of the specified port
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
@@ -5064,9 +5077,11 @@ int sata_scr_read(struct ata_port *ap, i
  *	RETURNS:
  *	0 on success, negative errno on failure.
  */
-int sata_scr_write(struct ata_port *ap, int reg, u32 val)
+int sata_scr_write(struct ata_link *link, int reg, u32 val)
 {
-	if (sata_scr_valid(ap)) {
+	struct ata_port *ap = link->ap;
+
+	if (sata_scr_valid(link)) {
 		ap->ops->scr_write(ap, reg, val);
 		return 0;
 	}
@@ -5075,7 +5090,7 @@ int sata_scr_write(struct ata_port *ap, 
 
 /**
  *	sata_scr_write_flush - write SCR register of the specified port and flush
- *	@ap: ATA port to write SCR for
+ *	@link: ATA link to write SCR for
  *	@reg: SCR to write
  *	@val: value to write
  *
@@ -5088,9 +5103,11 @@ int sata_scr_write(struct ata_port *ap, 
  *	RETURNS:
  *	0 on success, negative errno on failure.
  */
-int sata_scr_write_flush(struct ata_port *ap, int reg, u32 val)
+int sata_scr_write_flush(struct ata_link *link, int reg, u32 val)
 {
-	if (sata_scr_valid(ap)) {
+	struct ata_port *ap = link->ap;
+
+	if (sata_scr_valid(link)) {
 		ap->ops->scr_write(ap, reg, val);
 		ap->ops->scr_read(ap, reg);
 		return 0;
@@ -5099,12 +5116,12 @@ int sata_scr_write_flush(struct ata_port
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
@@ -5112,22 +5129,23 @@ int sata_scr_write_flush(struct ata_port
  *	RETURNS:
  *	1 if the port online status is available and online.
  */
-int ata_port_online(struct ata_port *ap)
+int ata_link_online(struct ata_link *link)
 {
 	u32 sstatus;
 
-	if (!sata_scr_read(ap, SCR_STATUS, &sstatus) && (sstatus & 0xf) == 0x3)
+	if (sata_scr_read(link, SCR_STATUS, &sstatus) == 0 &&
+	    (sstatus & 0xf) == 0x3)
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
+ *	Test whether @link is offline.  Note that this function
+ *	returns 0 if offline status of @link cannot be obtained, so
+ *	ata_link_online(link) != !ata_link_offline(link).
  *
  *	LOCKING:
  *	None.
@@ -5135,11 +5153,12 @@ int ata_port_online(struct ata_port *ap)
  *	RETURNS:
  *	1 if the port offline status is available and offline.
  */
-int ata_port_offline(struct ata_port *ap)
+int ata_link_offline(struct ata_link *link)
 {
 	u32 sstatus;
 
-	if (!sata_scr_read(ap, SCR_STATUS, &sstatus) && (sstatus & 0xf) != 0x3)
+	if (sata_scr_read(link, SCR_STATUS, &sstatus) == 0 &&
+	    (sstatus & 0xf) != 0x3)
 		return 1;
 	return 0;
 }
@@ -5664,7 +5683,7 @@ int ata_device_add(const struct ata_prob
 		int rc;
 
 		/* init sata_spd_limit to the current value */
-		if (sata_scr_read(ap, SCR_CONTROL, &scontrol) == 0) {
+		if (sata_scr_read(&ap->link, SCR_CONTROL, &scontrol) == 0) {
 			int spd = (scontrol >> 4) & 0xf;
 			ap->link.hw_sata_spd_limit &= (1 << spd) - 1;
 		}
@@ -6225,8 +6244,8 @@ EXPORT_SYMBOL_GPL(ata_bmdma_error_handle
 EXPORT_SYMBOL_GPL(ata_bmdma_post_internal_cmd);
 EXPORT_SYMBOL_GPL(ata_port_probe);
 EXPORT_SYMBOL_GPL(sata_set_spd);
-EXPORT_SYMBOL_GPL(sata_phy_debounce);
-EXPORT_SYMBOL_GPL(sata_phy_resume);
+EXPORT_SYMBOL_GPL(sata_link_debounce);
+EXPORT_SYMBOL_GPL(sata_link_resume);
 EXPORT_SYMBOL_GPL(sata_phy_reset);
 EXPORT_SYMBOL_GPL(__sata_phy_reset);
 EXPORT_SYMBOL_GPL(ata_bus_reset);
@@ -6256,8 +6275,8 @@ EXPORT_SYMBOL_GPL(sata_scr_valid);
 EXPORT_SYMBOL_GPL(sata_scr_read);
 EXPORT_SYMBOL_GPL(sata_scr_write);
 EXPORT_SYMBOL_GPL(sata_scr_write_flush);
-EXPORT_SYMBOL_GPL(ata_port_online);
-EXPORT_SYMBOL_GPL(ata_port_offline);
+EXPORT_SYMBOL_GPL(ata_link_online);
+EXPORT_SYMBOL_GPL(ata_link_offline);
 EXPORT_SYMBOL_GPL(ata_host_suspend);
 EXPORT_SYMBOL_GPL(ata_host_resume);
 EXPORT_SYMBOL_GPL(ata_id_string);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index bfae7fa..9cf41c4 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1290,7 +1290,7 @@ static int ata_eh_speed_down(struct ata_
 		return 0;
 
 	/* speed down SATA link speed if possible */
-	if (sata_down_spd_limit(dev->link->ap) == 0)
+	if (sata_down_spd_limit(dev->link) == 0)
 		return ATA_EH_HARDRESET;
 
 	/* lower transfer mode */
@@ -1315,7 +1315,8 @@ static int ata_eh_speed_down(struct ata_
  */
 static void ata_eh_autopsy(struct ata_port *ap)
 {
-	struct ata_eh_context *ehc = &ap->link.eh_context;
+	struct ata_link *link = &ap->link;
+	struct ata_eh_context *ehc = &link->eh_context;
 	unsigned int all_err_mask = 0;
 	int tag, is_io = 0;
 	u32 serror;
@@ -1327,7 +1328,7 @@ static void ata_eh_autopsy(struct ata_po
 		return;
 
 	/* obtain and analyze SError */
-	rc = sata_scr_read(ap, SCR_ERROR, &serror);
+	rc = sata_scr_read(link, SCR_ERROR, &serror);
 	if (rc == 0) {
 		ehc->i.serror |= serror;
 		ata_eh_analyze_serror(ap);
@@ -1515,7 +1516,8 @@ static int ata_eh_reset(struct ata_port 
 			ata_prereset_fn_t prereset, ata_reset_fn_t softreset,
 			ata_reset_fn_t hardreset, ata_postreset_fn_t postreset)
 {
-	struct ata_eh_context *ehc = &ap->link.eh_context;
+	struct ata_link *link = &ap->link;
+	struct ata_eh_context *ehc = &link->eh_context;
 	unsigned int *classes = ehc->classes;
 	int tries = ATA_EH_RESET_TRIES;
 	int verbose = !(ehc->i.flags & ATA_EHI_QUIET);
@@ -1532,7 +1534,7 @@ static int ata_eh_reset(struct ata_port 
 	 */
 	action = ehc->i.action;
 	ehc->i.action &= ~ATA_EH_RESET_MASK;
-	if (softreset && (!hardreset || (!sata_set_spd_needed(ap) &&
+	if (softreset && (!hardreset || (!sata_set_spd_needed(link) &&
 					 !(action & ATA_EH_HARDRESET))))
 		ehc->i.action |= ATA_EH_SOFTRESET;
 	else
@@ -1558,7 +1560,7 @@ static int ata_eh_reset(struct ata_port 
 		reset = softreset;
 	else {
 		/* prereset told us not to reset, bang classes and return */
-		ata_link_for_each_dev(dev, &ap->link)
+		ata_link_for_each_dev(dev, link)
 			classes[dev->devno] = ATA_DEV_NONE;
 		return 0;
 	}
@@ -1625,7 +1627,7 @@ static int ata_eh_reset(struct ata_port 
 		ssleep(5);
 
 		if (reset == hardreset)
-			sata_down_spd_limit(ap);
+			sata_down_spd_limit(link);
 		if (hardreset)
 			reset = hardreset;
 		goto retry;
@@ -1635,7 +1637,7 @@ static int ata_eh_reset(struct ata_port 
 		/* After the reset, the device state is PIO 0 and the
 		 * controller state is undefined.  Record the mode.
 		 */
-		ata_link_for_each_dev(dev, &ap->link)
+		ata_link_for_each_dev(dev, link)
 			dev->pio_mode = XFER_PIO_0;
 
 		if (postreset)
@@ -1663,7 +1665,7 @@ static int ata_eh_revalidate_and_attach(
 		unsigned int action = ata_eh_dev_action(dev);
 
 		if (action & ATA_EH_REVALIDATE && ata_dev_ready(dev)) {
-			if (ata_port_offline(ap)) {
+			if (ata_link_offline(dev->link)) {
 				rc = -EIO;
 				break;
 			}
@@ -1920,7 +1922,7 @@ static void ata_eh_handle_dev_fail(struc
 		ehc->tries[dev->devno] = 0;
 		break;
 	case -EIO:
-		sata_down_spd_limit(ap);
+		sata_down_spd_limit(&ap->link);
 	default:
 		ehc->tries[dev->devno]--;
 		if (down_xfermask &&
@@ -1933,7 +1935,7 @@ static void ata_eh_handle_dev_fail(struc
 		ata_dev_disable(dev);
 
 		/* detach if offline */
-		if (ata_port_offline(ap))
+		if (ata_link_offline(&ap->link))
 			ata_eh_detach_dev(dev);
 
 		/* probe if requested */
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 083234c..336805e 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -776,7 +776,7 @@ void ata_bmdma_error_handler(struct ata_
 	ata_reset_fn_t hardreset;
 
 	hardreset = NULL;
-	if (sata_scr_valid(ap))
+	if (sata_scr_valid(&ap->link))
 		hardreset = sata_std_hardreset;
 
 	ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset, hardreset,
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 017dc08..d8e9f4e 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -54,8 +54,8 @@ extern unsigned int ata_do_simple_cmd(st
 extern int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 			   int post_reset, u16 *id);
 extern int ata_dev_configure(struct ata_device *dev, int print_info);
-extern int sata_down_spd_limit(struct ata_port *ap);
-extern int sata_set_spd_needed(struct ata_port *ap);
+extern int sata_down_spd_limit(struct ata_link *link);
+extern int sata_set_spd_needed(struct ata_link *link);
 extern int ata_down_xfermask_limit(struct ata_device *dev, int force_pio0);
 extern int ata_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 9776a67..a56cb24 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -1311,8 +1311,8 @@ static void mv_err_intr(struct ata_port 
 	edma_err_cause = readl(port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
 
 	if (EDMA_ERR_SERR & edma_err_cause) {
-		sata_scr_read(ap, SCR_ERROR, &serr);
-		sata_scr_write_flush(ap, SCR_ERROR, serr);
+		sata_scr_read(&ap->link, SCR_ERROR, &serr);
+		sata_scr_write_flush(&ap->link, SCR_ERROR, serr);
 	}
 	if (EDMA_ERR_SELF_DIS & edma_err_cause) {
 		struct mv_port_priv *pp	= ap->private_data;
@@ -1951,15 +1951,15 @@ static void __mv_phy_reset(struct ata_po
 
 	/* Issue COMRESET via SControl */
 comreset_retry:
-	sata_scr_write_flush(ap, SCR_CONTROL, 0x301);
+	sata_scr_write_flush(&ap->link, SCR_CONTROL, 0x301);
 	__msleep(1, can_sleep);
 
-	sata_scr_write_flush(ap, SCR_CONTROL, 0x300);
+	sata_scr_write_flush(&ap->link, SCR_CONTROL, 0x300);
 	__msleep(20, can_sleep);
 
 	timeout = jiffies + msecs_to_jiffies(200);
 	do {
-		sata_scr_read(ap, SCR_STATUS, &sstatus);
+		sata_scr_read(&ap->link, SCR_STATUS, &sstatus);
 		if (((sstatus & 0x3) == 3) || ((sstatus & 0x3) == 0))
 			break;
 
@@ -1976,10 +1976,10 @@ comreset_retry:
 		"SCtrl 0x%08x\n", mv_scr_read(ap, SCR_STATUS),
 		mv_scr_read(ap, SCR_ERROR), mv_scr_read(ap, SCR_CONTROL));
 
-	if (ata_port_online(ap)) {
+	if (ata_link_online(&ap->link)) {
 		ata_port_probe(ap);
 	} else {
-		sata_scr_read(ap, SCR_STATUS, &sstatus);
+		sata_scr_read(&ap->link, SCR_STATUS, &sstatus);
 		ata_port_printk(ap, KERN_INFO,
 				"no device found (phy stat %08x)\n", sstatus);
 		ata_port_disable(ap);
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index ea1e3e5..29de9bd 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -551,7 +551,7 @@ static int sil24_softreset(struct ata_po
 
 	DPRINTK("ENTER\n");
 
-	if (ata_port_offline(ap)) {
+	if (ata_link_offline(&ap->link)) {
 		DPRINTK("PHY reports no device\n");
 		*class = ATA_DEV_NONE;
 		goto out;
@@ -608,10 +608,10 @@ static int sil24_hardreset(struct ata_po
 	u32 tmp;
 
 	/* sil24 does the right thing(tm) without any protection */
-	sata_set_spd(ap);
+	sata_set_spd(&ap->link);
 
 	tout_msec = 100;
-	if (ata_port_online(ap))
+	if (ata_link_online(&ap->link))
 		tout_msec = 5000;
 
 	writel(PORT_CS_DEV_RST, port + PORT_CTRL_STAT);
@@ -621,14 +621,14 @@ static int sil24_hardreset(struct ata_po
 	/* SStatus oscillates between zero and valid status after
 	 * DEV_RST, debounce it.
 	 */
-	rc = sata_phy_debounce(ap, sata_deb_timing_long);
+	rc = sata_link_debounce(&ap->link, sata_deb_timing_long);
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
index 48503d4..315ab6f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -710,9 +710,10 @@ extern void ata_port_probe(struct ata_po
 extern void __sata_phy_reset(struct ata_port *ap);
 extern void sata_phy_reset(struct ata_port *ap);
 extern void ata_bus_reset(struct ata_port *ap);
-extern int sata_set_spd(struct ata_port *ap);
-extern int sata_phy_debounce(struct ata_port *ap, const unsigned long *param);
-extern int sata_phy_resume(struct ata_port *ap, const unsigned long *param);
+extern int sata_set_spd(struct ata_link *link);
+extern int sata_link_debounce(struct ata_link *link,
+			      const unsigned long *params);
+extern int sata_link_resume(struct ata_link *link, const unsigned long *params);
 extern int ata_std_prereset(struct ata_port *ap);
 extern int ata_std_softreset(struct ata_port *ap, unsigned int *classes);
 extern int sata_port_hardreset(struct ata_port *ap,
@@ -753,12 +754,12 @@ extern int ata_sas_slave_configure(struc
 extern int ata_sas_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *),
 			    struct ata_port *ap);
 extern unsigned int ata_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
-extern int sata_scr_valid(struct ata_port *ap);
-extern int sata_scr_read(struct ata_port *ap, int reg, u32 *val);
-extern int sata_scr_write(struct ata_port *ap, int reg, u32 val);
-extern int sata_scr_write_flush(struct ata_port *ap, int reg, u32 val);
-extern int ata_port_online(struct ata_port *ap);
-extern int ata_port_offline(struct ata_port *ap);
+extern int sata_scr_valid(struct ata_link *link);
+extern int sata_scr_read(struct ata_link *link, int reg, u32 *val);
+extern int sata_scr_write(struct ata_link *link, int reg, u32 val);
+extern int sata_scr_write_flush(struct ata_link *link, int reg, u32 val);
+extern int ata_link_online(struct ata_link *link);
+extern int ata_link_offline(struct ata_link *link);
 extern int ata_scsi_device_resume(struct scsi_device *);
 extern int ata_scsi_device_suspend(struct scsi_device *, pm_message_t mesg);
 extern int ata_host_suspend(struct ata_host *host, pm_message_t mesg);
-- 
1.4.2.3


