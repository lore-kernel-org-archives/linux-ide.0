From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/15] libata: implement PM EH actions
Date: Sat, 24 Jun 2006 20:30:19 +0900
Message-ID: <11511486193966-git-send-email-htejun@gmail.com>
References: <11511486183271-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.200]:50821 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S933039AbWFXLaN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Jun 2006 07:30:13 -0400
Received: by nz-out-0102.google.com with SMTP id z31so964564nzd
        for <linux-ide@vger.kernel.org>; Sat, 24 Jun 2006 04:30:13 -0700 (PDT)
In-Reply-To: <11511486183271-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement two PM per-dev EH actions - ATA_EH_SUSPEND and
ATA_EH_RESUME.  These two actions put the target device into suspended
mode and resumes from it respectively.

Once a device is put to suspended mode, no EH operations other than
RESUME is allowed on the device.  The device will stay suspended till
it gets resumed and thus reset and revalidated.  To implement this, a
new device state helper - ata_dev_ready() - is implemented and used
over various EH action implementations to operate only on attached &
running devices.

Also, if all possible devices on a port are suspended, reset is
skipped too.  This prevents spurious events including hotplug events
from disrupting suspended devices.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    5 +
 drivers/scsi/libata-eh.c   |  192 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h     |   11 ++-
 3 files changed, 203 insertions(+), 5 deletions(-)

