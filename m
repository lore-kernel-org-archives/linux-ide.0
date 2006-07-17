From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/12] libata: implement sata_update_scontrol()
Date: Mon, 17 Jul 2006 15:52:32 +0900
Message-ID: <1153119152202-git-send-email-htejun@gmail.com>
References: <11531191512028-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:30311 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932299AbWGQGvy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Jul 2006 02:51:54 -0400
Received: by py-out-1112.google.com with SMTP id x31so3883138pye
        for <linux-ide@vger.kernel.org>; Sun, 16 Jul 2006 23:51:20 -0700 (PDT)
In-Reply-To: <11531191512028-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

SControl register hosts several control fields and update to one field
shouldn't alter others.  libata used to do read-modify-write to
achieve this.  However, this results in excessive SControl reading and
loss of SControl setting under certain circumstances (e.g. suspend /
resume cycles, hardware glitch).

This patch adds SControl cache, ap->scontrol, and two helper functions
- sata_update_scontrol_push() which only updates the cache and
sata_update_scontrol() which updates & commits the updated value to
SControl.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |  139 +++++++++++++++++++++++++++++---------------
 drivers/scsi/sata_mv.c     |    4 +
 include/linux/libata.h     |    4 +
 3 files changed, 99 insertions(+), 48 deletions(-)

ac471e3d83d7a3a7ae2b4cf976b348ce7a74948b
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 3e35839..cc77bd5 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1859,26 +1859,19 @@ int sata_down_spd_limit(struct ata_port 
 	return 0;
 }
 
