Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5997BB12
	for <linux-ide@vger.kernel.org>; Mon,  4 Mar 2024 22:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709590110; cv=none; b=Xpm778tevM7WENnbYRbW4raWxolkvrWzzNsp4lcUypucEhjeTS66LNYeZYBO24M7Ib0ntNy60tuRnBUv4XHv7jCTY2uwm7NLH49rGyPl4Ewf+PP3LGFJqi/n5gHVX1ByB5ApcHKPyvtdBVeuISKTDCde/XwgFPDSCb60tOMO3Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709590110; c=relaxed/simple;
	bh=3/t65CKOH2IM75rZtN+yfmvVZGp1YUepR4CA+qimXNQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IbqHQEtqVtzAmzbTmtc99RQO09/OYYPUbegeSd4Os3xKNbT3qXk4sW5DpyqA8QY7eyIBUwZrL2GrjI9riLc7R3UynGQejqOP/X0Mw2UOYZH04/M/CGZ9VBYlBYUVZET1GzgGRVJ2USBO3TKFlrtgIgoS7avzV+dYhKeGpHFNANs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mm3o2EGL; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mm3o2EGL"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608e4171382so65120207b3.3
        for <linux-ide@vger.kernel.org>; Mon, 04 Mar 2024 14:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709590107; x=1710194907; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sk3CpW1nBlC9B2u3M2hZXqAOuqsrucoph9Nx8BkR6sY=;
        b=mm3o2EGLjKCvgfOjTd5TwuJ7fAFYzkmhabYRif73iE1bQrJGc3lu3uxcqR82e7QHz2
         ZS6rQy8WZFZfcDUaZtgyIPMNSelAngJ3OJ629soDnktXAam3nlj4JH8scLxWlLDA0321
         wi9V7PFb5uISCqHpCM5ttxprcSnwJ5n7PXzgmaQNjPZI//zgPl60isX8kk/kEMt+ypSS
         ZNoogYzc145NV1d70SCIrDyuYykf8JMRmCyvLXq/I8dTlhXXQWcy/8EVAoPeZF1oJIRs
         U9zfkTwT/eDEh4VCsmvJKK8/9cdkY5/ExL6p+hIc8bf6R1jY6GqdzLMfu4EwfKHFRtQH
         QB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709590107; x=1710194907;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sk3CpW1nBlC9B2u3M2hZXqAOuqsrucoph9Nx8BkR6sY=;
        b=ZPnR+qDKg3E2p+1KFPGP8ZM+zn/Qm6JsEZApN3PwabclK+0OfYiwj8HwoJZkfucUli
         pxQSUP3aChZZWmriU9hh9PgZ9bqb4fwxecZGKiXxdWPkRzA90QKi+/qX9S2u49nc2BUL
         nfen6JO8Qgcpi3r2BkVEoRfS3FJdhTLPChrS4wXnStjNKcjmXJOTzmUe/AhuUcMGHpqT
         XVfvNJKcdKTLQ8oX+3s1mxgIN4D6Od8lCJhPohPSMaMLx+wQ0yMvYqKNLtO6YhCngOB6
         Z2mTckUYNX3Dz2ZeNVe35tKh+Yfa6Ec9u52pOJCWJnWCiCdAw36h1xJqPO1DdwqQWfd+
         UU0g==
X-Forwarded-Encrypted: i=1; AJvYcCVLDKlEek7Jd8gPEga140z7yvbQoJZ28It/lfuiw/ZRnYnkW4k4s/GI8FptVNa5ngcNHf5tx/S+Ll54IFdZp556iiUwCV07UgPA
X-Gm-Message-State: AOJu0Yx7uf6m4z/O6ICPkneZwNNEhKAG4Juhbj1Ul4RWFsESX4MB9+Z8
	kHV9znEqjHHkybkG0msztNRe/sPw9YtUVB2jl2L1siu23Sf4dEsM4lk1BdNNK/0jjjYZdP0ih7T
	D6kghekWoRA==
X-Google-Smtp-Source: AGHT+IGbrVs/xGjoy/8mD2A+QYmJDL7JVA1UBnSzKmsnIwl2Xr2YOnQasS8U5287oSsOsBSxoeeXBH71ukNoSw==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:e901:e760:20cd:d870])
 (user=ipylypiv job=sendgmr) by 2002:a05:690c:3581:b0:609:4293:23eb with SMTP
 id fr1-20020a05690c358100b00609429323ebmr2224960ywb.10.1709590107631; Mon, 04
 Mar 2024 14:08:27 -0800 (PST)
Date: Mon,  4 Mar 2024 14:08:10 -0800
In-Reply-To: <20240304220815.1766285-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304220815.1766285-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304220815.1766285-3-ipylypiv@google.com>
Subject: [PATCH v4 2/7] scsi: libsas: Define NCQ Priority sysfs attributes for
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
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/scsi/libsas/sas_ata.c | 94 +++++++++++++++++++++++++++++++++++
 include/scsi/sas_ata.h        |  6 +++
 2 files changed, 100 insertions(+)

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 12e2653846e3..4ecdfa2a12c3 100644
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
+	if (WARN_ON(!dev_is_sata(ddev)))
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
+	if (WARN_ON(!dev_is_sata(ddev)))
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
+	if (WARN_ON(!dev_is_sata(ddev)))
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

