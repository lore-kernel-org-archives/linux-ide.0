Return-Path: <SRS0=jBxd=5L=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DFEC43331
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 16:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3485320737
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 16:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="H++a8aZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgCZQAY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:00:24 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52613 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbgCZP6l (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2020 11:58:41 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200326155840euoutp0276b239f77ba18a9d617a116dfa9bc1d1~-5dpn08mV0075000750euoutp02N
        for <linux-ide@vger.kernel.org>; Thu, 26 Mar 2020 15:58:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200326155840euoutp0276b239f77ba18a9d617a116dfa9bc1d1~-5dpn08mV0075000750euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585238320;
        bh=tjSnuOlCAjOn2sRgXXH/J4iu3AMghYSQUVeuXVPyA4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H++a8aZbsqTVrYxluGBzGs5zb5Eu7XfL9AwAolsUGhm6j5yFQ+E8CwmmNr+F2sASk
         kzaFNggUHRKXVF2YvZlP+U8KuiwGGqCvNMlaCUxdOFf+9qPBqjDf0e9EVbPVgMMS6B
         p+XS2BkcMDcWZGf1QPhTNy6LvGhlsoeL3Z3X89NU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200326155839eucas1p1c7598c32383161c4b7eeb9d615958aab~-5dpKPaUy1202612026eucas1p1X;
        Thu, 26 Mar 2020 15:58:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 8A.F5.61286.F21DC7E5; Thu, 26
        Mar 2020 15:58:39 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200326155839eucas1p2c9e354eb1f81d47c2c00d1c6c42f28a5~-5dou6fto2605126051eucas1p2y;
        Thu, 26 Mar 2020 15:58:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200326155839eusmtrp1437c620802f6dc94705d32f0341cc41e~-5douWMgO2090020900eusmtrp1T;
        Thu, 26 Mar 2020 15:58:39 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-b6-5e7cd12f4499
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 47.CA.07950.E21DC7E5; Thu, 26
        Mar 2020 15:58:39 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155838eusmtip1a49e6c1093f52603a5a7dc355c36ce88~-5doTwIB01506115061eusmtip1w;
        Thu, 26 Mar 2020 15:58:38 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v5 02/27] ata: expose ncq_enable_prio sysfs attribute only
 on NCQ capable hosts
Date:   Thu, 26 Mar 2020 16:57:57 +0100
Message-Id: <20200326155822.19400-3-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200326155822.19400-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfyyUcRzH973nuece1ulxlM9k4VqtNL/ZnhSj1fZs/aP1h7HQlWcYju5x
        SvOHreiY5Lj5cYWWdceZn8Oh+YdhN5xhazG/k1RTRpGKuvNQ/nt935/3+/v5fL77kpikQehM
        JsrTWYVcliwlbPGOgW2zp/dYVozP4rIrXT/zlKBbypuE9PJUj4Cuq+8X0AOdiwJ6ovs5QeuX
        GjC6MqdMFEoyXdoZETMxomR6+1SIMeVs4szryWyCKWwzIGaj9WS4KMr2UhybnJjBKrxDbtkm
        rC3MCtNMx+/vmgewbLQlyUc2JFAB8MpkxK0soWoRaHKYfGRr4W8Ivhg6EH/YQNA8tUscJEY/
        mEV8QY9gfrJS9C9SVmjccxFUEKgfG5CVHSk3KPhVR1hNGPUVQW1xz15DB0oGU6WzFiZJnDoN
        TQVglcVUMNR8fofz3VyhfXNdaGUbKgT0jdUY77EHU8XSngezeB62P8Os9wOlE8G4akTAh69A
        3m8z4tkBPg22iXh2gaGSApwPNCLYUa3sp40I9CUHi16EafNPwjodRp2Dpm5vXg4D9Y4Os8pA
        2cHbVXt+CDso7ijbl8Wgyt1/3zPQrGsmDtrmd9VhPDMwPTEvKELu2kPraA+to/3f9wXCDMiJ
        VXIp8SznK2fveXGyFE4pj/e6k5rSiiyfaGh3cL0TfR+/3YsoEkmPiM8+yoqRCGUZXGZKLwIS
        kzqK30daJHGcLPMBq0iNVSiTWa4XnSBxqZPY/+XHaAkVL0tnk1g2jVUcVAWkjXM2cim/G7St
        1JcGqLu0I3In8k9gwGr4tGNgx5tKQ2TfeOiNraII6bXLC8ZsxSm/iBk056PEPaP6IXiI24ge
        81GPrtG6prxc5fBV+4Hz1z0Gl4dSueoxnXElrmVu9OixKrfQJM12jVuFv1+YfljUsoi5M5NP
        qm5eaO37oRnUTMZKcS5B5uuBKTjZX5PC4CxAAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xu7r6F2viDH50MFmsvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9
        O5uU1JzMstQifbsEvYwPD++xFpwUq/h37hhzA+N3oS5GTg4JAROJ88/PsXcxcnEICSxllLiy
        dztLFyMHUEJG4vj6MogaYYk/17rYIGo+MUr0zrnMBpJgE7CSmNi+ihHEFhFQkOj5vRKsiFng
        K6PE0kndzCAJYYF4iUOHDrGDDGURUJVY3yMBEuYVsJVY/PoxC8QCeYmt3z6xgticAnYSy9fN
        B2sVAqn58oEJol5Q4uTMJ2D1zED1zVtnM09gFJiFJDULSWoBI9MqRpHU0uLc9NxiI73ixNzi
        0rx0veT83E2MwHjZduznlh2MXe+CDzEKcDAq8fBqtNTECbEmlhVX5h5ilOBgVhLhfRoJFOJN
        SaysSi3Kjy8qzUktPsRoCvTDRGYp0eR8YCznlcQbmhqaW1gamhubG5tZKInzdggcjBESSE8s
        Sc1OTS1ILYLpY+LglGpgVP704fb64tRO1UNzBLWTjfXqDk7Of6hdvmWBvOvm+HN9W9ckfO88
        UqH5yF54cuWqsyenKfG8tjyl/sG0TviK8sm0vAfqXHaBsjukQt/yfqjPnNnEvS3uy/KrvI5r
        Nli7xq7gv8OlabfC+42GkXt05dw/Pa+mbnp+7ozsKa9gyWsfCt7qPDP1V2Ipzkg01GIuKk4E
        AH+BQSWtAgAA
