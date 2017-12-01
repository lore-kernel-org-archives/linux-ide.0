From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 2/2] ahci: mtk: Change driver name to ahci-mtk
Date: Fri,  1 Dec 2017 11:47:22 +0100
Message-ID: <20171201104722.17353-1-matthias.bgg@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35980 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbdLAKra (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 1 Dec 2017 05:47:30 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: matthias.bgg@gmail.com, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>

The driver name "ahci" is already used by the ahci platform driver.
This leads to the following error:
Error: Driver 'ahci' is already registered, aborting...

Change the name to ahci-mtk to fix this.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/ata/ahci_mtk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_mtk.c b/drivers/ata/ahci_mtk.c
index 80854f71559a..22efb9370d1d 100644
--- a/drivers/ata/ahci_mtk.c
+++ b/drivers/ata/ahci_mtk.c
@@ -25,7 +25,7 @@
 #include <linux/reset.h>
 #include "ahci.h"
 
-#define DRV_NAME		"ahci"
+#define DRV_NAME		"ahci-mtk"
 
 #define SYS_CFG			0x14
 #define SYS_CFG_SATA_MSK	GENMASK(31, 30)
-- 
2.12.3

