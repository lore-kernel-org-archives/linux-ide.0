Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D81C432C3
	for <linux-ide@archiver.kernel.org>; Fri, 12 Mar 2021 10:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD97F65011
	for <linux-ide@archiver.kernel.org>; Fri, 12 Mar 2021 10:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbhCLKYX (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 12 Mar 2021 05:24:23 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13596 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbhCLKYG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 12 Mar 2021 05:24:06 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Dxhh519C9z17JnC;
        Fri, 12 Mar 2021 18:22:13 +0800 (CST)
Received: from huawei.com (10.69.192.56) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Fri, 12 Mar 2021
 18:23:52 +0800
From:   Luo Jiaxing <luojiaxing@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, <john.garry@huawei.com>,
        <yangxingui@huawei.com>, <luojiaxing@huawei.com>
Subject: [PATCH v1] ata: ahci: Disable SXS for Hisilicon Kunpeng920
Date:   Fri, 12 Mar 2021 18:24:36 +0800
Message-ID: <1615544676-61926-1-git-send-email-luojiaxing@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Xingui Yang <yangxingui@huawei.com>

On Hisilicon Kunpeng920, ESP is set to 1 by default for all ports of
SATA controller. In some scenarios, some ports are not external SATA ports,
and it cause disks connected to these ports to be identified as removable
disks. So disable the SXS capability on the software side to prevent users
from mistakenly considering non-removable disks as removable disks and
performing related operations.

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Reviewed-by: John Garry <john.garry@huawei.com>
---
 drivers/ata/ahci.c    | 5 +++++
 drivers/ata/ahci.h    | 1 +
 drivers/ata/libahci.c | 5 +++++
 3 files changed, 11 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 00ba8e5..33192a8 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1772,6 +1772,11 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		hpriv->flags |= AHCI_HFLAG_NO_DEVSLP;
 
 #ifdef CONFIG_ARM64
+	if (pdev->vendor == PCI_VENDOR_ID_HUAWEI &&
+	    pdev->device == 0xa235 &&
+	    pdev->revision < 0x30)
+		hpriv->flags |= AHCI_HFLAG_NO_SXS;
+
 	if (pdev->vendor == 0x177d && pdev->device == 0xa01c)
 		hpriv->irq_handler = ahci_thunderx_irq_handler;
 #endif
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 98b8baa..d1f284f 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -242,6 +242,7 @@ enum {
 							suspend/resume */
 	AHCI_HFLAG_IGN_NOTSUPP_POWER_ON	= (1 << 27), /* ignore -EOPNOTSUPP
 							from phy_power_on() */
+	AHCI_HFLAG_NO_SXS		= (1 << 28), /* SXS not supported */
 
 	/* ap->flags bits */
 
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index ea5bf5f..fec2e97 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -493,6 +493,11 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
 		cap |= HOST_CAP_ALPM;
 	}
 
+	if ((cap & HOST_CAP_SXS) && (hpriv->flags & AHCI_HFLAG_NO_SXS)) {
+		dev_info(dev, "controller does not support SXS, disabling CAP_SXS\n");
+		cap &= ~HOST_CAP_SXS;
+	}
+
 	if (hpriv->force_port_map && port_map != hpriv->force_port_map) {
 		dev_info(dev, "forcing port_map 0x%x -> 0x%x\n",
 			 port_map, hpriv->force_port_map);
-- 
2.7.4

