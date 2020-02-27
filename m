Return-Path: <SRS0=ljer=4P=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4E1C35E15
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9110F246BD
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jaB5UAr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbgB0SWm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:22:42 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39680 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730863AbgB0SWm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Feb 2020 13:22:42 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200227182240euoutp0166d52038f37923bfaee8adb746a9d48a~3VXZfyJXF1058810588euoutp019
        for <linux-ide@vger.kernel.org>; Thu, 27 Feb 2020 18:22:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200227182240euoutp0166d52038f37923bfaee8adb746a9d48a~3VXZfyJXF1058810588euoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582827760;
        bh=IdmCUBxgFlf//TBu/Br//NY1ssaROzxlh9KlCCrWTcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jaB5UAr6DMZ7FbWSEPTUuEXwDKnU/TM/6yfELobnoif8Q5PfXcS/4dsy5tDoHVAFP
         3Xbqo6P2WJJ/YVbDi+ZPWb9w+dK95MhjrQFaeEA0c7V6IScbF0QWn1TXaykxApptAO
         /DLoLEWOtlJRIfmGKg5/4gsh3fGUKuuMTmWVau4E=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200227182240eucas1p2bde1c559fc03fbe46dba86a909cbdb71~3VXZJdJqp2012220122eucas1p2a;
        Thu, 27 Feb 2020 18:22:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 42.5F.61286.0F8085E5; Thu, 27
        Feb 2020 18:22:40 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200227182239eucas1p2fe76dcb686bea8f0a527461807b9292e~3VXYX-46p3194731947eucas1p2B;
        Thu, 27 Feb 2020 18:22:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200227182239eusmtrp23f318807369de237dd6f81a56feb9368~3VXYTPAUx1813218132eusmtrp2g;
        Thu, 27 Feb 2020 18:22:39 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-5a-5e5808f00413
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DB.B1.08375.FE8085E5; Thu, 27
        Feb 2020 18:22:39 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200227182239eusmtip29abd9271ce91f4f82a4c8f9841b5152c~3VXX2ah3a0595905959eusmtip2i;
        Thu, 27 Feb 2020 18:22:39 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v3 02/27] ata: expose ncq_enable_prio sysfs attribute only
 on NCQ capable hosts
Date:   Thu, 27 Feb 2020 19:22:01 +0100
Message-Id: <20200227182226.19188-3-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227182226.19188-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djPc7ofOCLiDH418VisvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoLpuU1JzMstQifbsErozmvv0sBT/4K5Y1f2JuYDzE28XIySEh
        YCLx7dBEti5GLg4hgRWMEvf/XYVyvjBKrNm2hgnC+cwo8fTZKSaYljWP70ElljNKvLw3nQWu
        pXF1B1gVm4CVxMT2VYwgtoiAgkTP75Vgc5kF3jNKrJi0lwUkISyQKHH6yg2gBAcHi4CqxPFF
        6iBhXgFbidkvzrBBbJOX2PrtEyuIzSlgJ3GjbzsbRI2gxMmZT8DGMAPVNG+dzQwyX0JgFbvE
        o/dzoJpdJB7deMAKYQtLvDq+hR3ClpH4v3M+E0TDOkaJvx0voLq3M0osn/wPqtta4s65X2DX
        MQtoSqzfpQ8RdpSY8GUDWFhCgE/ixltBiCP4JCZtm84MEeaV6GgTgqhWk9iwbAMbzNqunSuZ
        IWwPidu9l9kmMCrOQvLOLCTvzELYu4CReRWjeGppcW56arFhXmq5XnFibnFpXrpecn7uJkZg
        Kjr97/inHYxfLyUdYhTgYFTi4V2wIzxOiDWxrLgy9xCjBAezkgjvxq+hcUK8KYmVValF+fFF
        pTmpxYcYpTlYlMR5jRe9jBUSSE8sSc1OTS1ILYLJMnFwSjUwRs2y0N28Ytve8p6zPd6L/Xbn
        Z97TbrN9YBc5edIVbtOEE/0vdilv/Oe0T+bSgYq23xz3GFU5ZoZpVbrpceQc/N3dsP7k9Iai
        N1+szwiYKkmd2iOzu/zjn/NVTqd7PgXrPOmxYzn3c+quGWfupYtai9hYHghXndFRXcmifUCF
        N4H13a6XfjvqlViKMxINtZiLihMBo43BB0EDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xe7rvOSLiDO5+UbFYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehnNfftZCn7wVyxr/sTcwHiIt4uRk0NCwERizeN7TF2MXBxCAksZJfoX
        vmHuYuQASshIHF9fBlEjLPHnWhcbRM0nRoldy+YzgyTYBKwkJravYgSxRQQUJHp+rwQrYhb4
        yiixdFI32CBhgXiJMzPiQEwWAVWJ44vUQcp5BWwlZr84wwYxX15i67dPrCA2p4CdxI2+7WBx
        IaCaro6njBD1ghInZz5hAbGZgeqbt85mnsAoMAtJahaS1AJGplWMIqmlxbnpucWGesWJucWl
        eel6yfm5mxiB0bLt2M/NOxgvbQw+xCjAwajEw7tgR3icEGtiWXFl7iFGCQ5mJRHejV9D44R4
        UxIrq1KL8uOLSnNSiw8xmgL9MJFZSjQ5HxjJeSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNIT
        S1KzU1MLUotg+pg4OKUaGJsvekwKq3r26IHqowmPmnTkrHNEFkmeNHN4c/eSzDL7Ox6ldjKp
        r9Wv3D8x59vqylbDLZ+1zk7/urc9sl0gwGVW08ULwonNEoaL1LSSHq4z0UpO0z8esnX/fPPY
        xMq5E/Zt+t/Ic9dK6etlQZMkUfmPm9qfL5gl1fh+04ZtV16fmr5jnvCGmt1KLMUZiYZazEXF
        iQAjtKByrAIAAA==
X-CMS-MailID: 20200227182239eucas1p2fe76dcb686bea8f0a527461807b9292e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200227182239eucas1p2fe76dcb686bea8f0a527461807b9292e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200227182239eucas1p2fe76dcb686bea8f0a527461807b9292e
References: <20200227182226.19188-1-b.zolnierkie@samsung.com>
        <CGME20200227182239eucas1p2fe76dcb686bea8f0a527461807b9292e@eucas1p2.samsung.com>
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
 drivers/ata/libata-scsi.c | 8 +++++++-
 include/linux/libata.h    | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 11eb25b6e2cd..161e5d84bd82 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -462,11 +462,17 @@ EXPORT_SYMBOL_GPL(dev_attr_sw_activity);
 
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
index 2ca9b7056a82..df8f20a2a305 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1336,6 +1336,7 @@ extern int ata_link_nr_enabled(struct ata_link *link);
 extern const struct ata_port_operations ata_base_port_ops;
 extern const struct ata_port_operations sata_port_ops;
 extern struct device_attribute *ata_common_sdev_attrs[];
+extern struct device_attribute *ata_ncq_sdev_attrs[];
 
 /*
  * All sht initializers (BASE, PIO, BMDMA, NCQ) must be instantiated
@@ -1362,6 +1363,7 @@ extern struct device_attribute *ata_common_sdev_attrs[];
 
 #define ATA_NCQ_SHT(drv_name)					\
 	ATA_BASE_SHT(drv_name),					\
+	.sdev_attrs		= ata_ncq_sdev_attrs,		\
 	.change_queue_depth	= ata_scsi_change_queue_depth
 
 /*
-- 
2.24.1

