Return-Path: <SRS0=AjNr=5C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1A9C3F2CE
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401F720735
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KQmD7fjR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgCQOn5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:43:57 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40504 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgCQOn5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Mar 2020 10:43:57 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200317144353euoutp02cb176fae53eada576bbfc9339250defd~9Hoy9mDox1583015830euoutp02J
        for <linux-ide@vger.kernel.org>; Tue, 17 Mar 2020 14:43:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200317144353euoutp02cb176fae53eada576bbfc9339250defd~9Hoy9mDox1583015830euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584456233;
        bh=E5c8KMi7orRT/hIuviqy3NcbY3w9jv4xgCf0VZERwFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KQmD7fjRWECxp2qPAmxwBiMuSsqKyr0JRjq8rheU7tPY0RJk8SDmvjj4tM7T3ABfN
         IPeNRApUip0ArEMiAyrFTmL0RTr/Kc6Auc8/b0V/HGFrnw70/KCa/ECIaH3RrhhEnh
         lT3YlTk0us3VcCrM02Cm1W0eJkqyXxjPJJzDinZM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200317144353eucas1p2f2d26d1a9eee4854a76c59af8def9880~9HoyWHSzf3190931909eucas1p2e;
        Tue, 17 Mar 2020 14:43:53 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 47.E9.60698.822E07E5; Tue, 17
        Mar 2020 14:43:52 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144352eucas1p1ddb279cb52e2ae6f5189878912581162~9Hox23XQ61082710827eucas1p1q;
        Tue, 17 Mar 2020 14:43:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200317144352eusmtrp10dfe74b50a626cb32e1b3e33f741d67e~9Hox2SUe20867908679eusmtrp1x;
        Tue, 17 Mar 2020 14:43:52 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-f9-5e70e2288984
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 44.E4.08375.822E07E5; Tue, 17
        Mar 2020 14:43:52 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144352eusmtip1719b4eada508eb31ad4135f34a261f7f~9HoxXLr2M0973009730eusmtip1Z;
        Tue, 17 Mar 2020 14:43:51 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v4 23/27] ata: start separating SATA specific code from
 libata-scsi.c
Date:   Tue, 17 Mar 2020 15:43:29 +0100
Message-Id: <20200317144333.2904-24-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317144333.2904-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsWy7djPc7oajwriDO4tsbJYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBmNMw8zFvzcwlix9s8VlgbG11MZuxg5
        OSQETCSaJu5n7WLk4hASWMEo0XZtBRuE84VR4s2q2YwQzmdGibnXVjHBtDz9+Z8dIrGcUWLl
        2j4muJb7Z6awgFSxCVhJTGxfBbZEREBBouf3SrC5zALvGSVWTNoLViQsEC5xeusiNhCbRUBV
        Ys+0jawgNq+ArURb7y+oC+Ultn77BBbnBIpfO/yPDaJGUOLkzCdgc5iBapq3zmYGWSAhsIpd
        orV/FStEs4tE38G7bBC2sMSr41vYIWwZidOTe1ggGtYxSvzteAHVvZ1RYvnkf1Ad1hJ3zv0C
        sjmAVmhKrN+lDxF2lLi57TMLSFhCgE/ixltBiCP4JCZtm84MEeaV6GgTgqhWk9iwbAMbzNqu
        nSuZIWwPidMPd7NPYFScheSdWUjemYWwdwEj8ypG8dTS4tz01GLjvNRyveLE3OLSvHS95Pzc
        TYzAhHT63/GvOxj3/Uk6xCjAwajEw5uwqSBOiDWxrLgy9xCjBAezkgjv4sL8OCHelMTKqtSi
        /Pii0pzU4kOM0hwsSuK8xotexgoJpCeWpGanphakFsFkmTg4pRoYq1yjuNzKv3qyxLM+Err2
        v2V/lMi5Z9XTvKbN0BGWuivyTPW/n9qlSbcu/23bf986ZuPr+WyP/79tELwnf6ppflxS7iHt
        xFbxue9XPu7T7o2OD7/YbvE7aW3c4U0bS8KPcnY+Fq0RucZQOjlqY98UM07plDnhrLdKau3l
        ZvwPvBNhfVn7X4ObEktxRqKhFnNRcSIAKzRe6UQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xu7oajwriDE49lbZYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehmNMw8zFvzcwlix9s8VlgbG11MZuxg5OSQETCSe/vzP3sXIxSEksJRR
        YuGUg8xdjBxACRmJ4+vLIGqEJf5c62IDsYUEPjFKHGi1AbHZBKwkJravApsjIqAg0fN7JRvI
        HGaBr4wSSyd1M4MkhAVCJX78eccCYrMIqErsmbaRFcTmFbCVaOv9BXWEvMTWb5/A4pxA8WuH
        /0Ets5F48eY/E0S9oMTJmU/A5jAD1Tdvnc08gVFgFpLULCSpBYxMqxhFUkuLc9Nziw31ihNz
        i0vz0vWS83M3MQJjZtuxn5t3MF7aGHyIUYCDUYmHl2NDQZwQa2JZcWXuIUYJDmYlEd7Fhflx
        QrwpiZVVqUX58UWlOanFhxhNgZ6YyCwlmpwPjOe8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC
        6YklqdmpqQWpRTB9TBycUg2M/sn1nB9myPBv3xzs1PygIfi+l5+vepB2b7DvW6079mJtq9vm
        GKd4OLmqhR7nLU78e/zIi+vvJ3nw3nzxsfT4lFqdWjZtq/ePNezfPXlfzPN9v4yq1eO7+vyW
        Z920Dh/+6+y+ml0mY/62P6480/mE8kSLXD0f/bep339c4MfGjJ8NNhzr39UosRRnJBpqMRcV
        JwIAU9s80K8CAAA=
