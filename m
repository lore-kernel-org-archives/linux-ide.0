From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0246/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:52:57 +0800
Message-ID: <20160802105257.30140-1-baolex.ni@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63050 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755758AbcHBLaj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Aug 2016 07:30:39 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bp@alien8.de, davem@davemloft.net, linux@roeck-us.net, airlied@linux.ie, kgene@kernel.org, k.kozlowski@samsung.com, dougthompson@xmission.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, aduggan@synaptics.com, dianders@chromium.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/ide/ide-cd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index ef907fd..78f4059 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1719,7 +1719,7 @@ static const struct block_device_operations idecd_ops = {
 
 /* module options */
 static unsigned long debug_mask;
-module_param(debug_mask, ulong, 0644);
+module_param(debug_mask, ulong, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
 MODULE_DESCRIPTION("ATAPI CD-ROM Driver");
 
-- 
2.9.2

