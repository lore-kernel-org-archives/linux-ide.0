From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 17/22] libata: use new SCR and on/offline functions
Date: Thu, 11 May 2006 20:59:51 +0900
Message-ID: <1147348791897-git-send-email-htejun@gmail.com>
References: <11473487893774-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.225]:42430 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751618AbWEKMAG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 08:00:06 -0400
Received: by wr-out-0506.google.com with SMTP id i23so108618wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 05:00:05 -0700 (PDT)
In-Reply-To: <11473487893774-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Use new SCR and on/offline functions.  Note that for LLDD which know
it implements SCR callbacks, SCR functions are guaranteed to succeed
and ata_port_online() == !ata_port_offline().

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c        |    6 +-
 drivers/scsi/libata-core.c |  106 ++++++++++++++++++++++++--------------------
 drivers/scsi/sata_mv.c     |   16 ++++---
 drivers/scsi/sata_sil24.c  |    6 +-
 4 files changed, 74 insertions(+), 60 deletions(-)

1868a1691a56029b8e5f1378afbc56ca00145e3f
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index c332554..c2298fb 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -567,7 +567,7 @@ static int ahci_softreset(struct ata_por
 
 	DPRINTK("ENTER\n");
 
-	if (!sata_dev_present(ap)) {
+	if (ata_port_offline(ap)) {
 		DPRINTK("PHY reports no device\n");
 		*class = ATA_DEV_NONE;
 		return 0;
@@ -640,7 +640,7 @@ static int ahci_softreset(struct ata_por
 	msleep(150);
 
 	*class = ATA_DEV_NONE;
-	if (sata_dev_present(ap)) {
+	if (ata_port_online(ap)) {
 		if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
 			rc = -EIO;
 			reason = "device not ready";
@@ -670,7 +670,7 @@ static int ahci_hardreset(struct ata_por
 	rc = sata_std_hardreset(ap, class);
 	ahci_start_engine(ap);
 
-	if (rc == 0 && sata_dev_present(ap))
+	if (rc == 0 && ata_port_online(ap))
 		*class = ahci_dev_classify(ap);
 	if (*class == ATA_DEV_UNKNOWN)
 		*class = ATA_DEV_NONE;
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index e3c579e..128f84d 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1494,13 +1494,11 @@ static void sata_print_link_status(struc
 {
 	u32 sstatus, scontrol, tmp;
 
-	if (!ap->ops->scr_read)
+	if (ata_scr_read(ap, SCR_STATUS, &sstatus))
 		return;
+	ata_scr_read(ap, SCR_CONTROL, &scontrol);
 
-	sstatus = scr_read(ap, SCR_STATUS);
-	scontrol = scr_read(ap, SCR_CONTROL);
-
-	if (sata_dev_present(ap)) {
+	if (ata_port_online(ap)) {
 		tmp = (sstatus >> 4) & 0xf;
 		printk(KERN_INFO
 		       "ata%u: SATA link up %s (SStatus %X SControl %X)\n",
@@ -1531,17 +1529,18 @@ void __sata_phy_reset(struct ata_port *a
 
 	if (ap->flags & ATA_FLAG_SATA_RESET) {
 		/* issue phy wake/reset */
-		scr_write_flush(ap, SCR_CONTROL, 0x301);
+		ata_scr_write_flush(ap, SCR_CONTROL, 0x301);
 		/* Couldn't find anything in SATA I/II specs, but
 		 * AHCI-1.1 10.4.2 says at least 1 ms. */
 		mdelay(1);
 	}
-	scr_write_flush(ap, SCR_CONTROL, 0x300); /* phy wake/clear reset */
+	/* phy wake/clear reset */
+	ata_scr_write_flush(ap, SCR_CONTROL, 0x300);
 
 	/* wait for phy to become ready, if necessary */
 	do {
 		msleep(200);
-		sstatus = scr_read(ap, SCR_STATUS);
+		ata_scr_read(ap, SCR_STATUS, &sstatus);
 		if ((sstatus & 0xf) != 1)
 			break;
 	} while (time_before(jiffies, timeout));
@@ -1550,7 +1549,7 @@ void __sata_phy_reset(struct ata_port *a
 	sata_print_link_status(ap);
 
 	/* TODO: phy layer with polling, timeouts, etc. */
-	if (sata_dev_present(ap))
+	if (!ata_port_offline(ap))
 		ata_port_probe(ap);
 	else
 		ata_port_disable(ap);
@@ -1638,11 +1637,12 @@ void ata_port_disable(struct ata_port *a
  */
 int ata_down_sata_spd_limit(struct ata_port *ap)
 {
-	u32 spd, mask;
-	int highbit;
+	u32 sstatus, spd, mask;
+	int rc, highbit;
 
-	if (ap->cbl != ATA_CBL_SATA || !ap->ops->scr_read)
-		return -EOPNOTSUPP;
+	rc = ata_scr_read(ap, SCR_STATUS, &sstatus);
+	if (rc)
+		return rc;
 
 	mask = ap->sata_spd_limit;
 	if (mask <= 1)
@@ -1650,7 +1650,7 @@ int ata_down_sata_spd_limit(struct ata_p
 	highbit = fls(mask) - 1;
 	mask &= ~(1 << highbit);
 
-	spd = (scr_read(ap, SCR_STATUS) >> 4) & 0xf;
+	spd = (sstatus >> 4) & 0xf;
 	if (spd <= 1)
 		return -EINVAL;
 	spd--;
@@ -1700,11 +1700,9 @@ int ata_set_sata_spd_needed(struct ata_p
 {
 	u32 scontrol;
 
-	if (ap->cbl != ATA_CBL_SATA || !ap->ops->scr_read)
+	if (ata_scr_read(ap, SCR_CONTROL, &scontrol))
 		return 0;
 
-	scontrol = scr_read(ap, SCR_CONTROL);
-
 	return __ata_set_sata_spd_needed(ap, &scontrol);
 }
 
@@ -1719,20 +1717,21 @@ int ata_set_sata_spd_needed(struct ata_p
  *
  *	RETURNS:
  *	0 if spd doesn't need to be changed, 1 if spd has been
- *	changed.  -EOPNOTSUPP if SCR registers are inaccessible.
+ *	changed.  Negative errno if SCR registers are inaccessible.
  */
 int ata_set_sata_spd(struct ata_port *ap)
 {
 	u32 scontrol;
+	int rc;
 
-	if (ap->cbl != ATA_CBL_SATA || !ap->ops->scr_read)
-		return -EOPNOTSUPP;
+	if ((rc = ata_scr_read(ap, SCR_CONTROL, &scontrol)))
+		return rc;
 
-	scontrol = scr_read(ap, SCR_CONTROL);
 	if (!__ata_set_sata_spd_needed(ap, &scontrol))
 		return 0;
 
-	scr_write(ap, SCR_CONTROL, scontrol);
+	if ((rc = ata_scr_write(ap, SCR_CONTROL, scontrol)))
+		return rc;
 	return 1;
 }
 
@@ -2336,20 +2335,26 @@ static int sata_phy_resume(struct ata_po
 {
 	unsigned long timeout = jiffies + (HZ * 5);
 	u32 scontrol, sstatus;
+	int rc;
+
+	if ((rc = ata_scr_read(ap, SCR_CONTROL, &scontrol)))
+		return rc;
 
-	scontrol = scr_read(ap, SCR_CONTROL);
 	scontrol = (scontrol & 0x0f0) | 0x300;
-	scr_write_flush(ap, SCR_CONTROL, scontrol);
+
+	if ((rc = ata_scr_write(ap, SCR_CONTROL, scontrol)))
+		return rc;
 
 	/* Wait for phy to become ready, if necessary. */
 	do {
 		msleep(200);
-		sstatus = scr_read(ap, SCR_STATUS);
+		if ((rc = ata_scr_read(ap, SCR_STATUS, &sstatus)))
+			return rc;
 		if ((sstatus & 0xf) != 1)
 			return 0;
 	} while (time_before(jiffies, timeout));
 
-	return -1;
+	return -EBUSY;
 }
 
 /**
@@ -2367,21 +2372,20 @@ static int sata_phy_resume(struct ata_po
  */
 void ata_std_probeinit(struct ata_port *ap)
 {
-	if ((ap->flags & ATA_FLAG_SATA) && ap->ops->scr_read) {
-		u32 spd;
+	u32 scontrol;
 
-		/* resume link */
-		sata_phy_resume(ap);
+	/* resume link */
+	sata_phy_resume(ap);
 
-		/* init sata_spd_limit to the current value */
-		spd = (scr_read(ap, SCR_CONTROL) & 0xf0) >> 4;
-		if (spd)
-			ap->sata_spd_limit &= (1 << spd) - 1;
-
-		/* wait for device */
-		if (sata_dev_present(ap))
-			ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
+	/* init sata_spd_limit to the current value */
+	if (ata_scr_read(ap, SCR_CONTROL, &scontrol) == 0) {
+		int spd = (scontrol >> 4) & 0xf;
+		ap->sata_spd_limit &= (1 << spd) - 1;
 	}
+
+	/* wait for device */
+	if (ata_port_online(ap))
+		ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
 }
 
 /**
@@ -2406,7 +2410,7 @@ int ata_std_softreset(struct ata_port *a
 
 	DPRINTK("ENTER\n");
 
-	if (ap->ops->scr_read && !sata_dev_present(ap)) {
+	if (ata_port_offline(ap)) {
 		classes[0] = ATA_DEV_NONE;
 		goto out;
 	}
@@ -2457,6 +2461,7 @@ int ata_std_softreset(struct ata_port *a
 int sata_std_hardreset(struct ata_port *ap, unsigned int *class)
 {
 	u32 scontrol;
+	int rc;
 
 	DPRINTK("ENTER\n");
 
@@ -2466,17 +2471,25 @@ int sata_std_hardreset(struct ata_port *
 		 * reconfiguration.  This works for at least ICH7 AHCI
 		 * and Sil3124.
 		 */
-		scontrol = scr_read(ap, SCR_CONTROL);
+		if ((rc = ata_scr_read(ap, SCR_CONTROL, &scontrol)))
+			return rc;
+
 		scontrol = (scontrol & 0x0f0) | 0x302;
-		scr_write_flush(ap, SCR_CONTROL, scontrol);
+
+		if ((rc = ata_scr_write(ap, SCR_CONTROL, scontrol)))
+			return rc;
 
 		ata_set_sata_spd(ap);
 	}
 
 	/* issue phy wake/reset */
-	scontrol = scr_read(ap, SCR_CONTROL);
+	if ((rc = ata_scr_read(ap, SCR_CONTROL, &scontrol)))
+		return rc;
+
 	scontrol = (scontrol & 0x0f0) | 0x301;
-	scr_write_flush(ap, SCR_CONTROL, scontrol);
+
+	if ((rc = ata_scr_write_flush(ap, SCR_CONTROL, scontrol)))
+		return rc;
 
 	/* Couldn't find anything in SATA I/II specs, but AHCI-1.1
 	 * 10.4.2 says at least 1 ms.
@@ -2487,7 +2500,7 @@ int sata_std_hardreset(struct ata_port *
 	sata_phy_resume(ap);
 
 	/* TODO: phy layer with polling, timeouts, etc. */
-	if (!sata_dev_present(ap)) {
+	if (ata_port_offline(ap)) {
 		*class = ATA_DEV_NONE;
 		DPRINTK("EXIT, link offline\n");
 		return 0;
@@ -2527,8 +2540,7 @@ void ata_std_postreset(struct ata_port *
 	DPRINTK("ENTER\n");
 
 	/* print link status */
-	if (ap->cbl == ATA_CBL_SATA)
-		sata_print_link_status(ap);
+	sata_print_link_status(ap);
 
 	/* re-enable interrupts */
 	if (ap->ioaddr.ctl_addr)	/* FIXME: hack. create a hook instead */
@@ -2575,7 +2587,7 @@ int ata_std_probe_reset(struct ata_port 
 	ata_reset_fn_t hardreset;
 
 	hardreset = NULL;
-	if (ap->cbl == ATA_CBL_SATA && ap->ops->scr_read)
+	if (ata_scr_valid(ap))
 		hardreset = sata_std_hardreset;
 
 	return ata_drive_probe_reset(ap, ata_std_probeinit,
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 181917a..97aad57 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -1309,8 +1309,8 @@ static void mv_err_intr(struct ata_port 
 	edma_err_cause = readl(port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
 
 	if (EDMA_ERR_SERR & edma_err_cause) {
-		serr = scr_read(ap, SCR_ERROR);
-		scr_write_flush(ap, SCR_ERROR, serr);
+		ata_scr_read(ap, SCR_ERROR, &serr);
+		ata_scr_write_flush(ap, SCR_ERROR, serr);
 	}
 	if (EDMA_ERR_SELF_DIS & edma_err_cause) {
 		struct mv_port_priv *pp	= ap->private_data;
@@ -1934,15 +1934,16 @@ static void __mv_phy_reset(struct ata_po
 
 	/* Issue COMRESET via SControl */
 comreset_retry:
-	scr_write_flush(ap, SCR_CONTROL, 0x301);
+	ata_scr_write_flush(ap, SCR_CONTROL, 0x301);
 	__msleep(1, can_sleep);
 
-	scr_write_flush(ap, SCR_CONTROL, 0x300);
+	ata_scr_write_flush(ap, SCR_CONTROL, 0x300);
 	__msleep(20, can_sleep);
 
 	timeout = jiffies + msecs_to_jiffies(200);
 	do {
-		sstatus = scr_read(ap, SCR_STATUS) & 0x3;
+		ata_scr_read(ap, SCR_STATUS, &sstatus);
+		sstatus &= 0x3;
 		if ((sstatus == 3) || (sstatus == 0))
 			break;
 
@@ -1959,11 +1960,12 @@ comreset_retry:
 		"SCtrl 0x%08x\n", mv_scr_read(ap, SCR_STATUS),
 		mv_scr_read(ap, SCR_ERROR), mv_scr_read(ap, SCR_CONTROL));
 
-	if (sata_dev_present(ap)) {
+	if (ata_port_online(ap)) {
 		ata_port_probe(ap);
 	} else {
+		ata_scr_read(ap, SCR_STATUS, &sstatus);
 		printk(KERN_INFO "ata%u: no device found (phy stat %08x)\n",
-		       ap->id, scr_read(ap, SCR_STATUS));
+		       ap->id, sstatus);
 		ata_port_disable(ap);
 		return;
 	}
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index a9c8484..664b138 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -464,7 +464,7 @@ static int sil24_softreset(struct ata_po
 
 	DPRINTK("ENTER\n");
 
-	if (!sata_dev_present(ap)) {
+	if (ata_port_offline(ap)) {
 		DPRINTK("PHY reports no device\n");
 		*class = ATA_DEV_NONE;
 		goto out;
@@ -531,7 +531,7 @@ static int sil24_hardreset(struct ata_po
 	ata_set_sata_spd(ap);
 
 	tout_msec = 100;
-	if (sata_dev_present(ap))
+	if (ata_port_online(ap))
 		tout_msec = 5000;
 
 	writel(PORT_CS_DEV_RST, port + PORT_CTRL_STAT);
@@ -544,7 +544,7 @@ static int sil24_hardreset(struct ata_po
 	msleep(100);
 
 	if (tmp & PORT_CS_DEV_RST) {
-		if (!sata_dev_present(ap))
+		if (ata_port_offline(ap))
 			return 0;
 		reason = "link not ready";
 		goto err;
-- 
1.2.4


