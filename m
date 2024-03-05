Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7E49443
	for <linux-ide@vger.kernel.org>; Tue,  5 Mar 2024 00:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709599873; cv=none; b=rEnIxhppRvpwpl7PkZ2M1by91/6ibCBEe6gkb8F05fgHX7moxRLNsW2RmZiahWk87a/yzFaUOazRuD7ExwcIMCx/I8UQoJHfPTMP9GMWFQcPJcSOyePoORfgWB3dbl3u4xCDpxK4mssEF2ZJ/6a8MY9Iup2bQP97dPINWzhnfT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709599873; c=relaxed/simple;
	bh=YTgx3WEe4nP8Np9FZNVT4X89BHfmUTsxsDDNkC5GZ1c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NmXxQLg/Jmtb0tZ99soMC9UujBa08m/qq1l7nSd9HZJs6ThwPZtU6cx86JztZdV4hI8cDHvn+bcFlsK9ObdZJfDfrR1UUp8gWnHzPWITIusCXPMVj7QlMrzj3XJCYHQ/Ri4SW6j4civg6troVdqrt+d0xyWXYO1qr2vB61w/3iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x9KHuD5s; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x9KHuD5s"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so6171887276.0
        for <linux-ide@vger.kernel.org>; Mon, 04 Mar 2024 16:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709599871; x=1710204671; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Rvi5ygT6WAyce3RYZ1KHwBcishPIpdItYF4EiC3R2c=;
        b=x9KHuD5sysZFEmVAIS3VKO8Sg/YFwZrLKm6i9lTjSXxJR7AaOTTwGuOK2J7DxPHCJh
         0pBCZ+SxoHjQBY0CtIMw069uMQZwEsyv9Y/76yoh6MiJkTs3TV6FLtAHZv8u3aUUFq/1
         5z9V6jPY86q+qbbCYGPcw2hsGQFTDFwYBb3wsgjLI0DtahEVWX6g1o8U3MUp87jKlpdN
         VfOXp42BvmqjflzzDYfyhnT11DIH7aVOLDCvMQZ+qHqRR13pIEYSp3DEVXgCXn05GjOJ
         f4EgYrdIeNcaqNeAx/002dVtm7L0y2TBDsK1SM7TBBKkIyB5q5/bFyZ7wqxBl1vCWzyh
         b1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709599871; x=1710204671;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Rvi5ygT6WAyce3RYZ1KHwBcishPIpdItYF4EiC3R2c=;
        b=tNni6WdpAmTmHI2JNfQALDVZGcivmLgjJzgs4vKjOlAz/fyKe8GO0ImAvM5WRjH91z
         OxLLe09JlQuSG4lIOFj0cJR126ZQ2IRWXwhYLMqwRKnkLiLsatTBdRKoR+fb4hnwiRUm
         f3sZjlg7jKO7X1ID9ZkPHMwrS3bMop6tKwa0sMO52Obi2HBbU4R1Kf1rRW8wtzgHOHGE
         8TMHkr8EAxCWt39eCtyGpk8ZJDtu/WAOMqdh3EiSa7Bemn5UIoKNth3s27DpQHaYtE+4
         uFeXOKJI9r74czI45kcZXAi0bcikO//NdWOkGZBW0rDgipstXO+aRiaqU6/I6WSVd5Gi
         QcGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfIf/SKPPmrSW9j/0wE0ewspS6hl4xdPW7CDgbQjPd5L05fxOXGATeFxVMswCScoDg2DtrD07/2wdMK7JZv4o2b/XGw4E0PF2G
X-Gm-Message-State: AOJu0Ywppg0dnUrkm9jyooSCA6vEmb8lH+zCPRD5EldD/vmE+Vz1CWPo
	AzIsA3pqPZsBT2mFLEDDxleX9fhxC5g6+5k6pxN58/tx9eB0B+zBCla+nPBLBxGbdq539UVpr14
	wzhU5IwtRQw==
X-Google-Smtp-Source: AGHT+IFJjsZYiWXboDnHwWPLxZRDjqhfWxS4gVjqhuk3la2dYUeCqDR/H3YDuZseHOnChRDRlRD8ggqzL2MK6Q==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:e901:e760:20cd:d870])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:154e:b0:dc7:3189:4e75 with SMTP
 id r14-20020a056902154e00b00dc731894e75mr362935ybu.3.1709599871454; Mon, 04
 Mar 2024 16:51:11 -0800 (PST)
Date: Mon,  4 Mar 2024 16:50:58 -0800
In-Reply-To: <20240305005103.1849325-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305005103.1849325-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240305005103.1849325-3-ipylypiv@google.com>
Subject: [PATCH v5 2/7] scsi: libsas: Define NCQ Priority sysfs attributes for
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
index 2f8c719840a6..cded782fdf33 100644
--- a/include/scsi/sas_ata.h
+++ b/include/scsi/sas_ata.h
@@ -39,6 +39,8 @@ int smp_ata_check_ready_type(struct ata_link *link);
 int sas_discover_sata(struct domain_device *dev);
 int sas_ata_add_dev(struct domain_device *parent, struct ex_phy *phy,
 		    struct domain_device *child, int phy_id);
+
+extern const struct attribute_group sas_ata_sdev_attr_group;
 #else
 
 static inline void sas_ata_disabled_notice(void)
@@ -123,6 +125,10 @@ static inline int sas_ata_add_dev(struct domain_device *parent, struct ex_phy *p
 	sas_ata_disabled_notice();
 	return -ENODEV;
 }
+
+static const struct attribute_group sas_ata_sdev_attr_group = {
+	.attrs = NULL,
+};
 #endif
 
 #endif /* _SAS_ATA_H_ */
-- 
2.44.0.278.ge034bb2e1d-goog

