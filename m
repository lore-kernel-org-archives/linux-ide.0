From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/15] libata: add dev->sata_spd_limit and helpers
Date: Sat, 1 Apr 2006 01:38:18 +0900
Message-ID: <11438230982257-git-send-email-htejun@gmail.com>
References: <1143823097579-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:42854 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751410AbWCaQi2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Mar 2006 11:38:28 -0500
Received: by zproxy.gmail.com with SMTP id o37so955013nzf
        for <linux-ide@vger.kernel.org>; Fri, 31 Mar 2006 08:38:28 -0800 (PST)
In-Reply-To: <1143823097579-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

dev->sata_spd_limit contrains SATA PHY speed of the device and is
initialized to the configured value on probing.

Currently, This is only valid for dev[0] but still put into ata_device
instead of ata_port.  This is because 1. it's device constraints
(ie. when hotpluggin, it should be cleared with other device info)
2. for port multiplier, link actually belongs to each device.

Three helper functions - ata_down_sata_spd_limit(),
ata_set_sata_spd_needed() and ata_set_sata_spd() - are implemented.
They will be used by ata_bus_probe() rewrite and later by EH.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |  134 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h     |    3 +
 2 files changed, 137 insertions(+), 0 deletions(-)

d9f82105c7dbc64bcc679b3974147928eccc5fa1
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 5dee649..283994d 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -65,6 +65,7 @@ static unsigned int ata_dev_init_params(
 					struct ata_device *dev,
 					u16 heads,
 					u16 sectors);
+static int ata_down_sata_spd_limit(struct ata_port *ap, struct ata_device *dev);
 static int ata_down_xfermask_limit(struct ata_port *ap, struct ata_device *dev,
 				   int force_pio0);
 static int ata_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev);
@@ -1598,6 +1599,131 @@ void ata_port_disable(struct ata_port *a
 	ap->flags |= ATA_FLAG_PORT_DISABLED;
 }
 
+/**
+ *	ata_down_sata_spd_limit - adjust SATA spd limit downward
+ *	@ap: Port associated with device @dev
+ *	@dev: Device to adjust SATA spd limit
+ *
+ *	Adjust SATA spd limit of @dev downward.  Note that this
+ *	function only adjusts the limit.  The change must be applied
+ *	using ata_set_sata_spd().
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ *
+ *	RETURNS:
+ *	0 on success, negative errno on failure
+ */
+static int ata_down_sata_spd_limit(struct ata_port *ap, struct ata_device *dev)
+{
+	u32 spd, mask;
+	int highbit;
+
+	if (ap->cbl != ATA_CBL_SATA || !ap->ops->scr_read)
+		return -EOPNOTSUPP;
+
+	mask = dev->sata_spd_limit;
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
+	dev->sata_spd_limit = mask;
+
+	printk(KERN_WARNING "ata%u: dev %u limiting SATA link speed to %s\n",
+	       ap->id, dev->devno, sata_spd_string(fls(mask)));
+
+	return 0;
+}
+
+static int __ata_set_sata_spd_needed(struct ata_port *ap,
+				     struct ata_device *dev, u32 *scontrol)
+{
+	u32 spd, limit;
+
+	if (!ata_dev_enabled(dev))
+		return 0;
+
+	if (dev->sata_spd_limit == UINT_MAX)
+		limit = 0;
+	else
+		limit = fls(dev->sata_spd_limit);
+
+	spd = (*scontrol >> 4) & 0xf;
+	*scontrol = (*scontrol & ~0xf0) | ((limit & 0xf) << 4);
+
+	return spd != limit;
+}
+
+/**
+ *	ata_set_sata_spd_needed - is SATA spd configuration needed
+ *	@ap: Port associated with device @dev
+ *	@dev: Device in question
+ *
+ *	Test whether the spd limit in SControl matches
+ *	@dev->sata_spd_limit.  This function is used to determine
+ *	whether hardreset is necessary to apply SATA spd
+ *	configuration.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ *
+ *	RETURNS:
+ *	1 if SATA spd configuration is needed, 0 otherwise.
+ */
+static int ata_set_sata_spd_needed(struct ata_port *ap, struct ata_device *dev)
+{
+	u32 scontrol;
+
+	if (!ata_dev_enabled(dev) ||
+	    ap->cbl != ATA_CBL_SATA || !ap->ops->scr_read)
+		return 0;
+
+	scontrol = scr_read(ap, SCR_CONTROL);
+
+	return __ata_set_sata_spd_needed(ap, dev, &scontrol);
+}
+
+/**
+ *	ata_set_sata_spd - set SATA spd according to spd limit
+ *	@ap: Port associated with device @dev
+ *	@dev: Device to set SATA spd
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
+static int ata_set_sata_spd(struct ata_port *ap, struct ata_device *dev)
+{
+	u32 scontrol;
+
+	if (ap->cbl != ATA_CBL_SATA || !ap->ops->scr_read)
+		return -EOPNOTSUPP;
+
+	if (!ata_dev_enabled(dev))
+		return 0;
+
+	scontrol = scr_read(ap, SCR_CONTROL);
+	if (!__ata_set_sata_spd_needed(ap, dev, &scontrol))
+		return 0;
+
+	scr_write(ap, SCR_CONTROL, scontrol);
+	return 1;
+}
+
 /*
  * This mode timing computation functionality is ported over from
  * drivers/ide/ide-timing.h and was originally written by Vojtech Pavlik
@@ -2215,7 +2341,14 @@ static int sata_phy_resume(struct ata_po
 void ata_std_probeinit(struct ata_port *ap)
 {
 	if ((ap->flags & ATA_FLAG_SATA) && ap->ops->scr_read) {
+		u32 spd;
+
 		sata_phy_resume(ap);
+
+		spd = (scr_read(ap, SCR_CONTROL) & 0xf0) >> 4;
+		if (spd)
+			ap->device[0].sata_spd_limit &= (1 << spd) - 1;
+
 		if (sata_dev_present(ap))
 			ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
 	}
@@ -4512,6 +4645,7 @@ static void ata_host_init(struct ata_por
 		dev->pio_mask = UINT_MAX;
 		dev->mwdma_mask = UINT_MAX;
 		dev->udma_mask = UINT_MAX;
+		dev->sata_spd_limit = UINT_MAX;
 	}
 
 #ifdef ATA_IRQ_TRAP
diff --git a/include/linux/libata.h b/include/linux/libata.h
index c6883ba..d720f5b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -369,6 +369,9 @@ struct ata_device {
 	unsigned int		mwdma_mask;
 	unsigned int		udma_mask;
 
+	/* SATA PHY speed limit */
+	unsigned int		sata_spd_limit;
+
 	/* for CHS addressing */
 	u16			cylinders;	/* Number of cylinders */
 	u16			heads;		/* Number of heads */
-- 
1.2.4


