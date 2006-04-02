From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/7] libata: implement ap->sata_spd_limit and helpers
Date: Sun, 2 Apr 2006 17:54:46 +0900
Message-ID: <11439680862635-git-send-email-htejun@gmail.com>
References: <11439680863256-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.207]:51097 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932253AbWDBIyw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 04:54:52 -0400
Received: by zproxy.gmail.com with SMTP id o37so1438217nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 00:54:51 -0800 (PST)
In-Reply-To: <11439680863256-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ap->sata_spd_limit contrains SATA PHY speed of the port.  It is
initialized to the configured value prior to probing thus preserving
BIOS configured value.  hardreset is responsible for applying SPD
limit and sata_std_hardreset() is updated to do that.  SATA SPD limit
will be used to enhance failure handling during probing and later by
EH.

This patch also normalizes some comments around affected code.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |  138 +++++++++++++++++++++++++++++++++++++++++++-
 include/linux/libata.h     |    1 
 2 files changed, 135 insertions(+), 4 deletions(-)

1e78d28ef3d3c87b059e74e4414071952cab0493
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 3acf562..39afae1 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -65,6 +65,7 @@ static unsigned int ata_dev_init_params(
 					struct ata_device *dev,
 					u16 heads,
 					u16 sectors);
+static int ata_down_sata_spd_limit(struct ata_port *ap);
 static int ata_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev);
 static unsigned int ata_dev_set_xfermode(struct ata_port *ap,
 					 struct ata_device *dev);
@@ -1596,6 +1597,120 @@ void ata_port_disable(struct ata_port *a
 	ap->flags |= ATA_FLAG_PORT_DISABLED;
 }
 
