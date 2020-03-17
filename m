Return-Path: <SRS0=AjNr=5C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A40EC5ACBF
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024292073E
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sx8UOuYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgCQOnp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:43:45 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45862 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbgCQOno (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Mar 2020 10:43:44 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200317144342euoutp01f89096b2cbf1d20079f8a0f280b12666~9HoojEVHU2336723367euoutp017
        for <linux-ide@vger.kernel.org>; Tue, 17 Mar 2020 14:43:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200317144342euoutp01f89096b2cbf1d20079f8a0f280b12666~9HoojEVHU2336723367euoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584456222;
        bh=IMmyes1LIpriIQ41U3+KWe0FBAyMNloTDLxuMZGhBY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sx8UOuYxVHvDvLwAl98IkU6pnR/JbIR64uKnO5KW2aO3FepGP4k7ZgWpploRTVoIu
         WWd13yXdFluS8hFfW8IbBzFpwnyi2bamVZ98APXn7sjcU8v8j8vT+8OmyvFeXIIG07
         hsBRZhS5+0ucb36n/9K8CbmGS3qI8Skv4tWpQMGM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200317144342eucas1p2a17150759d5fff9c110bcf13967fc9af~9HooPmRtu0343503435eucas1p2H;
        Tue, 17 Mar 2020 14:43:42 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id FC.E1.60679.E12E07E5; Tue, 17
        Mar 2020 14:43:42 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144341eucas1p1b9caa7264b35b23e78fcaeb78d865255~9Hon5m86S1086210862eucas1p1Q;
        Tue, 17 Mar 2020 14:43:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200317144341eusmtrp28102c2f45b8070197539904f9e603395~9Hon4RG7S0146401464eusmtrp2-;
        Tue, 17 Mar 2020 14:43:41 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-34-5e70e21ec05f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B8.D4.08375.D12E07E5; Tue, 17
        Mar 2020 14:43:41 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144341eusmtip1ba90665aafc89a6defcbc2438b6a9e3f~9HonbYCXp1027610276eusmtip1B;
        Tue, 17 Mar 2020 14:43:41 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v4 02/27] ata: expose ncq_enable_prio sysfs attribute only
 on NCQ capable hosts
