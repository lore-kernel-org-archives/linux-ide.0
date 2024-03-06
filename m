Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF9DDDB1
	for <linux-ide@vger.kernel.org>; Wed,  6 Mar 2024 01:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709688157; cv=none; b=kk8fLMF0CEcXtswhR/b3fD95+B1c08kpYPUdnfCmO74PSePxk4W1hrRCkmWTh53rQbtJKCz5ZTHdrl0sEmonpZkj6b5Xz3U81Lsb5xkwWdU5c12oYGiPxZk8Cbl5LJoD1XLN7whJVxtTkBb940FN6D6JuwHnqaJN7POuHdhvMLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709688157; c=relaxed/simple;
	bh=n4LxPfG7AS9Lalbw6aTzUiw335yJJpF6kZEovqNpXTU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kK9jhtdHYKYmQZQL2n4xDqguAmaTyVX1GtRXqBSL0h0YAlDPh0JdE5e1a6KOqstINno4VJQ1LxYOSL8wEVasC3cgDYQbM5Aozihy57rue8gaxgsk4chGM6hz0rReRwOIGhMaukQLgke8q/Ru9h7/W1IOynMbPDOa0KeDiVteeCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LlQ3keOV; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LlQ3keOV"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60966f363c1so92662397b3.3
        for <linux-ide@vger.kernel.org>; Tue, 05 Mar 2024 17:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709688154; x=1710292954; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FSTiKWyL/nnmXNuU8GslZSbybClSIgn/PnMeem+fE3I=;
        b=LlQ3keOVH1NiKBPBhsf5A6vyC8eD6hnFfuv0bBkDPnuXWYgqztQh54V6SIZUWLfTQ3
         PzbsRCqTjYVW+93+1QAiOGofnAPiybsek0FzmCfFv7WEPZth4Zj/ZWOLFZ/XHh18Jfp8
         WmHGE+4IEb4MB8BrAiUT1IqLGWz/mAGFHzbHuAiQDuJF/bgLXP0yl2NPzlhxz3vLP4+h
         4dpk0/urSBvTM7mjW9OXC3kCyHLsFdjj/MfmoLasQR/HhvkGXwoCBtx744wMndxkRXqH
         QHExQyfixRfYIvJ18Tb46A5Bj40QgTIssmQNyafQNHRA/ssiCNK4vtN3/AfcxnZvkd0x
         /g8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709688154; x=1710292954;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FSTiKWyL/nnmXNuU8GslZSbybClSIgn/PnMeem+fE3I=;
        b=RKBa8HdxnvxCybqknEpy9F1VREbGM6BWlrvhqDbDUJPxn9iGtIprnulscZE6awsuTC
         AErj74qVgLw1a+Die3SV8oBy+e3Emzm8cMtc06ca2Y0QCXwrCOwVN+LYH513JYRuSv5u
         dw5XVMVFIUDg6DiEJ3tdls4vg6bkmwKmrpEXVoa4kMW3hE/saN/yECzy8C8G27/+aK/d
         HKgHghlhqASu1jZ5IPP8HrZDi6I4QyKaxeEiRYCO5TEv0o6HQrVXv6CEzLtQtr0ydj27
         hMuYq0+h0iHeOWDIi/+UfxvjJm2PmnaohHXJwuV9RvYtaiXdMV7lgYqd+8+hfG3yTo4c
         aj8w==
X-Forwarded-Encrypted: i=1; AJvYcCX2SVPOZJPFERllJ0mMNwTL822a2YDL0QfoEPXWDrcMGxXSKlroe3dmlpQnREtykFvTsJolGyZBhFU8NEzwCrcom2gz9BP7Bi3j
X-Gm-Message-State: AOJu0YyGOB/CW3T9bPJc7meViLI6ShnKu+R6DYNs1kEW03VSkNioGrf8
	ZTwJWn6HEVh85xjO/xfce5r+6B/zLyCuhmQLYe/sk/wNqCAeD//d4e2RPcw37rxzm5bhc+m252X
	xVU7btDNTig==
X-Google-Smtp-Source: AGHT+IGDgdAZaaUbvgWkTXP+6EFmj00+0ikeM9JhzpBpk4U5EIlsiZ7KKpZ+KsZUT+sILS7ZtWuHFzRcgbReHA==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:69ff:df2c:aa81:7b74])
 (user=ipylypiv job=sendgmr) by 2002:a05:690c:3386:b0:609:2570:f06f with SMTP
 id fl6-20020a05690c338600b006092570f06fmr3759250ywb.0.1709688154461; Tue, 05
 Mar 2024 17:22:34 -0800 (PST)
Date: Tue,  5 Mar 2024 17:22:21 -0800
In-Reply-To: <20240306012226.3398927-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306012226.3398927-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306012226.3398927-3-ipylypiv@google.com>
Subject: [PATCH v7 2/7] scsi: libsas: Define NCQ Priority sysfs attributes for
 SATA devices
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

Libata sysfs attributes cannot be used for libsas managed SATA devices
because the ata_port location is different for libsas.

