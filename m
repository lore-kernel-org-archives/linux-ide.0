From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH V2 1/2] ahci: use dev_info() instead of printk()
Date: Sat, 05 Oct 2013 09:15:16 +0900
Message-ID: <001501cec15f$f7bbffb0$e733ff10$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:55379 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126Ab3JEAPR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Oct 2013 20:15:17 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MU600FKC61GCA30@mailout1.samsung.com> for
 linux-ide@vger.kernel.org; Sat, 05 Oct 2013 09:15:16 +0900 (KST)
Content-language: ko
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Tejun Heo' <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

Change "raw" printk() call to dev_info() to provide a better
message to userspace so it can properly identify the device
and not just have to guess.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
Tested on Exynos5440.

 drivers/ata/ahci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 9d715ae..8e28f92 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1343,7 +1343,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
 		host->flags |= ATA_HOST_PARALLEL_SCAN;
 	else
-		printk(KERN_INFO "ahci: SSS flag set, parallel bus scan disabled\n");
+		dev_info(&pdev->dev, "SSS flag set, parallel bus scan disabled\n");
 
 	if (pi.flags & ATA_FLAG_EM)
 		ahci_reset_em(host);
-- 
1.7.10.4


