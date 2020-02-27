Return-Path: <SRS0=ljer=4P=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB33C35E17
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B19246AE
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mQ+t3qqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731029AbgB0SXS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:23:18 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59070 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731027AbgB0SWw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Feb 2020 13:22:52 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200227182251euoutp02f81fa4b60b9b951f09e13ed4479de1ea~3VXjVyjV20671406714euoutp020
        for <linux-ide@vger.kernel.org>; Thu, 27 Feb 2020 18:22:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200227182251euoutp02f81fa4b60b9b951f09e13ed4479de1ea~3VXjVyjV20671406714euoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582827771;
        bh=xAFCOuz9Devyo1N083YTZA4pByxwJLNhOBHxKduMCEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mQ+t3qqeZMMCkUXkRgix9McWCShzQiattDB5zGhIDGKKDzraInK8hYB8ngR1zg0o2
         Zovml/V8VVp03IKUo6zqQo6RVljML1GUOYye5RgbiaqCzqtrLtJfx5QGXaXh+q1np6
         sp7muYyMuQs75p2lbzOMShHkD8BQVqZTNrn8AfhA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200227182250eucas1p2b9bed9427fd7eff9d5923f0f945d5ad1~3VXiaLxki2012220122eucas1p2i;
        Thu, 27 Feb 2020 18:22:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 0B.05.60698.AF8085E5; Thu, 27
        Feb 2020 18:22:50 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200227182249eucas1p19b8af9cc8b7e8fac33cf400702322c7d~3VXh0Pr9s0931609316eucas1p1G;
        Thu, 27 Feb 2020 18:22:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200227182249eusmtrp1a59b81b91cc6870ba2b6d4f48ba22c86~3VXhznG3D0185901859eusmtrp1k;
        Thu, 27 Feb 2020 18:22:49 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-0a-5e5808fa024b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A7.61.07950.9F8085E5; Thu, 27
        Feb 2020 18:22:49 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200227182249eusmtip285b71c732da0995920908e48d9ea3447~3VXhYUACP2149421494eusmtip2M;
        Thu, 27 Feb 2020 18:22:49 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v3 23/27] ata: start separating SATA specific code from
 libata-scsi.c
Date:   Thu, 27 Feb 2020 19:22:22 +0100
Message-Id: <20200227182226.19188-24-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227182226.19188-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsWy7djPc7q/OCLiDG7+kbZYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBln575mLJi2lbFiwfXjrA2MHdMYuxg5
        OSQETCQ63nazdDFycQgJrGCUeDZvCpTzhVHi2NdlUM5nRokrh9eww7ScW7yPCSKxnFGi5+x2
        NriWZWv3gFWxCVhJTGxfBbZEREBBouf3SrAiZoH3jBIrJu1lAUkIC4RLHH1wlxnEZhFQlTh9
        9QtYnFfATuLFybesEOvkJbZ++wRmcwLFb/SBbAOpEZQ4OfMJWD0zUE3z1tnMIAskBFaxS+z4
        tIMJotlF4sy5e1C2sMSr41ugfpCROD25hwWiYR2jxN+OF1Dd2xkllk/+xwZRZS1x59wvIJsD
        aIWmxPpd+hBhR4nm01eZQMISAnwSN94KQhzBJzFp23RmiDCvREebEES1msSGZRvYYNZ27VzJ
        DGF7SHzcsIp5AqPiLCTvzELyziyEvQsYmVcxiqeWFuempxYb56WW6xUn5haX5qXrJefnbmIE
        JqTT/45/3cG470/SIUYBDkYlHt4FO8LjhFgTy4orcw8xSnAwK4nwbvwaGifEm5JYWZValB9f
        VJqTWnyIUZqDRUmc13jRy1ghgfTEktTs1NSC1CKYLBMHp1QDI7vyNKnZ3xs6/5yJSWQteCu2
        YN/MkDb+A5+sesK9k+U1hL9cld0fmuLVXHD3ZTZTAe8B9X37y4RrBSTiW0459509+Jw3VeCL
        /aUZcwpeSryTtg/YM0m6NPCgskVi7qfqMttnb/a/Kd/+SCXn+uFLyepu+7fEVjrE8r68cnrR
        /Ze9nln1lxeVKbEUZyQaajEXFScCAJJXLMtEAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsVy+t/xe7o/OSLiDD5dN7ZYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehln575mLJi2lbFiwfXjrA2MHdMYuxg5OSQETCTOLd7H1MXIxSEksJRR
        YsGrvWxdjBxACRmJ4+vLIGqEJf5c62KDqPnEKLH95U5WkASbgJXExPZVYINEBBQken6vBCti
        FvjKKLF0UjczSEJYIFTi5NRLYEUsAqoSp69+YQGxeQXsJF6cfMsKsUFeYuu3T2A2J1D8Rt92
        NhBbSMBWoqvjKSNEvaDEyZlPwHqZgeqbt85mnsAoMAtJahaS1AJGplWMIqmlxbnpucVGesWJ
        ucWleel6yfm5mxiBUbPt2M8tOxi73gUfYhTgYFTi4fXYFh4nxJpYVlyZe4hRgoNZSYR349fQ
        OCHelMTKqtSi/Pii0pzU4kOMpkBPTGSWEk3OB0Z0Xkm8oamhuYWlobmxubGZhZI4b4fAwRgh
        gfTEktTs1NSC1CKYPiYOTqkGRq9wuVlvmM5t47bgnR7vsbliRx9HicntfaJBGopPvH/Nty/3
        4Vyd7WLcem319ymFE151rC3bXCD0Pzg4c9cP2SeqAiUGLw/P0So+YHSxz6zwhUKF7QnJqK7E
        eP/Sh5cuC3ttv+m4RUrRS32qU29d9MLuLel+N3JmZx5bMvHAtNNJfz9YeJbIKLEUZyQaajEX
        FScCAOKxzkiwAgAA
