From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] sata_highbank: make ahci_highbank_pm_ops static
Date: Tue, 19 Mar 2013 10:14:26 +0900
Message-ID: <006801ce243f$1960ffd0$4c22ff70$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:64353 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753948Ab3CSBOm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Mar 2013 21:14:42 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MJV002C5VG0IS90@mailout1.samsung.com> for
 linux-ide@vger.kernel.org; Tue, 19 Mar 2013 10:14:27 +0900 (KST)
Received: from DOJG1HAN02 ([12.23.120.99])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MJV00E0QVG2PBA0@mmp1.samsung.com> for
 linux-ide@vger.kernel.org; Tue, 19 Mar 2013 10:14:26 +0900 (KST)
Content-language: ko
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Jeff Garzik' <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

Make ahci_highbank_pm_ops static because ahci_highbank_pm_ops is
not exported.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/ata/sata_highbank.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
index 5dba77c..b1ab7d8 100644
--- a/drivers/ata/sata_highbank.c
+++ b/drivers/ata/sata_highbank.c
@@ -418,7 +418,7 @@ static int ahci_highbank_resume(struct device *dev)
 }
 #endif
 
-SIMPLE_DEV_PM_OPS(ahci_highbank_pm_ops,
+static SIMPLE_DEV_PM_OPS(ahci_highbank_pm_ops,
 		  ahci_highbank_suspend, ahci_highbank_resume);
 
 static struct platform_driver ahci_highbank_driver = {
-- 
1.7.2.5