48af6e94fe14a236934c3e3127ab2a5276ef54ee
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 60e80e3..ab6ae1f 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2131,7 +2131,7 @@ int ata_set_mode(struct ata_port *ap, st
 		 * return error code and failing device on failure.
 		 */
 		for (i = 0; i < ATA_MAX_DEVICES; i++) {
-			if (ata_dev_enabled(&ap->device[i])) {
+			if (ata_dev_ready(&ap->device[i])) {
 				ap->ops->set_mode(ap);
 				break;
 			}
@@ -2197,7 +2197,8 @@ int ata_set_mode(struct ata_port *ap, st
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		dev = &ap->device[i];
 
-		if (!ata_dev_enabled(dev))
+		/* don't udpate suspended devices' xfer mode */
+		if (!ata_dev_ready(dev))
 			continue;
 
 		rc = ata_dev_set_mode(dev);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index bf5a72a..f05334a 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -760,8 +760,13 @@ static void ata_eh_about_to_do(struct at
 	unsigned long flags;
 
 	spin_lock_irqsave(ap->lock, flags);
+
 	ata_eh_clear_action(dev, &ap->eh_info, action);
-	ap->flags |= ATA_FLAG_RECOVERED;
+
+	/* set RECOVERED iff we're gonna perform real recovery */
+	if (!(action & (ATA_EH_SUSPEND | ATA_EH_RESUME)))
+		ap->flags |= ATA_FLAG_RECOVERED;
+
 	spin_unlock_irqrestore(ap->lock, flags);
 }
 
@@ -1605,7 +1610,7 @@ static int ata_eh_revalidate_and_attach(
 		dev = &ap->device[i];
 		action = ata_eh_dev_action(dev);
 
-		if (action & ATA_EH_REVALIDATE && ata_dev_enabled(dev)) {
+		if (action & ATA_EH_REVALIDATE && ata_dev_ready(dev)) {
 			if (ata_port_offline(ap)) {
 				rc = -EIO;
 				break;
@@ -1648,6 +1653,164 @@ static int ata_eh_revalidate_and_attach(
 	return rc;
 }
 
+/**
+ *	ata_eh_suspend - handle suspend EH action
+ *	@ap: target host port
+ *	@r_failed_dev: result parameter to indicate failing device
+ *
+ *	Handle suspend EH action.  Disk devices are spinned down and
+ *	other types of devices are just marked suspended.  Once
+ *	suspended, no EH action to the device is allowed until it is
+ *	resumed.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise
+ */
+static int ata_eh_suspend(struct ata_port *ap, struct ata_device **r_failed_dev)
+{
+	struct ata_device *dev;
+	int i, rc = 0;
+
+	DPRINTK("ENTER\n");
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		unsigned long flags;
+		unsigned int action, err_mask;
+
+		dev = &ap->device[i];
+		action = ata_eh_dev_action(dev);
+
+		if (!ata_dev_enabled(dev) || !(action & ATA_EH_SUSPEND))
+			continue;
+
+		WARN_ON(dev->flags & ATA_DFLAG_SUSPENDED);
+
+		ata_eh_about_to_do(ap, dev, ATA_EH_SUSPEND);
+
+		if (dev->class == ATA_DEV_ATA && !(action & ATA_EH_PM_FREEZE)) {
+			/* flush cache */
+			rc = ata_flush_cache(dev);
+			if (rc)
+				break;
+
+			/* spin down */
+			err_mask = ata_do_simple_cmd(dev, ATA_CMD_STANDBYNOW1);
+			if (err_mask) {
+				ata_dev_printk(dev, KERN_ERR, "failed to "
+					       "spin down (err_mask=0x%x)\n",
+					       err_mask);
+				rc = -EIO;
+				break;
+			}
+		}
+
+		spin_lock_irqsave(ap->lock, flags);
+		dev->flags |= ATA_DFLAG_SUSPENDED;
+		spin_unlock_irqrestore(ap->lock, flags);
+
+		ata_eh_done(ap, dev, ATA_EH_SUSPEND);
+	}
+
+	if (rc)
+		*r_failed_dev = dev;
+
+	DPRINTK("EXIT\n");
+	return 0;
+}
+
+/**
+ *	ata_eh_prep_resume - prep for resume EH action
+ *	@ap: target host port
+ *
+ *	Clear SUSPENDED in preparation for scheduled resume actions.
+ *	This allows other parts of EH to access the devices being
+ *	resumed.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+static void ata_eh_prep_resume(struct ata_port *ap)
+{
+	struct ata_device *dev;
+	unsigned long flags;
+	int i;
+
+	DPRINTK("ENTER\n");
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		unsigned int action;
+
+		dev = &ap->device[i];
+		action = ata_eh_dev_action(dev);
+
+		if (!ata_dev_enabled(dev) || !(action & ATA_EH_RESUME))
+			continue;
+
+		spin_lock_irqsave(&ap->host_set->lock, flags);
+		dev->flags &= ~ATA_DFLAG_SUSPENDED;
+		spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	}
+
+	DPRINTK("EXIT\n");
+}
+
+/**
+ *	ata_eh_resume - handle resume EH action
+ *	@ap: target host port
+ *	@r_failed_dev: result parameter to indicate failing device
+ *
+ *	Handle resume EH action.  Target devices are already reset and
+ *	revalidated.  Spinning up is the only operation left.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise
+ */
+static int ata_eh_resume(struct ata_port *ap, struct ata_device **r_failed_dev)
+{
+	struct ata_device *dev;
+	int i, rc = 0;
+
+	DPRINTK("ENTER\n");
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		unsigned int action, err_mask;
+
+		dev = &ap->device[i];
+		action = ata_eh_dev_action(dev);
+
+		if (!ata_dev_enabled(dev) || !(action & ATA_EH_RESUME))
+			continue;
+
+		ata_eh_about_to_do(ap, dev, ATA_EH_RESUME);
+
+		if (dev->class == ATA_DEV_ATA && !(action & ATA_EH_PM_FREEZE)) {
+			err_mask = ata_do_simple_cmd(dev,
+						     ATA_CMD_IDLEIMMEDIATE);
+			if (err_mask) {
+				ata_dev_printk(dev, KERN_ERR, "failed to "
+					       "spin up (err_mask=0x%x)\n",
+					       err_mask);
+				rc = -EIO;
+				break;
+			}
+		}
+
+		ata_eh_done(ap, dev, ATA_EH_RESUME);
+	}
+
+	if (rc)
+		*r_failed_dev = dev;
+
+	DPRINTK("EXIT\n");
+	return 0;
+}
+
 static int ata_port_nr_enabled(struct ata_port *ap)
 {
 	int i, cnt = 0;
@@ -1673,6 +1836,18 @@ static int ata_eh_skip_recovery(struct a
 	struct ata_eh_context *ehc = &ap->eh_context;
 	int i;
 
+	/* skip if all possible devices are suspended */
+	for (i = 0; i < ata_port_max_devices(ap); i++) {
+		struct ata_device *dev = &ap->device[i];
+
+		if (ata_dev_absent(dev) || ata_dev_ready(dev))
+			break;
+	}
+
+	if (i == ata_port_max_devices(ap))
+		return 1;
+
+	/* always thaw frozen port and recover failed devices */
 	if (ap->flags & ATA_FLAG_FROZEN || ata_port_nr_enabled(ap))
 		return 0;
 
@@ -1747,6 +1922,9 @@ static int ata_eh_recover(struct ata_por
 	if (ap->flags & ATA_FLAG_UNLOADING)
 		goto out;
 
+	/* prep for resume */
+	ata_eh_prep_resume(ap);
+
 	/* skip EH if possible. */
 	if (ata_eh_skip_recovery(ap))
 		ehc->i.action = 0;
@@ -1774,6 +1952,11 @@ static int ata_eh_recover(struct ata_por
 	if (rc)
 		goto dev_fail;
 
+	/* resume devices */
+	rc = ata_eh_resume(ap, &dev);
+	if (rc)
+		goto dev_fail;
+
 	/* configure transfer mode if the port has been reset */
 	if (ehc->i.flags & ATA_EHI_DID_RESET) {
 		rc = ata_set_mode(ap, &dev);
@@ -1783,6 +1966,11 @@ static int ata_eh_recover(struct ata_por
 		}
 	}
 
+	/* suspend devices */
+	rc = ata_eh_suspend(ap, &dev);
+	if (rc)
+		goto dev_fail;
+
 	goto out;
 
  dev_fail:
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 3afd009..6b582da 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -130,6 +130,7 @@ enum {
 	ATA_DFLAG_CFG_MASK	= (1 << 8) - 1,
 
 	ATA_DFLAG_PIO		= (1 << 8), /* device currently in PIO mode */
+	ATA_DFLAG_SUSPENDED	= (1 << 9), /* device suspended */
 	ATA_DFLAG_INIT_MASK	= (1 << 16) - 1,
 
 	ATA_DFLAG_DETACH	= (1 << 16),
@@ -247,9 +248,12 @@ enum {
 	ATA_EH_REVALIDATE	= (1 << 0),
 	ATA_EH_SOFTRESET	= (1 << 1),
 	ATA_EH_HARDRESET	= (1 << 2),
+	ATA_EH_SUSPEND		= (1 << 3),
+	ATA_EH_RESUME		= (1 << 4),
 
 	ATA_EH_RESET_MASK	= ATA_EH_SOFTRESET | ATA_EH_HARDRESET,
-	ATA_EH_PERDEV_MASK	= ATA_EH_REVALIDATE,
+	ATA_EH_PERDEV_MASK	= ATA_EH_REVALIDATE |
+				  ATA_EH_SUSPEND | ATA_EH_RESUME,
 
 	/* ata_eh_info->flags */
 	ATA_EHI_HOTPLUGGED	= (1 << 0),  /* could have been hotplugged */
@@ -920,6 +924,11 @@ static inline unsigned int ata_dev_absen
 	return ata_class_absent(dev->class);
 }
 
+static inline unsigned int ata_dev_ready(const struct ata_device *dev)
+{
+	return ata_dev_enabled(dev) && !(dev->flags & ATA_DFLAG_SUSPENDED);
+}
+
 /*
  * port helpers
  */
-- 
1.3.2


