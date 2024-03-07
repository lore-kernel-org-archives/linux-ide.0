Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E574A13B7B3
	for <linux-ide@vger.kernel.org>; Thu,  7 Mar 2024 21:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709847868; cv=none; b=F55Z8/8h4Q/Vgb3Fzv4Ey9jkK2H5wlf0zo8byf9pdgt/vqTawNZ1JVNlwhVnUs28Fr0R6rxWzWk9GTlabgJSxSuUMZuVzzouB/pERGXYCi48wtxG4BtxBt/D8wLmOTy1p43FMNtNFmmOZRu+O1ARkMVBoqsguQdfH+Eh/BauuBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709847868; c=relaxed/simple;
	bh=G0ZUJP/ZkBCOmzQOJc1xI74aPKgFFLAXayJWxtULjxc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nPm3llNBNr+c6rJNHH3OPW9MX0dDZ/hhjqMMC4mMPRSraU3W9sOWp3QcPTtfD6A5mSSQFvK1HZIACCDecm7ZhRTQXQVh2JZQj1GuuLwNa6AAS+5FnxNr94dhcG0sbmi45N5xrGdIL0dhe0Jtddo+PpQikIlEE2ojasaXWWbh61E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NBcSLfu1; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NBcSLfu1"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609ff3206c3so9758397b3.2
        for <linux-ide@vger.kernel.org>; Thu, 07 Mar 2024 13:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709847866; x=1710452666; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6LhSYtY6QZt6fH5eAYaAFVA5m0RDdwnpK0pNKamW+So=;
        b=NBcSLfu1DLWTObnvS35sATCi8ie+/+raGwP2HjT+e32a757kLP7q+JNHbd/dphXARy
         6gK7WnjH/lIugobtSSeQMTRTWSDeQH4zP9O1c11EOHH73kb1QxZdHe8PNBawWCBy2RVV
         ACqGFm6L/nTH/r2NSyVjH0a4/LSxJRMt8gu5KKW0Gzs77aAxEYl19Z5e8+cpmCgRBVPN
         2trFWG/N5M7TAW5RBC8o2yRnAeZ4vD6CQCifH2FXO3XJKeBEa5MMpevJNwcHztIrU21E
         u0rdTEiowvo6lilOyVTHzOISuLfdxfJy4OEtXfmybHqOQD2aefzV5gFgBAjQs9gxKNh8
         e4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709847866; x=1710452666;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6LhSYtY6QZt6fH5eAYaAFVA5m0RDdwnpK0pNKamW+So=;
        b=VFJ6FiJ7/wr33BmDwODDEwRxspd6zpMwke7xwTMxMaeU4ZAFvPhL/wweK+Av7uZJjS
         YbqHrqoLC0GFz/0SCPgUufy/7hLnJCYPMqODa3OS5yibexIqCQ9m99zoSQP7wXe6YuaU
         JUMiUzKVNEhIqByWH1Lfo8R8MsXbnuSU2xtX1u1VytaQMkiQtlbNpRCxCTyNQzxn+NsX
         NiDkIVlD3z85kcOzkP4kFIruZ1ZEMBjlKRz39eeFaUQgSnVVe+2go8V4RYCEMWn+OH4x
         L+FVYHOZmuow7KJeVMNxH/S5f2TJq3/2/urlh1tZeMVBO3HaSJsAaUmQ+dSvE878UZnX
         eXCA==
X-Forwarded-Encrypted: i=1; AJvYcCWd/NM5wPuxvckxZ2C1vKgyLfhNAo72U6DVOAS11eHDulusBoOi3GuhtPuXL4h34s48I1dy5IID/xHEiTyydoVX6qddvEbTAD3Z
X-Gm-Message-State: AOJu0YzygFKIiNo8dVZEAbcNVQEYlLli7piA0/Bal2v49DECphWXQlf9
	4fmJBC4XtTQVgM6IL9pMiqXvNa+jjXlgkjirHokItkfGujkjhz/7sm4mxqET4RXuTcDVqOYUwgG
	b5wQxlMadPw==
X-Google-Smtp-Source: AGHT+IH27M/JdvXhcgEPeKFtc+MyRJkzfUjHkwRS3/BAdp+NGrPpYuJmdjyCUfGJsC+OS42qDiD9lhL2aaJPzg==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:69c0:c447:593d:278c])
 (user=ipylypiv job=sendgmr) by 2002:a0d:d801:0:b0:609:ed23:8658 with SMTP id
 a1-20020a0dd801000000b00609ed238658mr944033ywe.8.1709847866113; Thu, 07 Mar
 2024 13:44:26 -0800 (PST)
Date: Thu,  7 Mar 2024 13:44:12 -0800
In-Reply-To: <20240307214418.3812290-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307214418.3812290-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307214418.3812290-2-ipylypiv@google.com>
Subject: [PATCH v8 1/7] ata: libata-sata: Factor out NCQ Priority
 configuration helpers
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Jason Yan <yanaijie@huawei.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>, 
	Xiang Chen <chenxiang66@hisilicon.com>, Artur Paszkiewicz <artur.paszkiewicz@intel.com>, 
	Bart Van Assche <bvanassche@acm.org>
