Return-Path: <SRS0=TxtD=3S=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37854C33CB2
	for <linux-ide@archiver.kernel.org>; Wed, 29 Jan 2020 11:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE109207FD
	for <linux-ide@archiver.kernel.org>; Wed, 29 Jan 2020 11:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TyY0F8lr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgA2LN3 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 29 Jan 2020 06:13:29 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56236 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgA2LN2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 29 Jan 2020 06:13:28 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200129111326euoutp02f0a40d165e9adad2e7b4b952f62a326f~uVzVqVgtR2708327083euoutp02T
        for <linux-ide@vger.kernel.org>; Wed, 29 Jan 2020 11:13:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200129111326euoutp02f0a40d165e9adad2e7b4b952f62a326f~uVzVqVgtR2708327083euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580296406;
        bh=wYDCBMNJKSla/j0QjT2LhcEnOo21Lfi5T8uEw3hqswU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=TyY0F8lrIHX6D5SLpfFWRRs2B0cea1nWuyi1CnVrJOB2nh4WNWCl1Ug5Qnw5WE6Sy
         cSersi/O7HJkGiB5YNIx0MV6tfLq7WY1J3Vvim17h/fmrkA+4LuJ6SDzfO2oC/wNMG
         T+Jks/S/j/Ynon6bMk4EVqlK5TRmcg3v3U0ndCIs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200129111325eucas1p1382158584c37bcd0348578142c721159~uVzVULNOX0375603756eucas1p12;
        Wed, 29 Jan 2020 11:13:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B6.93.60679.5D8613E5; Wed, 29
        Jan 2020 11:13:25 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200129111325eucas1p10ce3e20829bbbe7e657f3245bb2d009e~uVzVANIOU0759307593eucas1p1l;
        Wed, 29 Jan 2020 11:13:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200129111325eusmtrp1be0ca84fd226719440ac60df02ce305c~uVzU-nCXy0748407484eusmtrp1O;
        Wed, 29 Jan 2020 11:13:25 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-2f-5e3168d53170
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5D.E0.07950.5D8613E5; Wed, 29
        Jan 2020 11:13:25 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200129111324eusmtip2c3433487be2b4c702cbf15f0bb1d64c5~uVzULDPEr1672816728eusmtip2R;
        Wed, 29 Jan 2020 11:13:24 +0000 (GMT)
Subject: Re: [PATCH 24/28] ata: start separating SATA specific code from
 libata-scsi.c
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <15b7c0de-868a-092a-c53c-667a3bfccce5@samsung.com>
Date:   Wed, 29 Jan 2020 12:13:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200128133343.29905-25-b.zolnierkie@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djP87pXMwzjDPad1bJYfbefzeLZrb1M
        Fsd2PGKyuLxrDpvF3Nbp7A6sHjtn3WX3uHy21OPQ4Q5Gj8+b5AJYorhsUlJzMstSi/TtErgy
        Xj1bylqwbw9jxbLpq5gaGKfMYexi5OSQEDCRaFvWygxiCwmsYJToviHaxcgFZH9hlPj3+y47
        hPOZUWL9tKXMMB1Hp7xhhkgsZ5S4smwVlPOWUWL3ls1sIFXCAhESdxpvgO0QEVCQ6Pm9kg2k
        iFlgEqPEwck7mEASbAJWEhPbV4EV8QrYSbRO38kOYrMIqEo8ePmVFcQWBRr06cFhVogaQYmT
        M5+wgNicAvYSkyb9BrOZBcQlbj2ZzwRhy0tsfzsH7CIJgUXsEotapwIN5QByXCQezBKFeEFY
        4tXxLewQtozE6ck9LBD16xgl/na8gGreziixfPI/Nogqa4k7536xgQxiFtCUWL9LHyLsKLH4
        /BlmiPl8EjfeCkLcwCcxadt0qDCvREebEES1msSGZRvYYNZ27VzJPIFRaRaSz2Yh+WYWkm9m
        IexdwMiyilE8tbQ4Nz212CgvtVyvODG3uDQvXS85P3cTIzDRnP53/MsOxl1/kg4xCnAwKvHw
        zlAxiBNiTSwrrsw9xCjBwawkwivqahgnxJuSWFmVWpQfX1Sak1p8iFGag0VJnNd40ctYIYH0
        xJLU7NTUgtQimCwTB6dUA+MOlmMBGn02P39dv7ltwoYfL63OhFXVunt2JP86oDN174w+7962
        /UfvHLiq4MBfeezW90dWi1Jv2CQ/jfdW8bhVq33pT8uLeZqpSnyrfTPnBSo6nOfsZJSwemQf
        U+twft4BzcotlZEvVj+xUuupsXqS8amkK+Ev65uQu2dmfvjA9zaIe/EC5TVKLMUZiYZazEXF
        iQA0zxC3MAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsVy+t/xe7pXMwzjDE70SlmsvtvPZvHs1l4m
        i2M7HjFZXN41h81ibut0dgdWj52z7rJ7XD5b6nHocAejx+dNcgEsUXo2RfmlJakKGfnFJbZK
        0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZr54tZS3Yt4exYtn0VUwNjFPm
        MHYxcnJICJhIHJ3yhrmLkYtDSGApo0Rb53bWLkYOoISMxPH1ZRA1whJ/rnWxQdS8ZpT4u/w5
        K0hCWCBC4k7jDbBBIgIKEj2/V4IVMQtMYpTYd3E9O0THMUaJ3w+WMYNUsQlYSUxsXwXWwStg
        J9E6fSc7iM0ioCrx4OVXsKmiQFMP75gFVSMocXLmExYQm1PAXmLSpN9gNrOAusSfeZeYIWxx
        iVtP5jNB2PIS29/OYZ7AKDQLSfssJC2zkLTMQtKygJFlFaNIamlxbnpusZFecWJucWleul5y
        fu4mRmBsbTv2c8sOxq53wYcYBTgYlXh4HZQM4oRYE8uKK3MPMUpwMCuJ8Iq6GsYJ8aYkVlal
        FuXHF5XmpBYfYjQFem4is5Rocj4w7vNK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5akZqem
        FqQWwfQxcXBKAaPpieTqXVXpqn8FRNp/vLruWS8l83t/krH+o8ketgX93JEXmGqNziiypLCa
        XZseNemM77Ip22/94EuqTLk/0fuM+DPVMo49qcz5Dzl2hQRezMv2EzecJnFts8WuU1v9rptr
        OH/56R+a/urQop2ahV/iJonW6Bzb+yf/67ELMzhs3ftDT3F1XVViKc5INNRiLipOBACMtGdG
        wwIAAA==
