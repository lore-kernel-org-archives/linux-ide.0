From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH V2 2/2] ahci_platform: use dev_info() instead of printk()
Date: Sat, 05 Oct 2013 09:15:59 +0900
Message-ID: <001601cec160$11b0e570$3512b050$%han@samsung.com>
References: <001501cec15f$f7bbffb0$e733ff10$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:31916 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181Ab3JEAQA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Oct 2013 20:16:00 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MU6008H562JPZ00@mailout4.samsung.com> for
 linux-ide@vger.kernel.org; Sat, 05 Oct 2013 09:15:59 +0900 (KST)
In-reply-to: <001501cec15f$f7bbffb0$e733ff10$%han@samsung.com>
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

 drivers/ata/ahci_platform.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 2daaee0..7d3b853 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -184,7 +184,7 @@ static int ahci_probe(struct platform_device *pdev)
 	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
 		host->flags |= ATA_HOST_PARALLEL_SCAN;
 	else
-		printk(KERN_INFO "ahci: SSS flag set, parallel bus scan disabled\n");
+		dev_info(dev, "SSS flag set, parallel bus scan disabled\n");
 
 	if (pi.flags & ATA_FLAG_EM)
 		ahci_reset_em(host);
-- 
1.7.10.4


