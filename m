From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] ide: pmac: remove unnecessary pci_set_drvdata()
Date: Mon, 23 Sep 2013 10:28:11 +0900
Message-ID: <002c01ceb7fc$2ad496e0$807dc4a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:12381 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434Ab3IWB2N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Sep 2013 21:28:13 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MTK00HUZ1EICZE0@mailout4.samsung.com> for
 linux-ide@vger.kernel.org; Mon, 23 Sep 2013 10:28:12 +0900 (KST)
Content-language: ko
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'David Miller' <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

The driver core clears the driver data to NULL after device_release
or on probe failure. Thus, it is not needed to manually clear the
device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/ide/pmac.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
index bf83d7b..4511ea7 100644
--- a/drivers/ide/pmac.c
+++ b/drivers/ide/pmac.c
@@ -1318,7 +1318,6 @@ static int pmac_ide_pci_attach(struct pci_dev *pdev,
 	rc = pmac_ide_setup_device(pmif, &hw);
 	if (rc != 0) {
 		/* The inteface is released to the common IDE layer */
-		pci_set_drvdata(pdev, NULL);
 		iounmap(base);
 		pci_release_regions(pdev);
 		kfree(pmif);
-- 
1.7.10.4