Date:   Tue, 17 Mar 2020 15:43:08 +0100
Message-Id: <20200317144333.2904-3-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317144333.2904-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7djPc7pyjwriDB7f5LBYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBnzOq6xFcwRq7g++RpjA+N5oS5GTg4J
        AROJ72/nsnYxcnEICaxglHh67RCU84VR4sueP8wQzmdGia/7rzHDtHRdu8gIkVjOKLFz1QZm
        uJblV68zglSxCVhJTGxfBWaLCChI9PxeyQZSxCzwnlFixaS9LCAJYYFEiW9/JrJ3MXJwsAio
        Smx64gMS5hWwkbg1bzYrxDZ5ia3fPoHZnAK2EtcO/2ODqBGUODnzCdgYZqCa5q2zwY6QEFjF
        LtF5vR+q2UXi2KkWRghbWOLV8S3sELaMxP+d85kgGtYxSvzteAHVvR3ohckQKyQErCXunPvF
        BnIds4CmxPpd+iCmhICjxOnlehAmn8SNt4IQN/BJTNo2nRkizCvR0QYNXzWJDcs2sMFs7dq5
        EqrEQ2LhXt8JjIqzkDwzC8kzsxC2LmBkXsUonlpanJueWmyUl1quV5yYW1yal66XnJ+7iRGY
        hk7/O/5lB+OuP0mHGAU4GJV4eDk2FMQJsSaWFVfmHmKU4GBWEuFdXJgfJ8SbklhZlVqUH19U
        mpNafIhRmoNFSZzXeNHLWCGB9MSS1OzU1ILUIpgsEwenVAOjYef5W6fcjuS+O19js+51GK+a
        79WcvWHP2Z/t/ajSF6F0lWHbmRtP3vo3lFtyRBY7TZlbVP7yvGrEYjsbJ0s+yX8pseW/TXVm
        /TGwXsYn8mZe+3nD6pQNj2WV2g99LSz5vtvFsJHBftLLtY7b58pJfw28e1Poi/aPYieDl1bT
        bTbrrLYt9VmsxFKckWioxVxUnAgAGKUliT8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xu7qyjwriDBY90rdYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehnzOq6xFcwRq7g++RpjA+N5oS5GTg4JAROJrmsXGbsYuTiEBJYySqxt
        ucrexcgBlJCROL6+DKJGWOLPtS42iJpPjBIr/vxhA0mwCVhJTGxfxQhiiwgoSPT8XglWxCzw
        lVFi6aRuZpCEsEC8xI85p1lBhrIIqEpseuIDEuYVsJG4NW82K8QCeYmt3z6B2ZwCthLXDv8D
        my8EVPPizX8miHpBiZMzn7CA2MxA9c1bZzNPYBSYhSQ1C0lqASPTKkaR1NLi3PTcYkO94sTc
        4tK8dL3k/NxNjMB42Xbs5+YdjJc2Bh9iFOBgVOLh5dhQECfEmlhWXJl7iFGCg1lJhHdxYX6c
        EG9KYmVValF+fFFpTmrxIUZToB8mMkuJJucDYzmvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBA
        emJJanZqakFqEUwfEwenVANjwJTYnzs1cg3W/f1tN6Ew7KR5RepW4aWiNT9zlh9+18xXOJO1
        YP8Z6ctbYxmlErWUi/a23XHtfl2bdUPL8XPk/Ao9+909+4Un928WNV8UE8109dMtZw7e/Daj
        p1d9LnTxcRjs29k93cvcvZ2N73K52M/k2DXf0lf81b+pUplt9ifyjmyrgrQSS3FGoqEWc1Fx
        IgB3hwBPrQIAAA==
X-CMS-MailID: 20200317144341eucas1p1b9caa7264b35b23e78fcaeb78d865255
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200317144341eucas1p1b9caa7264b35b23e78fcaeb78d865255
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200317144341eucas1p1b9caa7264b35b23e78fcaeb78d865255
References: <20200317144333.2904-1-b.zolnierkie@samsung.com>
        <CGME20200317144341eucas1p1b9caa7264b35b23e78fcaeb78d865255@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

There is no point in exposing ncq_enable_prio sysfs attribute for
devices on PATA and non-NCQ capable SATA hosts so:

* remove dev_attr_ncq_prio_enable from ata_common_sdev_attrs[]

* add ata_ncq_sdev_attrs[]

* update ATA_NCQ_SHT() macro to use ata_ncq_sdev_attrs[]

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-scsi.c |  8 +++++++-
 include/linux/libata.h    | 11 ++++++++---
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 5a4f43c85131..7ef21e282061 100644
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
index e7090df2231b..fe8a360b4956 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1337,6 +1337,7 @@ extern int ata_link_nr_enabled(struct ata_link *link);
 extern const struct ata_port_operations ata_base_port_ops;
 extern const struct ata_port_operations sata_port_ops;
 extern struct device_attribute *ata_common_sdev_attrs[];
+extern struct device_attribute *ata_ncq_sdev_attrs[];
 
 /*
  * All sht initializers (BASE, PIO, BMDMA, NCQ) must be instantiated
@@ -1344,7 +1345,7 @@ extern struct device_attribute *ata_common_sdev_attrs[];
  * edge driver's module reference, otherwise the driver can be unloaded
  * even if the scsi_device is being accessed.
  */
-#define ATA_BASE_SHT(drv_name)					\
+#define __ATA_BASE_SHT(drv_name)				\
 	.module			= THIS_MODULE,			\
 	.name			= drv_name,			\
 	.ioctl			= ata_scsi_ioctl,		\
@@ -1358,11 +1359,15 @@ extern struct device_attribute *ata_common_sdev_attrs[];
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