+/**
+ *	ata_down_sata_spd_limit - adjust SATA spd limit downward
+ *	@ap: Port to adjust SATA spd limit for
+ *
+ *	Adjust SATA spd limit of @ap downward.  Note that this
+ *	function only adjusts the limit.  The change must be applied
+ *	using ata_set_sata_spd().
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ *
+ *	RETURNS:
+ *	0 on success, negative errno on failure
+ */
+static int ata_down_sata_spd_limit(struct ata_port *ap)
+{
+	u32 spd, mask;
+	int highbit;
+
+	if (ap->cbl != ATA_CBL_SATA || !ap->ops->scr_read)
+		return -EOPNOTSUPP;
+
+	mask = ap->sata_spd_limit;
+	if (mask <= 1)
+		return -EINVAL;
+	highbit = fls(mask) - 1;
+	mask &= ~(1 << highbit);
+
+	spd = (scr_read(ap, SCR_STATUS) >> 4) & 0xf;
+	if (spd <= 1)
+		return -EINVAL;
+	spd--;
+	mask &= (1 << spd) - 1;
+	if (!mask)
+		return -EINVAL;
+
+	ap->sata_spd_limit = mask;
+
+	printk(KERN_WARNING "ata%u: limiting SATA link speed to %s\n",
+	       ap->id, sata_spd_string(fls(mask)));
+
+	return 0;
+}
+
+static int __ata_set_sata_spd_needed(struct ata_port *ap, u32 *scontrol)
+{
+	u32 spd, limit;
+
+	if (ap->sata_spd_limit == UINT_MAX)
+		limit = 0;
+	else
+		limit = fls(ap->sata_spd_limit);
+
+	spd = (*scontrol >> 4) & 0xf;
+	*scontrol = (*scontrol & ~0xf0) | ((limit & 0xf) << 4);
+
+	return spd != limit;
+}
+
+/**
+ *	ata_set_sata_spd_needed - is SATA spd configuration needed
+ *	@ap: Port in question
+ *
+ *	Test whether the spd limit in SControl matches
+ *	@ap->sata_spd_limit.  This function is used to determine
+ *	whether hardreset is necessary to apply SATA spd
+ *	configuration.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ *
+ *	RETURNS:
+ *	1 if SATA spd configuration is needed, 0 otherwise.
+ */
+static int ata_set_sata_spd_needed(struct ata_port *ap)
+{
+	u32 scontrol;
+
+	if (ap->cbl != ATA_CBL_SATA || !ap->ops->scr_read)
+		return 0;
+
+	scontrol = scr_read(ap, SCR_CONTROL);
+
+	return __ata_set_sata_spd_needed(ap, &scontrol);
+}
+
+/**
+ *	ata_set_sata_spd - set SATA spd according to spd limit
+ *	@ap: Port to set SATA spd for
+ *
+ *	Set SATA spd of @ap according to sata_spd_limit.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ *
+ *	RETURNS:
+ *	0 if spd doesn't need to be changed, 1 if spd has been
+ *	changed.  -EOPNOTSUPP if SCR registers are inaccessible.
+ */
+static int ata_set_sata_spd(struct ata_port *ap)
+{
+	u32 scontrol;
+
+	if (ap->cbl != ATA_CBL_SATA || !ap->ops->scr_read)
+		return -EOPNOTSUPP;
+
+	scontrol = scr_read(ap, SCR_CONTROL);
+	if (!__ata_set_sata_spd_needed(ap, &scontrol))
+		return 0;
+
+	scr_write(ap, SCR_CONTROL, scontrol);
+	return 1;
+}
+
 /*
  * This mode timing computation functionality is ported over from
  * drivers/ide/ide-timing.h and was originally written by Vojtech Pavlik
@@ -2165,7 +2280,14 @@ static int sata_phy_resume(struct ata_po
 void ata_std_probeinit(struct ata_port *ap)
 {
 	if ((ap->flags & ATA_FLAG_SATA) && ap->ops->scr_read) {
+		u32 spd;
+
 		sata_phy_resume(ap);
+
+		spd = (scr_read(ap, SCR_CONTROL) & 0xf0) >> 4;
+		if (spd)
+			ap->sata_spd_limit &= (1 << spd) - 1;
+
 		if (sata_dev_present(ap))
 			ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
 	}
@@ -2253,18 +2375,25 @@ int sata_std_hardreset(struct ata_port *
 
 	DPRINTK("ENTER\n");
 
-	/* Issue phy wake/reset */
+	/* SATA spec says nothing about how to reconfigure spd.
+	 * Configuring before starting hardreset works for both of my
+	 * test cases - ICH7 AHCI and sil3124.  Configuring while phy
+	 * is off sounds nice but ICH7 chokes on that.  It preserves
+	 * configured value but does not apply it.
+	 */
+	ata_set_sata_spd(ap);
+
+	/* issue phy wake/reset */
 	scontrol = scr_read(ap, SCR_CONTROL);
 	scontrol = (scontrol & 0x0f0) | 0x301;
 	scr_write_flush(ap, SCR_CONTROL, scontrol);
 
-	/*
-	 * Couldn't find anything in SATA I/II specs, but AHCI-1.1
+	/* Couldn't find anything in SATA I/II specs, but AHCI-1.1
 	 * 10.4.2 says at least 1 ms.
 	 */
 	msleep(1);
 
-	/* Bring phy back */
+	/* bring phy back */
 	sata_phy_resume(ap);
 
 	/* TODO: phy layer with polling, timeouts, etc. */
@@ -4454,6 +4583,7 @@ static void ata_host_init(struct ata_por
 	ap->flags |= ent->host_flags;
 	ap->ops = ent->port_ops;
 	ap->cbl = ATA_CBL_NONE;
+	ap->sata_spd_limit = UINT_MAX;
 	ap->active_tag = ATA_TAG_POISON;
 	ap->last_ctl = 0xFF;
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 0f8e372..a5207e6 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -397,6 +397,7 @@ struct ata_port {
 	unsigned int		mwdma_mask;
 	unsigned int		udma_mask;
 	unsigned int		cbl;	/* cable type; ATA_CBL_xxx */
+	unsigned int		sata_spd_limit;	/* SATA PHY speed limit */
 
 	struct ata_device	device[ATA_MAX_DEVICES];
 
-- 
1.2.4


