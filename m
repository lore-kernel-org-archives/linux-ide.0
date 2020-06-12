Return-Path: <SRS0=lHAY=7Z=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0AEC433E0
	for <linux-ide@archiver.kernel.org>; Fri, 12 Jun 2020 12:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1644A2081A
	for <linux-ide@archiver.kernel.org>; Fri, 12 Jun 2020 12:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="D/X4Lr/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgFLMJg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 12 Jun 2020 08:09:36 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55993 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgFLMJf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 12 Jun 2020 08:09:35 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200612120933euoutp02d8fc85458fd53ec8da88b7e18269c098~Xyp4EeGsd2796227962euoutp02M
        for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2020 12:09:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200612120933euoutp02d8fc85458fd53ec8da88b7e18269c098~Xyp4EeGsd2796227962euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591963773;
        bh=dTgb0aDOsdW8dndgwJIretJ8lZpwDeagig+xzF9HRe4=;
        h=To:Cc:From:Subject:Date:References:From;
        b=D/X4Lr/bHQEKjFvYjka6Hh03+ya9Ek0eCeaeM/AAY7Y23gFSXOAK/ioj0heV9exdB
         c+LLzXRthpS+JneWQGRigP3QoTCkPvXSyzGNl9lP5ym0CRxVIgP3NvsLcm/tmH+1mp
         7MnMjtwmyvpiATWofRWZ2lHgfKOvbCDVl6mTHfeU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200612120932eucas1p1f963a07711503087e331b5a761f47cf9~Xyp3shBKJ0102601026eucas1p15;
        Fri, 12 Jun 2020 12:09:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D4.62.60698.C7073EE5; Fri, 12
        Jun 2020 13:09:32 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200612120932eucas1p29411e0c60963fad8c36ca35f2e6b8872~Xyp3YdLuE0030800308eucas1p2M;
        Fri, 12 Jun 2020 12:09:32 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200612120932eusmtrp199d1b76f882695df09220ed25fa130d6~Xyp3X2ZCK2263322633eusmtrp1G;
        Fri, 12 Jun 2020 12:09:32 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-85-5ee3707cd135
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 99.2F.08375.C7073EE5; Fri, 12
        Jun 2020 13:09:32 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200612120932eusmtip1f5a2a2fc60ad74c0d6a5082b15f12b55~Xyp3E61511573915739eusmtip17;
        Fri, 12 Jun 2020 12:09:32 +0000 (GMT)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kernel test robot <lkp@intel.com>, Christoph Hellwig <hch@lst.de>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] ata: fix AHCI_SHT() macro definition
Message-ID: <0d803e72-b15e-4673-4858-4741f2772fc4@samsung.com>
Date:   Fri, 12 Jun 2020 14:09:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsWy7djP87o1BY/jDHYfM7RYfbefzWLl6qNM
        Fsd2PGKyuLxrDpvFq+ZHbA6sHov3vGTyuHy21GP3zQY2j8+b5AJYorhsUlJzMstSi/TtErgy
        vqz8z1awR6rie8duxgbG3aJdjJwcEgImEn8f3mXsYuTiEBJYwSixcckVKOcLo0Tb7StsEM5n
        RonzDz6zwrT8WzOPCSKxnFHi9+mpUM5bRokVj+cyg1SJCChI9PxeCdbOLNDAKHH25S52kASb
        gJXExPZVjCC2sICpxO5bp8DivAJ2Etu2/QRrZhFQlXh6vQGsRlQgQuLTg8OsEDWCEidnPmEB
        sZkFxCVuPZnPBGHLSzRvnc0MskxCoJ1d4sLiH0ANHECOi0RnqzzE2cISr45vYYewZSROT+5h
        gahfxyjxt+MFVPN2Ronlk/+xQVRZS9w594sNZBCzgKbE+l36EGFHieVnJzNCzOeTuPFWEOIG
        PolJ26YzQ4R5JTrahCCq1SQ2LNvABrO2a+dKZgjbQ2L93W62CYyKs5B8NgvJZ7OQfDYL4YYF
        jCyrGMVTS4tz01OLjfNSy/WKE3OLS/PS9ZLzczcxAtPM6X/Hv+5g3Pcn6RCjAAejEg+vQcLj
        OCHWxLLiytxDjBIczEoivE5nT8cJ8aYkVlalFuXHF5XmpBYfYpTmYFES5zVe9DJWSCA9sSQ1
        OzW1ILUIJsvEwSnVwJjx9OMu7gLJ7Wwbu8xjzLtKavMTljnPupqv4nn9oe3cu7/zdlWz5X95
        N+nvpcmXJ/40cczJ/CznrfLG8QpjyFX+rry//fETcn84v+jgyJsTNHXjRMu35f+P575633vd
        6r2c777Tpe9vq+1v+Mo8xfamX2iel67183N9AWyV7V+uXbf+OuFYFIMSS3FGoqEWc1FxIgBb
        PsjqLwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsVy+t/xu7o1BY/jDM6flLNYfbefzWLl6qNM
        Fsd2PGKyuLxrDpvFq+ZHbA6sHov3vGTyuHy21GP3zQY2j8+b5AJYovRsivJLS1IVMvKLS2yV
        og0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyvqz8z1awR6rie8duxgbG3aJd
        jJwcEgImEv/WzGPqYuTiEBJYyijx++9sti5GDqCEjMTx9WUQNcISf651sUHUvGaUWD91GxNI
        QkRAQaLn90qwBLNAA6PE84ln2EASbAJWEhPbVzGC2MICphK7b51iB7F5Bewktm37yQxiswio
        Sjy93gBWIyoQIXF4xyxGiBpBiZMzn7CA2MwC6hJ/5l1ihrDFJW49mc8EYctLNG+dzTyBUWAW
        kpZZSFpmIWmZhaRlASPLKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMAo2Xbs5+YdjJc2Bh9i
        FOBgVOLh7Uh6HCfEmlhWXJl7iFGCg1lJhNfp7Ok4Id6UxMqq1KL8+KLSnNTiQ4ymQA9NZJYS
        Tc4HRnBeSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQZG1Svhk+qE
        rX9OO+lzi0/vmm2CddGiG1PuJYac5vnCFXEqWfqq+9p7RorMIlPlZY656dclWVz2zHS9xuC1
        2Mpfneke34X/ZydMbHgiFam9hndji+2iJZOKhb1D5jOudv/XOe2tg8iqUmkWcfYdJ1xO7Zbk
        iV3mGpZYurc6OGe5dT9nUNbx6UuVWIozEg21mIuKEwFP4N7tqAIAAA==
