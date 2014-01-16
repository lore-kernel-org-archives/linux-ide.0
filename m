From: Tejun Heo <tj@kernel.org>
Subject: [PATCH] libata: disable LPM for some WD SATA-I devices
Date: Thu, 16 Jan 2014 09:51:36 -0500
Message-ID: <20140116145136.GA23732@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:46041 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389AbaAPOvl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Jan 2014 09:51:41 -0500
Received: by mail-qc0-f178.google.com with SMTP id m20so2335957qcx.23
        for <linux-ide@vger.kernel.org>; Thu, 16 Jan 2014 06:51:39 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Nikos Barkas <levelwol@gmail.com>, Ioannis Barkas <risc4all@yahoo.com>

Applied to libata/for-3.14.

------- 8< -------
>From ecd75ad514d73efc1bbcc5f10a13566c3ace5f53 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Thu, 16 Jan 2014 09:47:17 -0500

For some reason, some early WD drives spin up and down drives
erratically when the link is put into slumber mode which can reduce
the life expectancy of the device significantly.  Unfortunately, we
don't have full list of devices and given the nature of the issue it'd
be better to err on the side of false positives than the other way
around.  Let's disable LPM on all WD devices which match one of the
known problematic model prefixes and are SATA-I.

As horkage list doesn't support matching SATA capabilities, this is
implemented as two horkages - WD_BROKEN_LPM and NOLPM.  The former is
set for the known prefixes and sets the latter if the matched device
is SATA-I.

Note that this isn't optimal as this disables all LPM operations and
partial link power state reportedly works fine on these; however, the
way LPM is implemented in libata makes it difficult to precisely map
libata LPM setting to specific link power state.  Well, these devices
are already fairly outdated.  Let's just disable whole LPM for now.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-and-tested-by: Nikos Barkas <levelwol@gmail.com>
Reported-and-tested-by: Ioannis Barkas <risc4all@yahoo.com>
References: https://bugzilla.kernel.org/show_bug.cgi?id=57211
Cc: stable@vger.kernel.org
---
 drivers/ata/libata-core.c | 27 +++++++++++++++++++++++++++
 drivers/ata/libata-scsi.c | 18 +++++++++++++++---
 include/linux/libata.h    |  2 ++
 3 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 1393a58..1a3dbd1 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2222,6 +2222,16 @@ int ata_dev_configure(struct ata_device *dev)
 	if (rc)
 		return rc;
 
+	/* some WD SATA-1 drives have issues with LPM, turn on NOLPM for them */
+	if ((dev->horkage & ATA_HORKAGE_WD_BROKEN_LPM) &&
+	    (id[ATA_ID_SATA_CAPABILITY] & 0xe) == 0x2)
+		dev->horkage |= ATA_HORKAGE_NOLPM;
+
+	if (dev->horkage & ATA_HORKAGE_NOLPM) {
+		ata_dev_warn(dev, "LPM support broken, forcing max_power\n");
+		dev->link->ap->target_lpm_policy = ATA_LPM_MAX_POWER;
+	}
+
 	/* let ACPI work its magic */
 	rc = ata_acpi_on_devcfg(dev);
 	if (rc)
@@ -4216,6 +4226,23 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "Micron_M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM, },
 	{ "Crucial_CT???M500SSD1",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM, },
 
+	/*
+	 * Some WD SATA-I drives spin up and down erratically when the link
+	 * is put into the slumber mode.  We don't have full list of the
+	 * affected devices.  Disable LPM if the device matches one of the
+	 * known prefixes and is SATA-1.  As a side effect LPM partial is
+	 * lost too.
+	 *
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=57211
+	 */
+	{ "WDC WD800JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
+	{ "WDC WD1200JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
+	{ "WDC WD1600JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
+	{ "WDC WD2000JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
+	{ "WDC WD2500JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
+	{ "WDC WD3000JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
+	{ "WDC WD3200JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
+
 	/* End Marker */
 	{ }
 };
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 176f629..75ef952 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -111,12 +111,14 @@ static const char *ata_lpm_policy_names[] = {
 	[ATA_LPM_MIN_POWER]	= "min_power",
 };
 
-static ssize_t ata_scsi_lpm_store(struct device *dev,
+static ssize_t ata_scsi_lpm_store(struct device *device,
 				  struct device_attribute *attr,
 				  const char *buf, size_t count)
 {
-	struct Scsi_Host *shost = class_to_shost(dev);
+	struct Scsi_Host *shost = class_to_shost(device);
 	struct ata_port *ap = ata_shost_to_port(shost);
+	struct ata_link *link;
+	struct ata_device *dev;
 	enum ata_lpm_policy policy;
 	unsigned long flags;
 
@@ -132,10 +134,20 @@ static ssize_t ata_scsi_lpm_store(struct device *dev,
 		return -EINVAL;
 
 	spin_lock_irqsave(ap->lock, flags);
+
+	ata_for_each_link(link, ap, EDGE) {
+		ata_for_each_dev(dev, &ap->link, ENABLED) {
+			if (dev->horkage & ATA_HORKAGE_NOLPM) {
+				count = -EOPNOTSUPP;
+				goto out_unlock;
+			}
+		}
+	}
+
 	ap->target_lpm_policy = policy;
 	ata_port_schedule_eh(ap);
+out_unlock:
 	spin_unlock_irqrestore(ap->lock, flags);
-
 	return count;
 }
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 9b50337..bec6dbe 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -419,6 +419,8 @@ enum {
 	ATA_HORKAGE_MAX_SEC_LBA48 = (1 << 17),	/* Set max sects to 65535 */
 	ATA_HORKAGE_ATAPI_DMADIR = (1 << 18),	/* device requires dmadir */
 	ATA_HORKAGE_NO_NCQ_TRIM	= (1 << 19),	/* don't use queued TRIM */
+	ATA_HORKAGE_NOLPM	= (1 << 20),	/* don't use LPM */
+	ATA_HORKAGE_WD_BROKEN_LPM = (1 << 21),	/* some WDs have broken LPM */
 
 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */
-- 
1.8.4.2

