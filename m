Received: from out30-70.freemail.mail.aliyun.com (out30-70.freemail.mail.aliyun.com [115.124.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD5A3D88FC;
	Thu, 30 Apr 2026 07:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777534485; cv=none; b=JjiMGvDmreStyUg1Hc3z9FABAGZ2r3RjmTm7Dl4SDBhWBQMIg9/opffLvzRFsAJSnLs8bEl3hz6zhBBob0Q9yyBDWfTP6g27vQ8wx4oBVu5Umq+YIq+yvZJt/CkrZcFvL/y0Z/DnGDq7mymeErbxXqcB7HOmy2kz4ze4QDNzFFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777534485; c=relaxed/simple;
	bh=P9sj3hk0mCZPWcHY9ILG/Es22mpMCVVmn9hdmfE2J5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZfntwsKdAkQYxipD60VyiT9ygL6sKDl35b93ypddmJNQUf0MQWyKciKDtboBzWztU821j1L2G6/zdKX36R9/WgsnfjvDy4voVisIRO8M1o6iAhEXWkIfLUDg72n3utS00FEMap5S1k+l4EZSJ/uDUC1c+XyoFUmDAsOT5yRqbbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com; spf=pass smtp.mailfrom=aliyun.com; dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b=wtaYBWSY; arc=none smtp.client-ip=115.124.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliyun.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="wtaYBWSY"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1777534476; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Y9ydREAEDogILRxFScgPo36dDIpEsk5PId899GH/I9Y=;
	b=wtaYBWSYkSykMLWbjsLHCskIocpdKkfLuCM5d5xulX9Ygg3TsUI7r/W+u7fcsgBAGxSP9Yxw5W64M/b714yIPMbKXXa1Z5ZNqxlEUOjdnPVl+BSeRSgDhHQp/NTtG+ZeckyaPabfPWWC0kw5Rzapd1drhZ7jlgL/f3du+WeAsvs=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07357557|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00609031-0.000238013-0.993672;FP=18194540581231619322|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=wdhh6@aliyun.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---0X2-Gogb_1777534468;
Received: from localhost.localdomain(mailfrom:wdhh6@aliyun.com fp:SMTPD_---0X2-Gogb_1777534468 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 30 Apr 2026 15:34:35 +0800
From: Chaohai Chen <wdhh6@aliyun.com>
To: dlemoal@kernel.org,
	cassel@kernel.org
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chaohai Chen <wdhh6@aliyun.com>
Subject: [PATCH] libata: disable device after repeated media errors
Date: Thu, 30 Apr 2026 15:34:16 +0800
Message-ID: <20260430073417.1803833-1-wdhh6@aliyun.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a SATA device (particularly those behind SAS HBAs using libsas)
hits unrecoverable media errors, it can trigger an infinite EH loop:
the device returns medium error, libata performs a hard reset (which
succeeds since the device is functional), then the upper layer retries
the read to the same bad sector, triggering another EH cycle.

This loop is particularly harmful for SATA devices behind SAS HBAs
because all devices sharing the same Scsi_Host are blocked during
SHOST_RECOVERY, not just the faulty device.

Fix this by tracking media error frequency per device. If a device
triggers more than media_err_limit (default 10) media errors within
a media_err_window (default 60 seconds), disable the device. This
allows the SCSI layer to offline the faulty device and restore I/O
to healthy devices on the same HBA.

The parameters are exposed via sysfs for runtime tuning:
  /sys/class/ata_device/devX.Y/media_err_limit  (rw, 0=disable)
  /sys/class/ata_device/devX.Y/media_err_window (rw, seconds)
  /sys/class/ata_device/devX.Y/media_err_count  (ro, current count)

Signed-off-by: Chaohai Chen <wdhh6@aliyun.com>
---
 drivers/ata/libata-core.c      |  2 +
 drivers/ata/libata-eh.c        | 35 ++++++++++++++++
 drivers/ata/libata-transport.c | 76 ++++++++++++++++++++++++++++++++++
 include/linux/libata.h         | 12 ++++++
 4 files changed, 125 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e76d15411e2a..9ea32ed53156 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5559,6 +5559,8 @@ void ata_dev_init(struct ata_device *dev)
 	dev->pio_mask = UINT_MAX;
 	dev->mwdma_mask = UINT_MAX;
 	dev->udma_mask = UINT_MAX;
+	dev->media_err_limit = ATA_EH_MEDIA_ERR_LIMIT;
+	dev->media_err_window = ATA_EH_MEDIA_ERR_WINDOW;
 }
 
 /**
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 9a4b67b90b17..9fc78020ac7e 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2419,12 +2419,47 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 		      ata_dev_enabled(link->device))))
 	    dev = link->device;
 
+	/*
+	 * Track repeated media errors. If the same device hits media errors
+	 * too many times within a configurable time window, disable it to
+	 * prevent infinite EH loops that block other devices sharing the
+	 * same Scsi_Host (particularly relevant for SATA devices behind
+	 * SAS HBAs using libsas).
+	 *
+	 * media_err_limit == 0 means this feature is disabled.
+	 */
+	if (dev && (all_err_mask & AC_ERR_MEDIA) && dev->media_err_limit) {
+		unsigned long now = jiffies;
+		unsigned long window = (unsigned long)dev->media_err_window * HZ;
+
+		if (!dev->media_err_count ||
+		    time_after(now, dev->media_err_first_jiffies + window)) {
+			dev->media_err_count = 1;
+			dev->media_err_first_jiffies = now;
+		} else {
+			dev->media_err_count++;
+		}
+
+		if (dev->media_err_count >= dev->media_err_limit) {
+			ata_dev_err(dev,
+				"too many media errors (%u in %u seconds), disabling device\n",
+				dev->media_err_count,
+				jiffies_to_msecs(now - dev->media_err_first_jiffies) / 1000);
+			ata_dev_disable(dev);
+			dev->media_err_count = 0;
+			/* skip speed_down for disabled device */
+			goto out_autopsy;
+		}
+	}
+
 	if (dev) {
 		if (dev->flags & ATA_DFLAG_DUBIOUS_XFER)
 			eflags |= ATA_EFLAG_DUBIOUS_XFER;
 		ehc->i.action |= ata_eh_speed_down(dev, eflags, all_err_mask);
 		trace_ata_eh_link_autopsy(dev, ehc->i.action, all_err_mask);
 	}
+out_autopsy:
+	return;
 }
 
 /**
diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 95862dc34419..c73a0bf0eeb7 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -477,6 +477,79 @@ show_ata_dev_trim(struct device *dev,
 
 static DEVICE_ATTR(trim, S_IRUGO, show_ata_dev_trim, NULL);
 
+static ssize_t
+media_err_limit_show(struct device *dev,
+		     struct device_attribute *attr, char *buf)
+{
+	struct ata_device *ata_dev = transport_class_to_dev(dev);
+
+	return sysfs_emit(buf, "%u\n", ata_dev->media_err_limit);
+}
+
+static ssize_t
+media_err_limit_store(struct device *dev,
+		      struct device_attribute *attr,
+		      const char *buf, size_t count)
+{
+	struct ata_device *ata_dev = transport_class_to_dev(dev);
+	unsigned int val;
+	int rc;
+
+	rc = kstrtouint(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	ata_dev->media_err_limit = val;
+	ata_dev->media_err_count = 0;
+	return count;
+}
+
+static DEVICE_ATTR_RW(media_err_limit);
+
+static ssize_t
+media_err_window_show(struct device *dev,
+		      struct device_attribute *attr, char *buf)
+{
+	struct ata_device *ata_dev = transport_class_to_dev(dev);
+
+	return sysfs_emit(buf, "%u\n", ata_dev->media_err_window);
+}
+
+static ssize_t
+media_err_window_store(struct device *dev,
+		       struct device_attribute *attr,
+		       const char *buf, size_t count)
+{
+	struct ata_device *ata_dev = transport_class_to_dev(dev);
+	unsigned int val;
+	int rc;
+
+	rc = kstrtouint(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	/* window=0 would prevent the counter from ever accumulating */
+	if (!val)
+		return -EINVAL;
+
+	ata_dev->media_err_window = val;
+	ata_dev->media_err_count = 0;
+	return count;
+}
+
+static DEVICE_ATTR_RW(media_err_window);
+
+static ssize_t
+media_err_count_show(struct device *dev,
+		     struct device_attribute *attr, char *buf)
+{
+	struct ata_device *ata_dev = transport_class_to_dev(dev);
+
+	return sysfs_emit(buf, "%u\n", ata_dev->media_err_count);
+}
+
+static DEVICE_ATTR_RO(media_err_count);
+
 static const struct attribute *const ata_device_attr_attrs[] = {
 	&dev_attr_class.attr,
 	&dev_attr_pio_mode.attr,
@@ -487,6 +560,9 @@ static const struct attribute *const ata_device_attr_attrs[] = {
 	&dev_attr_id.attr,
 	&dev_attr_gscr.attr,
 	&dev_attr_trim.attr,
+	&dev_attr_media_err_limit.attr,
+	&dev_attr_media_err_window.attr,
+	&dev_attr_media_err_count.attr,
 	NULL
 };
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5c085ef4eda7..8715704e06a6 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -419,6 +419,11 @@ enum {
 	ATA_EH_PMP_TRIES	= 5,
 	ATA_EH_PMP_LINK_TRIES	= 3,
 
+	/* default: disable device after this many media errors in time window */
+	ATA_EH_MEDIA_ERR_LIMIT	= 10,
+	/* default: time window in seconds */
+	ATA_EH_MEDIA_ERR_WINDOW	= 60,
+
 	SATA_PMP_RW_TIMEOUT	= 3000,		/* PMP read/write timeout */
 
 	/* This should match the actual table size of
@@ -786,6 +791,13 @@ struct ata_device {
 
 	/* error history */
 	int			spdn_cnt;
+
+	/* media error tracking for repeated EH */
+	unsigned int		media_err_count;
+	unsigned long		media_err_first_jiffies;
+	unsigned int		media_err_limit;
+	unsigned int		media_err_window;
+
 	/* ering is CLEAR_END, read comment above CLEAR_END */
 	struct ata_ering	ering;
 
-- 
2.43.7

