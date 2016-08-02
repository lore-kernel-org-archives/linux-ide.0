From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0064/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:38:03 +0800
Message-ID: <20160802103803.18024-1-baolex.ni@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:13394 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753988AbcHBLPn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Aug 2016 07:15:43 -0400
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
 drivers/ata/pata_octeon_cf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index 2724595..d0d002c 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -63,7 +63,7 @@ static struct scsi_host_template octeon_cf_sht = {
 };
 
 static int enable_dma;
-module_param(enable_dma, int, 0444);
+module_param(enable_dma, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable_dma,
 		 "Enable use of DMA on interfaces that support it (0=no dma [default], 1=use dma)");
 
-- 
2.9.2