X-CMS-MailID: 20200612120932eucas1p29411e0c60963fad8c36ca35f2e6b8872
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200612120932eucas1p29411e0c60963fad8c36ca35f2e6b8872
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200612120932eucas1p29411e0c60963fad8c36ca35f2e6b8872
References: <CGME20200612120932eucas1p29411e0c60963fad8c36ca35f2e6b8872@eucas1p2.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fix AHCI_SHT() macro definition to not reinitialize .can_queue and
.sdev_attrs fields.

This removes gcc warnings from W=1 builds such as:

  CC      drivers/ata/ahci_platform.o
In file included from drivers/ata/ahci_platform.c:21:0:
drivers/ata/ahci.h:384:16: warning: initialized field overwritten [-Woverride-init]
  .can_queue  = AHCI_MAX_CMDS,   \
                ^
drivers/ata/ahci_platform.c:40:2: note: in expansion of macro ‘AHCI_SHT’
  AHCI_SHT(DRV_NAME),
  ^
drivers/ata/ahci.h:384:16: note: (near initialization for ‘ahci_platform_sht.can_queue’)
  .can_queue  = AHCI_MAX_CMDS,   \
                ^
drivers/ata/ahci_platform.c:40:2: note: in expansion of macro ‘AHCI_SHT’
  AHCI_SHT(DRV_NAME),
  ^
drivers/ata/ahci.h:388:17: warning: initialized field overwritten [-Woverride-init]
  .sdev_attrs  = ahci_sdev_attrs
                 ^
drivers/ata/ahci_platform.c:40:2: note: in expansion of macro ‘AHCI_SHT’
  AHCI_SHT(DRV_NAME),
  ^
drivers/ata/ahci.h:388:17: note: (near initialization for ‘ahci_platform_sht.sdev_attrs’)
  .sdev_attrs  = ahci_sdev_attrs
                 ^
drivers/ata/ahci_platform.c:40:2: note: in expansion of macro ‘AHCI_SHT’
  AHCI_SHT(DRV_NAME),
  ^

Reported-by: kernel test robot <lkp@intel.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/ahci.h     |    7 ++++---
 include/linux/libata.h |    3 ++-
 2 files changed, 6 insertions(+), 4 deletions(-)

Index: b/drivers/ata/ahci.h
===================================================================
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -378,15 +378,16 @@ extern struct device_attribute *ahci_sde
 
 /*
  * This must be instantiated by the edge drivers.  Read the comments
- * for ATA_BASE_SHT
+ * for __ATA_BASE_SHT
  */
 #define AHCI_SHT(drv_name)						\
-	ATA_NCQ_SHT(drv_name),						\
+	__ATA_BASE_SHT(drv_name),					\
 	.can_queue		= AHCI_MAX_CMDS,			\
 	.sg_tablesize		= AHCI_MAX_SG,				\
 	.dma_boundary		= AHCI_DMA_BOUNDARY,			\
 	.shost_attrs		= ahci_shost_attrs,			\
-	.sdev_attrs		= ahci_sdev_attrs
+	.sdev_attrs		= ahci_sdev_attrs,			\
+	.change_queue_depth	= ata_scsi_change_queue_depth
 
 extern struct ata_port_operations ahci_ops;
 extern struct ata_port_operations ahci_platform_ops;
Index: b/include/linux/libata.h
===================================================================
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1389,7 +1389,6 @@ extern struct device_attribute *ata_comm
 	ATA_SCSI_COMPAT_IOCTL					\
 	.queuecommand		= ata_scsi_queuecmd,		\
 	.dma_need_drain		= ata_scsi_dma_need_drain,	\
-	.can_queue		= ATA_DEF_QUEUE,		\
 	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,		\
 	.this_id		= ATA_SHT_THIS_ID,		\
 	.emulated		= ATA_SHT_EMULATED,		\
@@ -1401,6 +1400,7 @@ extern struct device_attribute *ata_comm
 
 #define ATA_BASE_SHT(drv_name)					\
 	__ATA_BASE_SHT(drv_name),				\
+	.can_queue		= ATA_DEF_QUEUE,		\
 	.sdev_attrs		= ata_common_sdev_attrs
 
 #ifdef CONFIG_SATA_HOST
@@ -1408,6 +1408,7 @@ extern struct device_attribute *ata_ncq_
 
 #define ATA_NCQ_SHT(drv_name)					\
 	__ATA_BASE_SHT(drv_name),				\
+	.can_queue		= ATA_DEF_QUEUE,		\
 	.sdev_attrs		= ata_ncq_sdev_attrs,		\
 	.change_queue_depth	= ata_scsi_change_queue_depth
 #endif
