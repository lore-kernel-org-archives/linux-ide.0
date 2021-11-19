Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A73C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 19 Nov 2021 03:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 439E261361
	for <linux-ide@archiver.kernel.org>; Fri, 19 Nov 2021 03:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhKSECQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 18 Nov 2021 23:02:16 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:31885 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbhKSECM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 18 Nov 2021 23:02:12 -0500
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HwN8503SqzcbDD;
        Fri, 19 Nov 2021 11:54:13 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 19 Nov
 2021 11:59:07 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <damien.lemoal@opensource.wdc.com>, <axboe@kernel.dk>,
        <tj@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yebin10@huawei.com>, <libaokun1@huawei.com>, <yukuai3@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next 1/2] sata_fsl: fix UAF in sata_fsl_port_stop when rmmod sata_fsl
Date:   Fri, 19 Nov 2021 12:11:27 +0800
Message-ID: <20211119041128.2436889-2-libaokun1@huawei.com>
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

When the `rmmod sata_fsl.ko` command is executed in the PPC64 GNU/Linux,
a bug is reported:
 ==================================================================
 BUG: Unable to handle kernel data access on read at 0x80000800805b502c
 Oops: Kernel access of bad area, sig: 11 [#1]
 NIP [c0000000000388a4] .ioread32+0x4/0x20
 LR [80000000000c6034] .sata_fsl_port_stop+0x44/0xe0 [sata_fsl]
 Call Trace:
  .free_irq+0x1c/0x4e0 (unreliable)
  .ata_host_stop+0x74/0xd0 [libata]
  .release_nodes+0x330/0x3f0
  .device_release_driver_internal+0x178/0x2c0
  .driver_detach+0x64/0xd0
  .bus_remove_driver+0x70/0xf0
  .driver_unregister+0x38/0x80
  .platform_driver_unregister+0x14/0x30
  .fsl_sata_driver_exit+0x18/0xa20 [sata_fsl]
  .__se_sys_delete_module+0x1ec/0x2d0
  .system_call_exception+0xfc/0x1f0
  system_call_common+0xf8/0x200
 ==================================================================

The triggering of the BUG is shown in the following stack:

driver_detach
  device_release_driver_internal
    __device_release_driver
      drv->remove(dev) --> platform_drv_remove/platform_remove
        drv->remove(dev) --> sata_fsl_remove
          iounmap(host_priv->hcr_base);			<---- unmap
          kfree(host_priv);                             <---- free
      devres_release_all
        release_nodes
          dr->node.release(dev, dr->data) --> ata_host_stop
            ap->ops->port_stop(ap) --> sata_fsl_port_stop
                ioread32(hcr_base + HCONTROL)           <---- UAF
            host->ops->host_stop(host)

The iounmap(host_priv->hcr_base) and kfree(host_priv) commands should
not be executed in drv->remove. These commands should be executed in
host_stop after port_stop. Therefore, we move these commands to the
new function sata_fsl_host_stop and bind the new function to host_stop
by referring to achi.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 drivers/ata/sata_fsl.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index e5838b23c9e0..30759fd1c3a2 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1430,12 +1430,25 @@ static struct ata_port_operations sata_fsl_ops = {
 	.pmp_detach = sata_fsl_pmp_detach,
 };
 
+static void sata_fsl_host_stop(struct ata_host *host)
+{
+	struct sata_fsl_host_priv *host_priv = host->private_data;
+
+	iounmap(host_priv->hcr_base);
+	kfree(host_priv);
+}
+
+static struct ata_port_operations sata_fsl_platform_ops = {
+	.inherits       = &sata_fsl_ops,
+	.host_stop      = sata_fsl_host_stop,
+};
+
 static const struct ata_port_info sata_fsl_port_info[] = {
 	{
 	 .flags = SATA_FSL_HOST_FLAGS,
 	 .pio_mask = ATA_PIO4,
 	 .udma_mask = ATA_UDMA6,
-	 .port_ops = &sata_fsl_ops,
+	 .port_ops = &sata_fsl_platform_ops,
 	 },
 };
 
@@ -1558,8 +1571,6 @@ static int sata_fsl_remove(struct platform_device *ofdev)
 	ata_host_detach(host);
 
 	irq_dispose_mapping(host_priv->irq);
-	iounmap(host_priv->hcr_base);
-	kfree(host_priv);
 
 	return 0;
 }
-- 
2.31.1