-static int __sata_set_spd_needed(struct ata_port *ap, u32 *scontrol)
+static inline int sata_spd_val(struct ata_port *ap)
 {
-	u32 spd, limit;
-
 	if (ap->sata_spd_limit == UINT_MAX)
-		limit = 0;
+		return 0;
 	else
-		limit = fls(ap->sata_spd_limit);
-
-	spd = (*scontrol >> 4) & 0xf;
-	*scontrol = (*scontrol & ~0xf0) | ((limit & 0xf) << 4);
-
-	return spd != limit;
+		return fls(ap->sata_spd_limit);
 }
 
 /**
  *	sata_set_spd_needed - is SATA spd configuration needed
  *	@ap: Port in question
  *
- *	Test whether the spd limit in SControl matches
+ *	Test whether the spd limit in ap->scontrol matches
  *	@ap->sata_spd_limit.  This function is used to determine
  *	whether hardreset is necessary to apply SATA spd
  *	configuration.
@@ -1891,12 +1884,9 @@ static int __sata_set_spd_needed(struct 
  */
 int sata_set_spd_needed(struct ata_port *ap)
 {
-	u32 scontrol;
+	u32 spd = (ap->scontrol >> 4) & 0xf;
 
-	if (sata_scr_read(ap, SCR_CONTROL, &scontrol))
-		return 0;
-
-	return __sata_set_spd_needed(ap, &scontrol);
+	return spd != sata_spd_val(ap);
 }
 
 /**
@@ -1914,16 +1904,12 @@ int sata_set_spd_needed(struct ata_port 
  */
 int sata_set_spd(struct ata_port *ap)
 {
-	u32 scontrol;
 	int rc;
 
-	if ((rc = sata_scr_read(ap, SCR_CONTROL, &scontrol)))
-		return rc;
-
-	if (!__sata_set_spd_needed(ap, &scontrol))
+	if (!sata_set_spd_needed(ap))
 		return 0;
 
-	if ((rc = sata_scr_write(ap, SCR_CONTROL, scontrol)))
+	if ((rc = sata_update_scontrol(ap, ATA_SCTL_SPD, sata_spd_val(ap))))
 		return rc;
 
 	return 1;
@@ -2595,15 +2581,9 @@ int sata_phy_debounce(struct ata_port *a
  */
 int sata_phy_resume(struct ata_port *ap, const unsigned long *params)
 {
-	u32 scontrol;
 	int rc;
 
-	if ((rc = sata_scr_read(ap, SCR_CONTROL, &scontrol)))
-		return rc;
-
-	scontrol = (scontrol & 0x0f0) | 0x300;
-
-	if ((rc = sata_scr_write(ap, SCR_CONTROL, scontrol)))
+	if ((rc = sata_update_scontrol(ap, ATA_SCTL_DET, 0x0)))
 		return rc;
 
 	/* Some PHYs react badly if SStatus is pounded immediately
@@ -2765,7 +2745,6 @@ int sata_std_hardreset(struct ata_port *
 {
 	struct ata_eh_context *ehc = &ap->eh_context;
 	const unsigned long *timing = sata_ehc_deb_timing(ehc);
-	u32 scontrol;
 	int rc;
 
 	DPRINTK("ENTER\n");
@@ -2776,24 +2755,14 @@ int sata_std_hardreset(struct ata_port *
 		 * reconfiguration.  This works for at least ICH7 AHCI
 		 * and Sil3124.
 		 */
-		if ((rc = sata_scr_read(ap, SCR_CONTROL, &scontrol)))
-			return rc;
-
-		scontrol = (scontrol & 0x0f0) | 0x304;
-
-		if ((rc = sata_scr_write(ap, SCR_CONTROL, scontrol)))
+		if ((rc = sata_update_scontrol(ap, ATA_SCTL_DET, 0x4)))
 			return rc;
 
 		sata_set_spd(ap);
 	}
 
 	/* issue phy wake/reset */
-	if ((rc = sata_scr_read(ap, SCR_CONTROL, &scontrol)))
-		return rc;
-
-	scontrol = (scontrol & 0x0f0) | 0x301;
-
-	if ((rc = sata_scr_write_flush(ap, SCR_CONTROL, scontrol)))
+	if ((rc = sata_update_scontrol(ap, ATA_SCTL_DET, 0x1)))
 		return rc;
 
 	/* Couldn't find anything in SATA I/II specs, but AHCI-1.1
@@ -4975,6 +4944,77 @@ int sata_scr_write_flush(struct ata_port
 }
 
 /**
+ *	sata_update_scontrol_push - push SControl register update
+ *	@ap: ATA port to update SControl for
+ *	@sel: ATA_SCTL_* subfield selector
+ *	@val: value to be written
+ *
+ *	SControl hosts several control subfields which need to be
+ *	treated separately.  SControl value is cached on
+ *	initialization and this function updates only the requested
+ *	field of the cache.  This function only accumulates SControl
+ *	updates in the cache and does NOT write the updated value to
+ *	SControl.
+ *
+ *	SControl cache reduces SControl access and helps preserving
+ *	SControl when hardware forgets the configured value (e.g. over
+ *	suspend/resume).
+ *
+ *	LOCKING:
+ *	ap->scontrol is protected by ap->lock while EH is inactive and
+ *	owned by EH while it's active.  So, spin_lock_irqsave(host_set
+ *	lock) out of EH, and none during EH.
+ *
+ *	RETURNS:
+ *	0 on success, negative errno on failure.
+ */
+void sata_update_scontrol_push(struct ata_port *ap, int sel, u8 val)
+{
+	u32 scontrol = ap->scontrol;
+	int shift = sel * 4;
+
+	WARN_ON(val > 0xf);
+	val &= 0xf;
+
+	scontrol = (scontrol & ~(0xf << shift)) | (val << shift);
+
+	ap->scontrol = scontrol;
+}
+
+/**
+ *	sata_update_scontrol - update SControl register
+ *	@ap: ATA port to update SControl for
+ *	@sel: ATA_SCTL_* subfield selector
+ *	@val: value to be written
+ *
+ *	Update SControl cache using sata_update_scontrol_push() and
+ *	write the cached value to the SControl register.
+ *
+ *	LOCKING:
+ *	ap->scontrol is protected by ap->lock while EH is inactive and
+ *	owned by EH while it's active.  So, spin_lock_irqsave(host_set
+ *	lock) out of EH, and none during EH.
+ *
+ *	RETURNS:
+ *	0 on success, negative errno on failure.
+ */
+int sata_update_scontrol(struct ata_port *ap, int sel, u8 val)
+{
+	int rc;
+
+	/* push requested change */
+	sata_update_scontrol_push(ap, sel, val);
+
+	/* always use the flushing version */
+	rc = sata_scr_write_flush(ap, SCR_CONTROL, ap->scontrol);
+
+	/* SPM is oneshot field, don't cache it over write */
+	ap->scontrol &= ~(0xf << (ATA_SCTL_SPM * 4));
+
+	return 0;
+}
+
+/**
  *	ata_port_online - test whether the given port is online
  *	@ap: ATA port to test
  *
@@ -5492,7 +5532,6 @@ int ata_device_add(const struct ata_prob
 	DPRINTK("probe begin\n");
 	for (i = 0; i < count; i++) {
 		struct ata_port *ap;
-		u32 scontrol;
 		int rc;
 
 		ap = host_set->ports[i];
@@ -5502,9 +5541,15 @@ int ata_device_add(const struct ata_prob
 		list_add_tail(&ap->all_ports_entry, &ata_all_ports);
 		mutex_unlock(&ata_all_ports_mutex);
 
-		/* init sata_spd_limit to the current value */
-		if (sata_scr_read(ap, SCR_CONTROL, &scontrol) == 0) {
-			int spd = (scontrol >> 4) & 0xf;
+		/* init scontrol and sata_spd_limit to the current value */
+		ap->scontrol = 0x300; /* default value */
+		if (sata_scr_read(ap, SCR_CONTROL, &ap->scontrol) == 0) {
+			int spd;
+
+			/* zero PMP/SPM and no powersaving */
+			ap->scontrol = (ap->scontrol & 0xfff000ff) | 0x300;
+
+			spd = ata_scontrol_field(ap->scontrol, ATA_SCTL_SPD);
 			ap->hw_sata_spd_limit &= (1 << spd) - 1;
 		}
 		ap->sata_spd_limit = ap->hw_sata_spd_limit;
@@ -6036,6 +6081,8 @@ EXPORT_SYMBOL_GPL(sata_scr_valid);
 EXPORT_SYMBOL_GPL(sata_scr_read);
 EXPORT_SYMBOL_GPL(sata_scr_write);
 EXPORT_SYMBOL_GPL(sata_scr_write_flush);
+EXPORT_SYMBOL_GPL(sata_update_scontrol_push);
+EXPORT_SYMBOL_GPL(sata_update_scontrol);
 EXPORT_SYMBOL_GPL(ata_port_online);
 EXPORT_SYMBOL_GPL(ata_port_offline);
 EXPORT_SYMBOL_GPL(ata_host_set_suspend);
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 1053c7c..52bf790 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -1952,10 +1952,10 @@ static void __mv_phy_reset(struct ata_po
 
 	/* Issue COMRESET via SControl */
 comreset_retry:
-	sata_scr_write_flush(ap, SCR_CONTROL, 0x301);
+	sata_update_scontrol(ap, ATA_SCTL_DET, 0x1);
 	__msleep(1, can_sleep);
 
-	sata_scr_write_flush(ap, SCR_CONTROL, 0x300);
+	sata_update_scontrol(ap, ATA_SCTL_DET, 0x0);
 	__msleep(20, can_sleep);
 
 	timeout = jiffies + msecs_to_jiffies(200);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index c9ed035..1656d5b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -521,6 +521,8 @@ struct ata_port {
 	unsigned int		mwdma_mask;
 	unsigned int		udma_mask;
 	unsigned int		cbl;	/* cable type; ATA_CBL_xxx */
+
+	u32			scontrol;	/* for update_scontrol */
 	unsigned int		hw_sata_spd_limit;
 	unsigned int		sata_spd_limit;	/* SATA PHY speed limit */
 
@@ -696,6 +698,8 @@ extern int sata_scr_valid(struct ata_por
 extern int sata_scr_read(struct ata_port *ap, int reg, u32 *val);
 extern int sata_scr_write(struct ata_port *ap, int reg, u32 val);
 extern int sata_scr_write_flush(struct ata_port *ap, int reg, u32 val);
+extern void sata_update_scontrol_push(struct ata_port *ap, int sel, u8 val);
+extern int sata_update_scontrol(struct ata_port *ap, int sel, u8 val);
 extern int ata_port_online(struct ata_port *ap);
 extern int ata_port_offline(struct ata_port *ap);
 extern int ata_scsi_device_resume(struct scsi_device *);
-- 
1.3.2


