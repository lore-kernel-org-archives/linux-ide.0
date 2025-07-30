Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD997A921
	for <linux-ide@vger.kernel.org>; Wed, 30 Jul 2025 00:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753834938; cv=none; b=d57Yaj0Ymi2i2j8V8XkxvwKdf3sC4f3aywhT3rx6n9U2177xlWhod+WZRu6bLeH3ZLKJ/MFNlUEu1PoBkp5H+JX4HhdlJHwJk93NM9StQ0rHk2Vrn7CkeVh8+yi0IHIFf57XdhKzw+HmVmBjeuVIQAtjfP7KzCFeEKr9qCVwQC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753834938; c=relaxed/simple;
	bh=VAuRFtDcLeEuntyEuefnoHUteJAVZke/j3cTCVW4cnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RHrBTgToX7Kc4avoUphkr7AgijgqjpsGigMKED8SDJJizsn/Y6xnajRyOufVACy37ffCzSG3CZM8CjsftMhqIacUu3U7uGv4EWILK/UMM7PVHdboyHcCMRjJS6xYw+TKpkWL8/Zw2FsraFry+SA6lEVFFbw0zjq+o0dVLugBq+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/myK7LN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/myK7LN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD23C4CEEF;
	Wed, 30 Jul 2025 00:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753834938;
	bh=VAuRFtDcLeEuntyEuefnoHUteJAVZke/j3cTCVW4cnw=;
	h=From:To:Cc:Subject:Date:From;
	b=h/myK7LNX1HBMWxvKpJ6JqBSq49I5R6tnJAwW3ydfaQ/rethB37fco7QnD9f+gJ5y
	 snMzWLYTGyepb/CeEK0ynjcEXX5FkX7/X6sXz3qRYqWUHrUkpdLUSGZqEOtzBPAKSy
	 KsOkWnR5y9jpsm6GG2oHJWzDlNt4pFjtid5sQXsCms0pNPS+IrWs+DZMK2nBlQYmXP
	 1gAl8aXckLA+T4gLUoXEVqMWrNgzCSx53IGk3XmYkYDqgSlchXF9Tp8TDdgCePB7hy
	 wVwaG9OAighwHj+xkMm/zrvQGHQeecNG3+UI9ZISPG/wrIy3awAB56AFGUNIiz9aHV
	 UM3T0FBukoGvQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Borah,
	Chaitanya Kumar <chaitanya.kumar.borah@intel.com>
Subject: [PATCH] ata: libata-sata: Add link_power_management_supported sysfs attribute
Date: Wed, 30 Jul 2025 09:19:47 +0900
Message-ID: <20250730001947.332661-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A port link power management (LPM) policy can be controlled using the
link_power_management_policy sysfs host attribute. However, this
attribute exists also for hosts that do not support LPM and in such
case, attempting to change the LPM policy for the host (port) will fail
with -EOPNOTSUPP.

Introduce the new sysfs link_power_management_supported host attribute
to indicate to the user if a the port and the devices connected to the
port for the host support LPM, which implies that the
link_power_management_policy attribute can be used.

Since checking that a port and its devices support LPM is common between
the new ata_scsi_lpm_supported_show() function and the existing
ata_scsi_lpm_store() function, the new helper ata_scsi_lpm_supported()
is introduced.