X-CMS-MailID: 20200129111325eucas1p10ce3e20829bbbe7e657f3245bb2d009e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133418eucas1p157933935f14f9c83c604bc5dc38bcbae
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133418eucas1p157933935f14f9c83c604bc5dc38bcbae
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133418eucas1p157933935f14f9c83c604bc5dc38bcbae@eucas1p1.samsung.com>
        <20200128133343.29905-25-b.zolnierkie@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Start separating SATA specific code from libata-scsi.c:

* un-static ata_scsi_find_dev()

* move following code to libata-scsi-sata.c:
  - SATA only sysfs device attributes handling
  - __ata_change_queue_depth()
  - ata_scsi_change_queue_depth()

* cover with CONFIG_SATA_HOST ifdef SATA only sysfs device
  attributes handling code and ATA_SHT_NCQ() macro in
  <linux/libata.h>

* include libata-scsi-sata.c in the build when CONFIG_SATA_HOST=y

Code size savings on m68k arch using atari_defconfig:

   text    data     bss     dec     hex filename
before:
  20702     105    4096   24903    6147 drivers/ata/libata-scsi.o
after:
  19137      23    4096   23256    5ad8 drivers/ata/libata-scsi.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v1.5, the v1 didn't apply (by mistake I've included old patch version
which missed coma in ATA_NCQ_SHT() macro), sorry for that

 drivers/ata/Makefile           |   2 +-
 drivers/ata/libata-scsi-sata.c | 310 +++++++++++++++++++++++++++++++++
 drivers/ata/libata-scsi.c      | 301 +-------------------------------
 drivers/ata/libata.h           |   2 +
 include/linux/libata.h         |   9 +-
 5 files changed, 321 insertions(+), 303 deletions(-)
 create mode 100644 drivers/ata/libata-scsi-sata.c

diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index b06b9a211691..d6fb3d4a2ac5 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -123,7 +123,7 @@ obj-$(CONFIG_PATA_LEGACY)	+= pata_legacy.o
 
 libata-y	:= libata-core.o libata-scsi.o libata-eh.o \
 	libata-transport.o libata-trace.o
-libata-$(CONFIG_SATA_HOST)	+= libata-core-sata.o
+libata-$(CONFIG_SATA_HOST)	+= libata-core-sata.o libata-scsi-sata.o
 libata-$(CONFIG_ATA_SFF)	+= libata-sff.o
 libata-$(CONFIG_SATA_PMP)	+= libata-pmp.o
 libata-$(CONFIG_ATA_ACPI)	+= libata-acpi.o