X-CMS-MailID: 20200326155839eucas1p2c9e354eb1f81d47c2c00d1c6c42f28a5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200326155839eucas1p2c9e354eb1f81d47c2c00d1c6c42f28a5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200326155839eucas1p2c9e354eb1f81d47c2c00d1c6c42f28a5
References: <20200326155822.19400-1-b.zolnierkie@samsung.com>
        <CGME20200326155839eucas1p2c9e354eb1f81d47c2c00d1c6c42f28a5@eucas1p2.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

There is no point in exposing ncq_enable_prio sysfs attribute for
devices on PATA and non-NCQ capable SATA hosts so:

* remove dev_attr_ncq_prio_enable from ata_common_sdev_attrs[]

* add ata_ncq_sdev_attrs[]

* update ATA_NCQ_SHT() macro to use ata_ncq_sdev_attrs[]

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-scsi.c |  8 +++++++-
 include/linux/libata.h    | 11 ++++++++---
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index ebc3de7c363a..005c6f2f7d21 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -463,11 +463,17 @@ EXPORT_SYMBOL_GPL(dev_attr_sw_activity);
 
 struct device_attribute *ata_common_sdev_attrs[] = {
 	&dev_attr_unload_heads,
-	&dev_attr_ncq_prio_enable,
 	NULL
 };
 EXPORT_SYMBOL_GPL(ata_common_sdev_attrs);
 
+struct device_attribute *ata_ncq_sdev_attrs[] = {
+	&dev_attr_unload_heads,
+	&dev_attr_ncq_prio_enable,
+	NULL
+};
+EXPORT_SYMBOL_GPL(ata_ncq_sdev_attrs);
+
 /**
  *	ata_std_bios_param - generic bios head/sector/cylinder calculator used by sd.
  *	@sdev: SCSI device for which BIOS geometry is to be determined
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 710e09dae910..350fa584acde 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1334,6 +1334,7 @@ extern int ata_link_nr_enabled(struct ata_link *link);
 extern const struct ata_port_operations ata_base_port_ops;
 extern const struct ata_port_operations sata_port_ops;
 extern struct device_attribute *ata_common_sdev_attrs[];
+extern struct device_attribute *ata_ncq_sdev_attrs[];
 
 /*
  * All sht initializers (BASE, PIO, BMDMA, NCQ) must be instantiated
@@ -1341,7 +1342,7 @@ extern struct device_attribute *ata_common_sdev_attrs[];
  * edge driver's module reference, otherwise the driver can be unloaded
  * even if the scsi_device is being accessed.
  */
-#define ATA_BASE_SHT(drv_name)					\
+#define __ATA_BASE_SHT(drv_name)				\
 	.module			= THIS_MODULE,			\
 	.name			= drv_name,			\
 	.ioctl			= ata_scsi_ioctl,		\
@@ -1355,11 +1356,15 @@ extern struct device_attribute *ata_common_sdev_attrs[];
 	.slave_configure	= ata_scsi_slave_config,	\
 	.slave_destroy		= ata_scsi_slave_destroy,	\
 	.bios_param		= ata_std_bios_param,		\
-	.unlock_native_capacity	= ata_scsi_unlock_native_capacity, \
+	.unlock_native_capacity	= ata_scsi_unlock_native_capacity
+
+#define ATA_BASE_SHT(drv_name)					\
+	__ATA_BASE_SHT(drv_name),				\
 	.sdev_attrs		= ata_common_sdev_attrs
 
 #define ATA_NCQ_SHT(drv_name)					\
-	ATA_BASE_SHT(drv_name),					\
+	__ATA_BASE_SHT(drv_name),				\
+	.sdev_attrs		= ata_ncq_sdev_attrs,		\
 	.change_queue_depth	= ata_scsi_change_queue_depth
 
 /*
-- 
2.24.1

