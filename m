From: Albert Pool <albertpool@solcon.nl>
Subject: [PATCH] ata: mediatek: Fix typo in module description
Date: Mon, 20 Nov 2017 14:20:09 +0100
Message-ID: <979fd5c5-4375-9fd7-6f02-4613224a5783@solcon.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailrelay12.solcon.nl ([212.45.32.91]:54124 "EHLO
        mailrelay12.solcon.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbdKTODI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 20 Nov 2017 09:03:08 -0500
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org
Cc: ryder.lee@mediatek.com

Signed-off-by: Albert Pool <albertpool@solcon.nl>
---
  drivers/ata/ahci_mtk.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_mtk.c b/drivers/ata/ahci_mtk.c
index 80854f7..489452a 100644
--- a/drivers/ata/ahci_mtk.c
+++ b/drivers/ata/ahci_mtk.c
@@ -1,5 +1,5 @@
  /*
- * MeidaTek AHCI SATA driver
+ * MediaTek AHCI SATA driver
   *
   * Copyright (c) 2017 MediaTek Inc.
   * Author: Ryder Lee <ryder.lee@mediatek.com>
@@ -192,5 +192,5 @@ static struct platform_driver mtk_ahci_driver = {
  };
  module_platform_driver(mtk_ahci_driver);

-MODULE_DESCRIPTION("MeidaTek SATA AHCI Driver");
+MODULE_DESCRIPTION("MediaTek SATA AHCI Driver");
  MODULE_LICENSE("GPL v2");
-- 
2.7.4