diff --git a/drivers/ata/libata-scsi-sata.c b/drivers/ata/libata-scsi-sata.c
new file mode 100644
index 000000000000..da7d8344d003
--- /dev/null
+++ b/drivers/ata/libata-scsi-sata.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  libata-scsi-sata.c - SATA specific part of ATA helper library
+ *
+ *  Copyright 2003-2004 Red Hat, Inc.  All rights reserved.
+ *  Copyright 2003-2004 Jeff Garzik
+ */
+
+#include <linux/kernel.h>
+#include <scsi/scsi_device.h>
+#include <linux/libata.h>
+
+#include "libata.h"
+
+static const char *ata_lpm_policy_names[] = {
+	[ATA_LPM_UNKNOWN]		= "max_performance",
+	[ATA_LPM_MAX_POWER]		= "max_performance",
+	[ATA_LPM_MED_POWER]		= "medium_power",
+	[ATA_LPM_MED_POWER_WITH_DIPM]	= "med_power_with_dipm",
+	[ATA_LPM_MIN_POWER_WITH_PARTIAL] = "min_power_with_partial",
+	[ATA_LPM_MIN_POWER]		= "min_power",
+};
+
+static ssize_t ata_scsi_lpm_store(struct device *device,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct Scsi_Host *shost = class_to_shost(device);
+	struct ata_port *ap = ata_shost_to_port(shost);
+	struct ata_link *link;
+	struct ata_device *dev;
+	enum ata_lpm_policy policy;
+	unsigned long flags;
+
+	/* UNKNOWN is internal state, iterate from MAX_POWER */
+	for (policy = ATA_LPM_MAX_POWER;
+	     policy < ARRAY_SIZE(ata_lpm_policy_names); policy++) {
+		const char *name = ata_lpm_policy_names[policy];
+
+		if (strncmp(name, buf, strlen(name)) == 0)
+			break;
+	}
+	if (policy == ARRAY_SIZE(ata_lpm_policy_names))
+		return -EINVAL;
+
+	spin_lock_irqsave(ap->lock, flags);
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
+	ap->target_lpm_policy = policy;
+	ata_port_schedule_eh(ap);
+out_unlock:
+	spin_unlock_irqrestore(ap->lock, flags);
+	return count;
+}
+
+static ssize_t ata_scsi_lpm_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct ata_port *ap = ata_shost_to_port(shost);
+
+	if (ap->target_lpm_policy >= ARRAY_SIZE(ata_lpm_policy_names))
+		return -EINVAL;
+
+	return snprintf(buf, PAGE_SIZE, "%s\n",
+			ata_lpm_policy_names[ap->target_lpm_policy]);
+}
+DEVICE_ATTR(link_power_management_policy, S_IRUGO | S_IWUSR,
+	    ata_scsi_lpm_show, ata_scsi_lpm_store);
+EXPORT_SYMBOL_GPL(dev_attr_link_power_management_policy);
+
+static ssize_t ata_ncq_prio_enable_show(struct device *device,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct scsi_device *sdev = to_scsi_device(device);
+	struct ata_port *ap;
+	struct ata_device *dev;
+	bool ncq_prio_enable;
+	int rc = 0;
+
+	ap = ata_shost_to_port(sdev->host);
+
+	spin_lock_irq(ap->lock);
+	dev = ata_scsi_find_dev(ap, sdev);
+	if (!dev) {
+		rc = -ENODEV;
+		goto unlock;
+	}
+
+	ncq_prio_enable = dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLE;
+
+unlock:
+	spin_unlock_irq(ap->lock);
+
+	return rc ? rc : snprintf(buf, 20, "%u\n", ncq_prio_enable);
+}
+
+static ssize_t ata_ncq_prio_enable_store(struct device *device,
+					 struct device_attribute *attr,
+					 const char *buf, size_t len)
+{
+	struct scsi_device *sdev = to_scsi_device(device);
+	struct ata_port *ap;
+	struct ata_device *dev;
+	long int input;
+	int rc;
+
+	rc = kstrtol(buf, 10, &input);
+	if (rc)
+		return rc;
+	if ((input < 0) || (input > 1))
+		return -EINVAL;
+
+	ap = ata_shost_to_port(sdev->host);
+	dev = ata_scsi_find_dev(ap, sdev);
+	if (unlikely(!dev))
+		return  -ENODEV;
+
+	spin_lock_irq(ap->lock);
+	if (input)
+		dev->flags |= ATA_DFLAG_NCQ_PRIO_ENABLE;
+	else
+		dev->flags &= ~ATA_DFLAG_NCQ_PRIO_ENABLE;
+
+	dev->link->eh_info.action |= ATA_EH_REVALIDATE;
+	dev->link->eh_info.flags |= ATA_EHI_QUIET;
+	ata_port_schedule_eh(ap);
+	spin_unlock_irq(ap->lock);
+
+	ata_port_wait_eh(ap);
+
+	if (input) {
+		spin_lock_irq(ap->lock);
+		if (!(dev->flags & ATA_DFLAG_NCQ_PRIO)) {
+			dev->flags &= ~ATA_DFLAG_NCQ_PRIO_ENABLE;
+			rc = -EIO;
+		}
+		spin_unlock_irq(ap->lock);
+	}
+
+	return rc ? rc : len;
+}
+
+DEVICE_ATTR(ncq_prio_enable, S_IRUGO | S_IWUSR,
+	    ata_ncq_prio_enable_show, ata_ncq_prio_enable_store);
+EXPORT_SYMBOL_GPL(dev_attr_ncq_prio_enable);
+
+struct device_attribute *ata_ncq_sdev_attrs[] = {
+	&dev_attr_unload_heads,
+	&dev_attr_ncq_prio_enable,
+	NULL
+};
+EXPORT_SYMBOL_GPL(ata_ncq_sdev_attrs);
+
+static ssize_t
+ata_scsi_em_message_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct ata_port *ap = ata_shost_to_port(shost);
+	if (ap->ops->em_store && (ap->flags & ATA_FLAG_EM))
+		return ap->ops->em_store(ap, buf, count);
+	return -EINVAL;
+}
+
+static ssize_t
+ata_scsi_em_message_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct ata_port *ap = ata_shost_to_port(shost);
+
+	if (ap->ops->em_show && (ap->flags & ATA_FLAG_EM))
+		return ap->ops->em_show(ap, buf);
+	return -EINVAL;
+}
+DEVICE_ATTR(em_message, S_IRUGO | S_IWUSR,
+		ata_scsi_em_message_show, ata_scsi_em_message_store);
+EXPORT_SYMBOL_GPL(dev_attr_em_message);
+
+static ssize_t
+ata_scsi_em_message_type_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct ata_port *ap = ata_shost_to_port(shost);
+
+	return snprintf(buf, 23, "%d\n", ap->em_message_type);
+}
+DEVICE_ATTR(em_message_type, S_IRUGO,
+		  ata_scsi_em_message_type_show, NULL);
+EXPORT_SYMBOL_GPL(dev_attr_em_message_type);
+
+static ssize_t
+ata_scsi_activity_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct ata_port *ap = ata_shost_to_port(sdev->host);
+	struct ata_device *atadev = ata_scsi_find_dev(ap, sdev);
+
+	if (atadev && ap->ops->sw_activity_show &&
+	    (ap->flags & ATA_FLAG_SW_ACTIVITY))
+		return ap->ops->sw_activity_show(atadev, buf);
+	return -EINVAL;
+}
+
+static ssize_t
+ata_scsi_activity_store(struct device *dev, struct device_attribute *attr,
+	const char *buf, size_t count)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct ata_port *ap = ata_shost_to_port(sdev->host);
+	struct ata_device *atadev = ata_scsi_find_dev(ap, sdev);
+	enum sw_activity val;
+	int rc;
+
+	if (atadev && ap->ops->sw_activity_store &&
+	    (ap->flags & ATA_FLAG_SW_ACTIVITY)) {
+		val = simple_strtoul(buf, NULL, 0);
+		switch (val) {
+		case OFF: case BLINK_ON: case BLINK_OFF:
+			rc = ap->ops->sw_activity_store(atadev, val);
+			if (!rc)
+				return count;
+			else
+				return rc;
+		}
+	}
+	return -EINVAL;
+}
+DEVICE_ATTR(sw_activity, S_IWUSR | S_IRUGO, ata_scsi_activity_show,
+			ata_scsi_activity_store);
+EXPORT_SYMBOL_GPL(dev_attr_sw_activity);
+
+/**
+ *	__ata_change_queue_depth - helper for ata_scsi_change_queue_depth
+ *	@ap: ATA port to which the device change the queue depth
+ *	@sdev: SCSI device to configure queue depth for
+ *	@queue_depth: new queue depth
+ *
+ *	libsas and libata have different approaches for associating a sdev to
+ *	its ata_port.
+ *
+ */
+int __ata_change_queue_depth(struct ata_port *ap, struct scsi_device *sdev,
+			     int queue_depth)
+{
+	struct ata_device *dev;
+	unsigned long flags;
+
+	if (queue_depth < 1 || queue_depth == sdev->queue_depth)
+		return sdev->queue_depth;
+
+	dev = ata_scsi_find_dev(ap, sdev);
+	if (!dev || !ata_dev_enabled(dev))
+		return sdev->queue_depth;
+
+	/* NCQ enabled? */
+	spin_lock_irqsave(ap->lock, flags);
+	dev->flags &= ~ATA_DFLAG_NCQ_OFF;
+	if (queue_depth == 1 || !ata_ncq_enabled(dev)) {
+		dev->flags |= ATA_DFLAG_NCQ_OFF;
+		queue_depth = 1;
+	}
+	spin_unlock_irqrestore(ap->lock, flags);
+
+	/* limit and apply queue depth */
+	queue_depth = min(queue_depth, sdev->host->can_queue);
+	queue_depth = min(queue_depth, ata_id_queue_depth(dev->id));
+	queue_depth = min(queue_depth, ATA_MAX_QUEUE);
+
+	if (sdev->queue_depth == queue_depth)
+		return -EINVAL;
+
+	return scsi_change_queue_depth(sdev, queue_depth);
+}
+EXPORT_SYMBOL_GPL(__ata_change_queue_depth);
+
+/**
+ *	ata_scsi_change_queue_depth - SCSI callback for queue depth config
+ *	@sdev: SCSI device to configure queue depth for
+ *	@queue_depth: new queue depth
+ *
+ *	This is libata standard hostt->change_queue_depth callback.
+ *	SCSI will call into this callback when user tries to set queue
+ *	depth via sysfs.
+ *
+ *	LOCKING:
+ *	SCSI layer (we don't care)
+ *
+ *	RETURNS:
+ *	Newly configured queue depth.
+ */
+int ata_scsi_change_queue_depth(struct scsi_device *sdev, int queue_depth)
+{
+	struct ata_port *ap = ata_shost_to_port(sdev->host);
+
+	return __ata_change_queue_depth(ap, sdev, queue_depth);
+}
+EXPORT_SYMBOL_GPL(ata_scsi_change_queue_depth);
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index d549bd5b3d36..82c398c93379 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -45,8 +45,6 @@ typedef unsigned int (*ata_xlat_func_t)(struct ata_queued_cmd *qc);
 
 static struct ata_device *__ata_scsi_find_dev(struct ata_port *ap,
 					const struct scsi_device *scsidev);