X-CMS-MailID: 20200227182249eucas1p19b8af9cc8b7e8fac33cf400702322c7d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200227182249eucas1p19b8af9cc8b7e8fac33cf400702322c7d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200227182249eucas1p19b8af9cc8b7e8fac33cf400702322c7d
References: <20200227182226.19188-1-b.zolnierkie@samsung.com>
        <CGME20200227182249eucas1p19b8af9cc8b7e8fac33cf400702322c7d@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Start separating SATA specific code from libata-scsi.c:

* un-static ata_scsi_find_dev()

* move following code to libata-sata.c:
  - SATA only sysfs device attributes handling
  - __ata_change_queue_depth()
  - ata_scsi_change_queue_depth()

* cover with CONFIG_SATA_HOST ifdef SATA only sysfs device
  attributes handling code and ATA_SHT_NCQ() macro in
  <linux/libata.h>

Code size savings on m68k arch using (modified) atari_defconfig:

   text    data     bss     dec     hex filename
before:
  20702     105     576   21383    5387 drivers/ata/libata-scsi.o
after:
  19137      23     576   19736    4d18 drivers/ata/libata-scsi.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-sata.c | 298 +++++++++++++++++++++++++++++++++++++
 drivers/ata/libata-scsi.c | 301 +-------------------------------------
 drivers/ata/libata.h      |   2 +
 include/linux/libata.h    |   9 +-
 4 files changed, 308 insertions(+), 302 deletions(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index f3ad4aca5d09..341699f5af20 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -8,6 +8,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <scsi/scsi_device.h>
 #include <linux/libata.h>
 
 #include "libata.h"
@@ -764,3 +765,300 @@ bool sata_lpm_ignore_phy_events(struct ata_link *link)
 	return false;
 }
 EXPORT_SYMBOL_GPL(sata_lpm_ignore_phy_events);
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
index b8e41c8e6395..6d295d0396d0 100644
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
index cd8090ad43e5..ce3f3c039572 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -112,6 +112,8 @@ static inline void ata_acpi_bind_dev(struct ata_device *dev) {}
 #endif
 
 /* libata-scsi.c */
+extern struct ata_device *ata_scsi_find_dev(struct ata_port *ap,
+					    const struct scsi_device *scsidev);
 extern int ata_scsi_add_hosts(struct ata_host *host,
 			      struct scsi_host_template *sht);
 extern void ata_scsi_scan_host(struct ata_port *ap, int sync);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 99cd52a5a4c2..08c4c365fd98 100644
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
@@ -1373,7 +1375,6 @@ extern int ata_link_nr_enabled(struct ata_link *link);
 extern const struct ata_port_operations ata_base_port_ops;
 extern const struct ata_port_operations sata_port_ops;
 extern struct device_attribute *ata_common_sdev_attrs[];
-extern struct device_attribute *ata_ncq_sdev_attrs[];
 
 /*
  * All sht initializers (BASE, PIO, BMDMA, NCQ) must be instantiated
@@ -1398,10 +1399,14 @@ extern struct device_attribute *ata_ncq_sdev_attrs[];
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