Defined sysfs attributes (visible for SATA devices only):
- /sys/block/sda/device/ncq_prio_enable
- /sys/block/sda/device/ncq_prio_supported

The newly defined attributes will pass the correct ata_port to libata
helper functions.

Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Jason Yan <yanaijie@huawei.com>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/scsi/libsas/sas_ata.c | 94 +++++++++++++++++++++++++++++++++++
 include/scsi/sas_ata.h        |  6 +++
 2 files changed, 100 insertions(+)

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 12e2653846e3..04b0bd9a4e01 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -964,3 +964,97 @@ int sas_execute_ata_cmd(struct domain_device *device, u8 *fis, int force_phy_id)
 			       force_phy_id, &tmf_task);
 }
 EXPORT_SYMBOL_GPL(sas_execute_ata_cmd);
+
+static ssize_t sas_ncq_prio_supported_show(struct device *device,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct scsi_device *sdev = to_scsi_device(device);
+	struct domain_device *ddev = sdev_to_domain_dev(sdev);
+	bool supported;
+	int rc;
+
+	/* This attribute shall be visible for SATA devices only */
+	if (WARN_ON_ONCE(!dev_is_sata(ddev)))
+		return -EINVAL;
+
+	rc = ata_ncq_prio_supported(ddev->sata_dev.ap, sdev, &supported);
+	if (rc)
+		return rc;
+
+	return sysfs_emit(buf, "%d\n", supported);
+}
+
+DEVICE_ATTR(ncq_prio_supported, S_IRUGO, sas_ncq_prio_supported_show, NULL);
+
+static ssize_t sas_ncq_prio_enable_show(struct device *device,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct scsi_device *sdev = to_scsi_device(device);
+	struct domain_device *ddev = sdev_to_domain_dev(sdev);
+	bool enabled;
+	int rc;
+
+	/* This attribute shall be visible for SATA devices only */
+	if (WARN_ON_ONCE(!dev_is_sata(ddev)))
+		return -EINVAL;
+
+	rc = ata_ncq_prio_enabled(ddev->sata_dev.ap, sdev, &enabled);
+	if (rc)
+		return rc;
+
+	return sysfs_emit(buf, "%d\n", enabled);
+}
+
+static ssize_t sas_ncq_prio_enable_store(struct device *device,
+					 struct device_attribute *attr,
+					 const char *buf, size_t len)
+{
+	struct scsi_device *sdev = to_scsi_device(device);
+	struct domain_device *ddev = sdev_to_domain_dev(sdev);
+	bool enable;
+	int rc;
+
+	/* This attribute shall be visible for SATA devices only */
+	if (WARN_ON_ONCE(!dev_is_sata(ddev)))
+		return -EINVAL;
+
+	rc = kstrtobool(buf, &enable);
+	if (rc)
+		return rc;
+
+	rc = ata_ncq_prio_enable(ddev->sata_dev.ap, sdev, enable);
+	if (rc)
+		return rc;
+
+	return len;
+}
+
+DEVICE_ATTR(ncq_prio_enable, S_IRUGO | S_IWUSR,
+	    sas_ncq_prio_enable_show, sas_ncq_prio_enable_store);
+
+static struct attribute *sas_ata_sdev_attrs[] = {
+	&dev_attr_ncq_prio_supported.attr,
+	&dev_attr_ncq_prio_enable.attr,
+	NULL
+};
+
+static umode_t sas_ata_attr_is_visible(struct kobject *kobj,
+				       struct attribute *attr, int i)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct domain_device *ddev = sdev_to_domain_dev(sdev);
+
+	if (!dev_is_sata(ddev))
+		return 0;
+
+	return attr->mode;
+}
+
+const struct attribute_group sas_ata_sdev_attr_group = {
+	.attrs = sas_ata_sdev_attrs,
+	.is_visible = sas_ata_attr_is_visible,
+};
+EXPORT_SYMBOL_GPL(sas_ata_sdev_attr_group);
diff --git a/include/scsi/sas_ata.h b/include/scsi/sas_ata.h
index 2f8c719840a6..92e27e7bf088 100644
--- a/include/scsi/sas_ata.h
+++ b/include/scsi/sas_ata.h
@@ -39,6 +39,9 @@ int smp_ata_check_ready_type(struct ata_link *link);
 int sas_discover_sata(struct domain_device *dev);
 int sas_ata_add_dev(struct domain_device *parent, struct ex_phy *phy,
 		    struct domain_device *child, int phy_id);
+
+extern const struct attribute_group sas_ata_sdev_attr_group;
+
 #else
 
 static inline void sas_ata_disabled_notice(void)
@@ -123,6 +126,9 @@ static inline int sas_ata_add_dev(struct domain_device *parent, struct ex_phy *p
 	sas_ata_disabled_notice();
 	return -ENODEV;
 }
+
+#define sas_ata_sdev_attr_group ((struct attribute_group) {})
+
 #endif
 
 #endif /* _SAS_ATA_H_ */
-- 
2.44.0.278.ge034bb2e1d-goog