-static struct ata_device *ata_scsi_find_dev(struct ata_port *ap,
-					    const struct scsi_device *scsidev);
 
 #define RW_RECOVERY_MPAGE 0x1
 #define RW_RECOVERY_MPAGE_LEN 12
@@ -86,71 +84,6 @@ static const u8 def_control_mpage[CONTROL_MPAGE_LEN] = {
 	0, 30	/* extended self test time, see 05-359r1 */
 };
 
-static const char *ata_lpm_policy_names[] = {
-	[ATA_LPM_UNKNOWN]		= "max_performance",
-	[ATA_LPM_MAX_POWER]		= "max_performance",
-	[ATA_LPM_MED_POWER]		= "medium_power",
-	[ATA_LPM_MED_POWER_WITH_DIPM]	= "med_power_with_dipm",
-	[ATA_LPM_MIN_POWER_WITH_PARTIAL] = "min_power_with_partial",
-	[ATA_LPM_MIN_POWER]		= "min_power",
-};
-
-static ssize_t ata_scsi_lpm_store(struct device *device,
-				  struct device_attribute *attr,
-				  const char *buf, size_t count)
-{
-	struct Scsi_Host *shost = class_to_shost(device);
-	struct ata_port *ap = ata_shost_to_port(shost);
-	struct ata_link *link;
-	struct ata_device *dev;
-	enum ata_lpm_policy policy;
-	unsigned long flags;
-
-	/* UNKNOWN is internal state, iterate from MAX_POWER */
-	for (policy = ATA_LPM_MAX_POWER;
-	     policy < ARRAY_SIZE(ata_lpm_policy_names); policy++) {
-		const char *name = ata_lpm_policy_names[policy];
-
-		if (strncmp(name, buf, strlen(name)) == 0)
-			break;
-	}
-	if (policy == ARRAY_SIZE(ata_lpm_policy_names))
-		return -EINVAL;
-
-	spin_lock_irqsave(ap->lock, flags);
-
-	ata_for_each_link(link, ap, EDGE) {
-		ata_for_each_dev(dev, &ap->link, ENABLED) {
-			if (dev->horkage & ATA_HORKAGE_NOLPM) {
-				count = -EOPNOTSUPP;
-				goto out_unlock;
-			}
-		}
-	}
-
-	ap->target_lpm_policy = policy;
-	ata_port_schedule_eh(ap);
-out_unlock:
-	spin_unlock_irqrestore(ap->lock, flags);
-	return count;
-}
-
-static ssize_t ata_scsi_lpm_show(struct device *dev,
-				 struct device_attribute *attr, char *buf)
-{
-	struct Scsi_Host *shost = class_to_shost(dev);
-	struct ata_port *ap = ata_shost_to_port(shost);
-
-	if (ap->target_lpm_policy >= ARRAY_SIZE(ata_lpm_policy_names))
-		return -EINVAL;
-
-	return snprintf(buf, PAGE_SIZE, "%s\n",
-			ata_lpm_policy_names[ap->target_lpm_policy]);
-}
-DEVICE_ATTR(link_power_management_policy, S_IRUGO | S_IWUSR,
-	    ata_scsi_lpm_show, ata_scsi_lpm_store);
-EXPORT_SYMBOL_GPL(dev_attr_link_power_management_policy);
-
 static ssize_t ata_scsi_park_show(struct device *device,
 				  struct device_attribute *attr, char *buf)
 {
@@ -254,83 +187,6 @@ DEVICE_ATTR(unload_heads, S_IRUGO | S_IWUSR,
 	    ata_scsi_park_show, ata_scsi_park_store);
 EXPORT_SYMBOL_GPL(dev_attr_unload_heads);
 
-static ssize_t ata_ncq_prio_enable_show(struct device *device,
-					struct device_attribute *attr,
-					char *buf)
-{
-	struct scsi_device *sdev = to_scsi_device(device);
-	struct ata_port *ap;
-	struct ata_device *dev;
-	bool ncq_prio_enable;
-	int rc = 0;
-
-	ap = ata_shost_to_port(sdev->host);
-
-	spin_lock_irq(ap->lock);
-	dev = ata_scsi_find_dev(ap, sdev);
-	if (!dev) {
-		rc = -ENODEV;
-		goto unlock;
-	}
-
-	ncq_prio_enable = dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLE;
-
-unlock:
-	spin_unlock_irq(ap->lock);
-
-	return rc ? rc : snprintf(buf, 20, "%u\n", ncq_prio_enable);
-}
-
-static ssize_t ata_ncq_prio_enable_store(struct device *device,
-					 struct device_attribute *attr,
-					 const char *buf, size_t len)
-{
-	struct scsi_device *sdev = to_scsi_device(device);
-	struct ata_port *ap;
-	struct ata_device *dev;
-	long int input;
-	int rc;
-
-	rc = kstrtol(buf, 10, &input);
-	if (rc)
-		return rc;
-	if ((input < 0) || (input > 1))
-		return -EINVAL;
-
-	ap = ata_shost_to_port(sdev->host);
-	dev = ata_scsi_find_dev(ap, sdev);
-	if (unlikely(!dev))
-		return  -ENODEV;
-
-	spin_lock_irq(ap->lock);
-	if (input)
-		dev->flags |= ATA_DFLAG_NCQ_PRIO_ENABLE;
-	else
-		dev->flags &= ~ATA_DFLAG_NCQ_PRIO_ENABLE;
-
-	dev->link->eh_info.action |= ATA_EH_REVALIDATE;
-	dev->link->eh_info.flags |= ATA_EHI_QUIET;
-	ata_port_schedule_eh(ap);
-	spin_unlock_irq(ap->lock);
-
-	ata_port_wait_eh(ap);
-
-	if (input) {
-		spin_lock_irq(ap->lock);
-		if (!(dev->flags & ATA_DFLAG_NCQ_PRIO)) {
-			dev->flags &= ~ATA_DFLAG_NCQ_PRIO_ENABLE;
-			rc = -EIO;
-		}
-		spin_unlock_irq(ap->lock);
-	}
-
-	return rc ? rc : len;
-}
-
-DEVICE_ATTR(ncq_prio_enable, S_IRUGO | S_IWUSR,
-	    ata_ncq_prio_enable_show, ata_ncq_prio_enable_store);
-EXPORT_SYMBOL_GPL(dev_attr_ncq_prio_enable);
-
 void ata_scsi_set_sense(struct ata_device *dev, struct scsi_cmnd *cmd,
 			u8 sk, u8 asc, u8 ascq)
 {
@@ -379,100 +235,12 @@ static void ata_scsi_set_invalid_parameter(struct ata_device *dev,
 				     field, 0xff, 0);
 }
 
-static ssize_t
-ata_scsi_em_message_store(struct device *dev, struct device_attribute *attr,
-			  const char *buf, size_t count)
-{
-	struct Scsi_Host *shost = class_to_shost(dev);
-	struct ata_port *ap = ata_shost_to_port(shost);
-	if (ap->ops->em_store && (ap->flags & ATA_FLAG_EM))
-		return ap->ops->em_store(ap, buf, count);
-	return -EINVAL;
-}
-
-static ssize_t
-ata_scsi_em_message_show(struct device *dev, struct device_attribute *attr,
-			 char *buf)
-{
-	struct Scsi_Host *shost = class_to_shost(dev);
-	struct ata_port *ap = ata_shost_to_port(shost);
-
-	if (ap->ops->em_show && (ap->flags & ATA_FLAG_EM))
-		return ap->ops->em_show(ap, buf);
-	return -EINVAL;
-}
-DEVICE_ATTR(em_message, S_IRUGO | S_IWUSR,
-		ata_scsi_em_message_show, ata_scsi_em_message_store);
-EXPORT_SYMBOL_GPL(dev_attr_em_message);
-
-static ssize_t
-ata_scsi_em_message_type_show(struct device *dev, struct device_attribute *attr,
-			      char *buf)
-{
-	struct Scsi_Host *shost = class_to_shost(dev);
-	struct ata_port *ap = ata_shost_to_port(shost);
-
-	return snprintf(buf, 23, "%d\n", ap->em_message_type);
-}
-DEVICE_ATTR(em_message_type, S_IRUGO,
-		  ata_scsi_em_message_type_show, NULL);
-EXPORT_SYMBOL_GPL(dev_attr_em_message_type);
-
-static ssize_t
-ata_scsi_activity_show(struct device *dev, struct device_attribute *attr,
-		char *buf)
-{
-	struct scsi_device *sdev = to_scsi_device(dev);
-	struct ata_port *ap = ata_shost_to_port(sdev->host);
-	struct ata_device *atadev = ata_scsi_find_dev(ap, sdev);
-
-	if (atadev && ap->ops->sw_activity_show &&
-	    (ap->flags & ATA_FLAG_SW_ACTIVITY))
-		return ap->ops->sw_activity_show(atadev, buf);
-	return -EINVAL;
-}
-
-static ssize_t
-ata_scsi_activity_store(struct device *dev, struct device_attribute *attr,
-	const char *buf, size_t count)
-{
-	struct scsi_device *sdev = to_scsi_device(dev);
-	struct ata_port *ap = ata_shost_to_port(sdev->host);
-	struct ata_device *atadev = ata_scsi_find_dev(ap, sdev);
-	enum sw_activity val;
-	int rc;
-
-	if (atadev && ap->ops->sw_activity_store &&
-	    (ap->flags & ATA_FLAG_SW_ACTIVITY)) {
-		val = simple_strtoul(buf, NULL, 0);
-		switch (val) {
-		case OFF: case BLINK_ON: case BLINK_OFF:
-			rc = ap->ops->sw_activity_store(atadev, val);
-			if (!rc)
-				return count;
-			else
-				return rc;
-		}
-	}
-	return -EINVAL;
-}
-DEVICE_ATTR(sw_activity, S_IWUSR | S_IRUGO, ata_scsi_activity_show,
-			ata_scsi_activity_store);
-EXPORT_SYMBOL_GPL(dev_attr_sw_activity);
-
 struct device_attribute *ata_common_sdev_attrs[] = {
 	&dev_attr_unload_heads,
 	NULL
 };
 EXPORT_SYMBOL_GPL(ata_common_sdev_attrs);
 
-struct device_attribute *ata_ncq_sdev_attrs[] = {
-	&dev_attr_unload_heads,
-	&dev_attr_ncq_prio_enable,
-	NULL
-};
-EXPORT_SYMBOL_GPL(ata_ncq_sdev_attrs);
-
 /**
  *	ata_std_bios_param - generic bios head/sector/cylinder calculator used by sd.
  *	@sdev: SCSI device for which BIOS geometry is to be determined
@@ -1390,73 +1158,6 @@ void ata_scsi_slave_destroy(struct scsi_device *sdev)
 }
 EXPORT_SYMBOL_GPL(ata_scsi_slave_destroy);
 
-/**
- *	__ata_change_queue_depth - helper for ata_scsi_change_queue_depth
- *	@ap: ATA port to which the device change the queue depth
- *	@sdev: SCSI device to configure queue depth for
- *	@queue_depth: new queue depth
- *
- *	libsas and libata have different approaches for associating a sdev to
- *	its ata_port.
- *
- */
-int __ata_change_queue_depth(struct ata_port *ap, struct scsi_device *sdev,
-			     int queue_depth)
-{
-	struct ata_device *dev;
-	unsigned long flags;
-
-	if (queue_depth < 1 || queue_depth == sdev->queue_depth)
-		return sdev->queue_depth;
-
-	dev = ata_scsi_find_dev(ap, sdev);
-	if (!dev || !ata_dev_enabled(dev))
-		return sdev->queue_depth;
-
-	/* NCQ enabled? */
-	spin_lock_irqsave(ap->lock, flags);
-	dev->flags &= ~ATA_DFLAG_NCQ_OFF;
-	if (queue_depth == 1 || !ata_ncq_enabled(dev)) {
-		dev->flags |= ATA_DFLAG_NCQ_OFF;
-		queue_depth = 1;
-	}
-	spin_unlock_irqrestore(ap->lock, flags);
-
-	/* limit and apply queue depth */
-	queue_depth = min(queue_depth, sdev->host->can_queue);
-	queue_depth = min(queue_depth, ata_id_queue_depth(dev->id));
-	queue_depth = min(queue_depth, ATA_MAX_QUEUE);
-
-	if (sdev->queue_depth == queue_depth)
-		return -EINVAL;
-
-	return scsi_change_queue_depth(sdev, queue_depth);
-}
-EXPORT_SYMBOL_GPL(__ata_change_queue_depth);
-
-/**
- *	ata_scsi_change_queue_depth - SCSI callback for queue depth config
- *	@sdev: SCSI device to configure queue depth for
- *	@queue_depth: new queue depth
- *
- *	This is libata standard hostt->change_queue_depth callback.
- *	SCSI will call into this callback when user tries to set queue
- *	depth via sysfs.
- *
- *	LOCKING:
- *	SCSI layer (we don't care)
- *
- *	RETURNS:
- *	Newly configured queue depth.
- */
-int ata_scsi_change_queue_depth(struct scsi_device *sdev, int queue_depth)
-{
-	struct ata_port *ap = ata_shost_to_port(sdev->host);
-
-	return __ata_change_queue_depth(ap, sdev, queue_depth);
-}
-EXPORT_SYMBOL_GPL(ata_scsi_change_queue_depth);
-
 /**
  *	ata_scsi_start_stop_xlat - Translate SCSI START STOP UNIT command
  *	@qc: Storage for translated ATA taskfile
@@ -3093,7 +2794,7 @@ static struct ata_device *__ata_scsi_find_dev(struct ata_port *ap,
  *	RETURNS:
  *	Associated ATA device, or %NULL if not found.
  */
-static struct ata_device *
+struct ata_device *
 ata_scsi_find_dev(struct ata_port *ap, const struct scsi_device *scsidev)
 {
 	struct ata_device *dev = __ata_scsi_find_dev(ap, scsidev);
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 8f5da7be88fe..2c479e48c4c9 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -153,6 +153,8 @@ static inline void ata_acpi_bind_dev(struct ata_device *dev) {}
 #endif
 
 /* libata-scsi.c */
+extern struct ata_device *ata_scsi_find_dev(struct ata_port *ap,
+					    const struct scsi_device *scsidev);
 extern int ata_scsi_add_hosts(struct ata_host *host,
 			      struct scsi_host_template *sht);
 extern void ata_scsi_scan_host(struct ata_port *ap, int sync);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 3124cad39d50..4b6ac3eda0c9 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -532,12 +532,14 @@ typedef int (*ata_reset_fn_t)(struct ata_link *link, unsigned int *classes,
 			      unsigned long deadline);
 typedef void (*ata_postreset_fn_t)(struct ata_link *link, unsigned int *classes);
 
-extern struct device_attribute dev_attr_link_power_management_policy;
 extern struct device_attribute dev_attr_unload_heads;
+#ifdef CONFIG_SATA_HOST
+extern struct device_attribute dev_attr_link_power_management_policy;
 extern struct device_attribute dev_attr_ncq_prio_enable;
 extern struct device_attribute dev_attr_em_message_type;
 extern struct device_attribute dev_attr_em_message;
 extern struct device_attribute dev_attr_sw_activity;
+#endif
 
 enum sw_activity {
 	OFF,
@@ -1374,7 +1376,6 @@ extern int ata_link_nr_enabled(struct ata_link *link);
 extern const struct ata_port_operations ata_base_port_ops;
 extern const struct ata_port_operations sata_port_ops;
 extern struct device_attribute *ata_common_sdev_attrs[];
-extern struct device_attribute *ata_ncq_sdev_attrs[];
 
 /*
  * All sht initializers (BASE, PIO, BMDMA, NCQ) must be instantiated
@@ -1399,10 +1400,14 @@ extern struct device_attribute *ata_ncq_sdev_attrs[];
 	.unlock_native_capacity	= ata_scsi_unlock_native_capacity, \
 	.sdev_attrs		= ata_common_sdev_attrs
 
+#ifdef CONFIG_SATA_HOST
+extern struct device_attribute *ata_ncq_sdev_attrs[];
+
 #define ATA_NCQ_SHT(drv_name)					\
 	ATA_BASE_SHT(drv_name),					\
 	.sdev_attrs		= ata_ncq_sdev_attrs,		\
 	.change_queue_depth	= ata_scsi_change_queue_depth
+#endif
 
 /*
  * PMP helpers
-- 
2.24.1