Fixes: 413e800cadbf ("ata: libata-sata: Disallow changing LPM state if not supported")
Reported-by: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202507251014.a5becc3b-lkp@intel.com
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/ata_piix.c    |  1 +
 drivers/ata/libahci.c     |  1 +
 drivers/ata/libata-sata.c | 53 ++++++++++++++++++++++++++++++---------
 include/linux/libata.h    |  1 +
 4 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 229429ba5027..495fa096dd65 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -1089,6 +1089,7 @@ static struct ata_port_operations ich_pata_ops = {
 };
 
 static struct attribute *piix_sidpr_shost_attrs[] = {
+	&dev_attr_link_power_management_supported.attr,
 	&dev_attr_link_power_management_policy.attr,
 	NULL
 };
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index b335fb7e5cb4..c79abdfcd7a9 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -111,6 +111,7 @@ static DEVICE_ATTR(em_buffer, S_IWUSR | S_IRUGO,
 static DEVICE_ATTR(em_message_supported, S_IRUGO, ahci_show_em_supported, NULL);
 
 static struct attribute *ahci_shost_attrs[] = {
+	&dev_attr_link_power_management_supported.attr,
 	&dev_attr_link_power_management_policy.attr,
 	&dev_attr_em_message_type.attr,
 	&dev_attr_em_message.attr,
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 0708686ca58a..2391589d38d1 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -900,14 +900,52 @@ static const char *ata_lpm_policy_names[] = {
 	[ATA_LPM_MIN_POWER]		= "min_power",
 };
 
+/*
+ * Check if a port supports link power management.
+ * Must be called with the port locked.
+ */
+static bool ata_scsi_lpm_supported(struct ata_port *ap)
+{
+	struct ata_link *link;
+	struct ata_device *dev;
+
+	if (ap->flags & ATA_FLAG_NO_LPM)
+		return false;
+
+	ata_for_each_link(link, ap, EDGE) {
+		ata_for_each_dev(dev, &ap->link, ENABLED) {
+			if (dev->quirks & ATA_QUIRK_NOLPM)
+				return false;
+		}
+	}
+
+	return true;
+}
+
+static ssize_t ata_scsi_lpm_supported_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct ata_port *ap = ata_shost_to_port(shost);
+	unsigned long flags;
+	bool supported;
+
+	spin_lock_irqsave(ap->lock, flags);
+	supported = ata_scsi_lpm_supported(ap);
+	spin_unlock_irqrestore(ap->lock, flags);
+
+	return sysfs_emit(buf, "%d\n", supported);
+}
+DEVICE_ATTR(link_power_management_supported, S_IRUGO,
+	    ata_scsi_lpm_supported_show, NULL);
+EXPORT_SYMBOL_GPL(dev_attr_link_power_management_supported);
+
 static ssize_t ata_scsi_lpm_store(struct device *device,
 				  struct device_attribute *attr,
 				  const char *buf, size_t count)
 {
 	struct Scsi_Host *shost = class_to_shost(device);
 	struct ata_port *ap = ata_shost_to_port(shost);
-	struct ata_link *link;
-	struct ata_device *dev;
 	enum ata_lpm_policy policy;
 	unsigned long flags;
 
@@ -924,20 +962,11 @@ static ssize_t ata_scsi_lpm_store(struct device *device,
 
 	spin_lock_irqsave(ap->lock, flags);
 
-	if (ap->flags & ATA_FLAG_NO_LPM) {
+	if (!ata_scsi_lpm_supported(ap)) {
 		count = -EOPNOTSUPP;
 		goto out_unlock;
 	}
 
-	ata_for_each_link(link, ap, EDGE) {
-		ata_for_each_dev(dev, &ap->link, ENABLED) {
-			if (dev->quirks & ATA_QUIRK_NOLPM) {
-				count = -EOPNOTSUPP;
-				goto out_unlock;
-			}
-		}
-	}
-
 	ap->target_lpm_policy = policy;
 	ata_port_schedule_eh(ap);
 out_unlock:
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 1c0580627dbb..e9a6f37bd7f9 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -547,6 +547,7 @@ typedef void (*ata_postreset_fn_t)(struct ata_link *link, unsigned int *classes)
 
 extern struct device_attribute dev_attr_unload_heads;
 #ifdef CONFIG_SATA_HOST
+extern struct device_attribute dev_attr_link_power_management_supported;
 extern struct device_attribute dev_attr_link_power_management_policy;
 extern struct device_attribute dev_attr_ncq_prio_supported;
 extern struct device_attribute dev_attr_ncq_prio_enable;
-- 
2.50.1