X-CMS-MailID: 20200317144352eucas1p1ddb279cb52e2ae6f5189878912581162
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200317144352eucas1p1ddb279cb52e2ae6f5189878912581162
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200317144352eucas1p1ddb279cb52e2ae6f5189878912581162
References: <20200317144333.2904-1-b.zolnierkie@samsung.com>
        <CGME20200317144352eucas1p1ddb279cb52e2ae6f5189878912581162@eucas1p1.samsung.com>
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
index 0cf30782452a..c9760b52fb57 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -8,6 +8,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <scsi/scsi_device.h>
 #include <linux/libata.h>
 
 #include "libata.h"
@@ -761,3 +762,300 @@ bool sata_lpm_ignore_phy_events(struct ata_link *link)
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
index 2bf1376bc027..1000f7b0098b 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -46,8 +46,6 @@ typedef unsigned int (*ata_xlat_func_t)(struct ata_queued_cmd *qc);
 
 static struct ata_device *__ata_scsi_find_dev(struct ata_port *ap,
 					const struct scsi_device *scsidev);
-static struct ata_device *ata_scsi_find_dev(struct ata_port *ap,
-					    const struct scsi_device *scsidev);
 
 #define RW_RECOVERY_MPAGE 0x1
 #define RW_RECOVERY_MPAGE_LEN 12
@@ -87,71 +85,6 @@ static const u8 def_control_mpage[CONTROL_MPAGE_LEN] = {
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
@@ -255,83 +188,6 @@ DEVICE_ATTR(unload_heads, S_IRUGO | S_IWUSR,
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
@@ -380,100 +236,12 @@ static void ata_scsi_set_invalid_parameter(struct ata_device *dev,
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
@@ -1391,73 +1159,6 @@ void ata_scsi_slave_destroy(struct scsi_device *sdev)
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
@@ -3082,7 +2783,7 @@ static struct ata_device *__ata_scsi_find_dev(struct ata_port *ap,
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
index 0fa34370eefa..cc14030c139e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -519,12 +519,14 @@ typedef int (*ata_reset_fn_t)(struct ata_link *link, unsigned int *classes,
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
@@ -1402,10 +1403,14 @@ extern struct device_attribute *ata_ncq_sdev_attrs[];
 	__ATA_BASE_SHT(drv_name),				\
 	.sdev_attrs		= ata_common_sdev_attrs
 
+#ifdef CONFIG_SATA_HOST
+extern struct device_attribute *ata_ncq_sdev_attrs[];
+
 #define ATA_NCQ_SHT(drv_name)					\
 	__ATA_BASE_SHT(drv_name),				\
 	.sdev_attrs		= ata_ncq_sdev_attrs,		\
 	.change_queue_depth	= ata_scsi_change_queue_depth
+#endif
 
 /*
  * PMP helpers
-- 
2.24.1

