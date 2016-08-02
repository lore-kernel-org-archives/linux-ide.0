From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0061/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:37:51 +0800
Message-ID: <20160802103751.17826-1-baolex.ni@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:18534 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753778AbcHBLPb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Aug 2016 07:15:31 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: b.zolnierkie@samsung.com, tj@kernel.org, lenb@kernel.org, x86@kernel.org, hpa@zytor.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, travis@sgi.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/ata/pata_ali.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index d19cd88..e104c6b 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -38,7 +38,7 @@
 #define DRV_VERSION "0.7.8"
 
 static int ali_atapi_dma = 0;
-module_param_named(atapi_dma, ali_atapi_dma, int, 0644);
+module_param_named(atapi_dma, ali_atapi_dma, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(atapi_dma, "Enable ATAPI DMA (0=disable, 1=enable)");
 
 static struct pci_dev *ali_isa_bridge;
-- 
2.9.2

