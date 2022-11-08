Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71615C43217
	for <linux-ide@archiver.kernel.org>; Tue,  8 Nov 2022 07:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiKHHxk (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Nov 2022 02:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbiKHHxh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Nov 2022 02:53:37 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12157B858
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 23:53:32 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N60cc04HkzpWL1;
        Tue,  8 Nov 2022 15:49:52 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 15:53:31 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 15:53:31 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-ide@vger.kernel.org>
CC:     <damien.lemoal@opensource.wdc.com>, <yangyingliang@huawei.com>
Subject: [PATCH v2 3/4] ata: libata-transport: fix error handling in ata_tlink_add()
Date:   Tue, 8 Nov 2022 15:52:08 +0800
Message-ID: <20221108075209.2434888-4-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221108075209.2434888-1-yangyingliang@huawei.com>
References: <20221108075209.2434888-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

In ata_tlink_add(), the return value of transport_add_device() is not
checked. As a result, another error after that function call leads to
a kernel crash (null-ptr-deref) because transport_remove_device() is
called to remove a device that was not added.

Unable to handle kernel NULL pointer dereference at virtual address 00000000000000d0
CPU: 33 PID: 13850 Comm: rmmod Kdump: loaded Tainted: G        W          6.1.0-rc3+ #12
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : device_del+0x48/0x39c
lr : device_del+0x44/0x39c
Call trace:
 device_del+0x48/0x39c
 attribute_container_class_device_del+0x28/0x40
 transport_remove_classdev+0x60/0x7c
 attribute_container_device_trigger+0x118/0x120
 transport_remove_device+0x20/0x30
 ata_tlink_delete+0x88/0xb0 [libata]
 ata_tport_delete+0x2c/0x60 [libata]
 ata_port_detach+0x148/0x1b0 [libata]
 ata_pci_remove_one+0x50/0x80 [libata]
 ahci_remove_one+0x4c/0x8c [ahci]

Fix this by checking and handling return value of transport_add_device()
in ata_tlink_add().

Fixes: d9027470b886 ("[libata] Add ATA transport class")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/ata/libata-transport.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index ef53bdfbcbb2..aac9336e8153 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -458,7 +458,9 @@ int ata_tlink_add(struct ata_link *link)
 		goto tlink_err;
 	}
 
-	transport_add_device(dev);
+	error = transport_add_device(dev);
+	if (error)
+		goto tlink_transport_err;
 	transport_configure_device(dev);
 
 	ata_for_each_dev(ata_dev, link, ALL) {
@@ -473,6 +475,7 @@ int ata_tlink_add(struct ata_link *link)
 		ata_tdev_delete(ata_dev);
 	}
 	transport_remove_device(dev);
+  tlink_transport_err:
 	device_del(dev);
   tlink_err:
 	transport_destroy_device(dev);
-- 
2.25.1

