From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0247/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:53:01 +0800
Message-ID: <20160802105301.30206-1-baolex.ni@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:27436 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755830AbcHBLdK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Aug 2016 07:33:10 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davem@davemloft.net, linux@roeck-us.net, airlied@linux.ie, kgene@kernel.org, k.kozlowski@samsung.com, dougthompson@xmission.com, bp@alien8.de
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, aduggan@synaptics.com, dianders@chromium.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/ide/ide-gd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/ide-gd.c b/drivers/ide/ide-gd.c
index 838996a..ed03e32 100644
--- a/drivers/ide/ide-gd.c
+++ b/drivers/ide/ide-gd.c
@@ -24,7 +24,7 @@
 /* module parameters */
 static DEFINE_MUTEX(ide_gd_mutex);
 static unsigned long debug_mask;
-module_param(debug_mask, ulong, 0644);
+module_param(debug_mask, ulong, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
 static DEFINE_MUTEX(ide_disk_ref_mutex);
 
-- 
2.9.2

