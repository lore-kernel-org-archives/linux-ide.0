From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: [PATCH] ata: sata_mv: fix module license specification
Date: Tue, 20 Dec 2016 22:15:22 +0100
Message-ID: <20161220211522.25856-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:57791 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756977AbcLTVP2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 20 Dec 2016 16:15:28 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

The header allows GPL v2 only, so declare "GPL v2" for MODULE_LICENSE

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/ata/sata_mv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 823e938c9a78..bcbfe23a45f6 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4526,7 +4526,7 @@ static void __exit mv_exit(void)
 
 MODULE_AUTHOR("Brett Russ");
 MODULE_DESCRIPTION("SCSI low-level driver for Marvell SATA controllers");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_DEVICE_TABLE(pci, mv_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.10.2

