From: Marek Vasut <marex@denx.de>
Subject: [PATCH] [SCSI] esas2r: Fix comment
Date: Mon, 21 Apr 2014 22:55:49 +0200
Message-ID: <1398113749-7491-1-git-send-email-marex@denx.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:46114 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754210AbaDUUz6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Apr 2014 16:55:58 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>, James Bottomley <JBottomley@Parallels.com>, Bradley Grove <bgrove@attotech.com>

Minor fix for a comment in the driver so that it matches the function name.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: James Bottomley <JBottomley@Parallels.com>
Cc: Bradley Grove <bgrove@attotech.com>
---
 drivers/scsi/esas2r/esas2r_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/esas2r/esas2r_main.c b/drivers/scsi/esas2r/esas2r_main.c
index f37f3e3..6504a19 100644
--- a/drivers/scsi/esas2r/esas2r_main.c
+++ b/drivers/scsi/esas2r/esas2r_main.c
@@ -390,7 +390,7 @@ static int esas2r_probe(struct pci_dev *pcid,
 	esas2r_log_dev(ESAS2R_LOG_INFO, &(pcid->dev),
 		       "pci_enable_device() OK");
 	esas2r_log_dev(ESAS2R_LOG_INFO, &(pcid->dev),
-		       "after pci_device_enable() enable_cnt: %d",
+		       "after pci_enable_device() enable_cnt: %d",
 		       pcid->enable_cnt.counter);
 
 	host = scsi_host_alloc(&driver_template, host_alloc_size);
-- 
1.9.1