Cc: TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

Export libata NCQ Priority configuration helpers to be reused
for libsas managed SATA devices.

Switched locking from spin_lock_irq() to spin_lock_irqsave().
In the future someone might call these helper functions when interrupts
are disabled. spin_unlock_irq() could lead to a premature re-enabling
of interrupts, whereas spin_unlock_irqrestore() restores the interrupt
state to its condition prior to the spin_lock_irqsave() call.

Acked-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Jason Yan <yanaijie@huawei.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-sata.c | 160 +++++++++++++++++++++++++++++---------
 include/linux/libata.h    |   6 ++
 2 files changed, 128 insertions(+), 38 deletions(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 0fb1934875f2..a8d773003d74 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -848,80 +848,143 @@ DEVICE_ATTR(link_power_management_policy, S_IRUGO | S_IWUSR,
 	    ata_scsi_lpm_show, ata_scsi_lpm_store);
 EXPORT_SYMBOL_GPL(dev_attr_link_power_management_policy);
 
-static ssize_t ata_ncq_prio_supported_show(struct device *device,
-					   struct device_attribute *attr,
-					   char *buf)
+/**
+ *	ata_ncq_prio_supported - Check if device supports NCQ Priority
+ *	@ap: ATA port of the target device
+ *	@sdev: SCSI device
+ *	@supported: Address of a boolean to store the result
+ *
+ *	Helper to check if device supports NCQ Priority feature.
+ *
+ *	Context: Any context. Takes and releases @ap->lock.
+ *
+ *	Return:
+ *	* %0		- OK. Status is stored into @supported
+ *	* %-ENODEV	- Failed to find the ATA device
+ */
+int ata_ncq_prio_supported(struct ata_port *ap, struct scsi_device *sdev,
+			   bool *supported)
 {
-	struct scsi_device *sdev = to_scsi_device(device);
-	struct ata_port *ap = ata_shost_to_port(sdev->host);
 	struct ata_device *dev;
-	bool ncq_prio_supported;
+	unsigned long flags;
 	int rc = 0;
 
-	spin_lock_irq(ap->lock);
+	spin_lock_irqsave(ap->lock, flags);
 	dev = ata_scsi_find_dev(ap, sdev);
 	if (!dev)
 		rc = -ENODEV;
 	else
-		ncq_prio_supported = dev->flags & ATA_DFLAG_NCQ_PRIO;
-	spin_unlock_irq(ap->lock);
+		*supported = dev->flags & ATA_DFLAG_NCQ_PRIO;
+	spin_unlock_irqrestore(ap->lock, flags);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(ata_ncq_prio_supported);
+
+static ssize_t ata_ncq_prio_supported_show(struct device *device,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct scsi_device *sdev = to_scsi_device(device);
+	struct ata_port *ap = ata_shost_to_port(sdev->host);
+	bool supported;
+	int rc;
+
+	rc = ata_ncq_prio_supported(ap, sdev, &supported);
+	if (rc)
+		return rc;
 
-	return rc ? rc : sysfs_emit(buf, "%u\n", ncq_prio_supported);
+	return sysfs_emit(buf, "%d\n", supported);
 }
 
 DEVICE_ATTR(ncq_prio_supported, S_IRUGO, ata_ncq_prio_supported_show, NULL);
 EXPORT_SYMBOL_GPL(dev_attr_ncq_prio_supported);
 
-static ssize_t ata_ncq_prio_enable_show(struct device *device,
-					struct device_attribute *attr,
-					char *buf)
+/**
+ *	ata_ncq_prio_enabled - Check if NCQ Priority is enabled
+ *	@ap: ATA port of the target device
+ *	@sdev: SCSI device
+ *	@enabled: Address of a boolean to store the result
+ *
+ *	Helper to check if NCQ Priority feature is enabled.
+ *
+ *	Context: Any context. Takes and releases @ap->lock.
+ *
+ *	Return:
+ *	* %0		- OK. Status is stored into @enabled
+ *	* %-ENODEV	- Failed to find the ATA device
+ */
+int ata_ncq_prio_enabled(struct ata_port *ap, struct scsi_device *sdev,
+			 bool *enabled)
 {
-	struct scsi_device *sdev = to_scsi_device(device);
-	struct ata_port *ap = ata_shost_to_port(sdev->host);
 	struct ata_device *dev;
-	bool ncq_prio_enable;
+	unsigned long flags;
 	int rc = 0;
 
-	spin_lock_irq(ap->lock);
+	spin_lock_irqsave(ap->lock, flags);
 	dev = ata_scsi_find_dev(ap, sdev);
 	if (!dev)
 		rc = -ENODEV;
 	else
-		ncq_prio_enable = dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLED;
-	spin_unlock_irq(ap->lock);
+		*enabled = dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLED;
+	spin_unlock_irqrestore(ap->lock, flags);
 
-	return rc ? rc : sysfs_emit(buf, "%u\n", ncq_prio_enable);
+	return rc;
 }
+EXPORT_SYMBOL_GPL(ata_ncq_prio_enabled);
 
-static ssize_t ata_ncq_prio_enable_store(struct device *device,
-					 struct device_attribute *attr,
-					 const char *buf, size_t len)
+static ssize_t ata_ncq_prio_enable_show(struct device *device,
+					struct device_attribute *attr,
+					char *buf)
 {
 	struct scsi_device *sdev = to_scsi_device(device);
-	struct ata_port *ap;
-	struct ata_device *dev;
-	long int input;
-	int rc = 0;
+	struct ata_port *ap = ata_shost_to_port(sdev->host);
+	bool enabled;
+	int rc;
 
-	rc = kstrtol(buf, 10, &input);
+	rc = ata_ncq_prio_enabled(ap, sdev, &enabled);
 	if (rc)
 		return rc;
-	if ((input < 0) || (input > 1))
-		return -EINVAL;
 
-	ap = ata_shost_to_port(sdev->host);
-	dev = ata_scsi_find_dev(ap, sdev);
-	if (unlikely(!dev))
-		return  -ENODEV;
+	return sysfs_emit(buf, "%d\n", enabled);
+}
+
+/**
+ *	ata_ncq_prio_enable - Enable/disable NCQ Priority
+ *	@ap: ATA port of the target device
+ *	@sdev: SCSI device
+ *	@enable: true - enable NCQ Priority, false - disable NCQ Priority
+ *
+ *	Helper to enable/disable NCQ Priority feature.
+ *
+ *	Context: Any context. Takes and releases @ap->lock.
+ *
+ *	Return:
+ *	* %0		- OK. Status is stored into @enabled
+ *	* %-ENODEV	- Failed to find the ATA device
+ *	* %-EINVAL	- NCQ Priority is not supported or CDL is enabled
+ */
+int ata_ncq_prio_enable(struct ata_port *ap, struct scsi_device *sdev,
+			bool enable)
+{
+	struct ata_device *dev;
+	unsigned long flags;
+	int rc = 0;
+
+	spin_lock_irqsave(ap->lock, flags);
 
-	spin_lock_irq(ap->lock);
+	dev = ata_scsi_find_dev(ap, sdev);
+	if (!dev) {
+		rc = -ENODEV;
+		goto unlock;
+	}
 
 	if (!(dev->flags & ATA_DFLAG_NCQ_PRIO)) {
 		rc = -EINVAL;
 		goto unlock;
 	}
 
-	if (input) {
+	if (enable) {
 		if (dev->flags & ATA_DFLAG_CDL_ENABLED) {
 			ata_dev_err(dev,
 				"CDL must be disabled to enable NCQ priority\n");
@@ -934,9 +997,30 @@ static ssize_t ata_ncq_prio_enable_store(struct device *device,
 	}
 
 unlock:
-	spin_unlock_irq(ap->lock);
+	spin_unlock_irqrestore(ap->lock, flags);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(ata_ncq_prio_enable);
+
+static ssize_t ata_ncq_prio_enable_store(struct device *device,
+					 struct device_attribute *attr,
+					 const char *buf, size_t len)
+{
+	struct scsi_device *sdev = to_scsi_device(device);
+	struct ata_port *ap = ata_shost_to_port(sdev->host);
+	bool enable;
+	int rc;
+
+	rc = kstrtobool(buf, &enable);
+	if (rc)
+		return rc;
+
+	rc = ata_ncq_prio_enable(ap, sdev, enable);
+	if (rc)
+		return rc;
 
-	return rc ? rc : len;
+	return len;
 }
 
 DEVICE_ATTR(ncq_prio_enable, S_IRUGO | S_IWUSR,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 26d68115afb8..6dd9a4f9ca7c 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1157,6 +1157,12 @@ extern int ata_scsi_change_queue_depth(struct scsi_device *sdev,
 				       int queue_depth);
 extern int ata_change_queue_depth(struct ata_port *ap, struct scsi_device *sdev,
 				  int queue_depth);
+extern int ata_ncq_prio_supported(struct ata_port *ap, struct scsi_device *sdev,
+				  bool *supported);
+extern int ata_ncq_prio_enabled(struct ata_port *ap, struct scsi_device *sdev,
+				bool *enabled);
+extern int ata_ncq_prio_enable(struct ata_port *ap, struct scsi_device *sdev,
+			       bool enable);
 extern struct ata_device *ata_dev_pair(struct ata_device *adev);
 extern int ata_do_set_mode(struct ata_link *link, struct ata_device **r_failed_dev);
 extern void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap);
-- 
2.44.0.278.ge034bb2e1d-goog

