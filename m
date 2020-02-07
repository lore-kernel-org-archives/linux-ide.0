Return-Path: <SRS0=qhS8=33=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3513C04EB5
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6C821775
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DA6XRtg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgBGO3j (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:29:39 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49559 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbgBGO1z (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Feb 2020 09:27:55 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200207142753euoutp02dc894bd66cc89ce1d42a4463ed56448c~xJQr-lPKv2563925639euoutp02H
        for <linux-ide@vger.kernel.org>; Fri,  7 Feb 2020 14:27:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200207142753euoutp02dc894bd66cc89ce1d42a4463ed56448c~xJQr-lPKv2563925639euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581085673;
        bh=3qQ1tXUxRM71luwJzKpnWX6QalcKDrTN3LSmn7K5Nks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DA6XRtg+jNLKo668xYU7wjQ1suKmqxgZHIffn229Wpn71wclTZLmL0vc8uEoFKR5Z
         LR0KDu/ZE7lnvlvyE5AkJR52qBcGDQHTuDVarrQzNaRK/wwWQW5rC7xhldiGoQwGbE
         aw1CsHUdrD7xVuxqiIWeU0XxISQ2Ju995rK3gVl8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200207142752eucas1p1220d7dbf51fed220594894523b477940~xJQrnUR3K2611726117eucas1p1a;
        Fri,  7 Feb 2020 14:27:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id BA.4D.60679.8E37D3E5; Fri,  7
        Feb 2020 14:27:52 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200207142752eucas1p14ad96c1adf7508226cfdfa583bb442aa~xJQq0o3U61085510855eucas1p1k;
        Fri,  7 Feb 2020 14:27:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200207142752eusmtrp1e9328c7be91b80533c6a3cb38c12eb51~xJQq0CWT10480004800eusmtrp17;
        Fri,  7 Feb 2020 14:27:52 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-6a-5e3d73e80482
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 87.89.08375.8E37D3E5; Fri,  7
        Feb 2020 14:27:52 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142751eusmtip2917d6e1f493005230c987391dc2f26d2~xJQqX25VE2706527065eusmtip2Z;
        Fri,  7 Feb 2020 14:27:51 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v2 02/26] ata: expose ncq_enable_prio sysfs attribute only
 on NCQ capable hosts
Date:   Fri,  7 Feb 2020 15:27:10 +0100
Message-Id: <20200207142734.8431-3-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207142734.8431-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djPc7ovim3jDF71mFqsvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoLpuU1JzMstQifbsEroze7u1sBT/4K/o6L7M1MB7i7WLk5JAQ
        MJHY+fQ6excjF4eQwApGiXkH/rJBOF8YJTbefcsI4XxmlJj84i0bTMuaOTNZIRLLGSWWru9k
        hWt5t2UNO0gVm4CVxMT2VYwgtoiAgkTP75Vgc5kF3jNKrJi0lwUkISyQKPF6+m6wIhYBVYnn
        1/azgti8AjYSj14+h1onL7H12yewOKeArcTHKX/ZIGoEJU7OfAI2hxmopnnrbGaQBRICq9gl
        Wi5sZoFodpHonbqbGcIWlnh1fAs7hC0jcXpyDwtEwzpGib8dL6C6tzNKLJ/8D2q1tcSdc7+A
        bA6gFZoS63fpQ4QdJX5uWMoKEpYQ4JO48VYQ4gg+iUnbpjNDhHklOtqEIKrVJDYs28AGs7Zr
        50qoczwkVv3ezzqBUXEWkndmIXlnFsLeBYzMqxjFU0uLc9NTi43yUsv1ihNzi0vz0vWS83M3
        MQKT0el/x7/sYNz1J+kQowAHoxIPb4KjTZwQa2JZcWXuIUYJDmYlEd4+Vds4Id6UxMqq1KL8
        +KLSnNTiQ4zSHCxK4rzGi17GCgmkJ5akZqemFqQWwWSZODilGhgVHmlFCEh9C12wgXlWzs/1
        Gx5t404ReTp7pcCkjVveLjtZNM89lpUlZZFpYe7Nh1c/fTwptnWJvus9SWOxtd4CRSoLZWom
        mPbtd971+WdkyUc73nPhXbutGw3KYmWrDFQWSIteP99eccB8z+cVc2sM3hSaTvjTOPGxdc5H
        Bp03S3hXTFitvfKpEktxRqKhFnNRcSIAd24TJUIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xe7ovim3jDM7fYrZYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehm93dvZCn7wV/R1XmZrYDzE28XIySEhYCKxZs5M1i5GLg4hgaWMEm1X
        fzN2MXIAJWQkjq8vg6gRlvhzrYsNouYTo8SxPdsYQRJsAlYSE9tXgdkiAgoSPb9XghUxC3xl
        lFg6qZsZJCEsEC9x7fVqNhCbRUBV4vm1/awgNq+AjcSjl8/ZIDbIS2z99gkszilgK/Fxyl+w
        uBBQzff3k9gh6gUlTs58wgJiMwPVN2+dzTyBUWAWktQsJKkFjEyrGEVSS4tz03OLDfWKE3OL
        S/PS9ZLzczcxAiNm27Gfm3cwXtoYfIhRgINRiYc3wdEmTog1say4MvcQowQHs5IIb5+qbZwQ
        b0piZVVqUX58UWlOavEhRlOgJyYyS4km5wOjOa8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6
        YklqdmpqQWoRTB8TB6dUA6NMKfOSyx8dHEIWtartqipbNWdFiilnaueKSzUHpX6HM5/miHz5
        ruu7w6qIX0/5+tb7fZ/x6eX1EAvxpGKGGWxmOxSSdO5khc+empB79py2Qt6HL51lnpuk8gN6
        rt+07vj9xH368V0e22+quS9X91q4J/DbvCiB7fd9+gx5Xu+7em1dUwnT8XYlluKMREMt5qLi
        RADl8HgfrgIAAA==
X-CMS-MailID: 20200207142752eucas1p14ad96c1adf7508226cfdfa583bb442aa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200207142752eucas1p14ad96c1adf7508226cfdfa583bb442aa
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200207142752eucas1p14ad96c1adf7508226cfdfa583bb442aa
References: <20200207142734.8431-1-b.zolnierkie@samsung.com>
        <CGME20200207142752eucas1p14ad96c1adf7508226cfdfa583bb442aa@eucas1p1.samsung.com>
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
index a36bdcb8d9e9..86f4022c9b17 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1335,6 +1335,7 @@ extern int ata_link_nr_enabled(struct ata_link *link);
 extern const struct ata_port_operations ata_base_port_ops;
 extern const struct ata_port_operations sata_port_ops;
 extern struct device_attribute *ata_common_sdev_attrs[];
+extern struct device_attribute *ata_ncq_sdev_attrs[];
 
 /*
  * All sht initializers (BASE, PIO, BMDMA, NCQ) must be instantiated
@@ -1361,6 +1362,7 @@ extern struct device_attribute *ata_common_sdev_attrs[];
 
 #define ATA_NCQ_SHT(drv_name)					\
 	ATA_BASE_SHT(drv_name),					\
+	.sdev_attrs		= ata_ncq_sdev_attrs,		\
 	.change_queue_depth	= ata_scsi_change_queue_depth
 
 /*
-- 
2.24.1

