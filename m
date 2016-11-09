From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH 1/4] pata: imx: sort headers out
Date: Wed,  9 Nov 2016 02:56:35 +0200
Message-ID: <20161109005638.17691-2-vz@mleia.com>
References: <20161109005638.17691-1-vz@mleia.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:50571 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754019AbcKIA4l (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 8 Nov 2016 19:56:41 -0500
In-Reply-To: <20161109005638.17691-1-vz@mleia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-ide@vger.kernel.org

Put headers in alphabetic order and remove redundant ones.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/ata/pata_imx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/pata_imx.c b/drivers/ata/pata_imx.c
index 139d207..203e309 100644
--- a/drivers/ata/pata_imx.c
+++ b/drivers/ata/pata_imx.c
@@ -13,14 +13,12 @@
  * - dmaengine support
  * - check if timing stuff needed
  */
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/blkdev.h>
-#include <scsi/scsi_host.h>
+
 #include <linux/ata.h>
+#include <linux/clk.h>
 #include <linux/libata.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/clk.h>
 
 #define DRV_NAME "pata_imx"
 
-- 
2.10.2

