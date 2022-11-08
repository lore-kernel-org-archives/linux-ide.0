Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8459DC43219
	for <linux-ide@archiver.kernel.org>; Tue,  8 Nov 2022 13:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbiKHNlk (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Nov 2022 08:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbiKHNlY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Nov 2022 08:41:24 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA4850F12
        for <linux-ide@vger.kernel.org>; Tue,  8 Nov 2022 05:41:22 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N68Q12ShLzRnxF;
        Tue,  8 Nov 2022 21:41:13 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 21:41:21 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 21:41:20 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-ide@vger.kernel.org>
CC:     <damien.lemoal@opensource.wdc.com>, <yangyingliang@huawei.com>
Subject: [PATCH v3 1/4] ata: libata-transport: fix double ata_host_put() in ata_tport_add()
Date:   Tue, 8 Nov 2022 21:40:01 +0800
Message-ID: <20221108134004.1079981-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221108134004.1079981-1-yangyingliang@huawei.com>
References: <20221108134004.1079981-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

In the error path in ata_tport_add(), when calling put_device(),
ata_tport_release() is called, it will put the refcount of 'ap->host'.

And then ata_host_put() is called again, the refcount is decreased
to 0, ata_host_release() is called, all ports are freed and set to
null.

When unbinding the device after failure, ata_host_stop() is called
to release the resources, it leads a null-ptr-deref(), because all
the ports all freed and null.

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
CPU: 7 PID: 18671 Comm: modprobe Kdump: loaded Tainted: G            E      6.1.0-rc3+ #8
pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : ata_host_stop+0x3c/0x84 [libata]
lr : release_nodes+0x64/0xd0
Call trace:
 ata_host_stop+0x3c/0x84 [libata]
 release_nodes+0x64/0xd0
 devres_release_all+0xbc/0x1b0
 device_unbind_cleanup+0x20/0x70
 really_probe+0x158/0x320
 __driver_probe_device+0x84/0x120
 driver_probe_device+0x44/0x120
 __driver_attach+0xb4/0x220
 bus_for_each_dev+0x78/0xdc
 driver_attach+0x2c/0x40
 bus_add_driver+0x184/0x240
 driver_register+0x80/0x13c
 __pci_register_driver+0x4c/0x60
 ahci_pci_driver_init+0x30/0x1000 [ahci]

Fix this by removing redundant ata_host_put() in the error path.

Fixes: 2623c7a5f279 ("libata: add refcounting to ata_host")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/ata/libata-transport.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index a7e9a75410a3..105da3ec5eaa 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -317,7 +317,6 @@ int ata_tport_add(struct device *parent,
  tport_err:
 	transport_destroy_device(dev);
 	put_device(dev);
-	ata_host_put(ap->host);
 	return error;
 }
 
-- 
2.25.1

