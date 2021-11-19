Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1791C433F5
	for <linux-ide@archiver.kernel.org>; Fri, 19 Nov 2021 03:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B977B61051
	for <linux-ide@archiver.kernel.org>; Fri, 19 Nov 2021 03:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhKSECP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 18 Nov 2021 23:02:15 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:31886 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbhKSECM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 18 Nov 2021 23:02:12 -0500
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HwN850Ky4zcbFt;
        Fri, 19 Nov 2021 11:54:13 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 19 Nov
 2021 11:59:08 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <damien.lemoal@opensource.wdc.com>, <axboe@kernel.dk>,
        <tj@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yebin10@huawei.com>, <libaokun1@huawei.com>, <yukuai3@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next 2/2] sata_fsl: fix warning in remove_proc_entry when rmmod sata_fsl
Date:   Fri, 19 Nov 2021 12:11:28 +0800
Message-ID: <20211119041128.2436889-3-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211119041128.2436889-1-libaokun1@huawei.com>
References: <20211119041128.2436889-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Trying to remove the fsl-sata module in the PPC64 GNU/Linux
leads to the following warning:
 ------------[ cut here ]------------
 remove_proc_entry: removing non-empty directory 'irq/69',
   leaking at least 'fsl-sata[ff0221000.sata]'
 WARNING: CPU: 3 PID: 1048 at fs/proc/generic.c:722
   .remove_proc_entry+0x20c/0x220
 IRQMASK: 0
 NIP [c00000000033826c] .remove_proc_entry+0x20c/0x220
 LR [c000000000338268] .remove_proc_entry+0x208/0x220
 Call Trace:
  .remove_proc_entry+0x208/0x220 (unreliable)
  .unregister_irq_proc+0x104/0x140
  .free_desc+0x44/0xb0
  .irq_free_descs+0x9c/0xf0
  .irq_dispose_mapping+0x64/0xa0
  .sata_fsl_remove+0x58/0xa0 [sata_fsl]
  .platform_drv_remove+0x40/0x90
  .device_release_driver_internal+0x160/0x2c0
  .driver_detach+0x64/0xd0
  .bus_remove_driver+0x70/0xf0
  .driver_unregister+0x38/0x80
  .platform_driver_unregister+0x14/0x30
  .fsl_sata_driver_exit+0x18/0xa20 [sata_fsl]
 ---[ end trace 0ea876d4076908f5 ]---

The driver creates the mapping by calling irq_of_parse_and_map(),
so it also has to dispose the mapping. But the easy way out is to
simply use platform_get_irq() instead of irq_of_parse_map().

In this case the mapping is not managed by the device but by
the of core, so the device has not to dispose the mapping.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 drivers/ata/sata_fsl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 30759fd1c3a2..011daac4a14e 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1493,7 +1493,7 @@ static int sata_fsl_probe(struct platform_device *ofdev)
 	host_priv->ssr_base = ssr_base;
 	host_priv->csr_base = csr_base;
 
-	irq = irq_of_parse_and_map(ofdev->dev.of_node, 0);
+	irq = platform_get_irq(ofdev, 0);
 	if (!irq) {
 		dev_err(&ofdev->dev, "invalid irq from platform\n");
 		goto error_exit_with_cleanup;
@@ -1570,8 +1570,6 @@ static int sata_fsl_remove(struct platform_device *ofdev)
 
 	ata_host_detach(host);
 
-	irq_dispose_mapping(host_priv->irq);
-
 	return 0;
 }
 
-- 
2.31.1

